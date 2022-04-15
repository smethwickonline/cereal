import gleam/io
import cereal/log
import templates/test
import gleam/string
import gleam/http/elli
import gleam/http/request.{Request}
import gleam/http/response.{Response}
import gleam/bit_builder.{BitBuilder}


pub fn service(req: Request(BitString)) -> Response(BitBuilder) {
  log.log(log.Info, string.append(to: "request! ", suffix: req.path))
  let output = test.render("test!!")
  let body = bit_builder.from_string(output)

  response.new(200)
  |> response.prepend_header("content-type", "text/html")
  |> response.set_body(body)
}

pub fn main() {
  log.configure_backend()
  elli.become(service, on_port: 3000)
}
