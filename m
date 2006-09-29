Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWI2R3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWI2R3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWI2R3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:29:41 -0400
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:15238 "EHLO
	hachi.dashjr.org") by vger.kernel.org with ESMTP id S1751130AbWI2R3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:29:40 -0400
From: Luke-Jr <luke@dashjr.org>
Organization: -Jr family
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PCI bridge missing
Date: Fri, 29 Sep 2006 12:28:35 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200609281624.16082.luke@dashjr.org> <1159485255.13029.7.camel@localhost.localdomain>
In-Reply-To: <1159485255.13029.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609291228.38799.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 6:14 pm, Alan Cox wrote:
> lspci -vvxxx would be interesting

gnat:~# lspci -vvxxx
0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
00: 86 80 90 71 06 01 10 22 03 00 00 06 00 40 00 00
10: 08 00 00 f4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 8c 03 00 00 00 00 00 09 03 10 11 11 00 00 00 00
60: 00 00 08 10 18 20 20 20 00 0a 00 a0 0a 00 00 00
70: 20 1f 0a 38 50 05 07 01 00 3c 10 38 00 00 00 00
80: 02 00 0a 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 44 00 00 04 61 00 00 00 05 00 00 00 00 00 00
a0: 02 00 10 00 03 02 00 1f 00 00 00 00 00 00 00 00
b0: 80 20 00 00 30 00 00 00 00 00 62 0f 20 10 00 00
c0: 00 00 00 00 00 00 00 00 18 0c ff ff 7f 00 00 00
d0: 08 08 02 02 02 12 00 00 0c 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 f8 00 60 20 0f 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fc000000-feffffff
        Prefetchable memory behind bridge: f9000000-f9ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 1f 01 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 e0 e0 a0 22
20: 00 fc f0 fe 00 f9 f0 f9 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4d 00 20 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 09 80 80 0b 10 00 00 00 00 f6 80 00 00 00 00 00
70: 00 00 00 00 00 00 0c 0c 00 00 00 00 00 00 00 00
80: 00 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 05 00 00 e1 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 21 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 e3 07 e3 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at dce0 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: e1 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 10

0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 01 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 08 00 00 00 01 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 04 00 00 02 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 51 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

0000:00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 24)
        Subsystem: Dell 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00 [size=128]
        Region 1: Memory at ff000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at fb000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b7 10 55 90 17 01 10 02 24 00 00 02 08 40 00 00
10: 01 dc 00 00 00 00 00 ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 82 00
30: 00 00 00 fb dc 00 00 00 00 00 00 00 0b 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 76
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 5c) (prog-if 00 [VGA])
        Subsystem: Dell Optiplex GX1 Onboard Display Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at ec00 [size=256]
        Region 2: Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at f9000000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
00: 02 10 42 47 87 00 90 02 5c 00 00 03 08 40 00 00
10: 00 00 00 fd 01 ec 00 00 00 f0 ff fc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 82 40
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 01 08 00
40: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 10 00 03 02 00 ff 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

