Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269849AbRHMF27>; Mon, 13 Aug 2001 01:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269841AbRHMF2t>; Mon, 13 Aug 2001 01:28:49 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:3592 "EHLO mx3.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S269839AbRHMF2g>;
	Mon, 13 Aug 2001 01:28:36 -0400
Date: Mon, 13 Aug 2001 13:29:52 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: aic7xxx: Cannot map device: ahc_pci:1:3:0: No SCB space found
Message-ID: <Pine.LNX.4.33.0108131325290.269-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Help,

I got the following problem (from dmesg) ...

PCI: Enabling device 01:03.0 (0155 -> 0157)
aic7xxx: PCI1:3:0 MEM region 0xe8100000 in use. Cannot map device.
ahc_pci:1:3:0: No SCB space found
Trying to free free IRQ11


/proc/pci ...

  Bus  1, device   3, function  0:
    SCSI storage controller: Adaptec AIC-7881U (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0x1400 [0x14ff].
      Non-prefetchable 32 bit memory at 0x50000000 [0x50000fff].
  Bus  0, device  18, function  0:
    Host bridge: Intel Corporation 450NX - 82454NX/84460GX PCI Expander
Bridge (rev 4).
      Master Capable.  Latency=72.
  Bus  1, device   3, function  0:
    SCSI storage controller: Adaptec AIC-7881U (#2) (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 32 bit memory at 0xe8100000 [0xe8100fff].



I've only one AIC7881 card, but why does it shows up twice?

One another system, it works fine. Could this be due to hardware problem?

It's the same kernel. Linux 2.4.6-pre9 #1 SMP. Both are SMP machines.



Thanks,
Jeff
[ jchua@fedex.com ]

