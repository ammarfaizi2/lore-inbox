Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263418AbRFAIsA>; Fri, 1 Jun 2001 04:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263419AbRFAIru>; Fri, 1 Jun 2001 04:47:50 -0400
Received: from Backfire.WH8.TU-Dresden.De ([141.30.225.118]:11688 "EHLO
	Backfire.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S263418AbRFAIri>; Fri, 1 Jun 2001 04:47:38 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_ART8ETCSKRA4BMVVUYK0"
From: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Organization: Netzwerkadministrator WH8/DD
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 Kernel Oops and ls+rm segfaults
Date: Fri, 1 Jun 2001 10:47:34 +0200
X-Mailer: KMail [version 1.2]
Cc: Alexander Viro <viro@math.psu.edu>
X-PGP-fingerprint: B0FA 69E5 D8AC 02B3 BAEF  E307 BD3A E495 93DD A233
X-PGP-public-key: finger gjasny@hell.wh8.tu-dresden.de
MIME-Version: 1.0
Message-Id: <01060110473400.29231@backfire>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ART8ETCSKRA4BMVVUYK0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi!

Can anyone tell me, where this oops came from?
The machine is a HP NetServer II lc (EISA+PCI architecture).
The distribution is a slackware 7.0 with parts of 7.1 and current.
gcc: 2.95.4 20010319 (Debian prerelease)

I hope you can help me.

Regards, 

-Gregor
--------------Boundary-00=_ART8ETCSKRA4BMVVUYK0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="oops.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="oops.txt"

a3N5bW9vcHMgMi40LjEgb24gaTU4NiAyLjQuNC1jc2ZkZGkuICBPcHRpb25zIHVzZWQKICAgICAt
ViAoZGVmYXVsdCkKICAgICAtayAvcHJvYy9rc3ltcyAoZGVmYXVsdCkKICAgICAtbCAvcHJvYy9t
b2R1bGVzIChkZWZhdWx0KQogICAgIC1vIC9saWIvbW9kdWxlcy8yLjQuNC1jc2ZkZGkvIChkZWZh
dWx0KQogICAgIC1tIC9ib290L1N5c3RlbS5tYXAtMi40LjQtY3NmZGRpIChzcGVjaWZpZWQpCgpV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3Mg
YzkzNmQzMDAKYzAxMjJkOGMKKnBkZSA9IDAwMDAwMDAwCk9vcHM6IDAwMDIKQ1BVOiAgICAwCkVJ
UDogICAgMDAxMDpbPGMwMTIyZDhjPl0KVXNpbmcgZGVmYXVsdHMgZnJvbSBrc3ltb29wcyAtdCBl
bGYzMi1pMzg2IC1hIGkzODYKRUZMQUdTOiAwMDAxMDA4NwplYXg6IDMzOGI5NWVmICAgZWJ4OiAw
MWY5NTRiYSAgIGVjeDogYzE1MTgwMDAgICBlZHg6IDAwMDAwMDIzCmVzaTogYzExOWZjZGMgICBl
ZGk6IDAwMDAwMjAyICAgZWJwOiBjMTA1YmU5MCAgIGVzcDogYzFlYTFlYzQKZHM6IDAwMTggICBl
czogMDAxOCAgIHNzOiAwMDE4ClByb2Nlc3Mgcm0gKHBpZDogMzg3Nywgc3RhY2twYWdlPWMxZWEx
MDAwKQpTdGFjazogYzE1MThiYTAgYzE1MTgzNjAgYzE1MGRiYzAgYzEwNWJlOTAgYzAxMmUzZDkg
YzExOWZjZGMgYzE1MThiYTAgYzE1MGRiYzAgCiAgICAgICAwMDAwMTAwMCBjMTUwZGJjMCAwMDAw
MTAwMCAwMDAwMDAwMCAwMDAwMDAwMSBjMDEyY2UwOCBjMTA1YmU5MCAwMDAwMDAwMCAKICAgICAg
IGMxMDViZTkwIDAwMDAxMWMwIGM1ZDI2NGM0IDAwMDAwMDAwIGMwMTFkOWZlIGMxMDViZTkwIDAw
MDAwMDAwIGMxZWExZjQ4IApDYWxsIFRyYWNlOiBbPGMwMTJlM2Q5Pl0gWzxjMDEyY2UwOD5dIFs8
YzAxMWQ5ZmU+XSBbPGMwMTFkYWNjPl0gWzxjMDEzZGRhNj5dIFs8YzAxM2MzOTg+XSBbPGMwMTM2
MTk0Pl0gCiAgICAgICBbPGMwMTM2MjZiPl0gWzxjODU4YjhjYz5dIFs8YzAxMDZhYzM+XSAKQ29k
ZTogODkgNDQgOTkgMTggODkgNTkgMTQgOGIgNTYgMTQgOGIgNDEgMTAgZmYgNDkgMTAgMzkgZDAg
NzQgMDggCgo+PkVJUDsgYzAxMjJkOGMgPGttZW1fY2FjaGVfZnJlZSszOC9hYz4gICA8PT09PT0K
VHJhY2U7IGMwMTJlM2Q5IDx0cnlfdG9fZnJlZV9idWZmZXJzK2MxLzE1Yz4KVHJhY2U7IGMwMTJj
ZTA4IDxibG9ja19mbHVzaHBhZ2UrNzAvOTQ+ClRyYWNlOyBjMDExZDlmZSA8dHJ1bmNhdGVfbGlz
dF9wYWdlcytmNi8xODQ+ClRyYWNlOyBjMDExZGFjYyA8dHJ1bmNhdGVfaW5vZGVfcGFnZXMrNDAv
NmM+ClRyYWNlOyBjMDEzZGRhNiA8aXB1dCs5Ni8xNWM+ClRyYWNlOyBjMDEzYzM5OCA8ZF9kZWxl
dGUrNGMvNmM+ClRyYWNlOyBjMDEzNjE5NCA8dmZzX3VubGluaysxMTQvMTQ0PgpUcmFjZTsgYzAx
MzYyNmIgPHN5c191bmxpbmsrYTcvMTFjPgpUcmFjZTsgYzg1OGI4Y2MgPEVORF9PRl9DT0RFKzFk
NDg3ODgvPz8/Pz4KVHJhY2U7IGMwMTA2YWMzIDxzeXN0ZW1fY2FsbCszMy80MD4KQ29kZTsgIGMw
MTIyZDhjIDxrbWVtX2NhY2hlX2ZyZWUrMzgvYWM+CjAwMDAwMDAwMDAwMDAwMDAgPF9FSVA+OgpD
b2RlOyAgYzAxMjJkOGMgPGttZW1fY2FjaGVfZnJlZSszOC9hYz4gICA8PT09PT0KICAgMDogICA4
OSA0NCA5OSAxOCAgICAgICAgICAgICAgIG1vdiAgICAlZWF4LDB4MTgoJWVjeCwlZWJ4LDQpICAg
PD09PT09CkNvZGU7ICBjMDEyMmQ5MCA8a21lbV9jYWNoZV9mcmVlKzNjL2FjPgogICA0OiAgIDg5
IDU5IDE0ICAgICAgICAgICAgICAgICAgbW92ICAgICVlYngsMHgxNCglZWN4KQpDb2RlOyAgYzAx
MjJkOTMgPGttZW1fY2FjaGVfZnJlZSszZi9hYz4KICAgNzogICA4YiA1NiAxNCAgICAgICAgICAg
ICAgICAgIG1vdiAgICAweDE0KCVlc2kpLCVlZHgKQ29kZTsgIGMwMTIyZDk2IDxrbWVtX2NhY2hl
X2ZyZWUrNDIvYWM+CiAgIGE6ICAgOGIgNDEgMTAgICAgICAgICAgICAgICAgICBtb3YgICAgMHgx
MCglZWN4KSwlZWF4CkNvZGU7ICBjMDEyMmQ5OSA8a21lbV9jYWNoZV9mcmVlKzQ1L2FjPgogICBk
OiAgIGZmIDQ5IDEwICAgICAgICAgICAgICAgICAgZGVjbCAgIDB4MTAoJWVjeCkKQ29kZTsgIGMw
MTIyZDljIDxrbWVtX2NhY2hlX2ZyZWUrNDgvYWM+CiAgMTA6ICAgMzkgZDAgICAgICAgICAgICAg
ICAgICAgICBjbXAgICAgJWVkeCwlZWF4CkNvZGU7ICBjMDEyMmQ5ZSA8a21lbV9jYWNoZV9mcmVl
KzRhL2FjPgogIDEyOiAgIDc0IDA4ICAgICAgICAgICAgICAgICAgICAgamUgICAgIDFjIDxfRUlQ
KzB4MWM+IGMwMTIyZGE4IDxrbWVtX2NhY2hlX2ZyZWUrNTQvYWM+Cgo=

--------------Boundary-00=_ART8ETCSKRA4BMVVUYK0--
