Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSLKF7X>; Wed, 11 Dec 2002 00:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSLKF7X>; Wed, 11 Dec 2002 00:59:23 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:6804 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S265650AbSLKF7W>; Wed, 11 Dec 2002 00:59:22 -0500
Date: Wed, 11 Dec 2002 01:06:46 -0500 (EST)
From: Nathaniel Russell <reddog83@chartermi.net>
X-X-Sender: reddog83@reddog.example.net
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, <alan@redhat.com>
Subject: [PATCH] AGP support VIA VT8633
In-Reply-To: <Pine.LNX.4.44.0212110016470.2208-200000@reddog.example.net>
Message-ID: <Pine.LNX.4.44.0212110105450.3107-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2092698225-1039586806=:3107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-2092698225-1039586806=:3107
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch adds support for the Via VT8633 AGP Bridge. Also this patch has
been tested with a variety of GL apps including the GL ScreenSavers. The
patch includes the via_generic_setup routines and Device ID's.
Please Apply against current 2.4.x Kernel
Nathaniel
CC Me as I'm not subscribed to the list
reddog83@chartermi.net

THIS IS A REVISED PATCH

--8323328-2092698225-1039586806=:3107
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="agpgart.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212110106460.3107@reddog.example.net>
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
IAkJCWJyZWFrOw0KKwkJY2FzZSBWSUFfQVBPTExPX1BSTzI2NjoJaGVhZC0+
Y2hpcHNldCA9ICJWSUEgQXBvbGxvIFBybzI2NiI7DQorCQkJYnJlYWs7DQog
I2VuZGlmDQogDQogCQljYXNlIFZJQV9BUE9MTE9fUFJPOiAJaGVhZC0+Y2hp
cHNldCA9ICJWSUEgQXBvbGxvIFBybyI7DQpkaWZmIC11ck4gbGludXgtYWdw
L2RyaXZlcnMvY2hhci9kcm0vZHJtX2FncHN1cHBvcnQuaH4gbGludXgvZHJp
dmVycy9jaGFyL2RybS9kcm1fYWdwc3VwcG9ydC5oDQotLS0gbGludXgtYWdw
L2RyaXZlcnMvY2hhci9kcm0vZHJtX2FncHN1cHBvcnQuaH4JMjAwMi0xMi0w
NiAwMjowNzozNC4wMDAwMDAwMDAgLTA1MDANCisrKyBsaW51eC9kcml2ZXJz
L2NoYXIvZHJtL2RybV9hZ3BzdXBwb3J0LmgJMjAwMi0xMi0xMCAyMzo1MDo0
My4wMDAwMDAwMDAgLTA1MDANCkBAIC0yODEsNiArMjgxLDggQEANCiAJCQli
cmVhazsNCiAJCWNhc2UgVklBX0FQT0xMT19QUk86IAloZWFkLT5jaGlwc2V0
ID0gIlZJQSBBcG9sbG8gUHJvIjsNCiAJCQlicmVhazsNCisJCWNhc2UgVklB
X0FQT0xMT19QUk8yNjY6CWhlYWQtPmNoaXBzZXQgPSAiVklBIEFwb2xsbyBQ
cm8yNjYiOw0KKwkJCWJyZWFrOw0KIA0KIAkJY2FzZSBTSVNfR0VORVJJQzoJ
aGVhZC0+Y2hpcHNldCA9ICJTaVMiOyAgICAgICAgICAgYnJlYWs7DQogCQlj
YXNlIEFNRF9HRU5FUklDOgloZWFkLT5jaGlwc2V0ID0gIkFNRCI7ICAgICAg
ICAgICBicmVhazsNCmRpZmYgLXVyTiBsaW51eC1hZ3AvaW5jbHVkZS9saW51
eC9hZ3BfYmFja2VuZC5ofiBsaW51eC9pbmNsdWRlL2FncF9iYWNrZW5kLmgN
Ci0tLSBsaW51eC1hZ3AvaW5jbHVkZS9saW51eC9hZ3BfYmFja2VuZC5ofgky
MDAyLTEyLTAzIDIxOjA3OjA5LjAwMDAwMDAwMCAtMDUwMA0KKysrIGxpbnV4
L2luY2x1ZGUvbGludXgvYWdwX2JhY2tlbmQuaAkyMDAyLTEyLTEwIDA0OjI1
OjU5LjAwMDAwMDAwMCAtMDUwMA0KQEAgLTU3LDYgKzU3LDcgQEANCiAJVklB
X1ZQMywNCiAJVklBX01WUDMsDQogCVZJQV9NVlA0LA0KKwlWSUFfQVBPTExP
X1BSTzI2NiwNCiAJVklBX0FQT0xMT19QUk8sDQogCVZJQV9BUE9MTE9fS1gx
MzMsDQogCVZJQV9BUE9MTE9fS1QxMzMsDQpkaWZmIC11ck4gbGludXgtYWdw
L2RyaXZlcnMvY2hhci9hZ3AvYWdwZ2FydF9iZS5jfiBsaW51eC9kcml2ZXJz
L2NoYXIvYWdwL2FncGdhcnRfYmUuYw0KLS0tIGxpbnV4LWFncC9kcml2ZXJz
L2NoYXIvYWdwL2FncGdhcnRfYmUuY34JMjAwMi0xMi0wMiAxOToyMDoyMi4w
MDAwMDAwMDAgLTA1MDANCisrKyBsaW51eC9kcml2ZXJzL2NoYXIvYWdwL2Fn
cGdhcnRfYmUuYwkyMDAyLTEyLTA3IDA0OjA5OjU5LjAwMDAwMDAwMCAtMDUw
MA0KQEAgLTQ3MTQsNiArNDcxNCwxMiBAQA0KIAkJIlZpYSIsDQogCQkiQXBv
bGxvIFBybyBLVDI2NiIsDQogCQl2aWFfZ2VuZXJpY19zZXR1cCB9LA0KKwl7
IFBDSV9ERVZJQ0VfSURfVklBXzg2MzNfMCwNCisJCVBDSV9WRU5ET1JfSURf
VklBLA0KKwkJVklBX0FQT0xMT19QUk8yNjYsDQorCQkiVmlhIiwNCisJCSJB
cG9sbG8gUHJvMjY2IiwNCisJCXZpYV9nZW5lcmljX3NldHVwIH0sDQogCXsg
MCwNCiAJCVBDSV9WRU5ET1JfSURfVklBLA0KIAkJVklBX0dFTkVSSUMsDQo=
--8323328-2092698225-1039586806=:3107--
