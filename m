Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136412AbRD2XpX>; Sun, 29 Apr 2001 19:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136409AbRD2XpO>; Sun, 29 Apr 2001 19:45:14 -0400
Received: from [62.81.160.68] ([62.81.160.68]:23512 "EHLO smtp2.alehop.com")
	by vger.kernel.org with ESMTP id <S132993AbRD2XpB>;
	Sun, 29 Apr 2001 19:45:01 -0400
Date: Mon, 30 Apr 2001 01:36:05 -0400
From: Ignacio Monge <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.4.4 Hanging/Locking
Message-Id: <20010430013605.1d51277c.ignaciomonge@navegalia.com>
X-Mailer: Sylpheed version 0.4.65cvs11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	The same thing happens to me. I've tried to start my ethernet, but my
system hangs and, after a forced restart, the BIOS has cleared all my
setup configuration (!).
	kernel 2.4.4 / modutils 2.4.5
	VIA 868a, Athlon Thunderbidth 1 Ghz,  384 Mb RAM. Mandrake 8. Gcc 2.96.

	cat /proc/pci
	 [...
		  Bus  0, device  12, function  0:
    Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0x9000 [0x90ff].
      Non-prefetchable 32 bit memory at 0xde800000 [0xde8000ff].

	...]

	lspci -vv:
	[...
	00:0c.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX
(rev 10)
	Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at de800000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>
	...]

	I need some help.

	Thanks
