Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTGTGHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 02:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTGTGHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 02:07:07 -0400
Received: from k1.dinoex.de ([80.237.200.94]:4875 "EHLO k1.dinoex.de")
	by vger.kernel.org with ESMTP id S262283AbTGTGHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 02:07:04 -0400
To: Adam Belay <ambx1@neo.rr.com>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
	<20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com>
	<20030703025343.GC282@fs.tum.de> <20030703190304.GA17707@neo.rr.com>
	<20030704121124.GB12633@fs.tum.de> <20030715224732.GA31942@neo.rr.com>
	<20030716182251.GW10191@fs.tum.de> <20030716184317.GC31942@neo.rr.com>
From: Jochen Hein <jochen@jochen.org>
X-No-Archive: yes
Date: Sun, 20 Jul 2003 07:59:21 +0200
In-Reply-To: <20030716184317.GC31942@neo.rr.com> (Adam Belay's message of
 "Wed, 16 Jul 2003 18:43:17 +0000")
Message-ID: <87brvpkabq.fsf@echidna.jochen.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay <ambx1@neo.rr.com> writes:

> Also there is a kernel parameter to allow dma 0.  It is 'allowdma0' and
> I predict the extra dma will get the sound card working.

Can you please add some explanation to the kernel documentation, what
this parameter does and why it helps?

kernel-parameters.txt says only:

[...]
        allowdma0       [ISAPNP]
[...]

pnp.txt says:

[...]
also there are a series of kernel parameters:
allowdma0
pnp_reserve_irq=irq1[,irq2] ....
pnp_reserve_dma=dma1[,dma2] ....
pnp_reserve_io=io1,size1[,io2,size2] ....
pnp_reserve_mem=mem1,size1[,mem2,size2] ....
[...]

Even if I'd read the files, I'd never guess that I should try that
parameter.

Jochen


-- 
#include <~/.signature>: permission denied
