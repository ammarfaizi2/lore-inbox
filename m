Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271813AbRHWMDq>; Thu, 23 Aug 2001 08:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272241AbRHWMDg>; Thu, 23 Aug 2001 08:03:36 -0400
Received: from pD9508DD0.dip.t-dialin.net ([217.80.141.208]:9220 "EHLO
	neon.hh59.org") by vger.kernel.org with ESMTP id <S271813AbRHWMDS>;
	Thu, 23 Aug 2001 08:03:18 -0400
Date: Thu, 23 Aug 2001 14:04:15 +0200 (CEST)
From: Axel <axel@rayfun.org>
X-X-Sender: <axel@neon.hh59.org>
To: Kernel Ml <linux-kernel@vger.kernel.org>, Realtek Ml <realtek@scyld.com>
Subject: Realtek 8139C: NETDEV WATCHDOG transmit timeout
Message-ID: <Pine.LNX.4.33.0108231355260.15344-100000@neon.hh59.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

again I get those messages, that I had as well with older 8139too in
2.4. I thought that network problem was solved with the new 8139too? I'm
running kernel 2.4.8.
It's connected to an ADSL Modem, so my connection gets disconnected due to
the transmit timeouts.. it doesnt need so much traffic to cause it. just a
little network traffic and there it goes..

Axel

Aug 23 13:40:31 bello kernel: NETDEV WATCHDOG: eth1: transmit timed out
Aug 23 13:40:31 bello kernel: eth1: Tx queue start entry 191  dirty entry
187.
Aug 23 13:40:31 bello kernel: eth1:  Tx descriptor 0 is 00002000.
Aug 23 13:40:31 bello kernel: eth1:  Tx descriptor 1 is 00002000.
Aug 23 13:40:31 bello kernel: eth1:  Tx descriptor 2 is 00002000.
Aug 23 13:40:31 bello kernel: eth1:  Tx descriptor 3 is 00002000. (queue
head)
Aug 23 13:40:31 bello kernel: eth1: Setting half-duplex based on
auto-negotiated

rtl8139-diag.c:v1.01 4/30/99 Donald Becker (becker@cesdis.gsfc.nasa.gov)
Index #1: Found a RealTek RTL8139 adapter at 0xf800.
RealTek chip registers at 0xf800
 0x000: 26843000 0000470b 80040000 40000000 9008a054 9008a03c 9008a054
9008a054
 0x020: 03096000 03096600 03096c00 03097200 02f80000 0d0a0000 28702860
0000c07f
 0x040: 74000600 0e00f78e f851a9c5 00000000 000d10c6 00000000 008cd108
00100000
 0x060: 1000f00f 01e1782d 00000000 00000000 00000005 000f77c0 b0f243b9
7a36d743.  No interrupt sources are pending.
 The chip configuration is 0x10 0x0d, MII half-duplex mode.
 The RTL8139 does not use a MII transceiver.
 It does have internal MII-compatible registers:
   Basic mode control register   0x782d.
   Basic mode status register    0x1000.
   Autonegotiation Advertisement 0x01e1.
   Link Partner Ability register 0x0000.
   Autonegotiation expansion     0x0000.
   Disconnects                   0x0000.
   False carrier sense counter   0x0000.
   NWay test register            0x0005.
   Receive frame error count     0x0000.


