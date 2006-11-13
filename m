Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754564AbWKMMeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbWKMMeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754579AbWKMMeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:34:36 -0500
Received: from maigret.aip.de ([141.33.160.2]:39032 "HELO mail0.aip.de")
	by vger.kernel.org with SMTP id S1754564AbWKMMed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:34:33 -0500
Message-ID: <4558730B.5070002@aip.de>
Date: Mon, 13 Nov 2006 14:28:43 +0100
From: Harry Enke <henke@aip.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061108 Red Hat/1.0.6-0.1.el4 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI-Bus scanning at boot does not find hidden resource
Content-Type: multipart/mixed;
 boundary="------------030708090902060703060706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030708090902060703060706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


"PCI: Bus #0a (-#0d) is hidden behind transparent bridge #09 (-#09) (try 
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently"

(see Attachments).


It occurs on a samsung x11 laptop, just two weeks old.

Regards,
H. Enke

-- 
******************************************************************
* Harry Enke                            AstroGrid-D              *
* Astrophysikalisches Institut Potsdam  Phone : +49-331-7499-433 *
* An der Sternwarte 16                  FAX   : +49-331-7499-429 *
* D-14482 Potsdam                       Email : henke@aip.de     *
******************************************************************



--------------030708090902060703060706
Content-Type: text/plain;
 name="fornax_pci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fornax_pci.txt"

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d0000000-d1ffffff
	Prefetchable memory behind bridge: 00000000b0000000-00000000bff00000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 4032
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
		Slot: Number 1, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at d2300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c8000000-c9ffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000c1f00000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 2, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 403a
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: ca000000-cbffffff
	Prefetchable memory behind bridge: 00000000c2000000-00000000c3f00000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 3, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 4042
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=05, subordinate=06, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000c4000000-00000000c5f00000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 4, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 404a
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Bus: primary=00, secondary=07, subordinate=08, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: ce000000-cfffffff
	Prefetchable memory behind bridge: 00000000c6000000-00000000c7f00000
	Secondary status: 66Mhz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 5, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee00000  Data: 4052
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 209
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 201
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 193
	Region 4: I/O ports at 1840 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 169
	Region 4: I/O ports at 1860 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at d2304000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=09, subordinate=0d, sec-latency=32
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: d2000000-d20fffff
	Prefetchable memory behind bridge: 0000000088000000-0000000089f00000
	Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 193
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1880 [size=16]

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 201
	Region 4: I/O ports at 18a0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation GeForce Go 7400 (rev a1) (prog-if 00 [VGA])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at b0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at d0000000 (64-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <256ns, L1 <4us
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L0s L1 Enabled RCB 128 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit Ethernet PCI Express (rev 21)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 90
	Region 0: Memory at c8000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable+
		Address: 00000000fee00000  Data: 405a
	Capabilities: [d0] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 4096 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <4us, L1 <64us
		Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [13c] Virtual Channel
	Capabilities: [160] Device Serial Number d8-99-06-fe-ff-77-13-00
	Capabilities: [16c] Power Budgeting

03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network Connection (rev 02)
	Subsystem: Intel Corporation: Unknown device 1001
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size 10
	Interrupt: pin A routed to IRQ 185
	Region 0: Memory at ca000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <64us
		Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number f2-67-13-ff-ff-02-13-00

09:09.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b4)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 217
	Region 0: Memory at d2002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=09, secondary=0a, subordinate=0d, sec-latency=176
	Memory window 0: 88000000-89fff000 (prefetchable)
	Memory window 1: 8a000000-8bfff000
	I/O window 0: 00006000-000060ff
	I/O window 1: 00006400-000064ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

09:09.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 09) (prog-if 10 [OHCI])
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin B routed to IRQ 225
	Region 0: Memory at d2000000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

09:09.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 18)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 177
	Region 0: Memory at d2000800 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

09:09.3 System peripheral: Ricoh Co Ltd: Unknown device 0843
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 177
	Region 0: Memory at d2000c00 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

09:09.4 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host Adapter (rev 09)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 177
	Region 0: Memory at d2001000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

09:09.5 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 04)
	Subsystem: Samsung Electronics Co Ltd: Unknown device c026
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 177
	Region 0: Memory at d2001400 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-


--------------030708090902060703060706
Content-Type: text/plain;
 name="fornax_version.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fornax_version.txt"

Linux version 2.6.18.2_AIP (root@localhost.localdomain) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #2 SMP Sun Nov 5 12:53:12 CET 2006

--------------030708090902060703060706
Content-Type: text/plain;
 name="fornax.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fornax.txt"

+ PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/pbs/bin:/sbin:/usr/local/globus/gtk/sbin:/usr/local/pbs/bin:/sbin:/usr/local/globus/gtk/sbin:/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin:/root/bin
+ echo 'If some fields are empty or look unusual you may have an old version.'
If some fields are empty or look unusual you may have an old version.
+ echo 'Compare to the current minimal requirements in Documentation/Changes.'
Compare to the current minimal requirements in Documentation/Changes.
+ echo ' '
 
+ uname -a
Linux dhcp-dyn-192-202 2.6.18.2_AIP #2 SMP Sun Nov 5 12:53:12 CET 2006 i686 i686 i386 GNU/Linux
+ echo ' '
 
