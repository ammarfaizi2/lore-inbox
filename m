Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUJWTEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUJWTEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUJWTEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:04:52 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:18311 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261275AbUJWTD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:03:29 -0400
Subject: Re: linux 2.6.9 on alpha noritake
From: Alexander Rauth <Alexander.Rauth@promotion-ie.de>
Reply-To: Alexander.Rauth@promotion-ie.de
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023175811.GA23184@twiddle.net>
References: <1098476483.11296.37.camel@pro30.local.promotion-ie.de>
	 <1098520279.14984.12.camel@pro30.local.promotion-ie.de>
	 <20041023175811.GA23184@twiddle.net>
Content-Type: text/plain
Organization: Pro/Motion Industrie-Elektronik GmbH
Message-Id: <1098558099.11556.44.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 21:01:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If found another strangeness ....
this is running 2.6.8.1 same machine


0000:00:05.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide
SCSI (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, cache line size 10
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 9000 [size=34M]
????????????????????????????????????????????????????????? how this??
	Region 1: Memory at 0000000002270000 (32-bit, non-prefetchable)
[size=4K]
	Expansion ROM at 0000000000010000 [disabled]

0000:00:07.0 Non-VGA unclassified device: Intel Corp. 82375EB/SB PCI to
EISA Bridge (rev 15)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248

0000:00:0b.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895
(rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (7500ns min, 16000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 9400 [size=34M]
??????????????????????????????????????????????????????? same ....
	Region 1: Memory at 0000000002272000 (32-bit, non-prefetchable)
[size=256]
	Region 2: Memory at 0000000002271000 (32-bit, non-prefetchable)
[size=4K]
	Expansion ROM at 0000000000010000 [disabled]

0000:00:0d.0 VGA compatible controller: ATI Technologies Inc Radeon
RV200 QW [Radeon 7500] (prog-if 00 [VGA])
	Subsystem: C.P. Technology Co. Ltd RV200 QW [Radeon 7500 PCI Dual
Display]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at 0000000008000000 (32-bit, prefetchable)
	Region 1: I/O ports at 9800 [size=256]
??????????????????????????????????????? this seems to be right to me
	Region 2: Memory at 0000000002260000 (32-bit, non-prefetchable)
[size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
[Cyclone] (rev 64)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 9c00 [size=34M]
???????????????????????????????????? and again
	Region 1: Memory at 0000000002273000 (32-bit, non-prefetchable)
[size=128]
	Expansion ROM at 0000000000020000 [disabled]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+



