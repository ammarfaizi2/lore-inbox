Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbSLKFOU>; Wed, 11 Dec 2002 00:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSLKFOU>; Wed, 11 Dec 2002 00:14:20 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:3543 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S267013AbSLKFOS>; Wed, 11 Dec 2002 00:14:18 -0500
Date: Wed, 11 Dec 2002 00:21:39 -0500 (EST)
From: Nathaniel Russell <reddog83@chartermi.net>
X-X-Sender: reddog83@reddog.example.net
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, <alan@redhat.com>, <reddog83@chartermi.net>
Subject: [PATCH] AGP support VIA VT8633
Message-ID: <Pine.LNX.4.44.0212110016470.2208-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1767178952-1039584099=:2208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1767178952-1039584099=:2208
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch adds support for the Via VT8633 AGP Bridge. Also this patch has
been tested with a variety of GL apps including the GL ScreenSavers. The
patch includes the via_generic_setup routines and Device ID's.
Please Apply against current 2.4.x Kernel
Nathaniel
CC Me as I'm not subscribed to the list
reddog83@chartermi.net

--8323328-1767178952-1039584099=:2208
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="agpgart.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212110021390.2208@reddog.example.net>
Content-Description: Via VT8633 Support
Content-Disposition: attachment; filename="agpgart.diff"

