Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270465AbTGNQdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270612AbTGNQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:33:10 -0400
Received: from k1.dinoex.de ([80.237.200.94]:62983 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S270465AbTGNQbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:31:02 -0400
To: linux-kernel@vger.kernel.org
CC: trivial@rustcorp.com.au
Subject: [PATCH, 2.6, TRIVIAL, PNP] simple documentation fix
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Mon, 14 Jul 2003 18:29:07 +0200
Message-ID: <873ch9oywc.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The documentation talks about a file "possible", but 2.6.0-test1 names
it "options" AFAICS.

Jochen

--- linux-2.6.0-test1/Documentation/pnp.txt.jh	2003-07-14 18:23:36.000000000 +0200
+++ linux-2.6.0-test1/Documentation/pnp.txt	2003-07-14 18:24:09.000000000 +0200
@@ -22,7 +22,7 @@
 In addition to the standard driverfs file the following are created in each 
 device's directory:
 id - displays a list of support EISA IDs
-possible - displays possible resource configurations
+options - displays possible resource configurations
 resources - displays currently allocated resources and allows resource changes
 
 -activating a device
@@ -60,7 +60,7 @@
 - Notice the string "DISABLED".  THis means the device is not active.
 
 3.) check the device's possible configurations (optional)
-# cat possible
+# cat options
 Dependent: 01 - Priority acceptable
     port 0x3f0-0x3f0, align 0x7, size 0x6, 16-bit address decoding
     port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding

-- 
#include <~/.signature>: permission denied
