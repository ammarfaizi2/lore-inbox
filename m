Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135226AbRDVF7W>; Sun, 22 Apr 2001 01:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135228AbRDVF7N>; Sun, 22 Apr 2001 01:59:13 -0400
Received: from viper.haque.net ([66.88.179.82]:3456 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135226AbRDVF7E>;
	Sun, 22 Apr 2001 01:59:04 -0400
Date: Sun, 22 Apr 2001 01:59:03 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: i386 __builtin_expect compile fix
Message-ID: <Pine.LNX.4.32.0104220156540.2555-200000@viper.haque.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1480741555-2108335589-987919143=:2555"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1480741555-2108335589-987919143=:2555
Content-Type: TEXT/PLAIN; charset=US-ASCII

This should work. Its based on how __builtin_expect is handled on the
alpha for compilers < gcc 2.96.

Compiled but not tested.
-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

--1480741555-2108335589-987919143=:2555
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.4.4-p6-builtin_expect.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.32.0104220159030.2555@viper.haque.net>
Content-Description: 
Content-Disposition: attachment; filename="2.4.4-p6-builtin_expect.diff"

LS0tIGxpbnV4L2luY2x1ZGUvYXNtLWkzODYvc2VtYXBob3JlLmgub3JpZwlT
dW4gQXByIDIyIDAxOjA0OjU4IDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2Fz
bS1pMzg2L3NlbWFwaG9yZS5oCVN1biBBcHIgMjIgMDE6MjY6MjcgMjAwMQ0K
QEAgLTM4LDYgKzM4LDcgQEANCiANCiAjaW5jbHVkZSA8YXNtL3N5c3RlbS5o
Pg0KICNpbmNsdWRlIDxhc20vYXRvbWljLmg+DQorI2luY2x1ZGUgPGFzbS9j
b21waWxlci5oPiAvKiBfX2J1aWx0aW5fZXhwZWN0ICovDQogI2luY2x1ZGUg
PGxpbnV4L3dhaXQuaD4NCiAjaW5jbHVkZSA8bGludXgvcndzZW0uaD4NCiAN
Ci0tLSBsaW51eC9pbmNsdWRlL2FzbS1pMzg2L2NvbXBpbGVyLmgub3JpZwlT
dW4gQXByIDIyIDAxOjM0OjI4IDIwMDENCisrKyBsaW51eC9pbmNsdWRlL2Fz
bS1pMzg2L2NvbXBpbGVyLmgJU3VuIEFwciAyMiAwMTozNDozNiAyMDAxDQpA
QCAtMCwwICsxLDEzIEBADQorI2lmbmRlZiBfX0kzODZfQ09NUElMRVJfSA0K
KyNkZWZpbmUgX19JMzg2X0NPTVBJTEVSX0gNCisNCisvKiBTb21ld2hlcmUg
aW4gdGhlIG1pZGRsZSBvZiB0aGUgR0NDIDIuOTYgZGV2ZWxvcG1lbnQgY3lj
bGUsIHdlIGltcGxlbWVudGVkDQorICAgYSBtZWNoYW5pc20gYnkgd2hpY2gg
dGhlIHVzZXIgY2FuIGFubm90YXRlIGxpa2VseSBicmFuY2ggZGlyZWN0aW9u
cyBhbmQNCisgICBleHBlY3QgdGhlIGJsb2NrcyB0byBiZSByZW9yZGVyZWQg
YXBwcm9wcmlhdGVseS4gIERlZmluZSBfX2J1aWx0aW5fZXhwZWN0DQorICAg
dG8gbm90aGluZyBmb3IgZWFybGllciBjb21waWxlcnMuICAqLw0KKw0KKyNp
ZiBfX0dOVUNfXyA9PSAyICYmIF9fR05VQ19NSU5PUl9fIDwgOTYNCisjZGVm
aW5lIF9fYnVpbHRpbl9leHBlY3QoeCwgZXhwZWN0ZWRfdmFsdWUpICh4KQ0K
KyNlbmRpZg0KKw0KKyNlbmRpZiAvKiBfX0kzODZfQ09NUElMRVJfSCAqLw0K

--1480741555-2108335589-987919143=:2555--
