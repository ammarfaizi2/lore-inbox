Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbUK0UB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbUK0UB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 15:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUK0UB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 15:01:57 -0500
Received: from math.ut.ee ([193.40.5.125]:8872 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261320AbUK0UBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 15:01:52 -0500
Date: Sat, 27 Nov 2004 21:39:14 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: matthieu castet <castet.matthieu@free.fr>
cc: Li Shaohua <shaohua.li@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
In-Reply-To: <41A8CE4E.8090605@free.fr>
Message-ID: <Pine.SOC.4.61.0411272119030.21272@math.ut.ee>
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
 <Pine.SOC.4.61.0411272023240.21272@math.ut.ee> <41A8CE4E.8090605@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure you have enable ACPI DEBUG ?

Oops, I did not. Now with ACPi DEBUG enabled and the Makefile patch 
applied:

activate:
******574*******
Resource structure 0.
Io Resource
   16 bit decode
   Range minimum base: 00000000
   Range maximum base: 00000000
   Alignment: 00000001
   Range Length: 00000000
Resource structure 1.
IRQ Resource
   Edge Triggered
   Active High
   Exclusive
   0 Interrupts ( )
Resource structure 2.
Io Resource
   16 bit decode
   Range minimum base: 00000000
   Range maximum base: 00000000
   Alignment: 00000001
   Range Length: 00000000
Resource structure 3.
DMA Resource
   Compatibility mode
   Not a Bus Master
   16 bit only transfer
   Number of Channels: 0 ( )
Resource structure 4.
end_tag Resource
pnp: Res cnt 4
pnp: res cnt 4
pnp: Encode io
pnp: Encode irq
pnp: Encode io
pnp: Encode dma
******857*******
Resource structure 0.
Io Resource
   16 bit decode
   Range minimum base: 00000100
   Range maximum base: 00000107
   Alignment: 00000000
   Range Length: 00000008
Resource structure 1.
IRQ Resource
   Edge Triggered
   Active High
   Exclusive
   1 Interrupts ( 5 )
Resource structure 2.
Io Resource
   16 bit decode
   Range minimum base: 000002E8
   Range maximum base: 000002EF
   Alignment: 00000000
   Range Length: 00000008
Resource structure 3.
DMA Resource
   Compatibility mode
   Not a Bus Master
   16 bit only transfer
   Number of Channels: 1 ( 3 )
Resource structure 4.
end_tag Resource
pnp: Device 00:0a activated.


modprobe is still the same.

-- 
Meelis Roos (mroos@linux.ee)
