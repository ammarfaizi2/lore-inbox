Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274778AbRIZCGm>; Tue, 25 Sep 2001 22:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274784AbRIZCGX>; Tue, 25 Sep 2001 22:06:23 -0400
Received: from oe32.law11.hotmail.com ([64.4.16.89]:39437 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S274778AbRIZCGO>;
	Tue, 25 Sep 2001 22:06:14 -0400
X-Originating-IP: [64.180.168.53]
From: "David Grant" <davidgrant79@hotmail.com>
To: "Maxwell Spangler" <maxwax@mindspring.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Greg Ward" <gward@python.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109251614330.5310-100000@tyan.doghouse.com>
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Date: Tue, 25 Sep 2001 19:02:36 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Message-ID: <OE326eDIBlgb8hMppUY00003821@hotmail.com>
X-OriginalArrivalTime: 26 Sep 2001 02:06:35.0140 (UTC) FILETIME=[DE612440:01C1462F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Those messages are almost identical to the ones I get.  Except it happens to
me when I try to install Linux.  Just curious, Max, when did this start
happening?  You say it's an otherwise rock solid system, but was there ever
a time when it didn't do this?  Some people have suspected (with my system)
that the problem may come from IRQ sharing problems.  It looks like Max
isn't using any IRQ sharing with his Promise card, but he is with his Intel
on-board IDE controller, from the lspci listing.  So my other question for
Max is, where are your two hard drives connected to???  I hope I don't sound
completely like I don't know what I'm talking about.

David Grant

>
> Sep 13 22:19:50 tyan kernel: hde: timeout waiting for DMA
> Sep 13 22:19:52 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 13 22:19:52 tyan kernel: hde: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 13 22:20:12 tyan kernel: hde: timeout waiting for DMA
> Sep 13 22:20:13 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 13 22:20:13 tyan kernel: hde: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 13 22:20:34 tyan kernel: hde: timeout waiting for DMA
> Sep 13 22:20:35 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 13 22:20:35 tyan kernel: hde: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 13 22:20:56 tyan kernel: hde: timeout waiting for DMA
> Sep 13 22:20:56 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 13 22:20:56 tyan kernel: hde: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 13 22:20:59 tyan kernel: hde: DMA disabled
> Sep 13 22:20:59 tyan kernel: ide2: reset: success
> Sep 14 04:02:19 tyan kernel: hdg: timeout waiting for DMA
> Sep 14 04:02:20 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 14 04:02:20 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 14 04:02:29 tyan kernel: hde: lost interrupt
> Sep 14 04:02:41 tyan kernel: hdg: timeout waiting for DMA
> Sep 14 04:02:42 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 14 04:02:42 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 14 04:03:03 tyan kernel: hdg: timeout waiting for DMA
> Sep 14 04:03:04 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 14 04:03:04 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 14 04:03:13 tyan kernel: hde: lost interrupt
> Sep 14 04:03:25 tyan kernel: hdg: timeout waiting for DMA
> Sep 14 04:03:25 tyan kernel: ide_dmaproc: chipset supported
ide_dma_timeout func only: 14
> Sep 14 04:03:25 tyan kernel: hdg: irq timeout: status=0x50 { DriveReady
SeekComplete }
> Sep 14 04:03:25 tyan kernel: hdg: DMA disabled
> Sep 14 04:03:26 tyan kernel: ide3: reset: success
> Sep 14 04:04:17 tyan kernel: hde: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
> Sep 14 04:04:17 tyan kernel: hde: drive not ready for command
> Sep 14 04:04:34 tyan kernel: hde: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
> Sep 14 04:04:34 tyan kernel: hde: drive not ready for command
> Sep 14 04:04:42 tyan kernel: hdg: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
> Sep 14 04:04:42 tyan kernel: hdg: drive not ready for command
> Sep 14 10:20:33 tyan kernel: hde: irq timeout: status=0xd0 { Busy }
> Sep 14 10:20:34 tyan kernel: ide2: reset: success
>

[root@tyan /root]# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev
03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev
03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:11.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:12.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev
01)
00:13.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 02)
00:14.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10]
(rev 08)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
82)

