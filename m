Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbRFMJdH>; Wed, 13 Jun 2001 05:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbRFMJc5>; Wed, 13 Jun 2001 05:32:57 -0400
Received: from Expansa.sns.it ([192.167.206.189]:21261 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S261515AbRFMJcm>;
	Wed, 13 Jun 2001 05:32:42 -0400
Date: Wed, 13 Jun 2001 11:32:35 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Colonel <klink@clouddancer.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20010613015519.151BF78599@mail.clouddancer.com>
Message-ID: <Pine.LNX.4.33.0106131130200.22415-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the sound blaster 16 card on one of my athlon (on PIII i have
es1731), that has one isa slot on its MB.
It works well, but i do not use isapnp nor any pnp support is enabled
inside of the kernel.
running 2.4.5/2.4.6-pre2

Luigi


On Tue, 12 Jun 2001, Colonel wrote:

> From: Colonel <klink@clouddancer.com>
> To: linux-kernel@vger.kernel.org
> Subject: ISA Soundblaster problem
> Reply-to: klink@clouddancer.com
>
>
> The Maintainers list does not contain anyone for 2.4 Soundblaster
> modules, so perhaps some one on the mailing list is aware of a
> solution.  My ISA Soundblaster 16waveffects worked fine in kernel 2.2
> with XMMS.  But I have never been successful in a varity of 2.4
> kernels, the latest being 2.4.5-ac12.  This is what I know:
>
> [DMESG]
> isapnp: Scanning for PnP cards...
> isapnp: Calling quirk for 01:00
> isapnp: SB audio device quirk - increasing port range
> isapnp: Card 'Creative SB16 PnP'
> isapnp: 1 Plug & Play card detected total
>
> }modprobe sb
> /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: init_module: No such device
> /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
> /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: insmod /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o failed
> /lib/modules/2.4.5-ac12/kernel/drivers/sound/sb.o: insmod sb failed
>
>
> [/etc/modules.conf]
> options sb io=0x220 irq=5 dma=1 dma16=5 mpu_io=0x330
>
>
> [DMESG}
> Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
> sb: No ISAPnP cards found, trying standard ones...
> sb: dsp reset failed.
>
>
> So it seems that PnP finds the card, but the connections (or even the
> forced values) to the sb module fail.  Back when this was a single
> processor machine, but still running 2.4 kernel, a windoze
> installation found the SB at the listed interface parameters.
>
>
> Anyone have a solution?
>
> Same problem without modules.conf settings, valid version of mod
> utilities, a web search did not help,...
>
>
>
> TIA
>
>
> please CC:  klink@clouddancer.com, not currently on the mailing list.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

