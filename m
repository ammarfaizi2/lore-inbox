Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279845AbRKGKMi>; Wed, 7 Nov 2001 05:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280387AbRKGKM2>; Wed, 7 Nov 2001 05:12:28 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:32666 "HELO hazard.jcu.cz")
	by vger.kernel.org with SMTP id <S279688AbRKGKMO>;
	Wed, 7 Nov 2001 05:12:14 -0500
Date: Wed, 7 Nov 2001 11:10:56 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cannot unlock spinlock... Was: Problem in yenta.c, 2nd edition
Message-ID: <20011107111056.E11351@hazard.jcu.cz>
In-Reply-To: <20011107104044.C11351@hazard.jcu.cz> <20011106123427.A11351@hazard.jcu.cz> <3BE2D37A.D32C6DB1@zip.com.au> <20011105112900.C5919@hazard.jcu.cz> <23001.1005086449@redhat.com> <11670.1005127189@redhat.com> <20011107110702.D11351@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20011107110702.D11351@hazard.jcu.cz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

> I have ACPI enabled and I'm attaching my lspci -vvv... Thank you
> very much...

I'm sorry, I don't remember to attach this file... One's more...

> 
> > --
> > dwmw2
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lsp

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
	Subsystem: Compaq Computer Corporation: Unknown device b110
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at 50000000 (32-bit, prefetchable) [size=256M]

00:04.0 CardBus bridge: Texas Instruments PCI1211
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 7fffe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00004400-000044ff
	I/O window 1: 00004800-000048ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:05.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro (rev dc) (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device b11b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 41000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at 40280000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 3820 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 3800 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: Compaq Computer Corporation: Unknown device b112
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 3400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Compaq Computer Corporation 56k V.90 Modem
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 2400 [size=8]
	Region 2: I/O ports at 2000 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--xHFwDpU9dbj6ez1V--
