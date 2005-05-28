Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVE1Oip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVE1Oip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 10:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVE1Oip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 10:38:45 -0400
Received: from 66-7-185-178.estreet.net ([66.7.185.178]:23168 "EHLO
	mail.betelgeuse.us") by vger.kernel.org with ESMTP id S262731AbVE1Ohw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 10:37:52 -0400
Date: Sat, 28 May 2005 08:37:46 -0600
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel Crash - Machine Exception Interpretation?
Message-ID: <20050528143746.GA3612@morningstar.betelgeuse.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: "John W. M. Stevens" <john@betelgeuse.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Summary: Kernel crashes aprox. every 36 hours.

Description: Machine locks up, or crashes way to often.  The latest crash
	produced log output that hinted at the problem, but I don't know
	how to interpret what I'm seeing.

	The crashes can be quite severe.  The previous one wiped out my /usr
	partition.

Keywords: Machine exception, hang, crash.

Kernel Version: Linux version 2.4.29 (root@morningstar)
	(gcc version 2.95.4 20011002 (Debian prerelease))
	#4 SMP Mon Mar 28 18:29:11 MST 2005

Oops:  None.  Usually, the machine simply hangs and has to be power
	cycled.  The latest crash gave me a few lines in the log:

	May 27 21:42:06 morningstar kernel: CPU 1: Machine Check Exception: 0000000000000004
	May 27 21:42:07 morningstar kernel: Bank 0: e200000000000175
	May 27 21:42:07 morningstar kernel: Bank 2: b60020000000011a at 000000000bf16280May 27 21:42:07 morningstar kernel: Kernel panic: CPU context corrupt

Software:

	Gnu C                  2.95.4
	Gnu make               3.80
	util-linux             2.12
	mount                  2.12
	modutils               2.4.26
	e2fsprogs              1.35
	PPP                    2.4.2
	Linux C Library        2.3.2
	Dynamic linker (ldd)   2.3.2
	Procps                 3.2.1
	Net-tools              1.60
	Console-tools          0.2.3
	Sh-utils               5.2.1

Processor Information:

	processor       : 0
	vendor_id       : AuthenticAMD
	cpu family      : 6
	model           : 6
	model name      : AMD Athlon(tm) MP 2000+
	stepping        : 2
	cpu MHz         : 1666.771
	cache size      : 256 KB
	fdiv_bug        : no
	hlt_bug         : no
	f00f_bug        : no
	coma_bug        : no
	fpu             : yes
	fpu_exception   : yes
	cpuid level     : 1
	wp              : yes
	flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
	bogomips        : 3329.22

	processor       : 1
	vendor_id       : AuthenticAMD
	cpu family      : 6
	model           : 6
	model name      : AMD Athlon(tm) Processor
	stepping        : 2
	cpu MHz         : 1666.771
	cache size      : 256 KB
	fdiv_bug        : no
	hlt_bug         : no
	f00f_bug        : no
	coma_bug        : no
	fpu             : yes
	fpu_exception   : yes
	cpuid level     : 1
	wp              : yes
	flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
	bogomips        : 3329.22

Modules: None (I configured then static linked my own kernel).

Loaded Driver and Hardware Information:

	0000-001f : dma1
	0020-003f : pic1
	0040-005f : timer
	0060-006f : keyboard
	0070-007f : rtc
	0080-008f : dma page reg
	00a0-00bf : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	01f0-01f7 : ide0
	02f8-02ff : serial(set)
	03c0-03df : vga+
	03f6-03f6 : ide0
	03f8-03ff : serial(set)
	0cf8-0cff : PCI conf1
	1010-1013 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
	2000-2fff : PCI Bus #02
	  2000-20ff : Adaptec AHA-2940U2/U2W
	  2400-24ff : PCI device 1317:8201 (Linksys)
	  2800-287f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
		2800-287f : tulip
	  2880-28ff : 3Com Corporation 3c905C-TX/TX-M [Tornado]
		2880-28ff : 02:08.0
	  2c00-2c3f : Ensoniq ES1371 [AudioPCI-97]
		2c00-2c3f : es1371
	f000-f00f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
	  f000-f007 : ide0
	  f008-f00f : ide1

	00000000-0009f7ff : System RAM
	0009f800-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000cc800-000ccfff : Extension ROM
	000cd000-000d27ff : Extension ROM
	000e0000-000effff : Extension ROM
	000f0000-000fffff : System ROM
	00100000-1feeffff : System RAM
	  00100000-002ef24e : Kernel code
	  002ef24f-003bc6e3 : Kernel data
	1fef0000-1fefefff : ACPI Tables
	1feff000-1fefffff : ACPI Non-volatile Storage
	1ff00000-1ff7ffff : System RAM
	1ff80000-1fffffff : reserved
	e8000000-e8ffffff : PCI Bus #01
	  e8000000-e8ffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
	e9000000-e90fffff : PCI Bus #02
	  e9000000-e9000fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
		e9000000-e9000fff : usb-ohci
	  e9001000-e9001fff : Adaptec AHA-2940U2/U2W
		e9001000-e9001fff : aic7xxx
	  e9002000-e900207f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]    e9002000-e900207f : tulip
	  e9002400-e90027ff : PCI device 1317:8201 (Linksys)
	  e9002800-e900287f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
	e9300000-e9300fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
	ec000000-efffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
	f0000000-f7ffffff : PCI Bus #01
	  f0000000-f7ffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
	fec00000-fec03fff : reserved
	fee00000-fee00fff : reserved
	fff80000-ffffffff : reserved

