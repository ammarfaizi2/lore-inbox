Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUAZQXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 11:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUAZQXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 11:23:41 -0500
Received: from fairchild-196.adsl.newnet.co.uk ([213.131.187.196]:57530 "HELO
	pinus.navaho") by vger.kernel.org with SMTP id S264358AbUAZQXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 11:23:37 -0500
X-Sender-Local: 10.0.0.42
Date: Mon, 26 Jan 2004 16:23:02 +0000 (GMT)
From: Steve Hill <steve@navaho.co.uk>
X-X-Sender: steve@sorbus2.navaho
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ALIM7101 watchdog
Message-ID: <Pine.LNX.4.58.0401261621060.15669@sorbus2.navaho>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="666112-1741476213-1075134182=:15669"
X-Navaho-ID: 40153a0a
X-Domain-Forwarded-By: pinus.navaho
X-Navaho-Spam-Rating: 0.000000
X-Spam-Override: Local user [steve@navaho.co.uk]
X-Navaho-Spam: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--666112-1741476213-1075134182=:15669
Content-Type: TEXT/PLAIN; charset=US-ASCII


Attached is a patch against 2.4.24 to fix the ALIM7101 watchdog driver 
which wasn't properly taking notice of NOWAYOUT not being set.

- Steve Hill
Senior Software Developer                        Email: steve@navaho.co.uk
Navaho Technologies Ltd.                           Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...

--666112-1741476213-1075134182=:15669
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alim7101_wdt_nowayout_fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0401261623020.15669@sorbus2.navaho>
Content-Description: 
Content-Disposition: attachment; filename="alim7101_wdt_nowayout_fix.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4yNC52YW5pbGxhL2RyaXZlcnMvY2hhci9h
bGltNzEwMV93ZHQuYyBsaW51eC0yLjQuMjQvZHJpdmVycy9jaGFyL2FsaW03
MTAxX3dkdC5jDQotLS0gbGludXgtMi40LjI0LnZhbmlsbGEvZHJpdmVycy9j
aGFyL2FsaW03MTAxX3dkdC5jCTIwMDItMTEtMjggMjM6NTM6MTIuMDAwMDAw
MDAwICswMDAwDQorKysgbGludXgtMi40LjI0L2RyaXZlcnMvY2hhci9hbGlt
NzEwMV93ZHQuYwkyMDA0LTAxLTI2IDExOjUzOjA2LjAwMDAwMDAwMCArMDAw
MA0KQEAgLTIwOSw3ICsyMDksNyBAQA0KIA0KIHN0YXRpYyBpbnQgZm9wX2Ns
b3NlKHN0cnVjdCBpbm9kZSAqIGlub2RlLCBzdHJ1Y3QgZmlsZSAqIGZpbGUp
DQogew0KLQlpZih3ZHRfZXhwZWN0X2Nsb3NlKQ0KKwlpZiAoKHdkdF9leHBl
Y3RfY2xvc2UpIHx8ICghIG5vd2F5b3V0KSkNCiAJCXdkdF90dXJub2ZmKCk7
DQogCWVsc2Ugew0KIAkJcHJpbnRrKE9VUl9OQU1FICI6IGRldmljZSBmaWxl
IGNsb3NlZCB1bmV4cGVjdGVkbHkuIFdpbGwgbm90IHN0b3AgdGhlIFdEVCFc
biIpOw0K

--666112-1741476213-1075134182=:15669--

