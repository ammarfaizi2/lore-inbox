Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSHJL01>; Sat, 10 Aug 2002 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSHJL01>; Sat, 10 Aug 2002 07:26:27 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:60577 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S316824AbSHJL00>;
	Sat, 10 Aug 2002 07:26:26 -0400
Date: Sat, 10 Aug 2002 06:30:05 -0500 (CDT)
From: Robin Holt <holt@sgi.com>
X-X-Sender: holt@bedrock.americas.sgi.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add some convenient L1_CACHE related macros.
Message-ID: <Pine.LNX.4.44.0208100616270.10411-200000@bedrock.americas.sgi.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2726317826-1474989539-1028979005=:10417"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2726317826-1474989539-1028979005=:10417
Content-Type: TEXT/PLAIN; charset=US-ASCII


Attached is a patch against 2.5.30 to add a few convenient L1_CACHE
related macros.

I am not sure of the exact process, but I was wondering if these could get 
included in some future version of cache.h.  I am currently using them in 
some drivers I am writing and feel they add to the readability of the 
code.

Thanks,
Robin Holt

--2726317826-1474989539-1028979005=:10417
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cache.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208100630050.10417@bedrock.americas.sgi.com>
Content-Description: cache.patch
Content-Disposition: attachment; filename="cache.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjUuMzAtY2xlYW4vaW5jbHVkZS9saW51eC9j
YWNoZS5oIGxpbnV4LTIuNS4zMC9pbmNsdWRlL2xpbnV4L2NhY2hlLmgNCi0t
LSBsaW51eC0yLjUuMzAtY2xlYW4vaW5jbHVkZS9saW51eC9jYWNoZS5oCVRo
dSBBdWcgIDEgMTY6MTc6MzIgMjAwMg0KKysrIGxpbnV4LTIuNS4zMC9pbmNs
dWRlL2xpbnV4L2NhY2hlLmgJU2F0IEF1ZyAxMCAwNjowMjowNyAyMDAyDQpA
QCAtNCwxMiArNCwyNiBAQA0KICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4N
CiAjaW5jbHVkZSA8YXNtL2NhY2hlLmg+DQogDQorI2lmbmRlZiBMMV9DQUNI
RV9NQVNLDQorI2RlZmluZSBMMV9DQUNIRV9NQVNLCQkoTDFfQ0FDSEVfQllU
RVMgLSAxVUwpDQorI2VuZGlmDQorDQogI2RlZmluZSBBTElHTih4LGEpICgo
KHgpKyhhKS0xKSZ+KChhKS0xKSkNCiANCiAjaWZuZGVmIEwxX0NBQ0hFX0FM
SUdODQogI2RlZmluZSBMMV9DQUNIRV9BTElHTih4KSBBTElHTih4LCBMMV9D
QUNIRV9CWVRFUykNCiAjZW5kaWYNCiANCisvKiBSZXR1cm4gdGhlIHN0YXJ0
IG9mIHRoZSBjYWNoZSBsaW5lIGZvciBhZGRyZXNzIF9wICovDQorI2lmbmRl
ZiBMMV9DQUNIRV9MSU5FDQorI2RlZmluZSBMMV9DQUNIRV9MSU5FKF9wKQko
KHVuc2lnbmVkIGxvbmcpKF9wKSAmIH5MMV9DQUNIRV9NQVNLKQ0KKyNlbmRp
Zg0KKw0KKy8qIElzIGFkZHJlc3MgX3AgYWxpZ25lZCBvbiBhIGNhY2hlIGJv
dW5kYXJ5PyAqLw0KKyNpZm5kZWYgTDFfQ0FDSEVfQUxJR05FRA0KKyNkZWZp
bmUgTDFfQ0FDSEVfQUxJR05FRChfcCkJKCgodW5zaWduZWQgbG9uZykoX3Ap
ICYgTDFfQ0FDSEVfTUFTSykgPT0gMCkNCisjZW5kaWYNCisNCiAjaWZuZGVm
IFNNUF9DQUNIRV9CWVRFUw0KICNkZWZpbmUgU01QX0NBQ0hFX0JZVEVTIEwx
X0NBQ0hFX0JZVEVTDQogI2VuZGlmDQo=
--2726317826-1474989539-1028979005=:10417--
