Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274980AbTHLCSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274987AbTHLCSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:18:46 -0400
Received: from EPRONET.01.dios.net ([65.222.230.105]:15263 "EHLO
	mail.eproinet.com") by vger.kernel.org with ESMTP id S274980AbTHLCSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:18:44 -0400
Date: Mon, 11 Aug 2003 21:45:29 -0400 (EDT)
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3 problems on Acer TravelMate 260 (ALSA,ACPIvsSynaptics,yenta)
In-Reply-To: <20030811173538.GA2604@man.beta.es>
Message-ID: <Pine.LNX.4.44.0308112137340.20222-100000@llave.eproinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Santiago Garcia Mantinan wrote:

> Seems so, these are the messages for yenta on 2.4.21:
> 
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> PCI: Found IRQ 11 for device 01:09.0
> PCI: Sharing IRQ 11 with 00:1d.1
> IRQ routing conflict for 01:09.0, have irq 10, want irq 11
> Yenta IRQ list 00b8, PCI irq10
> Socket status: 30000007
> cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff
> 0xe0000-0xfffff
> 
> > - which version of pcmcia-cs are you using with 2.4 ?
> 
> 3.2.2
> 
> > - which IRQ(s) does 2.4 i82365 use ?
> 
> The same ones as yenta, here you have the messages I get with it just in
> case:
> 
> Linux PCMCIA Card Services 3.2.2
>   kernel build: 2.4.21 #1 Sat Jun 14 19:43:14 CEST 2003
>   options:  [pci] [cardbus] [apm]
> Intel ISA/PCI/CardBus PCIC probe:
> PCI: Found IRQ 11 for device 01:09.0
> PCI: Sharing IRQ 11 with 00:1d.1
> IRQ routing conflict for 01:09.0, have irq 10, want irq 11
>   O2Micro OZ6912 rev 00 PCI-to-CardBus at slot 01:09, mem 0x10001000
>     host opts [0]: [pci/way] [pci irq 10] [lat 32/176] [bus 2/5]
>     ISA irqs (default) = 3,4,5,7 PCI status changes

I'm fighting this same O2Micro (HP Pavilion ze4400). I could not get
yenta to do squat with it under 2.4 which means a lot of fudging
configs around to even try to get it working on 2.6. i82365 works on
2.4 (with IRQ routing complaints) but refuses to acknowlege it's
existance on 2.6. Could you post or send me your PCIC=yenta config file?
(Debian /etc/default/pcmcia. I don't know where on other distros.)

TIA,
mwa

-- 
Mark W. Alexander
slash@dotnetslash.net

