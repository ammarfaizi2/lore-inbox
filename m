Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270753AbTHJWv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270757AbTHJWv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:51:56 -0400
Received: from fubar.phlinux.com ([216.254.54.154]:4234 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP id S270753AbTHJWvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:51:54 -0400
Date: Sun, 10 Aug 2003 15:51:53 -0700 (PDT)
From: Matt C <wago@phlinux.com>
To: tytso@mit.edu,
       The Linux Kernel Mailing List 
	<linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>
Subject: [PATCH] [2.4] [Trivial] (re)add support for comtrol rocketport 4J
Message-ID: <Pine.LNX.4.44.0308101547180.8918-200000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-19359178-1484729349-1060555913=:8918"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---19359178-1484729349-1060555913=:8918
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Theodore, LKML:

I'm not quite sure this stopped working (worked under 2.4.19), but this 
patch adds support for the Comtrol Rocketport 4J 4-port rs232 PCI card. 
I've tested under 2.4.21, and verified that the support is still missing 
in 2.4.22-rc2.

thanks

-matt

---19359178-1484729349-1060555913=:8918
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rport.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0308101551530.8918@fubar.phlinux.com>
Content-Description: 
Content-Disposition: attachment; filename="rport.patch"

LS0tIGxpbnV4LTIuNC4yMi1yYzIvZHJpdmVycy9jaGFyL3JvY2tldC5jCTIw
MDEtMDktMjEgMTA6NTU6MjIuMDAwMDAwMDAwIC0wNzAwDQorKysgbGludXgt
Mi40LjIxZzEvZHJpdmVycy9jaGFyL3JvY2tldC5jCTIwMDMtMDgtMTAgMTU6
Mjc6MjYuMDAwMDAwMDAwIC0wNzAwDQpAQCAtMTk0NCw2ICsxOTQ0LDEwIEBA
DQogCQlzdHIgPSAiOEoiOw0KIAkJbWF4X251bV9haW9wcyA9IDE7DQogCQli
cmVhazsNCisJY2FzZSBQQ0lfREVWSUNFX0lEX1JQNEo6DQorCQlzdHIgPSAi
NEoiOw0KKwkJbWF4X251bV9haW9wcyA9IDE7DQorCQlicmVhazsNCiAJY2Fz
ZSBQQ0lfREVWSUNFX0lEX1JQMTZJTlRGOg0KIAkJc3RyID0gIjE2IjsNCiAJ
CW1heF9udW1fYWlvcHMgPSAyOw0KQEAgLTIwMDYsNiArMjAxMCwxMCBAQA0K
IAkJCVBDSV9ERVZJQ0VfSURfUlA4SiwgaSwgJmJ1cywgJmRldmljZV9mbikp
IA0KIAkJCWlmIChyZWdpc3Rlcl9QQ0koY291bnQrYm9hcmRzX2ZvdW5kLCBi
dXMsIGRldmljZV9mbikpDQogCQkJCWNvdW50Kys7DQorCQlpZiAoIXBjaWJp
b3NfZmluZF9kZXZpY2UoUENJX1ZFTkRPUl9JRF9SUCwNCisJCQlQQ0lfREVW
SUNFX0lEX1JQNEosIGksICZidXMsICZkZXZpY2VfZm4pKSANCisJCQlpZiAo
cmVnaXN0ZXJfUENJKGNvdW50K2JvYXJkc19mb3VuZCwgYnVzLCBkZXZpY2Vf
Zm4pKQ0KKwkJCQljb3VudCsrOw0KIAkJaWYoIXBjaWJpb3NfZmluZF9kZXZp
Y2UoUENJX1ZFTkRPUl9JRF9SUCwNCiAJCQlQQ0lfREVWSUNFX0lEX1JQOE9D
VEEsIGksICZidXMsICZkZXZpY2VfZm4pKSANCiAJCQlpZihyZWdpc3Rlcl9Q
Q0koY291bnQrYm9hcmRzX2ZvdW5kLCBidXMsIGRldmljZV9mbikpDQpAQCAt
MjAzMSw2ICsyMDM5LDEwIEBADQogCQkJaWYocmVnaXN0ZXJfUENJKGNvdW50
K2JvYXJkc19mb3VuZCwgYnVzLCBkZXZpY2VfZm4pKQ0KIAkJCQljb3VudCsr
Ow0KIAkJaWYoIXBjaWJpb3NfZmluZF9kZXZpY2UoUENJX1ZFTkRPUl9JRF9S
UCwNCisJCQlQQ0lfREVWSUNFX0lEX1JQNEosIGksICZidXMsICZkZXZpY2Vf
Zm4pKSANCisJCQlpZihyZWdpc3Rlcl9QQ0koY291bnQrYm9hcmRzX2ZvdW5k
LCBidXMsIGRldmljZV9mbikpDQorCQkJCWNvdW50Kys7DQorCQlpZighcGNp
Ymlvc19maW5kX2RldmljZShQQ0lfVkVORE9SX0lEX1JQLA0KIAkJCVBDSV9E
RVZJQ0VfSURfUlBQNCwgaSwgJmJ1cywgJmRldmljZV9mbikpIA0KIAkJCWlm
KHJlZ2lzdGVyX1BDSShjb3VudCtib2FyZHNfZm91bmQsIGJ1cywgZGV2aWNl
X2ZuKSkNCiAJCQkJY291bnQrKzsNCi0tLSBsaW51eC0yLjQuMjItcmMyL2Ry
aXZlcnMvY2hhci9yb2NrZXRfaW50LmgJMjAwMy0wOC0xMCAxNTozNToxMy4w
MDAwMDAwMDAgLTA3MDANCisrKyBsaW51eC0yLjQuMjFnMS9kcml2ZXJzL2No
YXIvcm9ja2V0X2ludC5oCTIwMDMtMDgtMTAgMTU6Mjc6MzEuMDAwMDAwMDAw
IC0wNzAwDQpAQCAtMTIwMCw2ICsxMTk5LDkgQEANCiAjaWZuZGVmIFBDSV9E
RVZJQ0VfSURfUlA4Sg0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9SUDhKCQkw
eDAwMDYNCiAjZW5kaWYNCisjaWZuZGVmIFBDSV9ERVZJQ0VfSURfUlA0Sg0K
KyNkZWZpbmUgUENJX0RFVklDRV9JRF9SUDRKCQkweDAwMDcNCisjZW5kaWYN
CiAjaWZuZGVmIFBDSV9ERVZJQ0VfSURfUlBQNA0KICNkZWZpbmUgUENJX0RF
VklDRV9JRF9SUFA0CQkweDAwMEENCiAjZW5kaWYNCg==
---19359178-1484729349-1060555913=:8918--
