Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVAOPzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVAOPzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVAOPzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 10:55:42 -0500
Received: from smtp08.web.de ([217.72.192.226]:10472 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262291AbVAOPzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 10:55:01 -0500
Message-ID: <000f01c4fb1a$86a8d6f0$0c00a8c0@amd64>
From: "Enrico Bartky" <DOSProfi@web.de>
To: "Martin Mares" <mj@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>
References: <003d01c4fa7b$983b21b0$0c00a8c0@amd64> <20050115123554.GA2115@ucw.cz>
Subject: Re: lspci != scanpci !?
Date: Sat, 15 Jan 2005 16:54:41 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000C_01C4FB22.E7F3A220"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4942.400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4942.400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000C_01C4FB22.E7F3A220
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Here are the outputs. Without H1 there is no 7101 device; with H1 there is a
7101 device.

Enrico

----- Original Message -----
From: "Martin Mares" <mj@ucw.cz>
To: "Enrico Bartky" <DOSProfi@web.de>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 15, 2005 1:35 PM
Subject: Re: lspci != scanpci !?


> Hello!
>
> > Now the scanpci command shows the M7101 BUT lspci and /proc/pci,
> > /proc/bus/pci, /sys/bus/pci NOT. What can I do? Is there anything like a
> > "update_pci" command?
>
> What does `lspci -vv -M' and `lspci -vv -M -H1' print?
>
> (Please Cc to me, I usually read LKML in large batches.)
>
> Have a nice fortnight
> --
> Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
> Air conditioned environment -- Do not open Windows.

------=_NextPart_000_000C_01C4FB22.E7F3A220
Content-Type: text/plain;
	name="lspcivvm.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspcivvm.txt"

WARNING: Bus mapping can be reliable only with direct hardware access =
enabled.=0A=
=0A=
00:00.0 Host bridge: ALi Corporation M1541 (rev 04)=0A=
	Subsystem: ALi Corporation ALI M1541 Aladdin V/V+ AGP System Controller=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 64=0A=
	Region 0: Memory at e0000000 (32-bit, non-prefetchable)=0A=
	Capabilities: [b0] AGP version 1.0=0A=
		Status: RQ=3D28 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- =
64bit- FW- AGP3- Rate=3Dx1,x2=0A=
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- =
Rate=3D<none>=0A=
=0A=
00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64=0A=
	I/O behind bridge: 0000c000-0000cfff=0A=
	Memory behind bridge: cde00000-cfefffff=0A=
	Prefetchable memory behind bridge: bdc00000-cdcfffff=0A=
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-=0A=
=0A=
## 00.01:0 is a bridge from 00 to 01-01=0A=
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) =
(prog-if 10 [OHCI])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (20000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 0=0A=
	Region 0: Memory at dffff000 (32-bit, non-prefetchable)=0A=
=0A=
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] =
(rev c3)=0A=
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort+ <MAbort+ >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. =
RTL-8139/8139C/8139C+ (rev 10)=0A=
	Subsystem: D-Link System Inc DRN-32TX=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (8000ns min, 16000ns max)=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: I/O ports at dc00=0A=
	Region 1: Memory at dfffef00 (32-bit, non-prefetchable)=0A=
	Capabilities: [50] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1+,D2+,D3hot+,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269 =
(rev 02) (prog-if 85)=0A=
	Subsystem: Promise Technology, Inc. Ultra133TX2=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (1000ns min, 4500ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: I/O ports at dff0=0A=
	Region 1: I/O ports at dfe4=0A=
	Region 2: I/O ports at dfa8=0A=
	Region 3: I/O ports at dfe0=0A=
	Region 4: I/O ports at df90=0A=
	Region 5: Memory at dfff8000 (32-bit, non-prefetchable)=0A=
	Expansion ROM at dffe0000=0A=
	Capabilities: [60] Power Management version 1=0A=
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 =
MX/MX 400] (rev a1) (prog-if 00 [VGA])=0A=
	Subsystem: ASUSTeK Computer Inc.: Unknown device 4019=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (1250ns min, 250ns max)=0A=
	Interrupt: pin A routed to IRQ 0=0A=
	Region 0: Memory at ce000000 (32-bit, non-prefetchable)=0A=
	Region 1: Memory at c0000000 (32-bit, prefetchable)=0A=
	Capabilities: [60] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [44] AGP version 2.0=0A=
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA- ITACoh- GART64- HTrans- =
64bit- FW+ AGP3- Rate=3Dx1,x2,x4=0A=
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- =
Rate=3D<none>=0A=
=0A=
=0A=
Summary of buses:=0A=
=0A=
00: Primary host bus=0A=
	01.0 Bridge to 01-01=0A=
