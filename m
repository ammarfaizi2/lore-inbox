Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136129AbRDVNy4>; Sun, 22 Apr 2001 09:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136128AbRDVNyr>; Sun, 22 Apr 2001 09:54:47 -0400
Received: from baltazar.tecnoera.com ([200.29.128.1]:5130 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id <S136129AbRDVNyd>; Sun, 22 Apr 2001 09:54:33 -0400
Date: Sun, 22 Apr 2001 09:54:11 -0400 (CLT)
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Andreas Hartmann <andihartmann@freenet.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.3ac11] clock timer configuration lost - probably a VIA686a
 motherboard
In-Reply-To: <01042214101400.15273@athlon>
Message-ID: <Pine.LNX.4.33.0104220952521.4950-100000@baltazar.tecnoera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should have gone on my last email:

[root@blackbird log]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies Unknown device (rev 68).
      Vendor id=1106. Device id=691.
      Medium devsel.  Master Capable.  No bursts.
      Prefetchable 32 bit memory at 0xd0000000 [0xd0000008].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies VT 82C598 Apollo MVP3 AGP (rev 0).
      Medium devsel.  Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies Unknown device (rev 34).
      Vendor id=1106. Device id=686.
      Medium devsel.  Master Capable.  No bursts.
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 16).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=32.
      I/O at 0xe000 [0xe001].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 16).
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.
      I/O at 0xe400 [0xe401].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 16).
      Medium devsel.  IRQ 10.  Master Capable.  Latency=32.
      I/O at 0xe800 [0xe801].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies Unknown device (rev 48).
      Vendor id=1106. Device id=3057.
      Medium devsel.  Fast back-to-back capable.
  Bus  0, device  11, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.
Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xdb100000 [0xdb100000].
      I/O at 0xec00 [0xec01].
      Non-prefetchable 32 bit memory at 0xdb000000 [0xdb000000].
  Bus  1, device   0, function  0:
    VGA compatible controller: 3Dfx Unknown device (rev 1).
      Vendor id=121a. Device id=5.
      Fast devsel.  Fast back-to-back capable.  IRQ 11.
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4000000].
      Prefetchable 32 bit memory at 0xd8000000 [0xd8000008].
      I/O at 0xd000 [0xd001].
[root@blackbird log]#

