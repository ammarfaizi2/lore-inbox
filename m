Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272254AbRHWMQp>; Thu, 23 Aug 2001 08:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272250AbRHWMQf>; Thu, 23 Aug 2001 08:16:35 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:29446 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272249AbRHWMQR>; Thu, 23 Aug 2001 08:16:17 -0400
Date: Thu, 23 Aug 2001 14:16:57 +0200 (CEST)
From: Axel Siebenwirth <axel@hh59.org>
To: Axel <axel@rayfun.org>
cc: Kernel Ml <linux-kernel@vger.kernel.org>, Realtek Ml <realtek@scyld.com>
Subject: Re: [realtek] Realtek 8139C: NETDEV WATCHDOG transmit timeout
In-Reply-To: <Pine.LNX.4.33.0108231355260.15344-100000@neon.hh59.org>
Message-ID: <Pine.LNX.4.33.0108231414350.16256-100000@neon.hh59.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got myself the latest version of rtl8139-diag and it gave me different
output in the chip registers! there are different values at 0x040.

axel

rtl8139-diag.c:v2.04 8/08/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a RealTek RTL8139 adapter at 0xf800.
The RealTek chip appears to be active, so some registers will not be read.
To see all register values use the '-f' flag.
RealTek chip registers at 0xf800
 0x000: 26843000 0000470b 80040000 40000000 9008a03c 9008a054 9008a054
9008a03c
 0x020: 03096000 03096600 03096c00 03097200 02f80000 0d0a0000 42dc42cc
0000c07f
 0x040: 74000600 0e00f78e 951264c7 00000000 000d1000 00000000 008cd108
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



