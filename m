Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbREAChh>; Mon, 30 Apr 2001 22:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135249AbREACh1>; Mon, 30 Apr 2001 22:37:27 -0400
Received: from cc1020302-a.sumt1.nj.home.com ([24.3.184.188]:2564 "EHLO
	shakti.sivalik.com") by vger.kernel.org with ESMTP
	id <S133110AbREAChS>; Mon, 30 Apr 2001 22:37:18 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.4: USB HC TakeOver failed!
In-Reply-To: <871yqbf66x.fsf@shakti.sivalik.com>
From: Narang <narang@home.com>
Date: 30 Apr 2001 22:37:16 -0400
In-Reply-To: <871yqbf66x.fsf@shakti.sivalik.com>
Message-ID: <873dapiylf.fsf@shakti.sivalik.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone has any suggestions on fixing 'USB HC TakeOver failed!'
problem. thanks.

syslog
------

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 01:04.0 to 64
usb-ohci.c: USB OHCI at membase 0xc8914000, IRQ 8
usb-ohci.c: usb-01:04.0, CMD Technology Inc USB0670
>>>> usb-ohci.c: USB HC TakeOver failed!
usb.c: USB bus -1 deregistered
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub

lspci -vv -s 01:04
------------------

01:04.0 USB Controller: CMD Technology Inc USB0670 (rev 06) (prog-if 10 [OHCI])
	Subsystem: CMD Technology Inc USB0670
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 8
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


lspci
--------

00:00.0 Host bridge: VLSI Technology Inc 82C592-FC1 (rev 01)
00:01.0 ISA bridge: VLSI Technology Inc 82C593-FC1 (rev 01)
00:0d.0 IDE interface: CMD Technology Inc PCI0640 (rev 02)
00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:11.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
00:12.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10]
01:04.0 USB Controller: CMD Technology Inc USB0670 (rev 06)
01:05.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020