PCI Information:

	0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
			Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
			Latency: 64
			Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
			Region 1: Memory at e9300000 (32-bit, prefetchable) [size=4K]
			Region 2: I/O ports at 1010 [disabled] [size=4]
			Capabilities: [a0] AGP version 2.0
					Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
					Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
	0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
			Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 99
			Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
			I/O behind bridge: 0000f000-00000fff
			Memory behind bridge: e8000000-e8ffffff
			Prefetchable memory behind bridge: f0000000-f7ffffff
			BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

	0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
			Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 0

	0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
			Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
			Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 0
			Region 4: I/O ports at f000 [size=16]

	0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
			Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
			Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

	0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
			Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
			Latency: 64
			Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
			I/O behind bridge: 00002000-00002fff
			Memory behind bridge: e9000000-e90fffff
			Prefetchable memory behind bridge: fff00000-000fffff
			BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

	0000:01:05.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2) (prog-if 00 [VGA])
			Subsystem: VISIONTEK: Unknown device 0023
			Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 248 (1250ns min, 250ns max)
			Interrupt: pin A routed to IRQ 18
			Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
			Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
			Expansion ROM at <unassigned> [disabled] [size=64K]
			Capabilities: [60] Power Management version 2
					Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
					Status: D0 PME-Enable- DSel=0 DScale=0 PME-
			Capabilities: [44] AGP version 2.0
					Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
					Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

	0000:02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
			Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
			Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
			Latency: 64 (20000ns max)
			Interrupt: pin D routed to IRQ 19
			Region 0: Memory at e9000000 (32-bit, non-prefetchable) [size=4K]

	0000:02:04.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
			Subsystem: Adaptec AHA-2940U2W SCSI Controller
			Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 64 (9750ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
			Interrupt: pin A routed to IRQ 16
			BIST result: 00
			Region 0: I/O ports at 2000 [disabled] [size=256]
			Region 1: Memory at e9001000 (64-bit, non-prefetchable) [size=4K]
			Expansion ROM at <unassigned> [disabled] [size=128K]
			Capabilities: [dc] Power Management version 1
					Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
					Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	0000:02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
			Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 64
			Interrupt: pin A routed to IRQ 17
			Region 0: I/O ports at 2800 [size=128]
			Region 1: Memory at e9002000 (32-bit, non-prefetchable) [size=128]
			Expansion ROM at <unassigned> [disabled] [size=256K]

	0000:02:06.0 Network controller: Linksys ADMtek ADM8211 802.11b Wireless Interface (rev 11)
			Subsystem: D-Link System Inc: Unknown device 3503
			Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 64 (16000ns min, 32000ns max), Cache Line Size: 0x10 (64 bytes)        Interrupt: pin A routed to IRQ 18
			Region 0: I/O ports at 2400 [size=256]
			Region 1: Memory at e9002400 (32-bit, non-prefetchable) [size=1K]
			Expansion ROM at <unassigned> [disabled] [size=128K]
			Capabilities: [c0] Power Management version 2
					Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
					Status: D0 PME-Enable- DSel=0 DScale=2 PME-

	0000:02:07.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
			Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
			Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort- >SERR- <PERR-
			Latency: 64 (3000ns min, 32000ns max)
			Interrupt: pin A routed to IRQ 19
			Region 0: I/O ports at 2c00 [size=64]
			Capabilities: [dc] Power Management version 1
					Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
					Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	0000:02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
			Subsystem: Tyan Computer Tiger MPX S2466 (3C920 Integrated Fast Ethernet Controller)
			Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
			Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
			Latency: 80 (2500ns min, 2500ns max), Cache Line Size: 0x10 (64 bytes)
			Interrupt: pin A routed to IRQ 19
			Region 0: I/O ports at 2880 [size=128]
			Region 1: Memory at e9002800 (32-bit, non-prefetchable) [size=128]
			Expansion ROM at <unassigned> [disabled] [size=128K]
			Capabilities: [dc] Power Management version 2
					Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
					Status: D0 PME-Enable- DSel=0 DScale=2 PME-
SCSI Information:

	Attached devices:
	Host: scsi0 Channel: 00 Id: 08 Lun: 00
	  Vendor: SEAGATE  Model: ST336607LW       Rev: 0007
	  Type:   Direct-Access                    ANSI SCSI revision: 03
	Host: scsi0 Channel: 00 Id: 09 Lun: 00
	  Vendor: SEAGATE  Model: ST336607LW       Rev: 0007
	  Type:   Direct-Access                    ANSI SCSI revision: 03
	Host: scsi0 Channel: 00 Id: 10 Lun: 00
	  Vendor: SEAGATE  Model: ST336607LW       Rev: 0007
	  Type:   Direct-Access                    ANSI SCSI revision: 03
	Host: scsi1 Channel: 00 Id: 00 Lun: 00
	  Vendor: SAMSUNG  Model: CD-R/RW SW-252B  Rev: R701
	  Type:   CD-ROM                           ANSI SCSI revision: 02

Memory: The memory in this box is ECC.  Could this exception be tied to
	a memory corruption detected by the ECC hardware?

Thanks,
John S.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCmII6KfVvqCSe6T8RAgefAKCdpai+GHuSEA17YKBSVkylvaM2hACfZj57
vpzvduuew+Cd64bTKchS4iA=
=vQXc
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
