Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311881AbSCZNkD>; Tue, 26 Mar 2002 08:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311959AbSCZNjy>; Tue, 26 Mar 2002 08:39:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311881AbSCZNju>;
	Tue, 26 Mar 2002 08:39:50 -0500
Message-ID: <3CA079D5.1030106@mandrakesoft.com>
Date: Tue, 26 Mar 2002 08:38:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andreas Jaeger <aj@suse.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Problems with Tigon v0.97
In-Reply-To: <E16prIu-00035D-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------010805000204050709040500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010805000204050709040500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

>>I've plugged for testing a 3C996-T in a 32-bit slot on my Athlon system
>>lspci -v gives for the unused card:
>>
>
>What chipset ?
>
Andreas' full lspci attached...





--------------010805000204050709040500
Content-Type: message/rfc822;
 name="mailbox-message://nobody@Local Folders/Inbox#1013942"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mailbox-message://nobody@Local Folders/Inbox#1013942"


>From - Tue Mar 26 07:36:05 2002
X-Mozilla-Status2: 00000000
Return-Path: <aj@suse.de>
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by smtp.mandrakesoft.com (8.12.1/8.12.1) with ESMTP id g2QCZjuk007844
	for <jgarzik@mandrakesoft.com>; Tue, 26 Mar 2002 13:35:46 +0100
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 2F25D1E46B; Tue, 26 Mar 2002 13:35:36 +0100 (MET)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "David S. Miller" <davem@redhat.com>
Subject: Re: Problems with Tigon v0.97
In-Reply-To: <ho1ye7tyqx.fsf@gee.suse.de> <3CA06A44.8080908@mandrakesoft.com>
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 26 Mar 2002 13:35:35 +0100
In-Reply-To: <3CA06A44.8080908@mandrakesoft.com> (Jeff Garzik's message of
 "Tue, 26 Mar 2002 07:32:04 -0500")
Message-ID: <hoadsvmrqg.fsf@gee.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Andreas,
>
> can you e-mail full 'lspci -vvv' run as root?

Hi Jeff,

I've appended it,

Andreas

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 120
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at eebff000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d600 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: eec00000-efcfffff
	Prefetchable memory behind bridge: e2a00000-e6afffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 07) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 06) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at efffd000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs CT4830 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at de00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 12)
	Subsystem: 3Com Corporation 3C996-T 1000BaseTX
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at effe0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] #07 [0002]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 8c5148924ac624e8  Data: 43b0

00:0a.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 36)
	Subsystem: Allied Telesyn International AT-2700TX 10/100 Fast Ethernet
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (6000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at da00 [size=32]
	Region 1: Memory at efffefe0 (32-bit, non-prefetchable) [size=32]
	Expansion ROM at efe00000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	BIST result: 00
	Region 0: I/O ports at dc00 [disabled] [size=256]
	Region 1: Memory at effff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at effc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at efcfc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at efce0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj



--------------010805000204050709040500--

