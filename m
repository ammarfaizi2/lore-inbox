Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLJXUK>; Sun, 10 Dec 2000 18:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbQLJXUA>; Sun, 10 Dec 2000 18:20:00 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:31633 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129431AbQLJXTq>; Sun, 10 Dec 2000 18:19:46 -0500
Date: Sun, 10 Dec 2000 17:49:10 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Urban Widmark <urban@teststation.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre8
In-Reply-To: <Pine.LNX.4.21.0012102259450.21029-100000@cola.svenskatest.se>
Message-ID: <Pine.LNX.4.30.0012101747060.1352-200000@viper.haque.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-813913991-976488550=:1352"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-813913991-976488550=:1352
Content-Type: TEXT/PLAIN; charset=US-ASCII

I think you're right. Here's an update to what I submitted before. I'll
be submitting more patches as I encounter more.

On Sun, 10 Dec 2000, Urban Widmark wrote:
> or just leaving the list as it is. It will be initialized anyway by
> schedule_task (queue_task), but using the init macro seems like a nice
> thing to do.
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

---1463811839-813913991-976488550=:1352
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tq_struct-t12p8-fix-2.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0012101749100.1352@viper.haque.net>
Content-Description: 
Content-Disposition: attachment; filename="tq_struct-t12p8-fix-2.diff"

