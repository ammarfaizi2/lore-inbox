Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313541AbSDQTMg>; Wed, 17 Apr 2002 15:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313546AbSDQTMf>; Wed, 17 Apr 2002 15:12:35 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:28550 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S313541AbSDQTMc>;
	Wed, 17 Apr 2002 15:12:32 -0400
Date: Wed, 17 Apr 2002 12:12:30 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] slab cache name changes (trivial)
Message-ID: <Pine.LNX.4.44.0204171208130.14881-200000@mackman.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-679268779-166124828-1019070750=:14881"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---679268779-166124828-1019070750=:14881
Content-Type: TEXT/PLAIN; charset=US-ASCII

A few of the slab caches had names containing spaces which breaks a few
slabinfo parsing scripts I use.  It seems the consensus is to use
underscores instead of spaces in slab cache names, and this patch corrects
those names still using spaces.  Applies cleanly against 2.4.18 and with
offsets on 2.4.19-pre7.

Thanks, Ryan

---679268779-166124828-1019070750=:14881
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="slab_names.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0204171212300.14881@mackman.net>
Content-Description: 
Content-Disposition: attachment; filename="slab_names.patch"

ZGlmZiAtYXVyIGxpbnV4LW9yaWcvZnMvZG5vdGlmeS5jIGxpbnV4L2ZzL2Ru
b3RpZnkuYw0KLS0tIGxpbnV4LW9yaWcvZnMvZG5vdGlmeS5jCVR1ZSBOb3Yg
IDcgMjM6Mjc6NTcgMjAwMA0KKysrIGxpbnV4L2ZzL2Rub3RpZnkuYwlXZWQg
QXByIDE3IDEyOjAyOjQ2IDIwMDINCkBAIC0xMzEsNyArMTMxLDcgQEANCiAN
CiBzdGF0aWMgaW50IF9faW5pdCBkbm90aWZ5X2luaXQodm9pZCkNCiB7DQot
CWRuX2NhY2hlID0ga21lbV9jYWNoZV9jcmVhdGUoImRub3RpZnkgY2FjaGUi
LA0KKwlkbl9jYWNoZSA9IGttZW1fY2FjaGVfY3JlYXRlKCJkbm90aWZ5X2Nh
Y2hlIiwNCiAJCXNpemVvZihzdHJ1Y3QgZG5vdGlmeV9zdHJ1Y3QpLCAwLCAw
LCBOVUxMLCBOVUxMKTsNCiAJaWYgKCFkbl9jYWNoZSkNCiAJCXBhbmljKCJj
YW5ub3QgY3JlYXRlIGRub3RpZnkgc2xhYiBjYWNoZSIpOw0KZGlmZiAtYXVy
IGxpbnV4LW9yaWcvZnMvZmNudGwuYyBsaW51eC9mcy9mY250bC5jDQotLS0g
bGludXgtb3JpZy9mcy9mY250bC5jCU1vbiBTZXAgMTcgMTM6MTY6MzAgMjAw
MQ0KKysrIGxpbnV4L2ZzL2ZjbnRsLmMJV2VkIEFwciAxNyAxMjowMzoyOSAy
MDAyDQpAQCAtNTI1LDcgKzUyNSw3IEBADQogDQogc3RhdGljIGludCBfX2lu
aXQgZmFzeW5jX2luaXQodm9pZCkNCiB7DQotCWZhc3luY19jYWNoZSA9IGtt
ZW1fY2FjaGVfY3JlYXRlKCJmYXN5bmMgY2FjaGUiLA0KKwlmYXN5bmNfY2Fj
aGUgPSBrbWVtX2NhY2hlX2NyZWF0ZSgiZmFzeW5jX2NhY2hlIiwNCiAJCXNp
emVvZihzdHJ1Y3QgZmFzeW5jX3N0cnVjdCksIDAsIDAsIE5VTEwsIE5VTEwp
Ow0KIAlpZiAoIWZhc3luY19jYWNoZSkNCiAJCXBhbmljKCJjYW5ub3QgY3Jl
YXRlIGZhc3luYyBzbGFiIGNhY2hlIik7DQpkaWZmIC1hdXIgbGludXgtb3Jp
Zy9mcy9sb2Nrcy5jIGxpbnV4L2ZzL2xvY2tzLmMNCi0tLSBsaW51eC1vcmln
L2ZzL2xvY2tzLmMJVGh1IE9jdCAxMSAwNzo1MjoxOCAyMDAxDQorKysgbGlu
dXgvZnMvbG9ja3MuYwlXZWQgQXByIDE3IDEyOjAzOjIyIDIwMDINCkBAIC0x
OTQwLDcgKzE5NDAsNyBAQA0KIA0KIHN0YXRpYyBpbnQgX19pbml0IGZpbGVs
b2NrX2luaXQodm9pZCkNCiB7DQotCWZpbGVsb2NrX2NhY2hlID0ga21lbV9j
YWNoZV9jcmVhdGUoImZpbGUgbG9jayBjYWNoZSIsDQorCWZpbGVsb2NrX2Nh
Y2hlID0ga21lbV9jYWNoZV9jcmVhdGUoImZpbGVfbG9ja19jYWNoZSIsDQog
CQkJc2l6ZW9mKHN0cnVjdCBmaWxlX2xvY2spLCAwLCAwLCBpbml0X29uY2Us
IE5VTEwpOw0KIAlpZiAoIWZpbGVsb2NrX2NhY2hlKQ0KIAkJcGFuaWMoImNh
bm5vdCBjcmVhdGUgZmlsZSBsb2NrIHNsYWIgY2FjaGUiKTsNCg==
---679268779-166124828-1019070750=:14881--
