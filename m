Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRHYOJw>; Sat, 25 Aug 2001 10:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269186AbRHYOJn>; Sat, 25 Aug 2001 10:09:43 -0400
Received: from 24-240-45-22.hsacorp.net ([24.240.45.22]:39143 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id <S269184AbRHYOJ3>; Sat, 25 Aug 2001 10:09:29 -0400
Date: Sat, 25 Aug 2001 10:03:38 -0400 (EDT)
From: Kernel Related Emails <kernel@penguin.linuxhardware.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Support for new chipsets in AGPGART
Message-ID: <Pine.LNX.4.21.0108250959130.23530-200000@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-266856915-1698956188-998748218=:23530"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---266856915-1698956188-998748218=:23530
Content-Type: TEXT/PLAIN; charset=US-ASCII

Attached is a patch to identify two new chipsets in the AGP kernel
module.  It adds support for a newer version of the AMD Irongate and the
new VIA KT266 chipset.  I have tested both of these.  The AMD patch was
needed on the MSI K7 Master-S and the VIA was needed on the SOYO
K7VDRAGON.

Enjoy,
Kris Kersey
LinuxHardware.org Site Manager
augustus@linuxhardware.org

---266856915-1698956188-998748218=:23530
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="agpviaamd.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0108251003380.23530@penguin.linuxhardware.org>
Content-Description: 
Content-Disposition: attachment; filename="agpviaamd.patch"

ZGlmZiAtdXJOIGxpbnV4L2RyaXZlcnMvY2hhci9hZ3AvYWdwLmggbGludXgt
a2svZHJpdmVycy9jaGFyL2FncC9hZ3AuaA0KLS0tIGxpbnV4L2RyaXZlcnMv
Y2hhci9hZ3AvYWdwLmgJV2VkIEF1ZyAxNSAwNDoyMjoxNSAyMDAxDQorKysg
bGludXgta2svZHJpdmVycy9jaGFyL2FncC9hZ3AuaAlTYXQgQXVnIDI1IDA5
OjU2OjQyIDIwMDENCkBAIC0xNTYsNiArMTU2LDkgQEANCiAjaWZuZGVmIFBD
SV9ERVZJQ0VfSURfVklBXzgzNjNfMA0KICNkZWZpbmUgUENJX0RFVklDRV9J
RF9WSUFfODM2M18wICAgICAgMHgwMzA1DQogI2VuZGlmDQorI2lmbmRlZiBQ
Q0lfREVWSUNFX0lEX1ZJQV84MzY2XzANCisjZGVmaW5lIFBDSV9ERVZJQ0Vf
SURfVklBXzgzNjZfMCAgICAgIDB4MzA5OQ0KKyNlbmRpZg0KICNpZm5kZWYg
UENJX0RFVklDRV9JRF9JTlRFTF84MTBfMA0KICNkZWZpbmUgUENJX0RFVklD
RV9JRF9JTlRFTF84MTBfMCAgICAgICAweDcxMjANCiAjZW5kaWYNCkBAIC0x
OTQsNiArMTk3LDkgQEANCiAjZW5kaWYNCiAjaWZuZGVmIFBDSV9ERVZJQ0Vf
SURfQU1EX0lST05HQVRFXzANCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfQU1E
X0lST05HQVRFXzAgICAgMHg3MDA2DQorI2VuZGlmDQorI2lmbmRlZiBQQ0lf
REVWSUNFX0lEX0FNRF9JUk9OR0FURV8xDQorI2RlZmluZSBQQ0lfREVWSUNF
X0lEX0FNRF9JUk9OR0FURV8xICAgIDB4NzAwZQ0KICNlbmRpZg0KICNpZm5k
ZWYgUENJX1ZFTkRPUl9JRF9BTA0KICNkZWZpbmUgUENJX1ZFTkRPUl9JRF9B
TAkJMHgxMGI5DQpkaWZmIC11ck4gbGludXgvZHJpdmVycy9jaGFyL2FncC9h
Z3BnYXJ0X2JlLmMgbGludXgta2svZHJpdmVycy9jaGFyL2FncC9hZ3BnYXJ0
X2JlLmMNCi0tLSBsaW51eC9kcml2ZXJzL2NoYXIvYWdwL2FncGdhcnRfYmUu
YwlXZWQgQXVnIDE1IDA0OjIyOjE1IDIwMDENCisrKyBsaW51eC1ray9kcml2
ZXJzL2NoYXIvYWdwL2FncGdhcnRfYmUuYwlTYXQgQXVnIDI1IDA5OjU2OjQy
IDIwMDENCkBAIC0yODc3LDYgKzI4NzcsMTIgQEANCiAJCSJBTUQiLA0KIAkJ
Iklyb25nYXRlIiwNCiAJCWFtZF9pcm9uZ2F0ZV9zZXR1cCB9LA0KKwl7IFBD
SV9ERVZJQ0VfSURfQU1EX0lST05HQVRFXzEsDQorCQlQQ0lfVkVORE9SX0lE
X0FNRCwNCisJCUFNRF9JUk9OR0FURSwNCisJCSJBTUQiLA0KKwkJIklyb25n
YXRlIiwNCisJCWFtZF9pcm9uZ2F0ZV9zZXR1cCB9LA0KIAl7IDAsDQogCQlQ
Q0lfVkVORE9SX0lEX0FNRCwNCiAJCUFNRF9HRU5FUklDLA0KQEAgLTMwMjQs
NiArMzAzMCwxMiBAQA0KIAkJVklBX0FQT0xMT19LVDEzMywNCiAJCSJWaWEi
LA0KIAkJIkFwb2xsbyBQcm8gS1QxMzMiLA0KKwkJdmlhX2dlbmVyaWNfc2V0
dXAgfSwNCisJeyBQQ0lfREVWSUNFX0lEX1ZJQV84MzY2XzAsDQorCQlQQ0lf
VkVORE9SX0lEX1ZJQSwNCisJCVZJQV9BUE9MTE9fS1QxMzMsDQorCQkiVmlh
IiwNCisJCSJBcG9sbG8gUHJvIEtUMjY2IiwNCiAJCXZpYV9nZW5lcmljX3Nl
dHVwIH0sDQogCXsgMCwNCiAJCVBDSV9WRU5ET1JfSURfVklBLA0K
---266856915-1698956188-998748218=:23530--
