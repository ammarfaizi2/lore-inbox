Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268372AbTAMWLR>; Mon, 13 Jan 2003 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268368AbTAMWLR>; Mon, 13 Jan 2003 17:11:17 -0500
Received: from mail.mediaways.net ([193.189.224.113]:18577 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268377AbTAMWLN>; Mon, 13 Jan 2003 17:11:13 -0500
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400
From: Soeren Sonnenburg <kernel@nn7.de>
To: ed@efix.biz
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042495829.1223.10.camel@sun>
Mime-Version: 1.0
Date: 13 Jan 2003 23:10:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard.
> The processor is a 1.5GHz Athlon XP. I started experimenting with
> new-ish kernels again because of the general lack of kernel support
> for this chipset in stock kernels. 3 questions below:

Hey finally someone with my setup :-))

> 1) I have 1GB ram, but I cannot get high memory support to work. It
> falls over during boot. I've seen discussions about AMD cache issues,
> but has it been fixed yet? Is it supposed to work?

I am using older kernels (2.4.20) and it seems to work...


> 2) The audio driver. It works and this is the main reason why I use
> this version of the kernel. The issue I have with it, is that if I
> start certain applications (gaim, macromedia flash player 6 for
> example), esd gets itself into some kind of hung/blocked state. When
> this happens, I need to kill -9 esd and re-start it. Games and xmms
> work however. The reason I ask about this is that the downloaded
> driver from the viaarena works on a stock kernel without this glitch.
> Is this a known problem?

I use the alsa 0.9 driver and never had a problem like that...

3) I get the following messages at boot-time:
[...]
> Jan 13 18:23:05 wires kernel: hda: dma_intr: error=0x84 {
> DriveStatusError BadCRC }
> Jan 13 18:23:05 wires kernel: blk: queue c0437940, I/O limit 4095Mb
> (mask 0xffffffff)
> Jan 13 18:23:05 wires kernel: hdb: DMA disabled
> Jan 13 18:23:05 wires kernel: ide0: reset: success
> Jan 13 18:23:05 wires kernel: spurious 8259A interrupt: IRQ7.

> Naturally, this is quite alarming. Everything works though, so am I
> safe in just ignoring this noise?

That sounds like a bad cable. Do you use 80wires ide cables, connectors
attached to the ends ?

however I also get this spurious interrupt and it might be alarming...

> 4) Does anyone know whether I can get the ethernet interface to work
> using stock kernel net device drivers (yes VIA supply the source, but
> I'd rather use stock drivers)? I thought it was the via-rhine driver,
> but it doesn't seem to recognise the chip. Anyone got it working?

just have a look at the cdrom supplied with your mainboard. there is a
GPLed bcm4400 driver on that disk... 

> I'd appreciate some help with this (great) motherboard.

well I have all kinds of trouble here (-> freezes)... I still hope that
it is not the via chipset nor the mainboard causing it this time.

Soeren.