+ gcc --version
+ head -n 1
+ grep -v gcc
+ awk 'NR==1{print "Gnu C                 ", $1}'
+ gcc --version
+ grep gcc
+ awk 'NR==1{print "Gnu C                 ", $3}'
Gnu C                  3.4.6
+ make --version
+ awk -F, '{print $1}'
+ awk '/GNU Make/{print "Gnu make              ",$NF}'
Gnu make               3.80
+ ld -v
+ awk '-F)' '{print $1}'
+ awk '/BFD/{print "binutils              ",$NF} \
/^GNU/{print "binutils              ",$4}'
binutils               2.15.92.0.2
+ echo -n 'util-linux             '
util-linux             + fdformat --version
+ awk '{print $NF}'
+ sed -e 's/^util-linux-//' -e 's/)$//'
2.12a
+ echo -n 'mount                  '
mount                  + mount --version
+ awk '{print $NF}'
+ sed -e 's/^mount-//' -e 's/)$//'
2.12a
+ depmod -V
+ awk 'NR==1 {print "module-init-tools     ",$NF}'
module-init-tools      3.1-pre5
+ tune2fs
+ grep '^tune2fs'
+ sed s/,//
+ awk 'NR==1 {print "e2fsprogs             ", $2}'
e2fsprogs              1.35
+ fsck.jfs -V
+ grep version
+ sed s/,//
+ awk 'NR==1 {print "jfsutils              ", $3}'
+ reiserfsck -V
+ grep '^reiserfsck'
+ awk 'NR==1{print "reiserfsprogs         ", $2}'
+ fsck.reiser4 -V
+ grep '^fsck.reiser4'
+ awk 'NR==1{print "reiser4progs          ", $2}'
+ xfs_db -V
+ grep version
+ awk 'NR==1{print "xfsprogs              ", $3}'
+ cardmgr -V
+ grep version
+ awk 'NR==1{print "pcmcia-cs             ", $3}'
pcmcia-cs              3.2.7
+ quota -V
+ grep version
+ awk 'NR==1{print "quota-tools           ", $NF}'
quota-tools            3.12.
+ pppd --version
+ grep version
+ awk 'NR==1{print "PPP                   ", $3}'
PPP                    2.4.2
+ isdnctrl
+ grep version
+ awk 'NR==1{print "isdn4k-utils          ", $NF}'
isdn4k-utils           3.3
+ showmount --version
+ grep nfs-utils
+ awk 'NR==1{print "nfs-utils             ", $NF}'
nfs-utils              1.0.6
++ ldd /bin/sh
+ sed -e 's/\.so$//'
+ awk '-F[.-]' '{print "Linux C Library        " \
$(NF-2)"."$(NF-1)"."$NF}'
++ awk '/libc/{print $3}'
+ ls -l /lib/tls/libc.so.6
Linux C Library        2.3.4
+ ldd -v
+ ldd --version
+ head -n 1
+ awk 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
Dynamic linker (ldd)   2.3.4
+ ls -l /usr/lib/libg++.so /usr/lib/libstdc++.so
+ awk -F. '{print "Linux C++ Library      " $4"."$5"."$6}'
+ ps --version
+ grep version
+ awk 'NR==1{print "Procps                ", $NF}'
Procps                 3.2.3
+ ifconfig --version
+ grep tools
+ awk 'NR==1{print "Net-tools             ", $NF}'
Net-tools              1.60
+ loadkeys -h
+ awk '(NR==1 && ($3 !~ /option/)) {print "Kbd                   ", $3}'
Kbd                    1.12
+ loadkeys -V
+ awk '(NR==1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3}'
+ expr --v
+ awk 'NR==1{print "Sh-utils              ", $NF}'
Sh-utils               5.2.1
+ udevinfo -V
+ grep version
+ awk '{print "udev                  ", $3}'
udev                   039
+ '[' -e /proc/modules ']'
++ cat /proc/modules
++ sed -e 's/ .*$//'
+ X='nvidia
parport_pc
lp
parport
autofs4
i2c_dev
i2c_core
ipv6
sunrpc
pcmcia
vfat
fat
tsdev
dm_mirror
dm_multipath
dm_mod
video
dock
container
button
battery
asus_acpi
ac
ohci1394
ieee1394
yenta_socket
hci_usb
bluetooth
rsrc_nonstatic
pcmcia_core
uhci_hcd
ehci_hcd
pcspkr
tg3
joydev
ext3
jbd'
+ echo 'Modules Loaded         nvidia' parport_pc lp parport autofs4 i2c_dev i2c_core ipv6 sunrpc pcmcia vfat fat tsdev dm_mirror dm_multipath dm_mod video dock container button battery asus_acpi ac ohci1394 ieee1394 yenta_socket hci_usb bluetooth rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd pcspkr tg3 joydev ext3 jbd
Modules Loaded         nvidia parport_pc lp parport autofs4 i2c_dev i2c_core ipv6 sunrpc pcmcia vfat fat tsdev dm_mirror dm_multipath dm_mod video dock container button battery asus_acpi ac ohci1394 ieee1394 yenta_socket hci_usb bluetooth rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd pcspkr tg3 joydev ext3 jbd

--------------030708090902060703060706
Content-Type: text/plain;
 name="fornax_cpu.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fornax_cpu.txt"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Genuine Intel(R) CPU           T2300  @ 1.66GHz
