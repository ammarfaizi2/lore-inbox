Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbUKUUUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUKUUUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKUUUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:20:35 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:65512 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261753AbUKUUUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:20:31 -0500
Message-ID: <41A0F893.9020106@free.fr>
Date: Sun, 21 Nov 2004 21:20:35 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee> <419F136B.8010308@free.fr> <Pine.SOC.4.61.0411211949260.23880@math.ut.ee> <41A0DB78.2010807@free.fr> <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0411212050490.11420@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
>> Could I have the log from smsc-ircc2 when it failed with pnpacpi ?
> 
> 
> found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> smsc_superio_flat(): IrDA not enabled
> smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
> 
just for curiosity, when you have time, could try pnpacpi and jean PNP 
smsc patch?

It sould find the correct resources because there are provided by PnP 
layer, but if the resources are not well allocated by PnPacpi, the 
device shouldn't work.


thanks

Matthieu
