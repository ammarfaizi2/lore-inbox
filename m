Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUALQl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUALQl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:41:26 -0500
Received: from gwyn.tux.org ([199.184.165.135]:2478 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id S266208AbUALQlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:41:24 -0500
Date: Mon, 12 Jan 2004 11:41:23 -0500 (EST)
From: Samuel S Chessman <chessman@tux.org>
To: <LINUX-390@VM.MARIST.EDU>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] s390 2.4.24 typo and missing include 
Message-ID: <Pine.LNX.4.30.0401121132480.19861-300000@gwyn.tux.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1194883163-1815809157-1073925586=:19861"
Content-ID: <Pine.LNX.4.30.0401121140550.23884@gwyn.tux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1194883163-1815809157-1073925586=:19861
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0401121140551.23884@gwyn.tux.org>

The following two patches are needed to get linux 2.4.24 to compile
s390 linux.  I have not had a chance to ipl to test if 2.4.24 runs
but these were necessary to compile.
The typo is only discovered if CONFIG_SMP is undefined.

Attached README and patch.

-- 
   Sam Chessman                                         chessman (a) tux.org
    First do what's necessary, then what's possible, finally the impossible.

---1194883163-1815809157-1073925586=:19861
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=README
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0401121139460.19861@gwyn.tux.org>
Content-Description: Patch Readme
Content-Disposition: ATTACHMENT; FILENAME=README

TW9uIEphbiAxMiAxMToyNDozMCBFU1QgMjAwNA0KbGludXgga2VybmVsIDIu
NC4yNCBzMzkwIHBhdGNoZXMgYnkgU2FtIENoZXNzbWFuIGNoZXNzbWFuQHR1
eC5vcmcNCg0KbGludXgtMi40LjI0L2RyaXZlcnMvczM5MC9jaGFyL2N0cmxj
aGFyLmMgYWRkIGVycm5vLmggZm9yIEVJTlZBTAkNCg0KbGludXgtMi40LjI0
L2RyaXZlcnMvczM5MC9jaGFyL2h3Y19ydy5jCWZpeCB0eXBvIGluIG5vbi1T
TVAgaWZkZWYgYmxvY2sNCmxpbnV4LTIuNC4yNC9kcml2ZXJzL3MzOTAvY2hh
ci9od2NfcncuYwlhZGQgYnJlYWsgYWZ0ZXIgZGVmYXVsdDogY2FzZQ0K
---1194883163-1815809157-1073925586=:19861
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="s390.2.4.24.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0401121141230.23884@gwyn.tux.org>
Content-Description: unified context diff
Content-Disposition: attachment; filename="s390.2.4.24.patch"

LS0tIGRyaXZlcnMvczM5MC9jaGFyL2N0cmxjaGFyLmMub3JpZwkyMDAzLTA4
LTI1IDA3OjQ0OjQyLjAwMDAwMDAwMCAtMDQwMA0KKysrIGRyaXZlcnMvczM5
MC9jaGFyL2N0cmxjaGFyLmMJMjAwNC0wMS0xMiAxMDoyMjowNi4wMDAwMDAw
MDAgLTA1MDANCkBAIC05LDYgKzksNyBAQA0KIA0KICNpbmNsdWRlIDxsaW51
eC9jb25maWcuaD4NCiAjaW5jbHVkZSA8bGludXgvc3RkZGVmLmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQogI2luY2x1ZGUgPGxpbnV4L3N5c3Jx
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2N0eXBlLmg+DQogI2luY2x1ZGUgPGxp
bnV4L2ludGVycnVwdC5oPg0KDQotLS0gZHJpdmVycy9zMzkwL2NoYXIvaHdj
X3J3LmMub3JpZwkyMDAyLTExLTI4IDE4OjUzOjE0LjAwMDAwMDAwMCAtMDUw
MA0KKysrIGRyaXZlcnMvczM5MC9jaGFyL2h3Y19ydy5jCTIwMDQtMDEtMTIg
MTA6MjU6MzYuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMTY2Miw3ICsxNjYyLDcg
QEANCiAJcHN3X3QgcXVpZXNjZV9wc3c7DQogDQogCXF1aWVzY2VfcHN3Lm1h
c2sgPSBfRFdfUFNXX01BU0s7DQotCXF1ZWlzY2VfcHN3LmFkZHIgPSAweGZm
ZjsNCisJcXVpZXNjZV9wc3cuYWRkciA9IDB4ZmZmOw0KIAlfX2xvYWRfcHN3
IChxdWllc2NlX3Bzdyk7DQogfQ0KIA0KQEAgLTIyNDcsNiArMjI0Nyw3IEBA
DQogCQkJCQl1bmNvbmRpdGlvbmFsX3JlYWRfMiAoZXh0X2ludF9wYXJhbSk7
DQogCQkJCQlicmVhazsNCiAJCQkJZGVmYXVsdDoNCisJCQkJCWJyZWFrOw0K
IAkJCQl9DQogCQkJfQ0KIAkJfQ0K
---1194883163-1815809157-1073925586=:19861--