stepping	: 8
cpu MHz		: 1000.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc pni monitor est tm2 xtpr
bogomips	: 3328.77

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Genuine Intel(R) CPU           T2300  @ 1.66GHz
stepping	: 8
cpu MHz		: 1000.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe constant_tsc pni monitor est tm2 xtpr
bogomips	: 3325.10


--------------030708090902060703060706
Content-Type: text/plain;
 name="fornax_dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fornax_dmesg.txt"

Linux version 2.6.18.2_AIP (root@localhost.localdomain) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-3)) #2 SMP Sun Nov 5 12:53:12 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fe90000 (usable)
 BIOS-e820: 000000007fe90000 - 000000007fe9a000 (ACPI data)
 BIOS-e820: 000000007fe9a000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7620
On node 0 totalpages: 523920
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294544 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7590
ACPI: RSDT (v001 PTLTD  Capell00 0x06040000  LTP 0x00000000) @ 0x7fe92380
ACPI: FADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x7fe99e20
ACPI: MADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x7fe99e94
ACPI: HPET (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x7fe99efc
ACPI: MCFG (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x7fe99f34
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x7fe99f70
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x7fe99fd8
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x7fe923c0
ACPI: DSDT (v001 INTEL  CALISTGA 0x06040000 INTL 0x20050624) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:14 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Detected 1662.608 MHz processor.
Built 1 zonelists.  Total pages: 523920
Kernel command line: ro root=LABEL=/ pci=routeirq # rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c049f000 soft=c049b000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:failed|failed|  ok  |failed|failed|failed|
                 A-B-B-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-B-C-C-A deadlock:failed|failed|  ok  |failed|failed|failed|
             A-B-C-A-B-C deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-B-C-C-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-D-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
         A-B-C-D-B-C-D-A deadlock:failed|failed|  ok  |failed|failed|failed|
                    double unlock:  ok  |  ok  |failed|  ok  |failed|failed|
                  initialize held:failed|failed|failed|failed|failed|failed|
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |failed|
           recursive read-lock #2:             |  ok  |             |failed|
            mixed read-write-lock:             |failed|             |failed|
            mixed write-read-lock:             |failed|             |failed|
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/12:failed|failed|  ok  |
     hard-irqs-on + irq-safe-A/21:failed|failed|  ok  |
     soft-irqs-on + irq-safe-A/21:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/12:failed|failed|  ok  |
       sirq-safe-A => hirqs-on/21:failed|failed|  ok  |
         hard-safe-A + irqs-on/12:failed|failed|  ok  |
         soft-safe-A + irqs-on/12:failed|failed|  ok  |
         hard-safe-A + irqs-on/21:failed|failed|  ok  |
         soft-safe-A + irqs-on/21:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #1/321:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/123:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/132:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/213:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/231:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/312:failed|failed|  ok  |
    hard-safe-A + unsafe-B #2/321:failed|failed|  ok  |
    soft-safe-A + unsafe-B #2/321:failed|failed|  ok  |
      hard-irq lock-inversion/123:failed|failed|  ok  |
      soft-irq lock-inversion/123:failed|failed|  ok  |
      hard-irq lock-inversion/132:failed|failed|  ok  |
      soft-irq lock-inversion/132:failed|failed|  ok  |
      hard-irq lock-inversion/213:failed|failed|  ok  |
      soft-irq lock-inversion/213:failed|failed|  ok  |
      hard-irq lock-inversion/231:failed|failed|  ok  |
      soft-irq lock-inversion/231:failed|failed|  ok  |
      hard-irq lock-inversion/312:failed|failed|  ok  |
      soft-irq lock-inversion/312:failed|failed|  ok  |
      hard-irq lock-inversion/321:failed|failed|  ok  |
      soft-irq lock-inversion/321:failed|failed|  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
--------------------------------------------------------
142 out of 218 testcases failed, as expected. |
----------------------------------------------------
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2068436k/2095680k available (2573k kernel code, 26048k reserved, 845k data, 236k init, 1178176k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Calibrating delay using timer specific routine.. 3328.77 BogoMIPS (lpj=6657545)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfe9fbff 00000000 00000000 00000000 0000c189 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00000000 00000000 00000000 0000c189 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfe9fbff 00000000 00000000 00000940 0000c189 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: Intel Genuine Intel(R) CPU           T2300  @ 1.66GHz stepping 08
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c04a0000 soft=c049c000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3325.10 BogoMIPS (lpj=6650218)
CPU: After generic identify, caps: bfe9fbff 00000000 00000000 00000000 0000c189 00000000 00000000
CPU: After vendor identify, caps: bfe9fbff 00000000 00000000 00000000 0000c189 00000000 00000000
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfe9fbff 00000000 00000000 00000940 0000c189 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Genuine Intel(R) CPU           T2300  @ 1.66GHz stepping 08
Total of 2 processors activated (6653.88 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=55
checking if image is initramfs... it is
Freeing initrd memory: 399k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/27a0] 000600 00
PCI: Calling quirk c021a200 for 0000:00:00.0
PCI: Calling quirk c0219b70 for 0000:00:00.0
PCI: Calling quirk c0302780 for 0000:00:00.0
PCI: Calling quirk c0302970 for 0000:00:00.0
PCI: Calling quirk c0302b40 for 0000:00:00.0
PCI: Found 0000:00:01.0 [8086/27a1] 000604 01
PCI: Calling quirk c021a200 for 0000:00:01.0
PCI: Calling quirk c0219b70 for 0000:00:01.0
PCI: Calling quirk c0302780 for 0000:00:01.0
PCI: Calling quirk c0302970 for 0000:00:01.0
PCI: Calling quirk c0302b40 for 0000:00:01.0
PCI: Found 0000:00:1b.0 [8086/27d8] 000403 00
PCI: Calling quirk c021a200 for 0000:00:1b.0
PCI: Calling quirk c0219b70 for 0000:00:1b.0
PCI: Calling quirk c0302780 for 0000:00:1b.0
PCI: Calling quirk c0302970 for 0000:00:1b.0
PCI: Calling quirk c0302b40 for 0000:00:1b.0
PCI: Found 0000:00:1c.0 [8086/27d0] 000604 01
PCI: Calling quirk c021a200 for 0000:00:1c.0
PCI: Calling quirk c0219b70 for 0000:00:1c.0
PCI: Calling quirk c0302780 for 0000:00:1c.0
PCI: Calling quirk c0302970 for 0000:00:1c.0
PCI: Calling quirk c0302b40 for 0000:00:1c.0
PCI: Found 0000:00:1c.1 [8086/27d2] 000604 01
PCI: Calling quirk c021a200 for 0000:00:1c.1
PCI: Calling quirk c0219b70 for 0000:00:1c.1
PCI: Calling quirk c0302780 for 0000:00:1c.1
PCI: Calling quirk c0302970 for 0000:00:1c.1
PCI: Calling quirk c0302b40 for 0000:00:1c.1
PCI: Found 0000:00:1c.2 [8086/27d4] 000604 01
PCI: Calling quirk c021a200 for 0000:00:1c.2
PCI: Calling quirk c0219b70 for 0000:00:1c.2
PCI: Calling quirk c0302780 for 0000:00:1c.2
PCI: Calling quirk c0302970 for 0000:00:1c.2
PCI: Calling quirk c0302b40 for 0000:00:1c.2
PCI: Found 0000:00:1c.3 [8086/27d6] 000604 01
PCI: Calling quirk c021a200 for 0000:00:1c.3
PCI: Calling quirk c0219b70 for 0000:00:1c.3
PCI: Calling quirk c0302780 for 0000:00:1c.3
PCI: Calling quirk c0302970 for 0000:00:1c.3
PCI: Calling quirk c0302b40 for 0000:00:1c.3
PCI: Found 0000:00:1d.0 [8086/27c8] 000c03 00
PCI: Calling quirk c021a200 for 0000:00:1d.0
PCI: Calling quirk c0219b70 for 0000:00:1d.0
PCI: Calling quirk c0302780 for 0000:00:1d.0
PCI: Calling quirk c0302970 for 0000:00:1d.0
PCI: Calling quirk c0302b40 for 0000:00:1d.0
PCI: Found 0000:00:1d.1 [8086/27c9] 000c03 00
PCI: Calling quirk c021a200 for 0000:00:1d.1
PCI: Calling quirk c0219b70 for 0000:00:1d.1
PCI: Calling quirk c0302780 for 0000:00:1d.1
PCI: Calling quirk c0302970 for 0000:00:1d.1
PCI: Calling quirk c0302b40 for 0000:00:1d.1
PCI: Found 0000:00:1d.2 [8086/27ca] 000c03 00
PCI: Calling quirk c021a200 for 0000:00:1d.2
PCI: Calling quirk c0219b70 for 0000:00:1d.2
PCI: Calling quirk c0302780 for 0000:00:1d.2
PCI: Calling quirk c0302970 for 0000:00:1d.2
PCI: Calling quirk c0302b40 for 0000:00:1d.2
PCI: Found 0000:00:1d.3 [8086/27cb] 000c03 00
PCI: Calling quirk c021a200 for 0000:00:1d.3
PCI: Calling quirk c0219b70 for 0000:00:1d.3
PCI: Calling quirk c0302780 for 0000:00:1d.3
PCI: Calling quirk c0302970 for 0000:00:1d.3
PCI: Calling quirk c0302b40 for 0000:00:1d.3
PCI: Found 0000:00:1d.7 [8086/27cc] 000c03 00
PCI: Calling quirk c021a200 for 0000:00:1d.7
PCI: Calling quirk c0219b70 for 0000:00:1d.7
PCI: Calling quirk c0302780 for 0000:00:1d.7
PCI: Calling quirk c0302970 for 0000:00:1d.7
PCI: Calling quirk c0302b40 for 0000:00:1d.7
PCI: Found 0000:00:1e.0 [8086/2448] 000604 01
PCI: Calling quirk c021a200 for 0000:00:1e.0
PCI: Calling quirk c0219b70 for 0000:00:1e.0
PCI: Calling quirk c0302780 for 0000:00:1e.0
PCI: Calling quirk c0302970 for 0000:00:1e.0
PCI: Calling quirk c0302b40 for 0000:00:1e.0
PCI: Found 0000:00:1f.0 [8086/27b9] 000601 00
PCI: Calling quirk c021a200 for 0000:00:1f.0
PCI: Calling quirk c0219b70 for 0000:00:1f.0
PCI: Calling quirk c0302780 for 0000:00:1f.0
PCI: Calling quirk c0302970 for 0000:00:1f.0
PCI: Calling quirk c0302b40 for 0000:00:1f.0
PCI: Found 0000:00:1f.1 [8086/27df] 000101 00
PCI: Calling quirk c021a200 for 0000:00:1f.1
PCI: Calling quirk c0219b70 for 0000:00:1f.1
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Calling quirk c0302780 for 0000:00:1f.1
PCI: Calling quirk c0302970 for 0000:00:1f.1
PCI: Calling quirk c0302b40 for 0000:00:1f.1
PCI: Found 0000:00:1f.3 [8086/27da] 000c05 00
PCI: Calling quirk c021a200 for 0000:00:1f.3
PCI: Calling quirk c0219b70 for 0000:00:1f.3
PCI: Calling quirk c0302780 for 0000:00:1f.3
PCI: Calling quirk c0302970 for 0000:00:1f.3
PCI: Calling quirk c0302b40 for 0000:00:1f.3
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [10de/01d8] 000300 00
PCI: Calling quirk c0219b70 for 0000:01:00.0
PCI: Calling quirk c0302780 for 0000:01:00.0
PCI: Calling quirk c0302b40 for 0000:01:00.0
Boot video device is 0000:01:00.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 020200, pass 0
PCI: Scanning bus 0000:02
PCI: Found 0000:02:00.0 [14e4/167d] 000200 00
PCI: Calling quirk c0219b70 for 0000:02:00.0
PCI: Calling quirk c0302780 for 0000:02:00.0
PCI: Calling quirk c0302b40 for 0000:02:00.0
PCI: Fixups for bus 0000:02
PCI: Bus scan for 0000:02 returning with max=02
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 040300, pass 0
PCI: Scanning bus 0000:03
PCI: Found 0000:03:00.0 [8086/4222] 000280 00
PCI: Calling quirk c021a200 for 0000:03:00.0
PCI: Calling quirk c0219b70 for 0000:03:00.0
PCI: Calling quirk c0302780 for 0000:03:00.0
PCI: Calling quirk c0302970 for 0000:03:00.0
PCI: Calling quirk c0302b40 for 0000:03:00.0
PCI: Fixups for bus 0000:03
PCI: Bus scan for 0000:03 returning with max=03
PCI: Scanning behind PCI bridge 0000:00:1c.2, config 060500, pass 0
PCI: Scanning bus 0000:05
PCI: Fixups for bus 0000:05
PCI: Bus scan for 0000:05 returning with max=05
PCI: Scanning behind PCI bridge 0000:00:1c.3, config 080700, pass 0
PCI: Scanning bus 0000:07
PCI: Fixups for bus 0000:07
PCI: Bus scan for 0000:07 returning with max=07
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 090900, pass 0
PCI: Scanning bus 0000:09
PCI: Found 0000:09:09.0 [1180/0476] 000607 02
PCI: Calling quirk c0219b70 for 0000:09:09.0
PCI: Calling quirk c0302780 for 0000:09:09.0
PCI: Calling quirk c0302b40 for 0000:09:09.0
PCI: Found 0000:09:09.1 [1180/0552] 000c00 00
PCI: Calling quirk c0219b70 for 0000:09:09.1
PCI: Calling quirk c0302780 for 0000:09:09.1
PCI: Calling quirk c0302b40 for 0000:09:09.1
PCI: Found 0000:09:09.2 [1180/0822] 000805 00
PCI: Calling quirk c0219b70 for 0000:09:09.2
PCI: Calling quirk c0302780 for 0000:09:09.2
PCI: Calling quirk c0302b40 for 0000:09:09.2
PCI: Found 0000:09:09.3 [1180/0843] 000880 00
PCI: Calling quirk c0219b70 for 0000:09:09.3
PCI: Calling quirk c0302780 for 0000:09:09.3
PCI: Calling quirk c0302b40 for 0000:09:09.3
PCI: Found 0000:09:09.4 [1180/0592] 000880 00
PCI: Calling quirk c0219b70 for 0000:09:09.4
PCI: Calling quirk c0302780 for 0000:09:09.4
PCI: Calling quirk c0302b40 for 0000:09:09.4
PCI: Found 0000:09:09.5 [1180/0852] 000880 00
PCI: Calling quirk c0219b70 for 0000:09:09.5
PCI: Calling quirk c0302780 for 0000:09:09.5
PCI: Calling quirk c0302b40 for 0000:09:09.5
PCI: Fixups for bus 0000:09
PCI: Transparent bridge - 0000:00:1e.0
PCI: Scanning behind PCI bridge 0000:09:09.0, config 000000, pass 0
PCI: Scanning behind PCI bridge 0000:09:09.0, config 000000, pass 1
PCI: Bus #0a (-#0d) is hidden behind transparent bridge #09 (-#09) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus scan for 0000:09 returning with max=0d
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 020200, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 040300, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.2, config 060500, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.3, config 080700, pass 1
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 090900, pass 1
PCI: Bus scan for 0000:00 returning with max=0d
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 11) *10
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs *10)
ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5)
ACPI: Embedded Controller [H_EC] (gpe 23) interrupt mode.
ACPI: Power Resource [FN00] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
PnPBIOS: Disabled by ACPI PNP
intel_rng: FWH not detected
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 201
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 209
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 201
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 209
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 201
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:09:09.0[A] -> GSI 20 (level, low) -> IRQ 217
ACPI: PCI Interrupt 0000:09:09.1[B] -> GSI 21 (level, low) -> IRQ 225
ACPI: PCI Interrupt 0000:09:09.2[C] -> GSI 22 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:09:09.3[C] -> GSI 22 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:09:09.4[C] -> GSI 22 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:09:09.5[C] -> GSI 22 (level, low) -> IRQ 177
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.2
PCI: Failed to allocate mem resource #6:20000@c0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d0000000-d1ffffff
  PREFETCH window: b0000000-bfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: c8000000-c9ffffff
  PREFETCH window: c0000000-c1ffffff
