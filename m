Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSHRSEG>; Sun, 18 Aug 2002 14:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSHRSEG>; Sun, 18 Aug 2002 14:04:06 -0400
Received: from smtp01.web.de ([194.45.170.210]:50190 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S315455AbSHRSEE>;
	Sun, 18 Aug 2002 14:04:04 -0400
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre3 boot hang
References: <20020818153145.GA3184@df1tlpc.local.here>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Sun, 18 Aug 2002 20:06:29 +0200
In-Reply-To: <20020818153145.GA3184@df1tlpc.local.here> (kladit@t-online.de's
 message of "Sun, 18 Aug 2002 17:31:45 +0200")
Message-ID: <87vg6811p6.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Klaus!

* Klaus Dittrich writes:
>SMP, P-III, Intel-BX
>booting Linux 2.4.20-pre3 stops after 

>Linux NET4.0 for Linux 2.4 
>Based upon Swansea University Computer Society NET3.039 
>Initializing RT netlink socket 

Same here.
Apart from that, the latest ac series oopses when I try to mount a CD
in a drive driven by ide-scsi emulation. And the IDE performance was
quite a bit worse than 2.4.18. Sorry for not being able to make more
concrete statements, just wanted to mention it.

regards
Markus

Athlon XP1800+, ECS K7VZA, single processor, APIC

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11m
mount                  2.11m
modutils               2.4.16
e2fsprogs              1.25
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr- Stepping- SERR- FastB2B- Status: Cap+ 66Mhz- UDF-
        FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR-
        <PERR- Latency: 32 Region 0: Memory at d0000000 (32-bit,
        non-prefetchable) [size=128M] Capabilities: [c0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr- Stepping- SERR+ FastB2B- Status: Cap- 66Mhz- UDF-
        FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR-
        <PERR- Latency: 64 Bus: primary=00, secondary=01,
        subordinate=01, sec-latency=64 I/O behind bridge:
        0000f000-00000fff Memory behind bridge: cde00000-cfefffff
        Prefetchable memory behind bridge: bdc00000-cdcfffff BridgeCtl:
        Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
        ParErr- Stepping- SERR- FastB2B- Status: Cap- 66Mhz- UDF-
        FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
        <PERR- Latency: 0

00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
(prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
        ParErr- Stepping- SERR+ FastB2B- Status: Cap- 66Mhz- UDF-
        FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
        <PERR- Latency: 64 (20000ns max), cache line size 08 Interrupt:
        pin D routed to IRQ 5 Region 0: Memory at cfffc000 (32-bit,
        non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
(prog-if 10 [OHCI])
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
        ParErr- Stepping- SERR+ FastB2B- Status: Cap- 66Mhz- UDF-
        FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
        <PERR- Latency: 64 (20000ns max), cache line size 08 Interrupt:
        pin A routed to IRQ 10 Region 0: Memory at cfffd000 (32-bit,
        non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0) (prog-if 80 [Master])
        Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE
        Controller (A,B step) Control: I/O+ Mem- BusMaster+ SpecCycle-
        MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap-
        66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
        <MAbort- >SERR- <PERR- Latency: 128 Region 4: I/O ports at ff00
        [size=16]

00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 90)
        Subsystem: Elitegroup Computer Systems: Unknown device 0a14
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
        ParErr- Stepping- SERR+ FastB2B- Status: Cap+ 66Mhz- UDF-
        FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
        <PERR- Latency: 64 (13000ns min, 2750ns max) Interrupt: pin A
        routed to IRQ 12 Region 0: I/O ports at d400 [size=256] Region
        1: Memory at cfffb000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at cffc0000 [disabled] [size=128K] Capabilities:
        [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
                PME(D0+,D1+,D2+,D3hot+,D3cold+) Status: D0 PME-Enable-
                DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly
NCR) 53c875 (rev 26)
        Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown
        device 1000 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+
        VGASnoop- ParErr+ Stepping- SERR+ FastB2B- Status: Cap+ 66Mhz-
        UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort-
        >SERR- <PERR- Latency: 134 (4250ns min, 16000ns max), cache line
        size 08 Interrupt: pin A routed to IRQ 11 Region 0: I/O ports at
        d800 [size=256] Region 1: Memory at cfffff00 (32-bit,
        non-prefetchable) [size=256] Region 2: Memory at cfffe000
        (32-bit, non-prefetchable) [size=4K] Expansion ROM at cffe0000
        [disabled] [size=64K] Capabilities: [40] Power Management
        version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
                PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable-
                DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev07)
        Subsystem: Creative Labs: Unknown device 8061 Control: I/O+ Mem-
        BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
        FastB2B- Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 64 (500ns min,
        5000ns max) Interrupt: pin A routed to IRQ 11 Region 0: I/O
        ports at d000 [size=32] Capabilities: [dc] Power Management
        version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
                PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable-
                DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick Control: I/O+ Mem-
        BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
        FastB2B- Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
        >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency: 64 Region 0:
        I/O ports at dc00 [size=8] Capabilities: [dc] Power Management
        version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
                PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable-
                DSel=0 DScale=0 PME-

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO Control: I/O-
        Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
        SERR+ FastB2B- Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
        DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
        64 (4000ns min, 10000ns max) Interrupt: pin A routed to IRQ 5
        Region 0: Memory at cddfe000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data Capabilities: [4c] Power
        Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
                PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable-
                DSel=0 DScale=0 PME-

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV/GO Control: I/O-
        Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
        SERR+ FastB2B- Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
        DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
        64 (1000ns min, 63750ns max) Interrupt: pin A routed to IRQ 5
        Region 0: Memory at cddff000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data Capabilities: [4c] Power
        Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
                PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable-
                DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS) Control:
        I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
        Stepping- SERR- FastB2B- Status: Cap- 66Mhz- UDF- FastB2B-
        ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5 Region 0: I/O ports at cc00
        [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev b2) (prog-if 00 [VGA])
        Subsystem: ABIT Computer Corp.: Unknown device 6109 Control:
        I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
        Stepping- SERR- FastB2B- Status: Cap+ 66Mhz+ UDF- FastB2B+
        ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max) Interrupt: pin A routed to
        IRQ 11 Region 0: Memory at ce000000 (32-bit, non-prefetchable)
        [size=16M] Region 1: Memory at c0000000 (32-bit, prefetchable)
        [size=128M] Expansion ROM at cfef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
                PME(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable-
                DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

