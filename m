Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269312AbUI3QFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269312AbUI3QFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269314AbUI3QFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:05:07 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:38030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269312AbUI3QEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:04:41 -0400
Subject: Re: IA32 (2.6.9-rc3 - 2004-09-29.21.30) - 10 New warnings (gcc
	3.2.2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Cherry <cherry@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409301432.i8UEW3Fn029396@cherrypit.pdx.osdl.net>
References: <200409301432.i8UEW3Fn029396@cherrypit.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-YwmPq6LP6J8Y8J/9xrDL"
Message-Id: <1096556510.19487.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 30 Sep 2004 16:01:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YwmPq6LP6J8Y8J/9xrDL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Iau, 2004-09-30 at 15:32, John Cherry wrote:
> drivers/net/wan/pc300_tty.c:704: warning: passing arg 1 of `tty_ldisc_ref' from incompatible pointer type

I've got a patch for this and the other 2 64bit warnings in that file. 
- Fix the ldisc ref bug
- Fix the 64bit pointer cast warnings
- Fix the coding style from "Alan bracketing" to "Linus bracketing"



--=-YwmPq6LP6J8Y8J/9xrDL
Content-Description: 
Content-Disposition: inline; filename=a1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8

LS0tIC4uL2xpbnV4LnZhbmlsbGEtMi42LjlyYzMvZHJpdmVycy9uZXQvd2FuL3BjMzAwX3R0eS5j
CTIwMDQtMDktMzAgMTY6MTM6MDkuMDc1MzA1NzYwICswMTAwDQorKysgZHJpdmVycy9uZXQvd2Fu
L3BjMzAwX3R0eS5jCTIwMDQtMDktMzAgMTc6MDI6MTguNDAwOTQwMTEyICswMTAwDQpAQCAtMTky
LDEzICsxOTIsMTQgQEANCiAgKi8NCiB2b2lkIGNwY190dHlfaW5pdChwYzMwMGRldl90ICpwYzMw
MGRldikNCiB7DQotCWludCBwb3J0LCBhdXg7DQorCXVuc2lnbmVkIGxvbmcgcG9ydDsNCisJaW50
IGF1eDsNCiAJc3RfY3BjX3R0eV9hcmVhICogY3BjX3R0eTsNCiANCiAJLyogaGRsY1ggLSBYPWlu
dGVyZmFjZSBudW1iZXIgKi8NCiAJcG9ydCA9IHBjMzAwZGV2LT5kZXYtPm5hbWVbNF0gLSAnMCc7
DQogCWlmIChwb3J0ID49IENQQ19UVFlfTlBPUlRTKSB7DQotCQlwcmludGsoIiVzLXR0eTogaW52
YWxpZCBpbnRlcmZhY2Ugc2VsZWN0ZWQgKDAtJWkpOiAlaSIsIA0KKwkJcHJpbnRrKCIlcy10dHk6
IGludmFsaWQgaW50ZXJmYWNlIHNlbGVjdGVkICgwLSVpKTogJWxpIiwgDQogCQkJcGMzMDBkZXYt
PmRldi0+bmFtZSwNCiAJCQlDUENfVFRZX05QT1JUUy0xLHBvcnQpOw0KIAkJcmV0dXJuOw0KQEAg
LTY4Miw3ICs2ODMsOCBAQA0KICAqLw0KIHN0YXRpYyB2b2lkIGNwY190dHlfcnhfd29yayh2b2lk
ICogZGF0YSkNCiB7DQotCWludCBwb3J0LCBpLCBqOw0KKwl1bnNpZ25lZCBsb25nIHBvcnQ7DQor
CWludCBpLCBqOw0KIAlzdF9jcGNfdHR5X2FyZWEgKmNwY190dHk7IA0KIAl2b2xhdGlsZSBzdF9j
cGNfcnhfYnVmICogYnVmOw0KIAljaGFyIGZsYWdzPTAsZmxnX3J4PTE7IA0KQEAgLTY5MywxOCAr
Njk1LDE1IEBADQogCQ0KIAlmb3IgKGk9MDsgKGkgPCA0KSAmJiBmbGdfcnggOyBpKyspIHsNCiAJ
CWZsZ19yeCA9IDA7DQotCQlwb3J0ID0gKGludCkgZGF0YTsNCisJCXBvcnQgPSAodW5zaWduZWQg
bG9uZykgZGF0YTsNCiAJCWZvciAoaj0wOyBqIDwgQ1BDX1RUWV9OUE9SVFM7IGorKykgew0KIAkJ
CWNwY190dHkgPSAmY3BjX3R0eV9hcmVhW3BvcnRdOw0KIAkJDQogCQkJaWYgKChidWY9Y3BjX3R0
eS0+YnVmX3J4LmZpcnN0KSAhPSAwKSB7DQotCQkJCQ0KLQkJCQlpZihjcGNfdHR5LT50dHkpDQot
CQkJCXsJCQkJCQkJCQkJCQ0KLQkJCQkJbGQgPSB0dHlfbGRpc2NfcmVmKGNwY190dHkpOw0KLQkJ
CQkJaWYobGQpDQotCQkJCQl7DQotCQkJCQkJaWYgKGxkLT5yZWNlaXZlX2J1ZikpIHsNCisJCQkJ
aWYoY3BjX3R0eS0+dHR5KSB7DQorCQkJCQlsZCA9IHR0eV9sZGlzY19yZWYoY3BjX3R0eS0+dHR5
KTsNCisJCQkJCWlmKGxkKSB7DQorCQkJCQkJaWYgKGxkLT5yZWNlaXZlX2J1Zikgew0KIAkJCQkJ
CQlDUENfVFRZX0RCRygiJXM6IGNhbGwgbGluZSBkaXNjLiByZWNlaXZlX2J1ZlxuIixjcGNfdHR5
LT5uYW1lKTsNCiAJCQkJCQkJbGQtPnJlY2VpdmVfYnVmKGNwY190dHktPnR0eSwgKGNoYXIgKiko
YnVmLT5kYXRhKSwgJmZsYWdzLCBidWYtPnNpemUpOw0KIAkJCQkJCX0NCg==

--=-YwmPq6LP6J8Y8J/9xrDL--
