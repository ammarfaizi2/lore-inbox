Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbUK0SsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbUK0SsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 13:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUK0SsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 13:48:13 -0500
Received: from math.ut.ee ([193.40.5.125]:23470 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261299AbUK0SsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 13:48:08 -0500
Date: Sat, 27 Nov 2004 20:24:55 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: Li Shaohua <shaohua.li@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <41A88904.3070305@free.fr>
Message-ID: <Pine.SOC.4.61.0411272023240.21272@math.ut.ee>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> 
 <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> 
 <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> 
 <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee> 
 <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee> 
 <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee> 
 <41A0F893.9020106@free.fr> <1101086961.2940.7.camel@sli10-desk.sh.intel.com>
 <Pine.SOC.4.61.0411221016270.16427@math.ut.ee> <41A753A0.1070305@free.fr>
 <Pine.SOC.4.61.0411262018170.26264@math.ut.ee> <41A7CF6A.8010603@free.fr>
 <Pine.SOC.4.61.0411271411190.1904@math.ut.ee> <41A88904.3070305@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just for confirmation, could you try this patch. It should enable pnp_dbg 
> message and print your _CRS when you activate the device.
> If there is nothing between ******574******* and ******857*******, you bios 
> is likely broken.

activate:
******574*******
pnp: Res cnt 4
pnp: res cnt 4
pnp: Encode io
pnp: Encode irq
pnp: Encode io
pnp: Encode dma
******857*******
pnp: Device 00:0a activated.

So it appears that there is something between 574 and 857.


modprobe is the same:
NET: Registered protocol family 23
found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): IrDA not enabled
smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02

-- 
Meelis Roos (mroos@linux.ee)
