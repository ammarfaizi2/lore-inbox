Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268953AbUHMCzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268953AbUHMCzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUHMCzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:55:48 -0400
Received: from [213.91.244.52] ([213.91.244.52]:52352 "HELO newbg.org")
	by vger.kernel.org with SMTP id S268953AbUHMCzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:55:45 -0400
Date: Fri, 13 Aug 2004 5:49:40 -0000
From: "Nikolay" <Nikolay@Alexandrov.ws>
To: linux-kernel@vger.kernel.org
Reply-to: "Nikolay" <nikolay@Alexandrov.ws>
Subject: [PATCH] 2.4.27 fs/open.c code small cleanup
X-Priority: 3
X-Mailer: UebiMiau 2.7.2
X-Original-IP: 192.168.111.2
Content-Transfer-Encoding: 8bit
X-MSMail-Priority: Medium
Importance: Medium
Content-Type: multipart/mixed; charset="iso-8859-1";
	boundary="--=_b2e924587e5cbe1a5d0b9d246adec3225"
MIME-Version: 1.0
Message-Id: <S268953AbUHMCzp/20040813025546Z+1005@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----=_b2e924587e5cbe1a5d0b9d246adec3225
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

A little clean up, soon I'll send few bug fixes and cleanups.

(see the attached file for more info)

----=_b2e924587e5cbe1a5d0b9d246adec3225
Content-Type: application/octet-stream; name="kernel.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="kernel.diff"

ZGlmZiAtdSBsaW51eC0yLjQuMjcvTUFJTlRBSU5FUlMgbGludXgtMi40LjI3L01BSU5UQUlORVJT
Ci0tLSBsaW51eC0yLjQuMjcvTUFJTlRBSU5FUlMJMjAwNC0wOC0wOSAwMjo0ODo1My4wMDAwMDAw
MDAgKzAzMDAKKysrIGxpbnV4LTIuNC4yNy9NQUlOVEFJTkVSUwkyMDA0LTA4LTA5IDAyOjUxOjA0
LjAwMDAwMDAwMCArMDMwMApAQCAtMTgwNiw2ICsxODA2LDEyIEBACiBMOglsaW51eC12aWRlb0Bh
dHJleS5rYXJsaW4ubWZmLmN1bmkuY3oKIFM6CU1haW50YWluZWQKIAorU1lTX0ZTVEFURlMgQ09E
RSBDTEVBTlVQCitQOiAgICAgIE5pa29sYXkgQWxleGFuZHJvdgorTTogICAgICBOaWtvbGF5QEFs
ZXhhbmRyb3Yud3MKK1c6ICAgICAgaHR0cDovL2tzdGF0cy5ibGFja3dhbGwub3JnCitTOiAgICAg
IE1haW50YWluZWQKKwogU1lTViBGSUxFU1lTVEVNCiBQOglDaHJpc3RvcGggSGVsbHdpZwogTToJ
aGNoQGluZnJhZGVhZC5vcmcKZGlmZiAtdSBsaW51eC0yLjQuMjcvZnMvb3Blbi5jIGxpbnV4LTIu
NC4yNy9mcy9vcGVuLmMKLS0tIGxpbnV4LTIuNC4yNy9mcy9vcGVuLmMgIDIwMDQtMDgtMDkgMDI6
MjI6NTguMDAwMDAwMDAwICswMzAwCisrKyBsaW51eC0yLjQuMjcvZnMvb3Blbi5jICAgICAgMjAw
NC0wOC0wOSAwMjoyNDo0OC4wMDAwMDAwMDAgKzAzMDAKQEAgLTIsNiArMiw3IEBACiAgKiAgbGlu
dXgvZnMvb3Blbi5jCiAgKgogICogIENvcHlyaWdodCAoQykgMTk5MSwgMTk5MiAgTGludXMgVG9y
dmFsZHMKKyAqICAwOC4wOC4yMDA0IC0gdmZzX2ZzdGF0ZnMgY29kZSBjbGVhbnVwIC0tIE5pa29s
YXkgQWxleGFuZHJvdiAoTmlrb2xheUBBbGV4YW5kcm92LndzKQogICovCgogI2luY2x1ZGUgPGxp
bnV4L3N0cmluZy5oPgpAQCAtNjIsMTIgKzYzLDExIEBACiAgICAgICAgZXJyb3IgPSAtRUJBREY7
CiAgICAgICAgZmlsZSA9IGZnZXQoZmQpOwogICAgICAgIGlmICghZmlsZSkKLSAgICAgICAgICAg
ICAgIGdvdG8gb3V0OworICAgICAgICAgICAgICAgcmV0dXJuIGVycm9yOwogICAgICAgIGVycm9y
ID0gdmZzX3N0YXRmcyhmaWxlLT5mX2RlbnRyeS0+ZF9pbm9kZS0+aV9zYiwgJnRtcCk7CiAgICAg
ICAgaWYgKCFlcnJvciAmJiBjb3B5X3RvX3VzZXIoYnVmLCAmdG1wLCBzaXplb2Yoc3RydWN0IHN0
YXRmcykpKQogICAgICAgICAgICAgICAgZXJyb3IgPSAtRUZBVUxUOwogICAgICAgIGZwdXQoZmls
ZSk7Ci1vdXQ6CiAgICAgICAgcmV0dXJuIGVycm9yOwogfQo=



----=_b2e924587e5cbe1a5d0b9d246adec3225--

