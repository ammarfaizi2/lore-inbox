Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTJTPll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbTJTPll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:41:41 -0400
Received: from math.ut.ee ([193.40.5.125]:37275 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262676AbTJTPlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:41:39 -0400
Date: Mon, 20 Oct 2003 18:41:30 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031020153020.GA6062@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.44.0310201835490.1336-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just curious, what bridge is in this machine (an output of lspci would
> do fine, too).  Thanks.

00:0b.0 ISA bridge: Symphony Labs W83C553 (rev 10)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0b.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=4]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=4]
	Region 4: I/O ports at 1480 [size=16]
	Region 5: I/O ports at 1490 [size=16]

00:0c.0 SCSI storage controller: LSI Logic / Symbios Logic 53c825 (rev 13)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (4250ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at c2008000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at c2009000 (32-bit, non-prefetchable) [size=4K]

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (5000ns min, 10000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=128]
	Region 1: Memory at c200a000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at c1040000 [disabled] [size=256K]

00:12.0 VGA compatible controller: Cirrus Logic GD 5446 (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 15
	Region 0: Memory at c1000000 (32-bit, prefetchable) [disabled] [size=16M]
	Expansion ROM at c2000000 [disabled] [size=32K]


-- 
Meelis Roos (mroos@linux.ee)

