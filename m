Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262336AbREROVp>; Fri, 18 May 2001 10:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262340AbREROVf>; Fri, 18 May 2001 10:21:35 -0400
Received: from 202-123-209-152.outblaze.com ([202.123.209.152]:22461 "EHLO
	mg.hk5.outblaze.com") by vger.kernel.org with ESMTP
	id <S262335AbREROVT>; Fri, 18 May 2001 10:21:19 -0400
Message-ID: <20010518142110.29102.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 4.104 (Entity 4.117)
From: "Joshua Corbin" <jcorbin@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 18 May 2001 22:21:09 +0800
Subject: FIC AD11(AMD 761/VIA 686B) AGP port not supported
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Motherboard is a FIC AD11(AMD 761/VIA 686B chipset).  Vid-card is a radeon 32M ddr model.

Whenever I startx with the radeon driver, the machine hangs, forced to use reset switch, not even C-A-Del works.  But with the generic vga driver I get all of 16 colors at less than 640x480.

Here are relevant dmesg lines:
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Unsupported AMD chipset (device id: 700e), you might want to try agp_try_unsupported=1.
agpgart: no supported devices found.

What does agp_try_unsupported mean?  Where do I set this setting?

and relevant lspci:
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e3100000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=421
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

Also attached are the full dmesg and lspci output.

Please help, as it is I am force to use windows to get anything done (that too needed updated drivers before it would work properly).

Thanks in advance -- Josh

-- 

Get your free email from www.linuxmail.org 


Powered by Outblaze
