Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRIDVNn>; Tue, 4 Sep 2001 17:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269354AbRIDVNd>; Tue, 4 Sep 2001 17:13:33 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:46765 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269257AbRIDVNX>; Tue, 4 Sep 2001 17:13:23 -0400
Date: Tue, 4 Sep 2001 17:13:15 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: lp0 (hpdj870) problem w/2.4.9-ac3
Message-ID: <Pine.LNX.4.33.0109041709500.6866-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the printer(lprng) wasn't doing anything, so I stopped it
and rmmoded the related modules and restarted:

Sep  4 17:01:26 back40 kernel: 0x378: FIFO is 16 bytes
Sep  4 17:01:26 back40 kernel: 0x378: writeIntrThreshold is 7
Sep  4 17:01:26 back40 kernel: 0x378: readIntrThreshold is 7
Sep  4 17:01:26 back40 kernel: 0x378: PWord is 8 bits
Sep  4 17:01:26 back40 kernel: 0x378: Interrupts are ISA-Pulses
Sep  4 17:01:26 back40 kernel: 0x378: ECP port cfgA=0x10 cfgB=0x4b
Sep  4 17:01:26 back40 kernel: 0x378: ECP settings irq=7 dma=3
Sep  4 17:01:26 back40 kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Sep  4 17:01:26 back40 kernel: parport0: cpp_daisy: aa5500ff(a8)
Sep  4 17:01:26 back40 kernel: parport0: assign_addrs: aa5500ff(a8)
Sep  4 17:01:26 back40 kernel: parport0: cpp_daisy: aa5500ff(18)
Sep  4 17:01:26 back40 kernel: parport0: assign_addrs: aa5500ff(18)
Sep  4 17:01:26 back40 kernel: parport0: Printer, HEWLETT-PACKARD DESKJET 870C
Sep  4 17:01:27 back40 kernel: lp0: using parport0 (interrupt-driven).
Sep  4 17:01:51 back40 kernel: DMA write timed out
Sep  4 17:02:01 back40 kernel: parport0: FIFO is stuck
Sep  4 17:02:01 back40 kernel: parport0: BUSY timeout (1) in compat_write_block_pio

/proc/interrupts and /proc/dma show no conflicts.  I'll try ac-7, if that
doesn't do it, what should I look at next ?
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya


