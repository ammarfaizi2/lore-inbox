Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTAKNlk>; Sat, 11 Jan 2003 08:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTAKNlk>; Sat, 11 Jan 2003 08:41:40 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:27409 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S267209AbTAKNlj>;
	Sat, 11 Jan 2003 08:41:39 -0500
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch][2.5] setup default dma_mask for cardbus devices
References: <20030110235010$4659@gated-at.bofh.it>
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 11 Jan 2003 14:17:36 +0100
In-Reply-To: <20030110235010$4659@gated-at.bofh.it> (Zwane Mwaikambo's
 message of "Sat, 11 Jan 2003 00:50:10 +0100")
Message-ID: <87k7hbsu4v.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@holomorphy.com> writes:

> Devices hanging off a cardbus bridge don't get a default dma mask which
> causes problems later when doing pci_alloc_consistent. Patch has been
> tested with tulip based ethernet.

A kernel patched with this patch and the one from bugzilla #134 works
for me.  Your patch is already in -bk, thanks.

Jochen

-- 
#include <~/.signature>: permission denied
