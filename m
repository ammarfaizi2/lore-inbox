Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRCSAPB>; Sun, 18 Mar 2001 19:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbRCSAOv>; Sun, 18 Mar 2001 19:14:51 -0500
Received: from mail1.svr.pol.co.uk ([195.92.193.18]:42620 "EHLO
	mail1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131305AbRCSAOk>; Sun, 18 Mar 2001 19:14:40 -0500
Date: Mon, 19 Mar 2001 00:16:26 +0000 (GMT)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Tim Waugh <twaugh@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103171951340.440-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0103190015080.8534-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2001, Mike Galbraith wrote:

> No device I'm using has irq troubles.. at least nothing obvious.  I've
> no idea if the spurious irq is VIA chipset related or not.. only that
> it's a fairly recent arrival.  All devices work fine here.

In /etc/modules.conf I have:

options parport_pc irq=none

but dmesg says:

parport0: PC-style at 0x378 (0x778), irq 7, dma 3
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_mux: aa55f00f52ad51(80)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
parport0: cpp_mux: aa55f00f52ad51(80)
parport0: cpp_daisy: aa5500ff(80)
parport0: assign_addrs: aa5500ff(80)
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
lp0: using parport0 (interrupt-driven).

How do I stop the parport module from using interrupts?


