Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279937AbRKGKZB>; Wed, 7 Nov 2001 05:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280357AbRKGKYv>; Wed, 7 Nov 2001 05:24:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55313 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279937AbRKGKYl>; Wed, 7 Nov 2001 05:24:41 -0500
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition
To: linux@hazard.jcu.cz (Jan Marek)
Date: Wed, 7 Nov 2001 10:30:39 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20011107111056.E11351@hazard.jcu.cz> from "Jan Marek" at Nov 07, 2001 11:10:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E161Pyh-0003hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 00:09.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
> 	Subsystem: Compaq Computer Corporation 56k V.90 Modem
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=256]
> 	Region 1: I/O ports at 2400 [size=8]
> 	Region 2: I/O ports at 2000 [size=256]
> 	Capabilities: [f8] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Can you disable the winmodem in the BIOS at all. I've seen similar reports
of audio hangs where the IRQ was shared by a lucent winmodem - no idea
why since it ought to be passive and minding its own business.
