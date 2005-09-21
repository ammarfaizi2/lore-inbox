Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVIURe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVIURe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVIURe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:34:59 -0400
Received: from pop3.student.malone.edu ([192.42.153.210]:989 "HELO
	webmail.malone.edu") by vger.kernel.org with SMTP id S1751266AbVIURe6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:34:58 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: FW: PCI Express or TG3 issue
Date: Wed, 21 Sep 2005 13:34:58 -0400
Message-ID: <15F23A40330F5742B268A041F003055705D2A3@srv-elijah1.malone.int>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Express or TG3 issue
Thread-Index: AcW+0Iok2v1xVuGqSkauwC7caTcOVQAAbsMK
From: "Campbell, Shawn" <scampbell@malone.edu>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hexdump /proc/bus/pci/02/00.0

0000000 14e4 1677 0146 0010 0011 0200 0008 0000
0000010 0004 d000 0001 8000 0000 0000 0000 0000
0000020 0000 0000 0000 0000 0007 0000 1014 02f7
0000030 0000 0000 0048 0000 0000 0000 0105 0000
0000040 0000 0000 0000 0000 5001 c002 2000 6400
0000050 5803 0010 0000 c010 d005 0086 4500 d6e2
0000060 0201 1302 8b80 0000 00ba 4101 0000 0000
0000070 1292 0000 00c0 0000 0410 0000 0b74 0000
0000080 0011 0000 6180 0020 0000 0000 1082 1c08
0000090 0601 0100 0000 0000 0000 0000 0000 0000
00000a0 0000 0000 0000 0000 0000 0000 0000 0000
*
00000c0 0000 0000 0000 0000 000e 0000 0000 0000
00000d0 0010 0001 0fa0 0028 2100 001a 6411 0003
00000e0 0040 1011 0000 0000 0000 0000 0000 0000
00000f0 0000 0000 0000 0000 0000 0000 0000 0000
0000100 0001 13c1 0000 0010 0000 0000 2011 0006
0000110 0000 0000 0000 0000 00b4 0000 0001 0400
0000120 1f0f 0000 0000 0201 0000 0000 0000 0000
0000130 0000 0000 0000 0000 0000 0000 0002 0001
0000140 0000 0000 0000 0000 0000 0000 0000 0000
0000150 00ff 8000 0000 0000 0000 0000 0000 0000
0000160 0000 0000 0000 0000 0000 0000 0000 0000
*
0001000





lspci -vvbx

pcilib: 02:00.0 64-bit device address ignored.
0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O Controller (rev 04)
	Subsystem: IBM: Unknown device 02f7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [2109]
00: 86 80 80 25 06 01 90 20 04 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL Express Chipset Family Graphics Controller (rev 04) (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0200000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 34e0
	Region 2: Memory at c0000000 (32-bit, prefetchable)
	Region 3: Memory at d0280000 (32-bit, non-prefetchable)
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 82 25 07 00 90 00 04 00 00 03 00 00 00 00
10: 00 00 20 d0 e1 34 00 00 08 00 00 c0 00 00 28 d0
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 d0 00 00 00 00 00 00 00 05 01 00 00

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: d0000000-d00fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40b9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 60 26 07 05 10 00 03 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 20
20: 00 d0 00 d0 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 04 00

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at <ignored>
00: 86 80 58 26 05 00 80 02 03 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 34 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 3460
00: 86 80 59 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 61 34 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 3480
00: 86 80 5a 26 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 34 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 02f7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d04c0000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]
00: 86 80 5c 26 06 01 90 02 03 20 03 0c 00 00 00 00
10: 00 00 4c d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=0a, subordinate=0a, sec-latency=56
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: 0000000030000000-0000000030000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]
00: 86 80 4e 24 07 01 10 00 d3 01 04 06 00 00 81 00
10: 00 00 00 00 00 00 00 00 00 0a 0a 38 40 40 80 22
20: 10 d0 10 d0 01 30 01 30 00 00 00 00 00 00 00 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 04 00

0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 3000
	Region 1: I/O ports at 3400
	Region 2: Memory at d04c0800 (32-bit, non-prefetchable)
	Region 3: Memory at d04c0400 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 6e 26 07 00 90 02 03 00 01 04 00 00 00 00
10: 01 30 00 00 01 34 00 00 00 08 4c d0 00 04 4c d0
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 03 01 00 00

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 40 26 07 01 00 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03) (prog-if 80 [Master])
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 255
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 34d0
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 51 26 05 00 b0 02 03 80 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: d1 34 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 70 00 00 00 00 00 00 00 ff 02 00 00

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: IBM: Unknown device 02f7
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 34a0
00: 86 80 6a 26 01 01 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 34 00 00 00 00 00 00 00 00 00 00 14 10 f7 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 02 00 00

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751 Gigabit Ethernet PCI Express (rev 11)
	Subsystem: IBM: Unknown device 02f7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 8000000100000000 (64-bit, non-prefetchable)
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 13020201d6e24500  Data: 8b80
	Capabilities: [d0] #10 [0001]
00: e4 14 77 16 46 01 10 00 11 00 00 02 08 00 00 00
10: 04 00 00 d0 01 00 00 80 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 14 10 f7 02
30: 00 00 00 00 48 00 00 00 00 00 00 00 05 01 00 00

0000:0a:00.0 Communication controller: Conexant: Unknown device 2702 (rev 01)
	Subsystem: Conexant: Unknown device 2002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0100000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 4400
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f1 14 02 27 07 03 90 02 01 00 80 07 00 20 00 00
10: 00 00 10 d0 01 44 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f1 14 02 20
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 01 00 00

0000:0a:01.0 Ethernet controller: Linksys NC100 Network Everywhere Fast Ethernet 10/100 (rev 11)
	Subsystem: Linksys: Unknown device 0574
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 55 (63750ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 4000
	Region 1: Memory at d0110000 (32-bit, non-prefetchable)
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 13 85 09 17 03 90 02 11 00 00 02 08 37 00 00
10: 01 40 00 00 00 00 11 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 02 02 00 00 17 13 74 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 01 ff ff


-----Original Message-----
From:	Martin Mares [mailto:mj@ucw.cz]
Sent:	Wed 9/21/2005 1:18 PM
To:	thockin@hockin.org
Cc:	Campbell, Shawn; linux-kernel@vger.kernel.org
Subject:	Re: PCI Express or TG3 issue
> >         Region 0: Memory at <ignored> (64-bit, non-prefetchable)
>                     ^^^^^^^^^^^^^^^^^^
> 		    Problem.
> 
> hexdump /proc/bus/pci/02/00.0 and send it here.

Or `lspci -vvbx'.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Beware of bugs in the above code; I have only proved it correct, not tried it." -- D.E.K.



