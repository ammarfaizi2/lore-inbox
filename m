Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSJ1IBI>; Mon, 28 Oct 2002 03:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJ1IBI>; Mon, 28 Oct 2002 03:01:08 -0500
Received: from [151.17.201.167] ([151.17.201.167]:13574 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S263143AbSJ1IBG>;
	Mon, 28 Oct 2002 03:01:06 -0500
Message-ID: <3DBCEF86.90DE507C@teamfab.it>
Date: Mon, 28 Oct 2002 09:04:22 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
Organization: TeamSystem Spa
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.2.22-svil i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Decision PCCOM4/PCCOM8 serial support for 2.4.19
Content-Type: multipart/mixed;
 boundary="------------6BDC936ED2A380BF1CE17C3D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6BDC936ED2A380BF1CE17C3D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch add support for the Decision PCCOM 4 and 8 ports pci cards.
The patch was made and tested on a 2.4.19 kernel with the standard
serial driver.

thanks,
luca
--------------6BDC936ED2A380BF1CE17C3D
Content-Type: application/x-patch;
 name="serial_decision.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="serial_decision.patch"

ZGlmZiAtdXIgbGludXgvZHJpdmVycy9jaGFyL3NlcmlhbC5jLm9yaWcgbGludXgvZHJpdmVy
cy9jaGFyL3NlcmlhbC5jCi0tLSBsaW51eC9kcml2ZXJzL2NoYXIvc2VyaWFsLmMub3JpZwlN
b24gQXVnIDE5IDEyOjAzOjEyIDIwMDIKKysrIGxpbnV4L2RyaXZlcnMvY2hhci9zZXJpYWwu
YwlGcmkgT2N0IDI1IDE2OjU1OjU1IDIwMDIKQEAgLTQzNDgsOSArNDM0OCwxMCBAQAogI2lm
ZGVmIENPTkZJR19EREI1MDc0CiAJcGJuX25lY19uaWxlNCwKICNlbmRpZgotI2lmIDAKKwor
CXBibl9kY2lfcGNjb200LAogCXBibl9kY2lfcGNjb204LAotI2VuZGlmCisKIAlwYm5feGly
Y29tX2NvbWJvLAogCiAJcGJuX3NpaWcxMHhfMCwKQEAgLTQ0NDQsOSArNDQ0NSwxMCBAQAog
CXsgU1BDSV9GTF9CQVNFMCwgMSwgNTIwODMzLAkJCSAgIC8qIHBibl9uZWNfbmlsZTQgKi8K
IAkJNjQsIDMsIE5VTEwsIDB4MzAwIH0sCiAjZW5kaWYKLSNpZiAwCS8qIFBDSV9ERVZJQ0Vf
SURfRENJX1BDQ09NOCA/ICovCQkgICAvKiBwYm5fZGNpX3BjY29tOCAqLwotCXsgU1BDSV9G
TF9CQVNFMywgOCwgMTE1MjAwLCA4IH0sCi0jZW5kaWYKKworCXtTUENJX0ZMX0JBU0UzLCA0
LCAxMTUyMDAsIDh9LAkJCSAgIC8qIHBibl9kY2lfcGNjb200ICovCisJe1NQQ0lfRkxfQkFT
RTMsIDgsIDExNTIwMCwgOH0sCQkJICAgLyogcGJuX2RjaV9wY2NvbTggKi8KKwogCXsgU1BD
SV9GTF9CQVNFMCwgMSwgMTE1MjAwLAkJCSAgLyogcGJuX3hpcmNvbV9jb21ibyAqLwogCQkw
LCAwLCBwY2lfeGlyY29tX2ZuIH0sCiAKQEAgLTQ5MDcsMTEgKzQ5MDksMTIgQEAKIAkJcGJu
X25lY19uaWxlNCB9LAogI2VuZGlmCiAKLSNpZiAwCS8qIFBDSV9ERVZJQ0VfSURfRENJX1BD
Q09NOCA/ICovCisJewlQQ0lfVkVORE9SX0lEX0RDSSwgUENJX0RFVklDRV9JRF9EQ0lfUEND
T000LAorCQlQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLAorCQlwYm5fZGNpX3BjY29t
NCB9LAogCXsJUENJX1ZFTkRPUl9JRF9EQ0ksIFBDSV9ERVZJQ0VfSURfRENJX1BDQ09NOCwK
IAkJUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwKIAkJcGJuX2RjaV9wY2NvbTggfSwK
LSNlbmRpZgogCiAgICAgICAgeyBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lE
LCBQQ0lfQU5ZX0lELAogCSBQQ0lfQ0xBU1NfQ09NTVVOSUNBVElPTl9TRVJJQUwgPDwgOCwg
MHhmZmZmMDAsIH0sCg==
--------------6BDC936ED2A380BF1CE17C3D--

