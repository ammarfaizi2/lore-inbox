Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267192AbSIRQUd>; Wed, 18 Sep 2002 12:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbSIRQUd>; Wed, 18 Sep 2002 12:20:33 -0400
Received: from mout1.freenet.de ([194.97.50.132]:22147 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S267192AbSIRQU3>;
	Wed, 18 Sep 2002 12:20:29 -0400
Date: Wed, 18 Sep 2002 18:25:23 +0200
From: axel@hh59.org
To: linux-kernel@vger.kernel.org
Cc: martin@dalecki.de, akpm@zip.com.au
Subject: 2.5.36: PCI: Unable to reserve I/O region
Message-ID: <20020918162523.GA204@prester.hh59.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, martin@dalecki.de,
	akpm@zip.com.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

just booted 2.5.36-mm1. The following part from dmesg appeared a little
strange or rather wrong to me. The systems runs fine as far as I can see.

ide1 at 0x170-0x177,0x376 on irq 15
ICH: IDE controller at PCI slot 00:1f.1
PCI: Unable to reserve I/O region #5:10@f000 for device 00:1f.1
ICH: not 100% native mode: will probe irqs later
ICH: port 0x01f0 already claimed by ide0
ICH: port 0x0170 already claimed by ide1
ICH: neither IDE port enabled (BIOS)

Are these messages bad?


Best regards,
Axel


Linux prester 2.5.36-mm1 #0 Wed Sep 18 17:38:19 CEST 2002 i686 unknown

Gnu C                  gcc (GCC) 3.2.1 20020915 (prerelease) Copyright (C)
2002
Free Software Foundation, Inc. This is free software; see the source for
copying conditions. There is NO warranty; not even for MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.19
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.8
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         8250 core rtc nls_iso8859-1 nls_cp437 minix

00:00.0 Host bridge: Intel Corp. 82810 GMCH [Graphics Memory Controller Hub]
(rev 03)
        Subsystem: Intel Corp. 82810 GMCH [Graphics Memory Controller Hub]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0

00:01.0 VGA compatible controller: Intel Corp. 82810 CGC [Chipset Graphics
Controller] (rev 03) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at d4000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00
[Normal
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80
[Master])
        Subsystem: Intel Corp. 82801AA IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801AA USB
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d000 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev
02)
        Subsystem: Analog Devices: Unknown device 5348
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at d800 [size=256]
        Region 1: I/O ports at dc00 [size=64]


--2oS5YaxWCcQjTEyO
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.out.bz2"
Content-Transfer-Encoding: base64

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
PuF3JFOFCQigiQQw

--2oS5YaxWCcQjTEyO
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config-2.5.36.bz2"
Content-Transfer-Encoding: base64

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
erV+siIgVIbbZtM1WJlhwB/+LuSKcKEgqqZZZg==

--2oS5YaxWCcQjTEyO--
