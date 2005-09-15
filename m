Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbVIOUQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbVIOUQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbVIOUQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:16:28 -0400
Received: from k1.dinoex.de ([80.237.200.138]:5331 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S1161005AbVIOUQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:16:27 -0400
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
From: Jochen Hein <jochen@jochen.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ACPI] suspend to RAM doesn't work
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
Date: Thu, 15 Sep 2005 22:04:49 +0200
Message-ID: <87irx23xni.fsf@echidna.jochen.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System is a Thinkpad R40, running debian/sarge with kernel 2.6.14-rc1.
I do:
root@hermes:/sys/power# echo mem > state
root@hermes:/sys/power#

dmesg shows:
PM: Preparing system for mem sleep

But the system doesn't suspend.  Suspend to disk works fine.

Jochen

-- 
#include <~/.signature>: permission denied
