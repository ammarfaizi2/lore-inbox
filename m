Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318812AbSIOWlr>; Sun, 15 Sep 2002 18:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSIOWlr>; Sun, 15 Sep 2002 18:41:47 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:53655 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318812AbSIOWlp>; Sun, 15 Sep 2002 18:41:45 -0400
Date: Sun, 15 Sep 2002 18:46:37 -0400 (EDT)
From: Albert Cranford <ac9410@attbi.com>
X-X-Sender: ac9410@home1
Reply-To: Albert Cranford <ac9410@attbi.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch 9/9]Four new i2c drivers and __init/__exit cleanup to i2c
Message-ID: <Pine.LNX.4.44.0209151845330.7637-200000@home1>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1609609187-1032129997=:7637"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1609609187-1032129997=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello Linus,
New I2C drivers that have been adjusted after Russell King comments of August.
o i2c-algo-8xx.c
o i2c-pport.c
o i2c-adap-ibm_ocp.c
o i2c-pcf-epp.c
o Add new drivers to Config.in and Makefile.
o Add new drivers to i2c-core for initialization.
o Remove EXPORT_NO_SYMBOLS statement from i2c-dev, i2c-elektor and i2c-frodo.
o Cleanup init_module and cleanup_module adding __init and __exit to most drivers.
o Adjust i2c-elektor with cli/sti replacement.
-- 
ac9410@attbi.com

--0-1609609187-1032129997=:7637
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=47-i2c-8-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209151846370.7637@home1>
Content-Description: 
Content-Disposition: attachment; filename=47-i2c-8-patch

LS0tIGxpbnV4L2RyaXZlcnMvaTJjL2kyYy1lbGVrdG9yLmMub3JpZwkyMDAy
LTA5LTE0IDIyOjEwOjQ1LjAwMDAwMDAwMCAtMDQwMA0KKysrIGxpbnV4LTIu
NS4zNC9kcml2ZXJzL2kyYy9pMmMtZWxla3Rvci5jCTIwMDItMDktMTUgMDE6
MTg6NTUuMDAwMDAwMDAwIC0wNDAwDQpAQCAtMTI1LDEyICsxMjUsMTIgQEAN
CiAJaW50IHRpbWVvdXQgPSAyOw0KIA0KIAlpZiAoaXJxID4gMCkgew0KLQkJ
Y2xpKCk7DQorCQlsb2NhbF9pcnFfZGlzYWJsZSgpOw0KIAkJaWYgKHBjZl9w
ZW5kaW5nID09IDApIHsNCiAJCQlpbnRlcnJ1cHRpYmxlX3NsZWVwX29uX3Rp
bWVvdXQoJnBjZl93YWl0LCB0aW1lb3V0KkhaICk7DQogCQl9IGVsc2UNCiAJ
CQlwY2ZfcGVuZGluZyA9IDA7DQotCQlzdGkoKTsNCisJCWxvY2FsX2lycV9l
bmFibGUoKTsNCiAJfSBlbHNlIHsNCiAJCXVkZWxheSgxMDApOw0KIAl9DQo=
--0-1609609187-1032129997=:7637--