01: Entered via 00:01.0=0A=

------=_NextPart_000_000C_01C4FB22.E7F3A220
Content-Type: text/plain;
	name="lspcivvmh1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspcivvmh1.txt"

00:00.0 Host bridge: ALi Corporation M1541 (rev 04)=0A=
	Subsystem: ALi Corporation ALI M1541 Aladdin V/V+ AGP System Controller=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 64=0A=
	Region 0: Memory at e0000000 (32-bit, non-prefetchable)=0A=
	Capabilities: [b0] AGP version 1.0=0A=
		Status: RQ=3D28 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTrans- =
64bit- FW- AGP3- Rate=3Dx1,x2=0A=
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- =
Rate=3D<none>=0A=
=0A=
00:01.0 PCI bridge: ALi Corporation M1541 PCI to AGP Controller (rev 04) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64=0A=
	I/O behind bridge: 0000c000-0000cfff=0A=
	Memory behind bridge: cde00000-cfefffff=0A=
	Prefetchable memory behind bridge: bdc00000-cdcfffff=0A=
	BridgeCtl: Parity+ SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-=0A=
=0A=
## 00.01:0 is a bridge from 00 to 01-01=0A=
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) =
(prog-if 10 [OHCI])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (20000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 0=0A=
	Region 0: Memory at dffff000 (32-bit, non-prefetchable)=0A=
=0A=
00:03.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]=0A=
	Subsystem: ALi Corporation M7101 Power Management Controller [PMU]=0A=
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
=0A=
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] =
(rev c3)=0A=
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort+ <MAbort+ >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. =
RTL-8139/8139C/8139C+ (rev 10)=0A=
	Subsystem: D-Link System Inc DRN-32TX=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (8000ns min, 16000ns max)=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: I/O ports at dc00=0A=
	Region 1: Memory at dfffef00 (32-bit, non-prefetchable)=0A=
	Capabilities: [50] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1+,D2+,D3hot+,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20269 =
(rev 02) (prog-if 85)=0A=
	Subsystem: Promise Technology, Inc. Ultra133TX2=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (1000ns min, 4500ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: I/O ports at dff0=0A=
	Region 1: I/O ports at dfe4=0A=
	Region 2: I/O ports at dfa8=0A=
	Region 3: I/O ports at dfe0=0A=
	Region 4: I/O ports at df90=0A=
	Region 5: Memory at dfff8000 (32-bit, non-prefetchable)=0A=
	Expansion ROM at dffe0000=0A=
	Capabilities: [60] Power Management version 1=0A=
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 =
MX/MX 400] (rev a1) (prog-if 00 [VGA])=0A=
	Subsystem: ASUSTeK Computer Inc.: Unknown device 4019=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64 (1250ns min, 250ns max)=0A=
	Interrupt: pin A routed to IRQ 0=0A=
	Region 0: Memory at ce000000 (32-bit, non-prefetchable)=0A=
	Region 1: Memory at c0000000 (32-bit, prefetchable)=0A=
	Capabilities: [60] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [44] AGP version 2.0=0A=
		Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA- ITACoh- GART64- HTrans- =
64bit- FW+ AGP3- Rate=3Dx1,x2,x4=0A=
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- =
Rate=3D<none>=0A=
=0A=
=0A=
Summary of buses:=0A=
=0A=
00: Primary host bus=0A=
	01.0 Bridge to 01-01=0A=
01: Entered via 00:01.0=0A=

------=_NextPart_000_000C_01C4FB22.E7F3A220--

