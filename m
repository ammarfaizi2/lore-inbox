Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131607AbRAOFHU>; Mon, 15 Jan 2001 00:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132041AbRAOFHA>; Mon, 15 Jan 2001 00:07:00 -0500
Received: from mail1.mia.bellsouth.net ([205.152.144.13]:7809 "EHLO
	mail1.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S131607AbRAOFGv>; Mon, 15 Jan 2001 00:06:51 -0500
Message-ID: <3A623F1A.6335981B@bellsouth.net>
Date: Mon, 15 Jan 2001 00:06:50 +0000
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <20010112204626.A2740@suse.cz> <E14HDqv-0005Fm-00@the-village.bc.nu> <20010114203823.A17160@pcep-jamie.cern.ch> <20010114233907.C2487@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> Is the board still available for some testing?
> 
I have a working PA-2007 but use a small hard disk.  Can I help.
PIRQ redirection, working around broken MP-BIOS.
... PIRQ0 -> IRQ 0
Initializing CPU#0
Detected 239.833 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 478.41 BogoMIPS
Memory: 61920k/65536k available (1197k kernel code, 3228k reserved, 432k data, 244k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 008001bf 008005bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 008005bf 00000000 00000000
CPU: After generic, caps: 008001bf 008005bf 00000000 00000000
CPU: Common caps: 008001bf 008005bf 00000000 00000000
CPU: AMD-K6tm w/ multimedia extensions stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
.............SNIP..............
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586a IDE UDMA33 controller on pci0:7.1
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:pio, hdb:pio
hda: WDC AC2540F, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04 { DriveStatusError }
hda: 1056384 sectors (541 MB) w/64KiB Cache, CHS=524/32/63, DMA

lspci -vv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C595/97 [Apollo VP2/97] (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 set

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 25)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at fff0 [size=16]
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
