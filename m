Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUKSR5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUKSR5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUKSR5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:57:47 -0500
Received: from math.ut.ee ([193.40.5.125]:14300 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261519AbUKSR50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:57:26 -0500
Date: Fri, 19 Nov 2004 19:34:35 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <419E2D2B.4020804@free.fr>
Message-ID: <Pine.SOC.4.61.0411191934070.29328@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>
 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee>
 <419E2D2B.4020804@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you send me the result of : "for i in /sys/bus/pnp/devices/*; do cat 
> $i/id $i/options; done" in order to see if other devices have missing 
> resources ?

PNP0c01
PNP0200
PNP0800
PNP0c04
PNP0303
PNP0f13
PNP0b00
PNP0c02
PNP0700
port 0x3f0-0x3f0, align 0x0, size 0x6, 16-bit address decoding
port 0x3f7-0x3f7, align 0x0, size 0x1, 16-bit address decoding
irq 6 High-Edge
dma 2 8-bit compatible
PNP0501
Dependent: 01 - Priority acceptable
    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
SMCf010
Dependent: 01 - Priority acceptable
    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 02 - Priority acceptable
    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 03 - Priority acceptable
    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
Dependent: 04 - Priority acceptable
    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
PNP0401
Dependent: 01 - Priority acceptable
    port 0x378-0x378, align 0x0, size 0x3, 16-bit address decoding
    port 0x778-0x778, align 0x0, size 0x3, 16-bit address decoding
    irq 7 High-Edge
Dependent: 02 - Priority acceptable
    port 0x278-0x278, align 0x0, size 0x3, 16-bit address decoding
    port 0x678-0x678, align 0x0, size 0x3, 16-bit address decoding
    irq 5 High-Edge
Dependent: 03 - Priority acceptable
    port 0x3bc-0x3bc, align 0x0, size 0x3, 16-bit address decoding
    port 0x7bc-0x7bc, align 0x0, size 0x3, 16-bit address decoding
    irq 7 High-Edge
TOS6200

-- 
Meelis Roos (mroos@linux.ee)
