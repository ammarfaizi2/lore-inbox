Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbRFMOgO>; Wed, 13 Jun 2001 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263799AbRFMOgE>; Wed, 13 Jun 2001 10:36:04 -0400
Received: from mta3.snfc21.pbi.net ([206.13.28.141]:34003 "EHLO
	mta3.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263165AbRFMOfp>; Wed, 13 Jun 2001 10:35:45 -0400
Date: Wed, 13 Jun 2001 07:32:36 -0700 (PDT)
From: Steve Snyder <swsnyder@home.com>
Subject: IDE chipset: CMD643 == CMD640?
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-to: Steve Snyder <swsnyder@home.com>
Message-id: <0GEV00CTLHR5YP@mta3.snfc21.pbi.net>
MIME-version: 1.0
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
Content-type: text/plain; charset="us-ascii"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My notebook, an old Pentium/150-based Dell Latitude, uses the CMD643 
IDE controller.  Is this effectively the same part as the CMD640 that 
is warned about in the kernel doc?  I'm trying to decide if the CMD640
bugfix is required in the v2.4.5 kernel options.

Thanks.

---------------------

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD643: IDE controller on PCI bus 00 dev 40
CMD643: chipset revision 0
CMD643: not 100% native mode: will probe irqs later
CMD643: simplex device: DMA forced
    ide0: BM-DMA at 0xfe00-0xfe07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfe08-0xfe0f, BIOS settings: hdc:pio, hdd:pio

---------------------

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PicoPower Technology PT86C52x [Vesuvius] (rev 4).
  Bus  0, device   6, function  0:
    ISA bridge: PicoPower Technology PT80C524 [Nile] (rev 0).
  Bus  0, device   7, function  0:
    VGA compat controller: Neomagic NM2090 [MagicGraph 128V] (rev1).
      Prefetchable 32 bit memory at 0x30000000 [0x303fffff].
  Bus  0, device   8, function  0:
    IDE interface: CMD Technology Inc PCI0643 (rev 0).
      IRQ 14.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0xfe00 [0xfe0f].
  Bus  0, device   9, function  0:
    CardBus bridge: Texas Instruments PCI1130 (rev 4).
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   9, function  1:
    CardBus bridge: Texas Instruments PCI1130 (#2) (rev 4).
      Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].


*** Steve Snyder ***