LS0tIGxpbnV4L2RyaXZlcnMvaTJvL2kyb19sYW4uYwlTdW4gRGVjIDEwIDE0
OjE3OjIyIDIwMDANCisrKyBsaW51eC0yLjQuMC10ZXN0MTIubWhhcXVlL2Ry
aXZlcnMvaTJvL2kyb19sYW4uYwlTdW4gRGVjIDEwIDE0OjI4OjI3IDIwMDAN
CkBAIC0xMTIsOCArMTEyLDEwIEBADQogfTsNCiBzdGF0aWMgaW50IGxhbl9j
b250ZXh0Ow0KIA0KLXN0YXRpYyBzdHJ1Y3QgdHFfc3RydWN0IGkyb19wb3N0
X2J1Y2tldHNfdGFzayA9IHsNCi0JMCwgMCwgKHZvaWQgKCopKHZvaWQgKikp
aTJvX2xhbl9yZWNlaXZlX3Bvc3QsICh2b2lkICopIDANCitERUNMQVJFX1RB
U0tfUVVFVUUoaTJvX3Bvc3RfYnVja2V0c190YXNrKTsNCitzdHJ1Y3QgdHFf
c3RydWN0IHJ1bl9pMm9fcG9zdF9idWNrZXRzX3Rhc2sgPSB7DQorCXJvdXRp
bmU6ICh2b2lkICgqKSh2b2lkICopKSBydW5fdGFza19xdWV1ZSwNCisJZGF0
YTogKHZvaWQgKikgMA0KIH07DQogDQogLyogRnVuY3Rpb25zIHRvIGhhbmRs
ZSBtZXNzYWdlIGZhaWx1cmVzIGFuZCB0cmFuc2FjdGlvbiBlcnJvcnM6DQpA
QCAtMzc5LDggKzM4MSw4IEBADQogCS8qIElmIERETSBoYXMgYWxyZWFkeSBj
b25zdW1lZCBidWNrZXRfdGhyZXNoIGJ1Y2tldHMsIHBvc3QgbmV3IG9uZXMg
Ki8NCiANCiAJaWYgKGF0b21pY19yZWFkKCZwcml2LT5idWNrZXRzX291dCkg
PD0gcHJpdi0+bWF4X2J1Y2tldHNfb3V0IC0gcHJpdi0+YnVja2V0X3RocmVz
aCkgew0KLQkJaTJvX3Bvc3RfYnVja2V0c190YXNrLmRhdGEgPSAodm9pZCAq
KWRldjsNCi0JCXF1ZXVlX3Rhc2soJmkyb19wb3N0X2J1Y2tldHNfdGFzaywg
JnRxX2ltbWVkaWF0ZSk7DQorCQlydW5faTJvX3Bvc3RfYnVja2V0c190YXNr
LmRhdGEgPSAodm9pZCAqKWRldjsNCisJCXF1ZXVlX3Rhc2soJnJ1bl9pMm9f
cG9zdF9idWNrZXRzX3Rhc2ssICZ0cV9pbW1lZGlhdGUpOw0KIAkJbWFya19i
aChJTU1FRElBVEVfQkgpOw0KIAl9DQogDQpAQCAtMTQwMSw3ICsxNDAzLDcg
QEANCiAJYXRvbWljX3NldCgmcHJpdi0+dHhfb3V0LCAwKTsNCiAJcHJpdi0+
dHhfY291bnQgPSAwOw0KIA0KLQlwcml2LT5pMm9fYmF0Y2hfc2VuZF90YXNr
Lm5leHQgICAgPSBOVUxMOw0KKwlJTklUX0xJU1RfSEVBRCgmcHJpdi0+aTJv
X2JhdGNoX3NlbmRfdGFzay5saXN0KTsNCiAJcHJpdi0+aTJvX2JhdGNoX3Nl
bmRfdGFzay5zeW5jICAgID0gMDsNCiAJcHJpdi0+aTJvX2JhdGNoX3NlbmRf
dGFzay5yb3V0aW5lID0gKHZvaWQgKilpMm9fbGFuX2JhdGNoX3NlbmQ7DQog
CXByaXYtPmkyb19iYXRjaF9zZW5kX3Rhc2suZGF0YSAgICA9ICh2b2lkICop
ZGV2Ow0KLS0tIGxpbnV4L2RyaXZlcnMvbmV0L2Fpcm9uZXQ0NTAwX2NvcmUu
YwlTdW4gRGVjIDEwIDE0OjMwOjIwIDIwMDANCisrKyBsaW51eC0yLjQuMC10
ZXN0MTIubWhhcXVlL2RyaXZlcnMvbmV0L2Fpcm9uZXQ0NTAwX2NvcmUuYwlT
dW4gRGVjIDEwIDE0OjMxOjA0IDIwMDANCkBAIC0yODY4LDcgKzI4NjgsNyBA
QA0KIAkNCiAJcHJpdi0+Y29tbWFuZF9zZW1hcGhvcmVfb24gPSAwOw0KIAlw
cml2LT51bmxvY2tfY29tbWFuZF9wb3N0cG9uZWQgPSAwOw0KLQlwcml2LT5p
bW1lZGlhdGVfYmgubmV4dCAJPSBOVUxMOw0KKwlJTklUX0xJU1RfSEVBRCgm
cHJpdi0+aW1tZWRpYXRlX2JoLmxpc3QpOw0KIAlwcml2LT5pbW1lZGlhdGVf
Ymguc3luYyAJPSAwOw0KIAlwcml2LT5pbW1lZGlhdGVfYmgucm91dGluZSAJ
PSAodm9pZCAqKSh2b2lkICopYXdjX2JoOw0KIAlwcml2LT5pbW1lZGlhdGVf
YmguZGF0YSAJPSBkZXY7DQotLS0gbGludXgvZHJpdmVycy91c2Ivc2VyaWFs
L2tleXNwYW5fcGRhLmMJU3VuIERlYyAxMCAxMzo1NToyNSAyMDAwDQorKysg
bGludXgtMi40LjAtdGVzdDEyLm1oYXF1ZS9kcml2ZXJzL3VzYi9zZXJpYWwv
a2V5c3Bhbl9wZGEuYwlTdW4gRGVjIDEwIDE0OjExOjE4IDIwMDANCkBAIC03
NDIsMTEgKzc0MiwxMSBAQA0KIAlpZiAoIXByaXYpDQogCQlyZXR1cm4gKDEp
OyAvKiBlcnJvciAqLw0KIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZzZXJpYWwt
PnBvcnRbMF0ud3JpdGVfd2FpdCk7DQotCXByaXYtPndha2V1cF90YXNrLm5l
eHQgPSBOVUxMOw0KKwlJTklUX0xJU1RfSEVBRCgmcHJpdi0+d2FrZXVwX3Rh
c2subGlzdCk7DQogCXByaXYtPndha2V1cF90YXNrLnN5bmMgPSAwOw0KIAlw
cml2LT53YWtldXBfdGFzay5yb3V0aW5lID0gKHZvaWQgKilrZXlzcGFuX3Bk
YV93YWtldXBfd3JpdGU7DQogCXByaXYtPndha2V1cF90YXNrLmRhdGEgPSAo
dm9pZCAqKSgmc2VyaWFsLT5wb3J0WzBdKTsNCi0JcHJpdi0+dW50aHJvdHRs
ZV90YXNrLm5leHQgPSBOVUxMOw0KKwlJTklUX0xJU1RfSEVBRCgmcHJpdi0+
dW50aHJvdHRsZV90YXNrLmxpc3QpOw0KIAlwcml2LT51bnRocm90dGxlX3Rh
c2suc3luYyA9IDA7DQogCXByaXYtPnVudGhyb3R0bGVfdGFzay5yb3V0aW5l
ID0gKHZvaWQgKilrZXlzcGFuX3BkYV9yZXF1ZXN0X3VudGhyb3R0bGU7DQog
CXByaXYtPnVudGhyb3R0bGVfdGFzay5kYXRhID0gKHZvaWQgKikoc2VyaWFs
KTsNCi0tLSBsaW51eC9mcy9zbWJmcy9zb2NrLmMJU3VuIERlYyAxMCAxNDoz
Mzo0OSAyMDAwDQorKysgbGludXgtMi40LjAtdGVzdDEyLm1oYXF1ZS9mcy9z
bWJmcy9zb2NrLmMJU3VuIERlYyAxMCAxNDozNDoyOCAyMDAwDQpAQCAtMTYz
LDcgKzE2Myw3IEBADQogCQlmb3VuZF9kYXRhKHNrKTsNCiAJCXJldHVybjsN
CiAJfQ0KLQlqb2ItPmNiLm5leHQgPSBOVUxMOw0KKwlJTklUX0xJU1RfSEVB
RCgmam9iLT5jYi5saXN0KTsNCiAJam9iLT5jYi5zeW5jID0gMDsNCiAJam9i
LT5jYi5yb3V0aW5lID0gc21iX2RhdGFfY2FsbGJhY2s7DQogCWpvYi0+Y2Iu
ZGF0YSA9IGpvYjsNCg==
---1463811839-813913991-976488550=:1352--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
