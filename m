Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRGLWgS>; Thu, 12 Jul 2001 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266290AbRGLWgI>; Thu, 12 Jul 2001 18:36:08 -0400
Received: from pn74.warszawa.adsl.tpnet.pl ([217.98.13.74]:60175 "EHLO
	blurp.slackware.pl") by vger.kernel.org with ESMTP
	id <S266263AbRGLWfw>; Thu, 12 Jul 2001 18:35:52 -0400
Date: Fri, 13 Jul 2001 00:27:01 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.4
Message-ID: <Pine.LNX.4.33.0107130016250.15527-300000@blurp.slackware.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1575457154-994976821=:15527"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1575457154-994976821=:15527
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

I got two sequent oopses in 2.4.4. Both were triggered by `ps xa'.
First (oops1) resulted in such line in ps output:
 5149 tty3     Z      0:00 [mcextHLroIj <defunct>]
Second (oops2), run just after the first, crashed bash.

System is pII 400, 128MB RAM. I was unable to reproduce it.

regards
pkot
-- 
[ Pawe³ Kot ] [ Linux Registered User #94478 ] [ LinuxNews.pl Team Member ]
[ mailto:pkot@linuxnews.pl ] [ PGP Public Key: http://tfuj.pl/pgp.asc ] [ ]
[ http://tfuj.pl/cv.html ] [ -------------------------------------------- ]

---1463811839-1575457154-994976821=:15527
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=oops1
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107130027010.15527@blurp.slackware.pl>
Content-Description: 
Content-Disposition: attachment; filename=oops1

SnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5lbDogVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwg
YWRkcmVzcyAwMDAwMDdiNA0KSnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5l
bDogIHByaW50aW5nIGVpcDoNCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJu
ZWw6IGMwMTExZjAxDQpKdWwgIDggMjM6MjY6NDMgYmx1cnAga2VybmVsOiAq
cGRlID0gMDAwMDAwMDANCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6
IE9vcHM6IDAwMDINCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6IENQ
VTogICAgMA0KSnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5lbDogRUlQOiAg
ICAwMDEwOltjb3B5X2ZpbGVzKzM3Ny81OTJdDQpKdWwgIDggMjM6MjY6NDMg
Ymx1cnAga2VybmVsOiBFRkxBR1M6IDAwMDEwMjA2DQpKdWwgIDggMjM6MjY6
NDMgYmx1cnAga2VybmVsOiBlYXg6IDAwMDAwN2EwICAgZWJ4OiBjNGM5MTBj
MCAgIGVjeDogYzdhYWYwMDAgICBlZHg6IDAwMDAwMDAxDQpKdWwgIDggMjM6
MjY6NDMgYmx1cnAga2VybmVsOiBlc2k6IGM3M2IyNWEwICAgZWRpOiBjNGM5
MTEwMCAgIGVicDogYzNjYzg3ZmMgICBlc3A6IGM1NDExZjM0DQpKdWwgIDgg
MjM6MjY6NDMgYmx1cnAga2VybmVsOiBkczogMDAxOCAgIGVzOiAwMDE4ICAg
c3M6IDAwMTgNCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6IFByb2Nl
c3MgYmFzaCAocGlkOiA0MzA5LCBzdGFja3BhZ2U9YzU0MTEwMDApDQpKdWwg
IDggMjM6MjY6NDMgYmx1cnAga2VybmVsOiBTdGFjazogMDAwMDAwMTEgYzU0
MTA1OTAgMDAwMDAwMTEgYzU0MTFmYmMgMDAwMDAwMDggMDAwMDAxMDAgYzdh
YWYwMDAgYzczYjI1NjANCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6
ICAgICAgICBjMDExMjJiYyAwMDAwMDAxMSBjMmE4YTAwMCBjNTQxMDAwMCBi
ZmZmZmJjYyAwMDAwMDAwMCBjNTQxMWZiYyBjMmE4YTAwMA0KSnVsICA4IDIz
OjI2OjQzIGJsdXJwIGtlcm5lbDogICAgICAgIGM1NDExZjk0IDAwMDAwMDAw
IGZmZmZmZmY0IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIGM1NDExZmEw
IGM1NDExZmEwDQpKdWwgIDggMjM6MjY6NDMgYmx1cnAga2VybmVsOiBDYWxs
IFRyYWNlOiBbZG9fZm9yays3NDAvMTgxNl0gW3N5c19mb3JrKzIwLzI4XSBb
c3lzdGVtX2NhbGwrNTEvNTZdDQpKdWwgIDggMjM6MjY6NDMgYmx1cnAga2Vy
bmVsOg0KSnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5lbDogQ29kZTogZmYg
NDAgMTQgODkgNDUgMDAgODMgYzUgMDQgNGEgNzUgZTMgOGIgNDMgMDggMmIg
NDQgMjQgMTQgOGQNCg==
---1463811839-1575457154-994976821=:15527
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=oops2
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107130027011.15527@blurp.slackware.pl>
Content-Description: 
Content-Disposition: attachment; filename=oops2

SnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5lbDogVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwg
YWRkcmVzcyAwMDAwMDdiNA0KSnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5l
bDogIHByaW50aW5nIGVpcDoNCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJu
ZWw6IGMwMTJkNmM2DQpKdWwgIDggMjM6MjY6NDMgYmx1cnAga2VybmVsOiAq
cGRlID0gMDAwMDAwMDANCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6
IE9vcHM6IDAwMDANCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6IENQ
VTogICAgMA0KSnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5lbDogRUlQOiAg
ICAwMDEwOltmaWxwX2Nsb3NlKzYvMTAwXQ0KSnVsICA4IDIzOjI2OjQzIGJs
dXJwIGtlcm5lbDogRUZMQUdTOiAwMDAxMDIwNg0KSnVsICA4IDIzOjI2OjQz
IGJsdXJwIGtlcm5lbDogZWF4OiBjN2FhZWMwMCAgIGVieDogMDAwMDA3YTAg
ICBlY3g6IDAwMDAwMDAwIGVkeDogMDAwMDA3YTANCkp1bCAgOCAyMzoyNjo0
MyBibHVycCBrZXJuZWw6IGVzaTogMDAwMDAwZmYgICBlZGk6IGM3M2IyNTYw
ICAgZWJwOiAwMDAwMDAwOCBlc3A6IGM1NDExZTA0DQpKdWwgIDggMjM6MjY6
NDMgYmx1cnAga2VybmVsOiBkczogMDAxOCAgIGVzOiAwMDE4ICAgc3M6IDAw
MTgNCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6IFByb2Nlc3MgYmFz
aCAocGlkOiA0MzA5LCBzdGFja3BhZ2U9YzU0MTEwMDApDQpKdWwgIDggMjM6
MjY6NDMgYmx1cnAga2VybmVsOiBTdGFjazogMDAwMDAwMDEgMDAwMDAwZmYg
YzAxMTRlYjggMDAwMDA3YTAgYzczYjI1NjAgYzEzZTRiYTAgYzU0MTAwMDAg
MDAwMDAwMGINCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6ICAgICAg
ICAwMDAwMDdiNCBjNzNiMjY4MCBjMDExNTRhZiBjNzNiMjU2MCAwMDAwMDAw
MCBjNTQxMWYwMCBjMDEwZmYzNCBjMDEwNmY2ZQ0KSnVsICA4IDIzOjI2OjQz
IGJsdXJwIGtlcm5lbDogICAgICAgIDAwMDAwMDBiIGMwMTEwMjY3IGMwMWU5
MTllIGM1NDExZjAwIDAwMDAwMDAyIGM1NDEwMDAwIDAwMDAwMDAyIGMwMTBm
ZjM0DQpKdWwgIDggMjM6MjY6NDMgYmx1cnAga2VybmVsOiBDYWxsIFRyYWNl
OiBbcHV0X2ZpbGVzX3N0cnVjdCs4NC8xODhdIFtkb19leGl0KzE5NS81NTZd
IFtkb19wYWdlX2ZhdWx0KzAvMTA2OF0gW2RpZSs2Ni82OF0gW2RvX3BhZ2Vf
ZmF1bHQrODE5LzEwNjhdIFtkb19wYWdlX2ZhdWx0KzAvMTA2OF0gW2xmKzUy
Lzk2XQ0KSnVsICA4IDIzOjI2OjQzIGJsdXJwIGtlcm5lbDogICAgICAgIFtk
b19jb25fdHJvbCszNzQvMzI1Ml0gW2RvX2Nvbl93cml0ZSsxNDE3LzE2MDBd
IFtjaGFuZ2VfdGVybWlvcyszNzIvMzg0XSBbaGFuZGxlX21tX2ZhdWx0KzE0
NS8xOTZdIFtlcnJvcl9jb2RlKzUyLzYwXSBbY29weV9maWxlcyszNzcvNTky
XSBbZG9fZm9yays3NDAvMTgxNl0gW3N5c19mb3JrKzIwLzI4XQ0KSnVsICA4
IDIzOjI2OjQzIGJsdXJwIGtlcm5lbDogICAgICAgIFtzeXN0ZW1fY2FsbCs1
MS81Nl0NCkp1bCAgOCAyMzoyNjo0MyBibHVycCBrZXJuZWw6DQpKdWwgIDgg
MjM6MjY6NDMgYmx1cnAga2VybmVsOiBDb2RlOiA4YiA0MyAxNCA4NSBjMCA3
NSAxMyA2OCA4MiBlNCAxZSBjMCBlOCBhNSA1NiBmZSBmZiAzMSBjMCA4Mw0K

---1463811839-1575457154-994976821=:15527--