PCI: Bridge: 0000:00:1c.1
  IO window: 3000-3fff
  MEM window: ca000000-cbffffff
  PREFETCH window: c2000000-c3ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: disabled.
  PREFETCH window: c4000000-c5ffffff
PCI: Bridge: 0000:00:1c.3
  IO window: 5000-5fff
  MEM window: ce000000-cfffffff
  PREFETCH window: c6000000-c7ffffff
  got res [d2002000:d2002fff] bus [d2002000:d2002fff] flags 200 for BAR 0 of 0000:09:09.0
PCI: moved device 0000:09:09.0 resource 0 (200) to d2002000
PCI: Bus 10, cardbus bridge: 0000:09:09.0
  IO window: 00006000-000060ff
  IO window: 00006400-000064ff
  PREFETCH window: 88000000-89ffffff
  MEM window: 8a000000-8bffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-6fff
  MEM window: d2000000-d20fffff
  PREFETCH window: 88000000-89ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Enabling device 0000:00:1e.0 (0004 -> 0007)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:09:09.0[A] -> GSI 20 (level, low) -> IRQ 217
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
apm: BIOS not found.
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1163420617.896:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Calling quirk c0219a80 for 0000:00:00.0
PCI: Calling quirk c0219e00 for 0000:00:00.0
PCI: Calling quirk c02da530 for 0000:00:00.0
PCI: Calling quirk c0219a80 for 0000:00:01.0
PCI: Calling quirk c0219e00 for 0000:00:01.0
PCI: Calling quirk c02da530 for 0000:00:01.0
PCI: Calling quirk c0219a80 for 0000:00:1b.0
PCI: Calling quirk c0219e00 for 0000:00:1b.0
PCI: Calling quirk c02da530 for 0000:00:1b.0
PCI: Calling quirk c0219a80 for 0000:00:1c.0
PCI: Calling quirk c0219e00 for 0000:00:1c.0
PCI: Calling quirk c02da530 for 0000:00:1c.0
PCI: Calling quirk c0219a80 for 0000:00:1c.1
PCI: Calling quirk c0219e00 for 0000:00:1c.1
PCI: Calling quirk c02da530 for 0000:00:1c.1
PCI: Calling quirk c0219a80 for 0000:00:1c.2
PCI: Calling quirk c0219e00 for 0000:00:1c.2
PCI: Calling quirk c02da530 for 0000:00:1c.2
PCI: Calling quirk c0219a80 for 0000:00:1c.3
PCI: Calling quirk c0219e00 for 0000:00:1c.3
PCI: Calling quirk c02da530 for 0000:00:1c.3
PCI: Calling quirk c0219a80 for 0000:00:1d.0
PCI: Calling quirk c0219e00 for 0000:00:1d.0
PCI: Calling quirk c02da530 for 0000:00:1d.0
PCI: Calling quirk c0219a80 for 0000:00:1d.1
PCI: Calling quirk c0219e00 for 0000:00:1d.1
PCI: Calling quirk c02da530 for 0000:00:1d.1
PCI: Calling quirk c0219a80 for 0000:00:1d.2
PCI: Calling quirk c0219e00 for 0000:00:1d.2
PCI: Calling quirk c02da530 for 0000:00:1d.2
PCI: Calling quirk c0219a80 for 0000:00:1d.3
PCI: Calling quirk c0219e00 for 0000:00:1d.3
PCI: Calling quirk c02da530 for 0000:00:1d.3
PCI: Calling quirk c0219a80 for 0000:00:1d.7
PCI: Calling quirk c0219e00 for 0000:00:1d.7
PCI: Calling quirk c02da530 for 0000:00:1d.7
PCI: Calling quirk c0219a80 for 0000:00:1e.0
PCI: Calling quirk c0219e00 for 0000:00:1e.0
PCI: Calling quirk c02da530 for 0000:00:1e.0
PCI: Calling quirk c0219a80 for 0000:00:1f.0
PCI: Calling quirk c0219e00 for 0000:00:1f.0
PCI: Calling quirk c02da530 for 0000:00:1f.0
PCI: Calling quirk c0219a80 for 0000:00:1f.1
PCI: Calling quirk c0219e00 for 0000:00:1f.1
PCI: Calling quirk c02da530 for 0000:00:1f.1
PCI: Calling quirk c0219a80 for 0000:00:1f.3
PCI: Calling quirk c0219e00 for 0000:00:1f.3
PCI: Calling quirk c02da530 for 0000:00:1f.3
PCI: Calling quirk c0219a80 for 0000:01:00.0
PCI: Calling quirk c02da530 for 0000:01:00.0
PCI: Calling quirk c0219a80 for 0000:02:00.0
PCI: Calling quirk c02da530 for 0000:02:00.0
PCI: Calling quirk c0219a80 for 0000:03:00.0
PCI: Calling quirk c0219e00 for 0000:03:00.0
PCI: Calling quirk c02da530 for 0000:03:00.0
PCI: Calling quirk c0219a80 for 0000:09:09.0
PCI: Calling quirk c02da530 for 0000:09:09.0
PCI: Calling quirk c0219a80 for 0000:09:09.1
PCI: Calling quirk c02da530 for 0000:09:09.1
PCI: Calling quirk c0219a80 for 0000:09:09.2
PCI: Calling quirk c02da530 for 0000:09:09.2
PCI: Calling quirk c0219a80 for 0000:09:09.3
PCI: Calling quirk c02da530 for 0000:09:09.3
PCI: Calling quirk c0219a80 for 0000:09:09.4
PCI: Calling quirk c02da530 for 0000:09:09.4
PCI: Calling quirk c0219a80 for 0000:09:09.5
PCI: Calling quirk c02da530 for 0000:09:09.5
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Transitioning device [FAN0] to D3
ACPI: Transitioning device [FAN0] to D3
ACPI: Fan [FAN0] (off)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Thermal Zone [TZ00] (40 C)
ACPI: Thermal Zone [TZ01] (40 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
ICH7: chipset revision 2
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: SAMSUNG MP0804H, ATA DISK drive
hdb: DV-W28EA, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: Host Protected Area detected.
	current capacity is 141464640 sectors (72429 MB)
	native  capacity is 156368016 sectors (80060 MB)
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0x37
hda: 141464640 sectors (72429 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
hdb: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 1419kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
TCP lp registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 236k freed
Time: tsc clocksource has been installed.
Time: hpet clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04713/0x200000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
floppy0: no floppy controllers found
tg3.c:v3.65 (August 07, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751m) rev 4201 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:13:77:06:99:d8
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
input: PC Speaker as /class/input/input2
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 209, io mem 0xd2304000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 209, io base 0x00001800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 201, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
usb 2-1: new low speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 193, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-1: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/input/input3
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:00:1d.0-1
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 169, io base 0x00001860
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 4-1: new full speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
Bluetooth: Core ver 2.10
hci_usb: Unknown symbol hci_suspend_dev
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_resume_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
hci_usb: Unknown symbol hci_suspend_dev
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_resume_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
hci_usb: Unknown symbol hci_suspend_dev
hci_usb: Unknown symbol hci_free_dev
hci_usb: Unknown symbol hci_resume_dev
hci_usb: Unknown symbol hci_alloc_dev
hci_usb: Unknown symbol hci_unregister_dev
hci_usb: Unknown symbol hci_register_dev
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new driver hci_usb
Yenta: CardBus bridge found at 0000:09:09.0 [144d:c026]
Yenta: ISA IRQ mask 0x0cb8, PCI irq 217
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#09) from #09 to #0d
pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
cs: IO port probe 0x6000-0x6fff: clean.
pcmcia: parent PCI bridge Memory window: 0xd2000000 - 0xd20fffff
pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x89ffffff
ieee1394: Initialized config rom entry `ip1394'
PCI: Enabling device 0000:09:09.1 (0000 -> 0002)
ACPI: PCI Interrupt 0000:09:09.1[B] -> GSI 21 (level, low) -> IRQ 225
PCI: Enabling bus mastering for device 0000:09:09.1
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[225]  MMIO=[d2000000-d20007ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: ACPI Dock Station Driver 
Using specific hotkey driver
i2c_ec: Unknown symbol i2c_del_adapter
i2c_ec: Unknown symbol i2c_add_adapter
ibm_acpi: ec object not found
sbs: Unknown symbol acpi_get_ec_hc
ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFFE [20060707]
ACPI Exception (acpi_video-1544): UNKNOWN_STATUS_CODE, Cant attach device [20060707]
ACPI: Video Device [NVID] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
EXT3 FS on hda8, internal journal
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000f0412008ffc0]
device-mapper: multipath: version 1.0.4 loaded
ts: Compaq touchscreen protocol output
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda12, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2048248k swap on /dev/hda10.  Priority:-1 extents:1 across:2048248k
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0x100-0x4ff: excluding 0x3b0-0x3df 0x4d0-0x4d7
cs: IO port probe 0xa00-0xaff: clean.
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was 100406, writing 100006)
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
i2c /dev entries driver
lp: driver loaded but no devices found
eth0: no IPv6 routers present
nvidia: no version for "struct_module" found: kernel tainted.
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-9629  Wed Nov  1 19:30:07 PST 2006
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-9629  Wed Nov  1 19:30:07 PST 2006

--------------030708090902060703060706
Content-Type: text/plain;
 name="fornax_driver.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fornax_driver.txt"

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
1000-107f : motherboard
  1000-1003 : ACPI PM1a_EVT_BLK
  1004-1005 : ACPI PM1a_CNT_BLK
  1008-100b : ACPI PM_TMR
  1010-1015 : ACPI CPU throttle
  1020-1020 : ACPI PM2_CNT_BLK
  1028-102f : ACPI GPE0_BLK
1180-11bf : motherboard
1640-164f : motherboard
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci_hcd
1860-187f : 0000:00:1d.3
  1860-187f : uhci_hcd
1880-188f : 0000:00:1f.1
  1880-1887 : ide0
18a0-18bf : 0000:00:1f.3
2000-2fff : PCI Bus #02
3000-3fff : PCI Bus #03
4000-4fff : PCI Bus #05
5000-5fff : PCI Bus #07
6000-6fff : PCI Bus #09
  6000-60ff : PCI CardBus #0a
  6400-64ff : PCI CardBus #0a
00000000-0009f3ff : System RAM
  00000000-00000000 : Crash kernel
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000f0000-000fffff : System ROM
00100000-7fe8ffff : System RAM
  00100000-00383555 : Kernel code
  00383556-00456b0b : Kernel data
7fe90000-7fe99fff : ACPI Tables
7fe9a000-7fefffff : ACPI Non-volatile Storage
7ff00000-7fffffff : reserved
88000000-89ffffff : PCI Bus #09
  88000000-89ffffff : PCI CardBus #0a
8a000000-8bffffff : PCI CardBus #0a
b0000000-bfffffff : PCI Bus #01
  b0000000-bfffffff : 0000:01:00.0
c0000000-c1ffffff : PCI Bus #02
c2000000-c3ffffff : PCI Bus #03
c4000000-c5ffffff : PCI Bus #05
c6000000-c7ffffff : PCI Bus #07
c8000000-c9ffffff : PCI Bus #02
  c8000000-c800ffff : 0000:02:00.0
    c8000000-c800ffff : tg3
ca000000-cbffffff : PCI Bus #03
  ca000000-ca000fff : 0000:03:00.0
ce000000-cfffffff : PCI Bus #07
d0000000-d1ffffff : PCI Bus #01
  d0000000-d0ffffff : 0000:01:00.0
  d1000000-d1ffffff : 0000:01:00.0
    d1000000-d1ffffff : nvidia
d2000000-d20fffff : PCI Bus #09
  d2000000-d20007ff : 0000:09:09.1
    d2000000-d20007ff : ohci1394
  d2000800-d20008ff : 0000:09:09.2
  d2000c00-d2000cff : 0000:09:09.3
  d2001000-d20010ff : 0000:09:09.4
  d2001400-d20014ff : 0000:09:09.5
  d2002000-d2002fff : 0000:09:09.0
    d2002000-d2002fff : yenta_socket
d2300000-d2303fff : 0000:00:1b.0
d2304000-d23043ff : 0000:00:1d.7
  d2304000-d23043ff : ehci_hcd
e0000000-efffffff : reserved
fec00000-fec0ffff : reserved
fed00000-fed003ff : reserved
fed14000-fed19fff : reserved
fed1c000-fed8ffff : reserved
fee00000-fee00fff : reserved
ff000000-ffffffff : reserved

--------------030708090902060703060706
Content-Type: text/plain;
 name="fornax_modules.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fornax_modules.txt"

nvidia 4709492 22 - Live 0xf91a1000
parport_pc 41540 0 - Live 0xf8a70000
lp 14152 0 - Live 0xf89d8000
parport 38600 2 parport_pc,lp, Live 0xf89cd000
autofs4 23556 0 - Live 0xf89c6000
i2c_dev 10500 0 - Live 0xf89e5000
i2c_core 22656 2 nvidia,i2c_dev, Live 0xf8a69000
ipv6 269600 14 - Live 0xf8a26000
sunrpc 160316 1 - Live 0xf89fd000
pcmcia 39740 2 - Live 0xf89b6000
vfat 14208 1 - Live 0xf89b1000
fat 55708 1 vfat, Live 0xf89a2000
tsdev 8768 0 - Live 0xf89c2000
dm_mirror 25040 0 - Live 0xf89eb000
dm_multipath 20872 0 - Live 0xf89f6000
dm_mod 62616 2 dm_mirror,dm_multipath, Live 0xf895d000
video 17156 0 - Live 0xf8957000
dock 8856 0 - Live 0xf8953000
container 5376 0 - Live 0xf8975000
button 7568 0 - Live 0xf8972000
battery 10500 0 - Live 0xf8947000
asus_acpi 16152 0 - Live 0xf8942000
ac 6020 0 - Live 0xf8835000
ohci1394 36528 0 - Live 0xf8923000
ieee1394 307288 1 ohci1394, Live 0xf8aa3000
yenta_socket 28428 2 - Live 0xf894b000
hci_usb 19100 0 - Live 0xf88f9000
bluetooth 54372 1 hci_usb, Live 0xf88ea000
rsrc_nonstatic 14464 1 yenta_socket, Live 0xf88e5000
pcmcia_core 43168 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xf8870000
uhci_hcd 26252 0 - Live 0xf8868000
ehci_hcd 35848 0 - Live 0xf882b000
pcspkr 3968 0 - Live 0xf8829000
tg3 110980 0 - Live 0xf884b000
joydev 10816 0 - Live 0xf8825000
ext3 140168 7 - Live 0xf88c1000
jbd 63272 1 ext3, Live 0xf883a000

--------------030708090902060703060706--
