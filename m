Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSHEKDc>; Mon, 5 Aug 2002 06:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSHEKDb>; Mon, 5 Aug 2002 06:03:31 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:1949 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S317589AbSHEKDa>; Mon, 5 Aug 2002 06:03:30 -0400
Date: Mon, 5 Aug 2002 15:36:51 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: linux-alpha@vger.kernel.org, <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: 2.5.30 : __builtin_expect() cleanups in alpha code (rwsem.h)
Message-ID: <Pine.GSO.4.44.0208051536030.3149-200000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1028542011=:3149"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1028542011=:3149
Content-Type: TEXT/PLAIN; charset=US-ASCII


Please apply patch

---559023410-851401618-1028542011=:3149
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=alpha
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0208051536510.3149@cbin2-view1.cisco.com>
Content-Description: 
Content-Disposition: attachment; filename=alpha

LS0tIGxpbnV4LTIuNS4zMC9pbmNsdWRlL2FzbS1hbHBoYS9yd3NlbS5ofglG
cmkgQXVnICAyIDAyOjQ2OjM1IDIwMDINCisrKyBsaW51eC0yLjUuMzAvaW5j
bHVkZS9hc20tYWxwaGEvcndzZW0uaAlNb24gQXVnICA1IDE1OjM0OjU5IDIw
MDINCkBAIC04MCwxMyArODAsMTMgQEANCiAJIi5zdWJzZWN0aW9uIDJcbiIN
CiAJIjI6CWJyCTFiXG4iDQogCSIucHJldmlvdXMiDQogCToiPSZyIiAob2xk
Y291bnQpLCAiPW0iIChzZW0tPmNvdW50KSwgIj0mciIgKHRlbXApDQogCToi
SXIiIChSV1NFTV9BQ1RJVkVfUkVBRF9CSUFTKSwgIm0iIChzZW0tPmNvdW50
KSA6ICJtZW1vcnkiKTsNCiAjZW5kaWYNCi0JaWYgKF9fYnVpbHRpbl9leHBl
Y3Qob2xkY291bnQgPCAwLCAwKSkNCisJaWYgKHVubGlrZWx5KG9sZGNvdW50
IDwgMCkpDQogCQlyd3NlbV9kb3duX3JlYWRfZmFpbGVkKHNlbSk7DQogfQ0K
IA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2Rvd25fd3JpdGUoc3RydWN0IHJ3
X3NlbWFwaG9yZSAqc2VtKQ0KIHsNCiAJbG9uZyBvbGRjb3VudDsNCkBAIC0x
MDQsMTMgKzEwNCwxMyBAQA0KIAkiLnN1YnNlY3Rpb24gMlxuIg0KIAkiMjoJ
YnIJMWJcbiINCiAJIi5wcmV2aW91cyINCiAJOiI9JnIiIChvbGRjb3VudCks
ICI9bSIgKHNlbS0+Y291bnQpLCAiPSZyIiAodGVtcCkNCiAJOiJJciIgKFJX
U0VNX0FDVElWRV9XUklURV9CSUFTKSwgIm0iIChzZW0tPmNvdW50KSA6ICJt
ZW1vcnkiKTsNCiAjZW5kaWYNCi0JaWYgKF9fYnVpbHRpbl9leHBlY3Qob2xk
Y291bnQsIDApKQ0KKwlpZiAodW5saWtlbHkob2xkY291bnQpKQ0KIAkJcndz
ZW1fZG93bl93cml0ZV9mYWlsZWQoc2VtKTsNCiB9DQogDQogc3RhdGljIGlu
bGluZSB2b2lkIF9fdXBfcmVhZChzdHJ1Y3Qgcndfc2VtYXBob3JlICpzZW0p
DQogew0KIAlsb25nIG9sZGNvdW50Ow0KQEAgLTEyOCwxMyArMTI4LDEzIEBA
DQogCSIuc3Vic2VjdGlvbiAyXG4iDQogCSIyOglicgkxYlxuIg0KIAkiLnBy
ZXZpb3VzIg0KIAk6Ij0mciIgKG9sZGNvdW50KSwgIj1tIiAoc2VtLT5jb3Vu
dCksICI9JnIiICh0ZW1wKQ0KIAk6IklyIiAoUldTRU1fQUNUSVZFX1JFQURf
QklBUyksICJtIiAoc2VtLT5jb3VudCkgOiAibWVtb3J5Iik7DQogI2VuZGlm
DQotCWlmIChfX2J1aWx0aW5fZXhwZWN0KG9sZGNvdW50IDwgMCwgMCkpIA0K
KwlpZiAodW5saWtlbHkob2xkY291bnQgPCAwKSkgDQogCQlpZiAoKGludClv
bGRjb3VudCAtIFJXU0VNX0FDVElWRV9SRUFEX0JJQVMgPT0gMCkNCiAJCQly
d3NlbV93YWtlKHNlbSk7DQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBf
X3VwX3dyaXRlKHN0cnVjdCByd19zZW1hcGhvcmUgKnNlbSkNCiB7DQpAQCAt
MTU0LDEzICsxNTQsMTMgQEANCiAJIi5zdWJzZWN0aW9uIDJcbiINCiAJIjI6
CWJyCTFiXG4iDQogCSIucHJldmlvdXMiDQogCToiPSZyIiAoY291bnQpLCAi
PW0iIChzZW0tPmNvdW50KSwgIj0mciIgKHRlbXApDQogCToiSXIiIChSV1NF
TV9BQ1RJVkVfV1JJVEVfQklBUyksICJtIiAoc2VtLT5jb3VudCkgOiAibWVt
b3J5Iik7DQogI2VuZGlmDQotCWlmIChfX2J1aWx0aW5fZXhwZWN0KGNvdW50
LCAwKSkNCisJaWYgKHVubGlrZWx5KGNvdW50KSkNCiAJCWlmICgoaW50KWNv
dW50ID09IDApDQogCQkJcndzZW1fd2FrZShzZW0pOw0KIH0NCiANCiBzdGF0
aWMgaW5saW5lIHZvaWQgcndzZW1fYXRvbWljX2FkZChsb25nIHZhbCwgc3Ry
dWN0IHJ3X3NlbWFwaG9yZSAqc2VtKQ0KIHsNCg==
---559023410-851401618-1028542011=:3149--
