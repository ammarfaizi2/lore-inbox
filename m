Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbQKGXVH>; Tue, 7 Nov 2000 18:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129591AbQKGXUs>; Tue, 7 Nov 2000 18:20:48 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:50191 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129270AbQKGXUj>; Tue, 7 Nov 2000 18:20:39 -0500
Date: Wed, 8 Nov 2000 00:20:46 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, andre@linux-ide.org
Subject: [PATCH] 
Message-ID: <Pine.LNX.4.21.0011080016060.1772-200000@tricky>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-703745271-973639246=:1772"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-703745271-973639246=:1772
Content-Type: TEXT/PLAIN; charset=US-ASCII


Patch fixes ide-disk/ide-floppy/ide-probe modules interaction
with /proc fs. Last chunk is needed to compile ide-probe as
module without /proc support.

--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

--8323328-703745271-973639246=:1772
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="240t10p6-ide_procfs.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0011080020460.1772@tricky>
Content-Description: 
Content-Disposition: attachment; filename="240t10p6-ide_procfs.diff"

LS0tIGxpbnV4LTI0MHQxMHA2L2RyaXZlcnMvaWRlL2lkZS1kaXNrLmMJVGh1
IE9jdCAxOSAyMjowNTowMSAyMDAwDQorKysgbGludXgvZHJpdmVycy9pZGUv
aWRlLWRpc2suYwlTYXQgT2N0IDI4IDIyOjU5OjIyIDIwMDANCkBAIC04OTEs
OCArODkxLDEwIEBADQogCQl9DQogCQkvKiBXZSBtdXN0IHJlbW92ZSBwcm9j
IGVudHJpZXMgZGVmaW5lZCBpbiB0aGlzIG1vZHVsZS4NCiAJCSAgIE90aGVy
d2lzZSB3ZSBvb3BzIHdoaWxlIGFjY2Vzc2luZyB0aGVzZSBlbnRyaWVzICov
DQorI2lmZGVmIENPTkZJR19QUk9DX0ZTDQogCQlpZiAoZHJpdmUtPnByb2Mp
DQogCQkJaWRlX3JlbW92ZV9wcm9jX2VudHJpZXMoZHJpdmUtPnByb2MsIGlk
ZWRpc2tfcHJvYyk7DQorI2VuZGlmDQogCX0NCiAJaWRlX3VucmVnaXN0ZXJf
bW9kdWxlKCZpZGVkaXNrX21vZHVsZSk7DQogfQ0KLS0tIGxpbnV4LTI0MHQx
MHA2L2RyaXZlcnMvaWRlL2lkZS1mbG9wcHkuYwlUdWUgSnVuIDEzIDIwOjMy
OjAwIDIwMDANCisrKyBsaW51eC9kcml2ZXJzL2lkZS9pZGUtZmxvcHB5LmMJ
U2F0IE9jdCAyOCAyMjo1OTo1MSAyMDAwDQpAQCAtMTY4Myw4ICsxNjgzLDEw
IEBADQogCQl9DQogCQkvKiBXZSBtdXN0IHJlbW92ZSBwcm9jIGVudHJpZXMg
ZGVmaW5lZCBpbiB0aGlzIG1vZHVsZS4NCiAJCSAgIE90aGVyd2lzZSB3ZSBv
b3BzIHdoaWxlIGFjY2Vzc2luZyB0aGVzZSBlbnRyaWVzICovDQorI2lmZGVm
IENPTkZJR19QUk9DX0ZTDQogCQlpZiAoZHJpdmUtPnByb2MpDQogCQkJaWRl
X3JlbW92ZV9wcm9jX2VudHJpZXMoZHJpdmUtPnByb2MsIGlkZWZsb3BweV9w
cm9jKTsNCisjZW5kaWYNCiAJfQ0KIAlpZGVfdW5yZWdpc3Rlcl9tb2R1bGUo
JmlkZWZsb3BweV9tb2R1bGUpOw0KIH0NCi0tLSBsaW51eC0yNDB0MTBwNi9k
cml2ZXJzL2lkZS9pZGUtcHJvYmUuYwlUdWUgT2N0ICAzIDAwOjE2OjUxIDIw
MDANCisrKyBsaW51eC9kcml2ZXJzL2lkZS9pZGUtcHJvYmUuYwlTYXQgT2N0
IDI4IDIyOjU4OjA5IDIwMDANCkBAIC05MDYsNyArOTA2LDkgQEANCiAJZm9y
IChpbmRleCA9IDA7IGluZGV4IDwgTUFYX0hXSUZTOyArK2luZGV4KQ0KIAkJ
aWRlX3VucmVnaXN0ZXIoaW5kZXgpOw0KIAlpZGVwcm9iZV9pbml0KCk7DQor
I2lmZGVmIENPTkZJR19QUk9DX0ZTDQogCWNyZWF0ZV9wcm9jX2lkZV9pbnRl
cmZhY2VzKCk7DQorI2VuZGlmDQogCXJldHVybiAwOw0KIH0NCiANCg==
--8323328-703745271-973639246=:1772--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
