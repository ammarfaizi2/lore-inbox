Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTLBNqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLBNqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:46:07 -0500
Received: from k1.dinoex.de ([80.237.200.138]:57800 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S262009AbTLBNqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:46:05 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: rddunlap@osdl.org
Subject: Re: [2.6] Missing L2-cache after warm boot
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
References: <87ptf8bpnd.fsf@echidna.jochen.org> <20031201113300.7eb9bb7f.rddunlap@osdl.org>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Tue, 02 Dec 2003 14:16:33 +0100
In-Reply-To: <20031201113300.7eb9bb7f.rddunlap@osdl.org> (Randy Dunlap's
 message of "Mon, 1 Dec 2003 11:33:00 -0800")
Message-ID: <87ekvnjr66.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> Can you apply this patch so that we can see what cache/TLB descriptors
> are found during the boot?

The last reboots (cold, warm from Linux and Win2k) all had Level2
cache enabled.  I'll keep running with your patch, so we have some
traces when it happens again.

What disturbs me is that the system locked hard a view times now.
I've now restricted memory with mem=190m (has 196m installed).  I'll
keep investigating.

Jochen

-- 
#include <~/.signature>: permission denied
