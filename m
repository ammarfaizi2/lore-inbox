Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUAZT7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUAZT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:59:45 -0500
Received: from 81-178-248-213.dsl.pipex.com ([81.178.248.213]:28421 "EHLO
	gimp.puzlebox") by vger.kernel.org with ESMTP id S265081AbUAZT7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:59:15 -0500
Subject: (Wrong ID) USB Crontroller
From: Robert Reardon <rreardon@dsl.pipex.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-7McP5UWA1JPU0QEf5zto"
Message-Id: <1075147348.7156.12.camel@mordor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 20:02:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7McP5UWA1JPU0QEf5zto
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I've been trying to get USB working with the 2.6 and keep getting 
the attached error messages. The kernel appears (to me at least)
to detect the USB controller correctly on boot, but it still doesn't
want to work. This is my first post to the list, so please be gentle
:-).

The motherboard is a Supermicro 370DDE, currently running
kernel-2.6.2-rc1-mm3. I've tried to attached any relevant information
but I'm happy to provide more if it's needed.

cat /proc/version reports:

Linux version 2.6.2-rc1-mm3 (root@mordor) (gcc version 3.3.2 20031218
(Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #2 SMP Sun Jan 25 21:16:13 GMT
2004

Anyone got any ideas?

Rob.
---
Robert Reardon
<RReardon@dsl.pipex.com>

--=-7McP5UWA1JPU0QEf5zto
Content-Disposition: attachment; filename=kernel-lspci.txt
Content-Type: text/plain; name=kernel-lspci.txt; charset=
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
	Subsystem: Super Micro Computer Inc: Unknown device 1966
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: ec000000-f3ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 129
	Region 0: Memory at fb000000 (32-bit, non-prefetchable) [size=1M]

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4760 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 113
	Region 0: I/O ports at b000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at b400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
	Subsystem: 3Com Corporation: Unknown device 1000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 81
	Region 0: I/O ports at b800 [size=128]
	Region 1: Memory at fb120000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Promise Technology, Inc. Fasttrak100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 129
	Region 0: I/O ports at bc00 [size=8]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at c400 [size=8]
	Region 3: I/O ports at c800 [size=4]
	Region 4: I/O ports at cc00 [size=64]
	Region 5: Memory at fb100000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: Super Micro Computer Inc: Unknown device 1966
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc: Unknown device 1966
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 81
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 81
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 18) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 81
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R100 QD [Radeon 7200] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon AIW
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 129
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at a000 [size=256]
	Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x2
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--=-7McP5UWA1JPU0QEf5zto
Content-Disposition: attachment; filename=kernel-usb.txt
Content-Type: text/plain; name=kernel-usb.txt; charset=
Content-Transfer-Encoding: 7bit

et -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: usb_disable_device nuking non-ep0 URBs
usb 1-2: unregistering interface 1-2:1.0
drivers/usb/core/usb.c: usb_hotplug
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 9 ret -110
usb 1-2: registering 1-2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usb 1-2: bulk timeout on ep4out
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_BULK failed dev 3 ep 0x4 len 8 ret -110
usb 1-2: bulk timeout on ep4out
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_BULK failed dev 3 ep 0x4 len 9 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0out
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
drivers/usb/core/message.c: manual set_interface for dev 3, iface 0, alt 0
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usb 1-2: control timeout on ep0in
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 32 ret -32
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -32
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -32
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -32
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 3 rqt 128 rq 6 len 18 ret -110
hub 1-0:1.0: port 2, status 100, change 3, 12 Mb/s
usb 1-2: USB disconnect, address 3
usb 1-2: usb_disable_device nuking all URBs
usb 1-2: unregistering interface 1-2:1.0
drivers/usb/core/usb.c: usb_hotplug
usb 1-2: unregistering device
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: port 2 enable change, status 100
drivers/usb/host/uhci-hcd.c: d400: suspend_hc
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
hub 1-0:1.0: port 2, status 101, change 1, 12 Mb/s
drivers/usb/host/uhci-hcd.c: d400: wakeup_hc
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:1.0: new USB device on port 2, assigned address 4
usb 1-2: control timeout on ep0in
usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 4 default language ID 0x409
usb 1-2: Product: C-3030ZOOM
usb 1-2: Manufacturer: OLYMPU
drivers/usb/core/usb.c: usb_hotplug
usb 1-2: registering 1-2:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 4 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 4 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 4 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 4 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 4 rqt 128 rq 6 len 18 ret -110
usb 1-2: control timeout on ep0in

--=-7McP5UWA1JPU0QEf5zto
Content-Disposition: attachment; filename=kernel-boot.txt
Content-Type: text/plain; name=kernel-boot.txt; charset=
Content-Transfer-Encoding: 7bit

 Via IRQ fixup for 0000:00:11.3, from 5 to 1
PCI: Via IRQ fixup for 0000:00:11.4, from 5 to 1
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Pro 266 chipset
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Radeon QD R100
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c980C Python-T at 0xb800. Vers LK1.1.19
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
NET: Registered protocol family 24
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IC35L060AVV207-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: AOpen Inc. DVD-ROM DVD-9632 0115, ATAPI CD/DVD-ROM drive
hdd: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdb: max request size: 1024KiB
hdb: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host0/bus0/target1/lun0: p1 p2
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: DMA disabled
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02 
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: ATAPI reset complete
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: irq 81, io base 0000d400
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:11.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.2-rc1-mm3 uhci_hcd
usb usb1: SerialNumber: 0000:00:11.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: irq 81, io base 0000d800
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:11.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.2-rc1-mm3 uhci_hcd
usb usb2: SerialNumber: 0000:00:11.3
drivers/usb/core/usb.c: usb_hotplug
usb usb2: registering 2-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
uhci_hcd 0000:00:11.4: UHCI Host Controller
uhci_hcd 0000:00:11.4: irq 81, io base 0000dc00
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:11.4: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.2-rc1-mm3 uhci_hcd
usb usb3: SerialNumber: 0000:00:11.4
drivers/usb/core/usb.c: usb_hotplug
usb usb3: registering 3-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: ganged power switching
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.1 (Tue Dec 30 10:04:14 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Sound Blaster Live! (rev.8) at 0xb000, irq 113
NET: Registered protocol family 2
hub 2-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 2-0:1.0: port 2, status 100, change 3, 12 Mb/s
hub 1-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 1-0:1.0: port 2, status 100, change 3, 12 Mb/s
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
NET: Registered protocol family 4
hub 3-0:1.0: port 1, status 100, change 3, 12 Mb/s
hub 3-0:1.0: port 2, status 100, change 3, 12 Mb/s
BIOS EDD facility v0.11 2003-Dec-17, 2 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
hub 1-0:1.0: port 1 enable change, status 100
hub 1-0:1.0: port 2 enable change, status 100
hub 2-0:1.0: port 1 enable change, status 100
hub 2-0:1.0: port 2 enable change, status 100
hub 3-0:1.0: port 1 enable change, status 100
hub 3-0:1.0: port 2 enable change, status 100
drivers/usb/host/uhci-hcd.c: d400: suspend_hc
drivers/usb/host/uhci-hcd.c: d800: suspend_hc
drivers/usb/host/uhci-hcd.c: dc00: suspend_hc
EXT3 FS on hdb2, internal journal
Adding 262136k swap on /swapfile.  Priority:-1 extents:767
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.

--=-7McP5UWA1JPU0QEf5zto--

