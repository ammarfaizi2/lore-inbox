Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbUDSCFx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 22:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbUDSCFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 22:05:53 -0400
Received: from mxsf22.cluster1.charter.net ([209.225.28.222]:38415 "EHLO
	mxsf22.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264240AbUDSCFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 22:05:51 -0400
Date: Sun, 18 Apr 2004 21:49:53 -0400 (EDT)
From: ameer armaly <ameer@charter.net>
X-X-Sender: ameer@debian
To: linux-kernel@vger.kernel.org
cc: linus@osdl.org
Subject: [patch] config option to make at keyboards beep when too many keys
 are pressed
Message-ID: <Pine.LNX.4.58.0404182147160.828@debian>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1292722318-1082339393=:828"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1292722318-1082339393=:828
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi all.
Here are two patches, that should be applied in
/usr/src/linux/drivers/input.  These make a config option, that if
selected, allows atd keyboards to beep rather than cluttering the screen
with  messages about too many keys pressed.   This has been patched
against the latest kernel tree from bitkeeper.
--8323328-1292722318-1082339393=:828
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="atkbd.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0404182149530.828@debian>
Content-Description: 
Content-Disposition: attachment; filename="atkbd.patch"

LS0tIGF0a2JkLm9yaWcJMjAwNC0wNC0xOCAyMTozMToyMi4wMDAwMDAwMDAg
LTA0MDANCisrKyBhdGtiZC5jCTIwMDQtMDQtMTggMjE6NDA6NTkuMDAwMDAw
MDAwIC0wNDAwDQpAQCAtMjg0LDggKzI4NCwxMiBAQA0KIAkJCWF0a2JkX3Jl
cG9ydF9rZXkoJmF0a2JkLT5kZXYsIHJlZ3MsIEtFWV9IQU5KQSwgMyk7DQog
CQkJZ290byBvdXQ7DQogCQljYXNlIEFUS0JEX1JFVF9FUlI6DQorI2lmbmRl
ZiBDT05GSUdfQkVFUF9UT01BTllfS0VZUw0KIAkJCXByaW50ayhLRVJOX1dB
Uk5JTkcgImF0a2JkLmM6IEtleWJvYXJkIG9uICVzIHJlcG9ydHMgdG9vIG1h
bnkga2V5cyBwcmVzc2VkLlxuIiwgc2VyaW8tPnBoeXMpOw0KLQkJCWdvdG8g
b3V0Ow0KKw0KKyNlbHNlDQorcHJpbnRrKEtFUk5fQUxFUlQsICJcMDA3Iik7
DQorI2VuZGlmCQkJZ290byBvdXQ7DQogCX0NCiANCiAJaWYgKGF0a2JkLT5z
ZXQgIT0gMykNCg==

--8323328-1292722318-1082339393=:828
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="Kconfig.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0404182149531.828@debian>
Content-Description: 
Content-Disposition: attachment; filename="Kconfig.patch"

LS0tIEtjb25maWcJMjAwNC0wNC0xOCAyMTozNDo1Mi4wMDAwMDAwMDAgLTA0
MDANCisrKyBrY29uZmlnCTIwMDQtMDQtMTggMjE6Mzc6NDQuMDAwMDAwMDAw
IC0wNDAwDQpAQCAtMjksNiArMjksOSBAQA0KIAkgIFRvIGNvbXBpbGUgdGhp
cyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KIAkg
IG1vZHVsZSB3aWxsIGJlIGNhbGxlZCBhdGtiZC4NCiANCitjb25maWcgQkVF
UF9UT01BTkVZX0tFWVMNCitib29sICJCZWVwIHdoZW4gdG9vIG1hbnkga2V5
cyBhcmUgcHJlc3NlZCBvbiBhdCBrZXlib2FyZHMiDQorZGVwZW5kcyBvbiBL
RVlCT0FSRF9BVEtCRA0KIGNvbmZpZyBLRVlCT0FSRF9TVU5LQkQNCiAJdHJp
c3RhdGUgIlN1biBUeXBlIDQgYW5kIFR5cGUgNSBrZXlib2FyZCBzdXBwb3J0
Ig0KIAlkZXBlbmRzIG9uIElOUFVUICYmIElOUFVUX0tFWUJPQVJEDQo=

--8323328-1292722318-1082339393=:828--
