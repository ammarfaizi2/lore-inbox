Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVBYNcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVBYNcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 08:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVBYNca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 08:32:30 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:27268 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S262698AbVBYNaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 08:30:01 -0500
From: Mws <mws@twisted-brains.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
Date: Fri, 25 Feb 2005 14:30:12 +0100
User-Agent: KMail/1.7.92
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
In-Reply-To: <1109316551.14993.63.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3609595.co6CvsqqoI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502251430.16860.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3609595.co6CvsqqoI
Content-Type: multipart/mixed;
  boundary="Boundary-01=_khyHC215hfklIMQ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_khyHC215hfklIMQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

i also have problems with 2.6.11-rc5 and radeon:

i am using a ATI Radeon X600 PciExpress.

a) now the console framebuffer seems to bee working, thx benjamin :)
b) when bootup seq ist completed and i want to start X (xorg-x11) with ati-=
drivers
    x is freezing - not your problem, but the console is not correctly rest=
ored :/ the only way
    out is to reset the machine :/
    2.6.11-rc3 was running fine in this case

i have attached my lspci -vv & lspci -tv output and following a small seq o=
f the dmesg output
when initializing the radeon fb.

if i can provide/assit  you with testing, i am available to do so, also if =
you need more information
on my system.

i am subscribed to lkml, but i would like to be included into cc seprately,=
 thx.


 radeonfb_pci_register BEGIN
ACPI: PCI interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb (0000:05:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:05:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D400.00 Mhz, System=
=3D300.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3221
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
      Display is GTF capable
hStart =3D 1344, hEnd =3D 1504, hTotal =3D 1728
vStart =3D 1025, vEnd =3D 1028, vTotal =3D 1072
h_total_disp =3D 0x9f00d7	   hsync_strt_wid =3D 0x14054a
v_total_disp =3D 0x3ff042f	   vsync_strt_wid =3D 0x30400
pixclock =3D 6349
freq =3D 15750
freq =3D 15750, PLL min =3D 20000, PLL max =3D 40000
ref_div =3D 12, ref_clk =3D 2700, output_freq =3D 31500
ref_div =3D 12, ref_clk =3D 2700, output_freq =3D 31500
post div =3D 0x1
fb_div =3D 0x8c
ppll_div_3 =3D 0x1008c
Console: switching to colour frame buffer device 160x64
radeonfb (0000:05:00.0): ATI Radeon [b=20
radeonfb_pci_register END


--Boundary-01=_khyHC215hfklIMQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspcivt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspcivt"

-[00]-+-00.0  Intel Corp. 925X/XE Memory Controller Hub
      +-01.0-[05]--+-00.0  ATI Technologies Inc RV370 5B62 [Radeon X600 (PCIE)]
      |            \-00.1  ATI Technologies Inc: Unknown device 5b72
      +-1b.0  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller
      +-1c.0-[04]--
      +-1c.1-[03]----00.0  Marvell Technology Group Ltd. Gigabit Ethernet Controller
      +-1c.2-[02]----00.0  Marvell Technology Group Ltd. Gigabit Ethernet Controller
      +-1d.0  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
      +-1d.1  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
      +-1d.2  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
      +-1d.3  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
      +-1d.7  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
      +-1e.0-[01]--+-00.0  Marvell Technology Group Ltd.: Unknown device 1fa7
      |            +-03.0  Texas Instruments TSB82AA2 IEEE-1394b Link Layer Controller
      |            +-04.0  Integrated Technology Express, Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, embedded seems to be ITE8212)
      |            +-05.0  Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller
      |            \-0a.0  Philips Semiconductors SAA7146
      +-1f.0  Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge
      +-1f.1  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller
      +-1f.2  Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller
      \-1f.3  Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller

--Boundary-01=_khyHC215hfklIMQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspcivv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspcivv"

0000:00:00.0 Host bridge: Intel Corp. 925X/XE Memory Controller Hub (rev 04)
	Subsystem: Intel Corp.: Unknown device 2580
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corp. 925X/XE PCI Express Root Port (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d7f00000-d7ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Expansion ROM at 0000e000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [a0] #10 [0141]

0000:00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d7bf4000 (64-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Expansion ROM at 0000d000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d7e00000-d7efffff
	Expansion ROM at 0000c000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.2 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: d7d00000-d7dfffff
	Expansion ROM at 0000b000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at 7880 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 7c00 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 8000 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 16
	Region 4: I/O ports at 8080 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at d7bff800 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: d7c00000-d7cfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]

0000:00:1f.2 Class 0106: Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 03) (prog-if 01)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 2606
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: I/O ports at 8c00
	Region 1: I/O ports at 8880 [size=4]
	Region 2: I/O ports at 8800 [size=8]
	Region 3: I/O ports at 8480 [size=4]
	Region 4: I/O ports at 8400 [size=16]
	Region 5: Memory at d7bffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 0400 [size=32]

0000:01:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown device 1fa7 (rev 07)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 138f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d7ce0000 (32-bit, non-prefetchable)
	Region 1: Memory at d7cb0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer Controller (rev 01) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at d7cff000 (32-bit, non-prefetchable)
	Region 1: Memory at d7cf8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:01:04.0 Unknown mass storage controller: Integrated Technology Express, Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, embedded seems (rev 13)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a080 [size=d7cc0000]
	Region 1: I/O ports at a000 [size=4]
	Region 2: I/O ports at 9c00 [size=8]
	Region 3: I/O ports at 9880 [size=4]
	Region 4: I/O ports at 9800 [size=16]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8136
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at ac00 [size=d7c00000]
	Region 1: I/O ports at a880 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a480 [size=4]
	Region 4: I/O ports at a400 [size=16]
	Region 5: Memory at d7cff800 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 00080000 [disabled]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:01:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
	Subsystem: Technotrend Systemtechnik GmbH Technotrend/Hauppauge DVB card rev2.1
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (3750ns min, 9500ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d7cffc00 (32-bit, non-prefetchable)

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 15)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet Controller (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at d7dfc000 (64-bit, non-prefetchable) [size=d7dc0000]
	Region 2: I/O ports at b800 [size=256]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] #10 [0011]

0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 15)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet Controller (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at d7efc000 (64-bit, non-prefetchable) [size=d7ec0000]
	Region 2: I/O ports at c800 [size=256]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] #10 [0011]

0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B62 [Radeon X600 (PCIE)] (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 0450
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=d7fc0000]
	Region 1: I/O ports at e000 [size=256]
	Region 2: Memory at d7fe0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #10 [0001]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:05:00.1 Display controller: ATI Technologies Inc: Unknown device 5b72
	Subsystem: PC Partner Limited: Unknown device 0451
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Region 0: Memory at d7ff0000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #10 [0001]


--Boundary-01=_khyHC215hfklIMQ--

--nextPart3609595.co6CvsqqoI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCHyhoPpA+SyJsko8RAujMAKCvKxFBw/X/sKH8kJhBe17VPtx2NwCg5HHP
72NJbRi8edfUB+9wfQ6Y4ro=
=LUue
-----END PGP SIGNATURE-----

--nextPart3609595.co6CvsqqoI--
