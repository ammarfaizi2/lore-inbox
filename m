Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSF2BwB>; Fri, 28 Jun 2002 21:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSF2BwA>; Fri, 28 Jun 2002 21:52:00 -0400
Received: from [194.105.207.66] ([194.105.207.66]:14539 "EHLO rockie")
	by vger.kernel.org with ESMTP id <S317499AbSF2BwA>;
	Fri, 28 Jun 2002 21:52:00 -0400
Message-ID: <000901c21f0f$f9fa82f0$9802a8c0@nick>
From: "Nick Evgeniev" <nick@octet.spb.ru>
To: <linux-kernel@vger.kernel.org>
Subject: linnux 2.4.19-rc1 i845e ide not detected. dma doesn't work
Date: Sat, 29 Jun 2002 05:54:59 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote here about my problems with promise pdc controller in smp
configuration, and I was told that I'm using bad hardware (VIA chipset)
and blah-blah-blah...

Well, I've changed hardware to UP P4 box based on i845e chipset...
Now I've got the following messages on kernel boot, and of cause no DMA
on ide channels (even with hdparm):


Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: (ide_setup_pci_device:) Could not enable device.

here is lspci output:

00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01) (prog-if 8a
+[Master SecP PriP])
        Subsystem: Micro-star International Co Ltd: Unknown device 5661
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
+Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
+<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at <unassigned> [size=8]
        Region 1: I/O ports at <unassigned> [size=4]
        Region 2: I/O ports at <unassigned> [size=8]
        Region 3: I/O ports at <unassigned> [size=4]
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

What should I do with my hardware? Through it away? round and around?!



