Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWFYUmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWFYUmO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFYUmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:42:14 -0400
Received: from web52904.mail.yahoo.com ([206.190.49.14]:4689 "HELO
	web52904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932315AbWFYUmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:42:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nbw2rmN/0ZiFazF0DPr87RynDnBciSGG8Tnn0kwPFJ+fbBO3vpsGc9w+zeDTRYs/r3Id/db44P5kAZuTjjnaoMdqzr2CVsXJxcBe/v8/s25SsGqgSGekaac7KuSJCqO87gNxKHdAkJAl110UPgBEWHi0JS8fOVfC+gJk/ATfExw=  ;
Message-ID: <20060625204212.29646.qmail@web52904.mail.yahoo.com>
Date: Sun, 25 Jun 2006 21:42:12 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Linux-2.6.17: PMTimer results for another PCI chipset
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060623182237.GA19853@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This motherboard / chipset runs the pmtimer_test application correctly as well. (PIII / UP).

Linux version 2.6.17 (chris@twopit) (gcc version 4.1.1) #1 SMP Sun Jun 25 20:29:46 BST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffeb000 (usable)
 BIOS-e820: 000000001ffeb000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131051
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126955 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f7b40
ACPI: RSDT (v001 ASUS   TUSL2-C  0x30303031 MSFT 0x31313031) @ 0x1ffeb000
ACPI: FADT (v001 ASUS   TUSL2-C  0x30303031 MSFT 0x31313031) @ 0x1ffeb100
ACPI: BOOT (v001 ASUS   TUSL2-C  0x30303031 MSFT 0x31313031) @ 0x1ffeb040
ACPI: MADT (v001 ASUS   TUSL2-C  0x30303031 MSFT 0x31313031) @ 0x1ffeb080
ACPI: DSDT (v001   ASUS TUSL2-C  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408

PCI summary:

00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)

Full PCI output:

00:00.0 Class 0600: 8086:1130 (rev 04)
	Subsystem: 1043:8027
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [88] #09 [e104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 Class 0604: 8086:1131 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f8800000-f9cfffff
	Prefetchable memory behind bridge: f9f00000-fbffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 Class 0604: 8086:244e (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 0000b000-0000dfff
	Memory behind bridge: f5800000-f87fffff
	Prefetchable memory behind bridge: f9d00000-f9efffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 Class 0601: 8086:2440 (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 Class 0101: 8086:244b (rev 05) (prog-if 80 [Master])
	Subsystem: 1043:8027
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at a800 [size=16]

00:1f.2 Class 0c03: 8086:2442 (rev 05)
	Subsystem: 1043:8027
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 17
	Region 4: I/O ports at a400 [size=32]

00:1f.3 Class 0c05: 8086:2443 (rev 05)
	Subsystem: 1043:8027
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at e800 [size=16]

00:1f.4 Class 0c03: 8086:2444 (rev 05)
	Subsystem: 1043:8027
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at a000 [size=32]



		
___________________________________________________________ 
Inbox full of spam? Get leading spam protection and 1GB storage with All New Yahoo! Mail. http://uk.docs.yahoo.com/nowyoucan.html