ZGlmZiAtdXJOIGxpbnV4LWFncC9kcml2ZXJzL2NoYXIvZHJtLTQuMC9hZ3Bz
dXBwb3J0LmN+IGxpbnV4L2RyaXZlcnMvY2hhci9kcm0tNC4wL2FncHN1cHBv
cnQuYw0KLS0tIGxpbnV4LWFncC9kcml2ZXJzL2NoYXIvZHJtLTQuMC9hZ3Bz
dXBwb3J0LmN+CTIwMDItMTItMDMgMjE6MDc6MDguMDAwMDAwMDAwIC0wNTAw
DQorKysgbGludXgvZHJpdmVycy9jaGFyL2RybS00LjAvYWdwc3VwcG9ydC5j
CTIwMDItMTItMTAgMjM6NTI6NDYuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMjc1
LDYgKzI3NSw4IEBADQogCQkJYnJlYWs7DQogCQljYXNlIFZJQV9BUE9MTE9f
S1QxMzM6CWhlYWQtPmNoaXBzZXQgPSAiVklBIEFwb2xsbyBLVDEzMyI7IA0K
IAkJCWJyZWFrOw0KKwkJY2FzZSBWSUFfQVBPTExPX1BSTzI2NgloZWFkLT5j
aGlwc2V0ID0gIlZJQSBBcG9sbG8gUHJvMjY2IjsNCisJCQlicmVhazsNCiAj
ZW5kaWYNCiANCiAJCWNhc2UgVklBX0FQT0xMT19QUk86IAloZWFkLT5jaGlw
c2V0ID0gIlZJQSBBcG9sbG8gUHJvIjsNCmRpZmYgLXVyTiBsaW51eC1hZ3Av
ZHJpdmVycy9jaGFyL2RybS9kcm1fYWdwc3VwcG9ydC5ofiBsaW51eC9kcml2
ZXJzL2NoYXIvZHJtL2RybV9hZ3BzdXBwb3J0LmgNCi0tLSBsaW51eC1hZ3Av
ZHJpdmVycy9jaGFyL2RybS9kcm1fYWdwc3VwcG9ydC5ofgkyMDAyLTEyLTA2
IDAyOjA3OjM0LjAwMDAwMDAwMCAtMDUwMA0KKysrIGxpbnV4L2RyaXZlcnMv
Y2hhci9kcm0vZHJtX2FncHN1cHBvcnQuaAkyMDAyLTEyLTEwIDIzOjUwOjQz
LjAwMDAwMDAwMCAtMDUwMA0KQEAgLTI4MSw2ICsyODEsOCBAQA0KIAkJCWJy
ZWFrOw0KIAkJY2FzZSBWSUFfQVBPTExPX1BSTzogCWhlYWQtPmNoaXBzZXQg
PSAiVklBIEFwb2xsbyBQcm8iOw0KIAkJCWJyZWFrOw0KKwkJY2FzZSBWSUFf
QVBPTExPX1BSTzI2NgloZWFkLT5jaGlwc2V0ID0gIlZJQSBBcG9sbG8gUHJv
MjY2IjsNCisJCQlicmVhazsNCiANCiAJCWNhc2UgU0lTX0dFTkVSSUM6CWhl
YWQtPmNoaXBzZXQgPSAiU2lTIjsgICAgICAgICAgIGJyZWFrOw0KIAkJY2Fz
ZSBBTURfR0VORVJJQzoJaGVhZC0+Y2hpcHNldCA9ICJBTUQiOyAgICAgICAg
ICAgYnJlYWs7DQpkaWZmIC11ck4gbGludXgtYWdwL2luY2x1ZGUvbGludXgv
YWdwX2JhY2tlbmQuaH4gbGludXgvaW5jbHVkZS9hZ3BfYmFja2VuZC5oDQot
LS0gbGludXgtYWdwL2luY2x1ZGUvbGludXgvYWdwX2JhY2tlbmQuaH4JMjAw
Mi0xMi0wMyAyMTowNzowOS4wMDAwMDAwMDAgLTA1MDANCisrKyBsaW51eC9p
bmNsdWRlL2xpbnV4L2FncF9iYWNrZW5kLmgJMjAwMi0xMi0xMCAwNDoyNTo1
OS4wMDAwMDAwMDAgLTA1MDANCkBAIC01Nyw2ICs1Nyw3IEBADQogCVZJQV9W
UDMsDQogCVZJQV9NVlAzLA0KIAlWSUFfTVZQNCwNCisJVklBX0FQT0xMT19Q
Uk8yNjYsDQogCVZJQV9BUE9MTE9fUFJPLA0KIAlWSUFfQVBPTExPX0tYMTMz
LA0KIAlWSUFfQVBPTExPX0tUMTMzLA0KZGlmZiAtdXJOIGxpbnV4LWFncC9k
cml2ZXJzL2NoYXIvYWdwL2FncGdhcnRfYmUuY34gbGludXgvZHJpdmVycy9j
aGFyL2FncC9hZ3BnYXJ0X2JlLmMNCi0tLSBsaW51eC1hZ3AvZHJpdmVycy9j
aGFyL2FncC9hZ3BnYXJ0X2JlLmN+CTIwMDItMTItMDIgMTk6MjA6MjIuMDAw
MDAwMDAwIC0wNTAwDQorKysgbGludXgvZHJpdmVycy9jaGFyL2FncC9hZ3Bn
YXJ0X2JlLmMJMjAwMi0xMi0wNyAwNDowOTo1OS4wMDAwMDAwMDAgLTA1MDAN
CkBAIC00NzE0LDYgKzQ3MTQsMTIgQEANCiAJCSJWaWEiLA0KIAkJIkFwb2xs
byBQcm8gS1QyNjYiLA0KIAkJdmlhX2dlbmVyaWNfc2V0dXAgfSwNCisJeyBQ
Q0lfREVWSUNFX0lEX1ZJQV84NjMzXzAsDQorCQlQQ0lfVkVORE9SX0lEX1ZJ
QSwNCisJCVZJQV9BUE9MTE9fUFJPMjY2LA0KKwkJIlZpYSIsDQorCQkiQXBv
bGxvIFBybzI2NiIsDQorCQl2aWFfZ2VuZXJpY19zZXR1cCB9LA0KIAl7IDAs
DQogCQlQQ0lfVkVORE9SX0lEX1ZJQSwNCiAJCVZJQV9HRU5FUklDLA0K
--8323328-1767178952-1039584099=:2208--
