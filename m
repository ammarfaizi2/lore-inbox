Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268287AbTAMULC>; Mon, 13 Jan 2003 15:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTAMULB>; Mon, 13 Jan 2003 15:11:01 -0500
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:21128
	"EHLO efix.biz") by vger.kernel.org with ESMTP id <S268287AbTAMUKx>;
	Mon, 13 Jan 2003 15:10:53 -0500
Subject: Linux 2.4.21-pre3-ac3 and KT400
From: Edward Tandi <ed@efix.biz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042489183.2617.28.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Jan 2003 20:19:43 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new to this list and most of the e-mail here seems to be very
low-level, so I'm not so sure if this is the right forum for these kinds
of questions -please do point me in the right direction...

I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard. The
processor is a 1.5GHz Athlon XP. I started experimenting with new-ish
kernels again because of the general lack of kernel support for this
chipset in stock kernels. 3 questions below:


1) I have 1GB ram, but I cannot get high memory support to work. It
falls over during boot. I've seen discussions about AMD cache issues,
but has it been fixed yet? Is it supposed to work?


2) The audio driver. It works and this is the main reason why I use this
version of the kernel. The issue I have with it, is that if I start
certain applications (gaim, macromedia flash player 6 for example), esd
gets itself into some kind of hung/blocked state. When this happens, I
need to kill -9 esd and re-start it. Games and xmms work however. The
reason I ask about this is that the downloaded driver from the viaarena
works on a stock kernel without this glitch. Is this a known problem?


3) I get the following messages at boot-time:
Jan 13 18:23:05 wires kernel: Freeing unused kernel memory: 128k freed
Jan 13 18:23:05 wires kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Jan 13 18:23:05 wires kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jan 13 18:23:05 wires kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Jan 13 18:23:05 wires kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jan 13 18:23:05 wires kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Jan 13 18:23:05 wires kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jan 13 18:23:05 wires kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Jan 13 18:23:05 wires kernel: hda: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Jan 13 18:23:05 wires kernel: blk: queue c0437940, I/O limit 4095Mb
(mask 0xffffffff)
Jan 13 18:23:05 wires kernel: hdb: DMA disabled
Jan 13 18:23:05 wires kernel: ide0: reset: success
Jan 13 18:23:05 wires kernel: spurious 8259A interrupt: IRQ7.

Naturally, this is quite alarming. Everything works though, so am I safe
in just ignoring this noise?


4) Does anyone know whether I can get the ethernet interface to work
using stock kernel net device drivers (yes VIA supply the source, but
I'd rather use stock drivers)? I thought it was the via-rhine driver,
but it doesn't seem to recognise the chip. Anyone got it working?


I'd appreciate some help with this (great) motherboard.

Ed-T.

