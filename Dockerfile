FROM golang:1.16-alpine3.15 as build

WORKDIR /go/src/github.com/uselagoon/lagoon-sync/
COPY . .

ARG VERSION

RUN apk update && apk add git

RUN CGO_ENABLED=0 GOOS=linux go build -o lagoon-sync .

FROM alpine:3.15

WORKDIR /root/
COPY --from=build /go/src/github.com/uselagoon/lagoon-sync/lagoon-sync /lagoon-sync

RUN touch ~/.lagoon.yml

ENTRYPOINT ["/lagoon-sync"]
