Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVCBQ4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVCBQ4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVCBQye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:54:34 -0500
Received: from alog0675.analogic.com ([208.224.223.212]:24504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262376AbVCBQxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:53:04 -0500
Date: Wed, 2 Mar 2005 11:51:43 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Patch Linux-2.6.11 jiffies.h uses shadowed variable names.
Message-ID: <Pine.LNX.4.61.0503021146180.5511@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-1760998023-1109782303=:5511"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-1760998023-1109782303=:5511
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


The attached patch was sent for 2.6.10 but the kernel was
never updated. The kernel used to be compiled with -Wshadow
and would catch these problems. It no longer is (and it
should be).

I attached it so the M$ mail-sender doesn't dork with
white-space.

Signed Off By: rjohnson@analogic.com

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-1760998023-1109782303=:5511
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="jiffies.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0503021151430.5511@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename="jiffies.patch"

LS0tIGxpbnV4LTIuNi4xMS9pbmNsdWRlL2xpbnV4L2ppZmZpZXMuaC5vcmln
CTIwMDUtMDMtMDIgMTE6Mjk6MjcuMDAwMDAwMDAwIC0wNTAwDQorKysgbGlu
dXgtMi42LjExL2luY2x1ZGUvbGludXgvamlmZmllcy5oCTIwMDUtMDMtMDIg
MTE6MzY6MDUuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMzI4LDEzICszMjgsMTMg
QEANCiB9DQogDQogc3RhdGljIF9faW5saW5lX18gdm9pZA0KLWppZmZpZXNf
dG9fdGltZXNwZWMoY29uc3QgdW5zaWduZWQgbG9uZyBqaWZmaWVzLCBzdHJ1
Y3QgdGltZXNwZWMgKnZhbHVlKQ0KK2ppZmZpZXNfdG9fdGltZXNwZWMoY29u
c3QgdW5zaWduZWQgbG9uZyBqaWYsIHN0cnVjdCB0aW1lc3BlYyAqdmFsdWUp
DQogew0KIAkvKg0KIAkgKiBDb252ZXJ0IGppZmZpZXMgdG8gbmFub3NlY29u
ZHMgYW5kIHNlcGFyYXRlIHdpdGgNCiAJICogb25lIGRpdmlkZS4NCiAJICov
DQotCXU2NCBuc2VjID0gKHU2NClqaWZmaWVzICogVElDS19OU0VDOw0KKwl1
NjQgbnNlYyA9ICh1NjQpamlmICogVElDS19OU0VDOw0KIAl2YWx1ZS0+dHZf
c2VjID0gZGl2X2xvbmdfbG9uZ19yZW0obnNlYywgTlNFQ19QRVJfU0VDLCAm
dmFsdWUtPnR2X25zZWMpOw0KIH0NCiANCkBAIC0zNjYsMTMgKzM2NiwxMyBA
QA0KIH0NCiANCiBzdGF0aWMgX19pbmxpbmVfXyB2b2lkDQotamlmZmllc190
b190aW1ldmFsKGNvbnN0IHVuc2lnbmVkIGxvbmcgamlmZmllcywgc3RydWN0
IHRpbWV2YWwgKnZhbHVlKQ0KK2ppZmZpZXNfdG9fdGltZXZhbChjb25zdCB1
bnNpZ25lZCBsb25nIGppZiwgc3RydWN0IHRpbWV2YWwgKnZhbHVlKQ0KIHsN
CiAJLyoNCiAJICogQ29udmVydCBqaWZmaWVzIHRvIG5hbm9zZWNvbmRzIGFu
ZCBzZXBhcmF0ZSB3aXRoDQogCSAqIG9uZSBkaXZpZGUuDQogCSAqLw0KLQl1
NjQgbnNlYyA9ICh1NjQpamlmZmllcyAqIFRJQ0tfTlNFQzsNCisJdTY0IG5z
ZWMgPSAodTY0KWppZiAqIFRJQ0tfTlNFQzsNCiAJdmFsdWUtPnR2X3NlYyA9
IGRpdl9sb25nX2xvbmdfcmVtKG5zZWMsIE5TRUNfUEVSX1NFQywgJnZhbHVl
LT50dl91c2VjKTsNCiAJdmFsdWUtPnR2X3VzZWMgLz0gTlNFQ19QRVJfVVNF
QzsNCiB9DQo=

--1879706418-1760998023-1109782303=:5511--
