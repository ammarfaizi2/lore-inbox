Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbTA0LNZ>; Mon, 27 Jan 2003 06:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTA0LNZ>; Mon, 27 Jan 2003 06:13:25 -0500
Received: from host213-121-111-56.in-addr.btopenworld.com ([213.121.111.56]:20177
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S267156AbTA0LNR>; Mon, 27 Jan 2003 06:13:17 -0500
Subject: DFE-580TX lockup
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: becker@scyld.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+TJ3d4M+ixnT/Q4wAZyo"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Jan 2003 11:22:44 +0000
Message-Id: <1043666564.6978.29.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+TJ3d4M+ixnT/Q4wAZyo
Content-Type: multipart/mixed; boundary="=-z/GrnHBmUefLBW1KcRUP"


--=-z/GrnHBmUefLBW1KcRUP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using v1.10 of the sundance driver for DFE-580TX (on 2.4.19), I have
5 of these cards in a system. Every few weeks all networking on the box
stops working, only a reboot can fix it. (not tried unloading and
reloading the modules yet, box is miles away to get to keyboard).
Problem does not appear to be reproducable.

Is this a known problem, is there a solution, if not, would you like
some more debugging information?

Thanks.

Attached is lspci -vv, and /proc/interrupts output.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-z/GrnHBmUefLBW1KcRUP
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-

00:03.0 System peripheral: Compaq Computer Corporation Advanced System Mana=
gement Controller
	Subsystem: Compaq Computer Corporation: Unknown device b0f3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1800 [size=3D256]
	Region 1: Memory at f7df0000 (32-bit, non-prefetchable) [size=3D256]

00:04.0 RAID bus controller: Symbios Logic Inc. (formerly NCR): Unknown dev=
ice 0010 (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 4040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 192 (7500ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 2000 [size=3D256]
	Region 1: Memory at f6000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 2: Memory at f5000000 (32-bit, non-prefetchable) [size=3D16M]
	Expansion ROM at <unassigned> [disabled] [size=3D512K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:05.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC =
[Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at f3000000 (32-bit, prefetchable) [size=3D16M]
	Region 1: I/O ports at 2400 [size=3D256]
	Region 2: Memory at f4ff0000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at <unassigned> [disabled] [size=3D128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 PCI bridge: Intel Corporation: Unknown device b152 (prog-if 00 [Nor=
mal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 00003000-00003fff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
	Subsystem: ServerWorks OSB4 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master =
SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 2800 [size=3D16]

01:04.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 3000 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

01:05.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 3080 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

01:06.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 3400 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

01:07.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 3480 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

02:05.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug Co=
ntroller (rev 12)
	Subsystem: Compaq Computer Corporation: Unknown device a2f8
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f7ef0000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable=
-
		Address: 0000000000000000  Data: 0000

02:06.0 PCI bridge: Intel Corporation: Unknown device b152 (prog-if 00 [Nor=
mal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D64
	I/O behind bridge: 00004000-00004fff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

02:08.0 PCI bridge: Intel Corporation: Unknown device b152 (prog-if 00 [Nor=
mal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=3D02, secondary=3D04, subordinate=3D04, sec-latency=3D64
	I/O behind bridge: 00005000-00005fff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

02:09.0 PCI bridge: Intel Corporation: Unknown device b152 (prog-if 00 [Nor=
mal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=3D02, secondary=3D05, subordinate=3D05, sec-latency=3D64
	I/O behind bridge: 00006000-00006fff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

03:04.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 4000 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

03:05.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 4080 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

03:06.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 4400 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

03:07.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 4480 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

04:04.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 5000 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

04:05.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 5080 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

04:06.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 5400 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

04:07.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 5480 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

05:04.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 6000 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

05:05.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 6080 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

05:06.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 6400 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

05:07.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 6480 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

07:05.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug Co=
ntroller (rev 12)
	Subsystem: Compaq Computer Corporation: Unknown device a2f9
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f7ff0000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=3D0/0 Enable=
-
		Address: 0000000000000000  Data: 0000

07:07.0 PCI bridge: Intel Corporation: Unknown device b152 (prog-if 00 [Nor=
mal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=3D07, secondary=3D08, subordinate=3D08, sec-latency=3D64
	I/O behind bridge: 00007000-00007fff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
		Bridge: PM- B3+

08:04.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 7000 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

08:05.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 7080 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

08:06.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 7400 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-

08:07.0 Ethernet controller: D-Link System Inc: Unknown device 1002 (rev 12=
)
	Subsystem: D-Link System Inc: Unknown device 1012
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 7480 [size=3D128]
	Expansion ROM at <unassigned> [disabled] [size=3D64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-


--=-z/GrnHBmUefLBW1KcRUP
Content-Disposition: attachment; filename=intr
Content-Type: text/plain; name=intr; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

           CPU0      =20
  0:    4482909          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:   11286193          XT-PIC  eth0, eth2, eth9, eth11
  5:     228654          XT-PIC  ida0
  8:          1          XT-PIC  rtc
 11:   10898381          XT-PIC  eth1, eth3, eth8, eth10
 14:          3          XT-PIC  ide0
 15:    4224483          XT-PIC  eth4, eth5, eth6, eth7, eth12, eth13, eth1=
4, eth15, eth16, eth17, eth18, eth19
NMI:          0=20
LOC:    4483084=20
ERR:          0
MIS:          0

--=-z/GrnHBmUefLBW1KcRUP--

--=-+TJ3d4M+ixnT/Q4wAZyo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+NRaEkbV2aYZGvn0RAkgZAJ0WfKxFAveWruFMtkbU6erQn79AQgCfco0K
suQeb+pEzZ9Sru+Pit4VI9w=
=/4Js
-----END PGP SIGNATURE-----

--=-+TJ3d4M+ixnT/Q4wAZyo--

