Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSHTTCT>; Tue, 20 Aug 2002 15:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHTTCT>; Tue, 20 Aug 2002 15:02:19 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:25098 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S317024AbSHTTCP>;
	Tue, 20 Aug 2002 15:02:15 -0400
Subject: Re: RE:2.4.20-pre{2-4} boot problems
From: Sid Boyce <sboyce@blueyonder.co.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1029856527.2211.21.camel@barrabas>
References: <20020820121157.56510.qmail@web14002.mail.yahoo.com> 
	<1029856527.2211.21.camel@barrabas>
Content-Type: multipart/mixed; boundary="=-ecDAuDu1dg/H2/pRmqPY"
X-Mailer: Evolution/1.0.2 
Date: 20 Aug 2002 19:06:16 +0000
Message-Id: <1029870376.2183.105.camel@barrabas>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ecDAuDu1dg/H2/pRmqPY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

	I have booted 2.4.20-pre4 on another machine with a VIA chipset (ASUS
A7V333) gcc-2.95.3 and just about everything the same.
Regards
Sid.

On Tue, 2002-08-20 at 15:15, Sid Boyce wrote:
> 	Thanks for the reply. I saw some posts about the VIA chipset and
> wondered if they were related. During kernel/modules builds, I get a
> number of warnings of various ideXXX.ver redefined.
> 	Strange you are seeing this on the 845G chipset also.
> Regards
> Sid.
> 
> On Tue, 2002-08-20 at 12:11, Tony Spinillo wrote:
> > Sid,
> > 
> > I just saw your post on linux-kernel. What chipset is your
> > motherboard?
> > I have had similiar problems. I'm using an 845G chipset board.
> > 2.4.20pre1ac1 is also working well for me. The latest patches fail
> > to pick up my IDE devices. 
> > 
> > They might be interested in seeing your lspci -vvv. Mine has been
> > getting hits at http://ac.marywood.edu/tspin/www/lspci.txt
> > since I posted it.
> > 
> > -ac6 is supposed to have more fixes.
> > 
> > Good luck!
> > 
> > Tony
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > HotJobs - Search Thousands of New Jobs
> > http://www.hotjobs.com
> -- 
> Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
> Linux only shop
> ----
> 

> 00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
> 	Subsystem: Asustek Computer, Inc.: Unknown device 807f
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: [a0] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	Memory behind bridge: d6000000-d7dfffff
> 	Prefetchable memory behind bridge: d7f00000-dfffffff
> 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 8080
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin A routed to IRQ 9
> 	Region 4: I/O ports at d800 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 00 [UHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 8080
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin B routed to IRQ 11
> 	Region 4: I/O ports at d400 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:09.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 51) (prog-if 20)
> 	Subsystem: Asustek Computer, Inc.: Unknown device 8080
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin C routed to IRQ 10
> 	Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (8000ns min, 16000ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at d000 [size=256]
> 	Region 1: Memory at d5000000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
> 	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 32 (3000ns min, 32000ns max)
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: I/O ports at b800 [size=64]
> 	Capabilities: [dc] Power Management version 1
> 		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0f.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871 (rev 03)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (2000ns min, 2000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at b400 [disabled] [size=256]
> 	Region 1: Memory at d4800000 (32-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 
> 00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
> 	Subsystem: Asustek Computer, Inc.: Unknown device 808c
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 808c
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Interrupt: pin A routed to IRQ 0
> 	Region 4: I/O ports at b000 [size=16]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 808c
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 9
> 	Region 4: I/O ports at a800 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 00 [UHCI])
> 	Subsystem: Asustek Computer, Inc.: Unknown device 808c
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32, cache line size 08
> 	Interrupt: pin D routed to IRQ 9
> 	Region 4: I/O ports at a400 [size=32]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev b2) (prog-if 00 [VGA])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 64 (1250ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
> 	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
> 	Expansion ROM at d7ff0000 [disabled] [size=64K]
> 	Capabilities: [60] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [44] AGP version 2.0
> 		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
> 		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
> 
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

--=-ecDAuDu1dg/H2/pRmqPY
Content-Disposition: attachment; filename=lspci_B.out
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [=
Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: d9c00000-ddcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at dc00 [disabled] [size=3D256]
	Region 1: Memory at dffff000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at dffe0000 [disabled] [size=3D64K]

00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dddfe000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0c.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at dddff000 (32-bit, prefetchable) [size=3D4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 04)
	Subsystem: Giga-byte Technology 5880 AudioPCI On Motherboard 6OXET
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort+ =
<MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d800 [size=3D64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
	Subsystem: VIA Technologies, Inc.: Unknown device 3074
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 14
	Region 4: I/O ports at ff00 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev =
10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at cc00 [size=3D256]
	Region 1: Memory at dfffef00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) =
(prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at da000000 (32-bit, prefetchable) [size=3D32M]
	Expansion ROM at dfef0000 [disabled] [size=3D64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=3D31 SBA- 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>


--=-ecDAuDu1dg/H2/pRmqPY--

