Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTDYGLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 02:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTDYGLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 02:11:21 -0400
Received: from aktion1.adns.de ([62.116.145.13]:4534 "EHLO aktion1.adns.de")
	by vger.kernel.org with ESMTP id S263036AbTDYGLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 02:11:15 -0400
Message-ID: <3EA8D45A.3070205@web.de>
Date: Fri, 25 Apr 2003 08:23:22 +0200
From: Sven Krohlas <darkshadow@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4b) Gecko/20030423
X-Accept-Language: de, de-at, de-de, de-li, de-lu, de-ch, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1 freezes
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060601050503050207030706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601050503050207030706
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

after some time rc1 always freezes on my system.
I tried it three times:

1. I was running lopster under X. When I came home from work
my screen told me "no input signal".

2. I ripped a cd using cdparanoia and oggenc under X.
After some time (1/2 hour maybe) the system freezed.

3. Same disc on a tty -> The next morning I had a black screen.
(this time with apm and acpi disabled).

My /var/log/boot.msg is attached, if you need further
information just ask (I don't want to flood the list with
my .config. if you don't need it).

BTW: I could find nothing interesting in /var/log/messages and
/var/log/warn
-- 
BOFH excuse of the day:
Quantum dynamics are affecting the transistors

--------------060601050503050207030706
Content-Type: text/plain;
 name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.msg"

Cannot find map file.
Loaded 124 symbols from 10 modules.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.21-rc1 (root@linux) (gcc version 3.2) #4 Thu Apr 24 06:45:57 CEST 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
<4> BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000007ffc000 (usable)
<4> BIOS-e820: 0000000007ffc000 - 0000000007fff000 (ACPI data)
<4> BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>0MB HIGHMEM available.
<5>127MB LOWMEM available.
<4>On node 0 totalpages: 32764
<4>zone(0): 4096 pages.
<4>zone(1): 28668 pages.
<4>zone(2): 0 pages.
<4>Kernel command line: auto BOOT_IMAGE=2_4_21-rc1 ro hdh=ide-scsi
<6>ide_setup: hdh=ide-scsi
<4>No local APIC present or hardware disabled
<6>Initializing CPU#0
<4>Detected 501.132 MHz processor.
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 999.42 BogoMIPS
<6>Memory: 126304k/131056k available (1482k kernel code, 4360k reserved, 535k data, 128k init, 0k highmem)
<6>Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
<6>Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
<6>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
<4>Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
<4>Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
<6>CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
<6>CPU: L2 Cache: 128K (32 bytes/line)
<7>CPU:     After generic, caps: 008021bf c08029bf 00000000 00000002
<7>CPU:             Common caps: 008021bf c08029bf 00000000 00000002
<4>CPU: AMD-K6(tm)-III Processor stepping 04
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: AMD K6
<6>PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
<6>PCI: Using configuration type 1
<6>PCI: Probing PCI hardware
<6>PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
<4>Starting kswapd
<5>VFS: Diskquotas version dquot_6.4.0 initialized
<6>Journalled Block Device driver loaded
<5>ACPI: APM is already active, exiting
<6>vesafb: framebuffer at 0xe7000000, mapped to 0xc880d000, size 16128k
<6>vesafb: mode is 1024x768x16, linelength=2048, pages=8
<6>vesafb: protected mode interface info at c000:0444
<6>vesafb: scrolling: redraw
<6>vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
<4>Console: switching to colour frame buffer device 128x48
<6>fb0: VESA VGA frame buffer device
<6>Detected PS/2 Mouse Port.
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<6>Real Time Clock Driver v1.10e
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<4>RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
<6>loop: loaded (max 8 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>PDC20269: IDE controller at PCI slot 00:0c.0
<6>PCI: Found IRQ 11 for device 00:0c.0
<6>PDC20269: chipset revision 2
<6>PDC20269: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:pio, hdb:pio
<6>    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:pio, hdd:pio
<6>ALI15X3: IDE controller at PCI slot 00:0f.0
<6>ALI15X3: chipset revision 193
<6>ALI15X3: not 100%% native mode: will probe irqs later
<6>    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:DMA, hdf:DMA
<6>    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:DMA, hdh:pio
<4>hda: IC35L120AVV207-0, ATA DISK drive
<4>blk: queue c0349f60, I/O limit 4095Mb (mask 0xffffffff)
<4>hdc: IC35L120AVV207-0, ATA DISK drive
<4>blk: queue c034a3b0, I/O limit 4095Mb (mask 0xffffffff)
<4>hde: Maxtor 4G120J6, ATA DISK drive
<4>hdf: IBM-DJNA-352030, ATA DISK drive
<4>blk: queue c034a800, I/O limit 4095Mb (mask 0xffffffff)
<4>blk: queue c034a93c, I/O limit 4095Mb (mask 0xffffffff)
<4>hdg: IC35L120AVV207-0, ATA DISK drive
<4>hdh: R/RW 8x4x32, ATAPI CD/DVD-ROM drive
<4>blk: queue c034ac50, I/O limit 4095Mb (mask 0xffffffff)
<4>ide0 at 0xb800-0xb807,0xb402 on irq 11
<4>ide1 at 0xb000-0xb007,0xa802 on irq 11
<4>ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide3 at 0x170-0x177,0x376 on irq 15
<4>hda: attached ide-disk driver.
<4>hda: host protected area => 1
<6>hda: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=15017/255/63, UDMA(100)
<4>hdc: attached ide-disk driver.
<4>hdc: host protected area => 1
<6>hdc: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=15017/255/63, UDMA(100)
<4>hde: attached ide-disk driver.
<4>hde: host protected area => 1
<6>hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(33)
<4>hdf: attached ide-disk driver.
<4>hdf: host protected area => 1
<6>hdf: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=2482/255/63, UDMA(33)
<4>hdg: attached ide-disk driver.
<4>hdg: host protected area => 1
<6>hdg: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=15017/255/63, UDMA(33)
<6>ide-floppy driver 0.99.newide
<6>Partition check:
<6> hda: hda1
<6> hdc: hdc1
<6> hde: hde1 hde2 hde3 hde4
<6> hdf: hdf1
<6> hdg: hdg1
<6>ide-floppy driver 0.99.newide
<6>SCSI subsystem driver Revision: 1.00
<3>kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
<6>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: Autodetecting RAID arrays.
<6> [events: 00000057]
<6> [events: 00000057]
<6> [events: 00000057]
<6>md: autorun ...
<6>md: considering hdg1 ...
<6>md:  adding hdg1 ...
<6>md:  adding hdc1 ...
<6>md:  adding hda1 ...
<6>md: created md0
<6>md: bind<hda1,1>
<6>md: bind<hdc1,2>
<6>md: bind<hdg1,3>
<6>md: running: <hdg1><hdc1><hda1>
<6>md: hdg1's event counter: 00000057
<6>md: hdc1's event counter: 00000057
<6>md: hda1's event counter: 00000057
<3>md: md0: raid array is not clean -- starting background reconstruction
<3>kmod: failed to exec /sbin/modprobe -s -k md-personality-4, errno = 2
<3>md: personality 4 is not loaded!
<4>md :do_md_run() returned -22
<6>md: md0 stopped.
<6>md: unbind<hdg1,2>
<6>md: export_rdev(hdg1)
<6>md: unbind<hdc1,1>
<6>md: export_rdev(hdc1)
<6>md: unbind<hda1,0>
<6>md: export_rdev(hda1)
<6>md: ... autorun DONE.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<6>IP: routing cache hash table of 512 buckets, 4Kbytes
<6>TCP: Hash tables configured (established 8192 bind 16384)
<6>Linux IP multicast router 0.06 plus PIM-SM
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<5>RAMDISK: Compressed image found at block 0
<6>Freeing initrd memory: 375k freed
<4>VFS: Mounted root (ext2 filesystem).
<6>PCI: Found IRQ 9 for device 00:09.0
<6>ncr53c8xx: at PCI bus 0, device 9, function 0
<6>ncr53c8xx: 53c875 detected with Symbios NVRAM
<6>ncr53c875-0: rev 0x26 on pci bus 0 device 9 function 0 irq 9
<6>ncr53c875-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
<6>ncr53c875-0: on-chip RAM at 0xdd800000
<6>ncr53c875-0: restart (scsi reset).
<4>ncr53c875-0: Downloading SCSI SCRIPTS.
<6>scsi0 : ncr53c8xx-3.4.3b-20010512
<6>raid5: measuring checksumming speed
<4>   8regs     :   768.800 MB/sec
<4>   32regs    :   501.600 MB/sec
<4>   pII_mmx   :  1074.000 MB/sec
<4>   p5_mmx    :  1077.200 MB/sec
<4>raid5: using function: p5_mmx (1077.200 MB/sec)
<6>md: raid5 personality registered as nr 4
<4>hdh: attached ide-scsi driver.
<6>scsi1 : SCSI host adapter emulation for IDE ATAPI devices
<4>  Vendor: IDE-CD    Model: R/RW 8x4x32       Rev:  1.5
<4>  Type:   CD-ROM                             ANSI SCSI revision: 02
<6>md: Autodetecting RAID arrays.
<6> [events: 00000057]
<6> [events: 00000057]
<6> [events: 00000057]
<6>md: autorun ...
<6>md: considering hda1 ...
<6>md:  adding hda1 ...
<6>md:  adding hdc1 ...
<6>md:  adding hdg1 ...
<6>md: created md0
<6>md: bind<hdg1,1>
<6>md: bind<hdc1,2>
<6>md: bind<hda1,3>
<6>md: running: <hda1><hdc1><hdg1>
<6>md: hda1's event counter: 00000057
<6>md: hdc1's event counter: 00000057
<6>md: hdg1's event counter: 00000057
<3>md: md0: raid array is not clean -- starting background reconstruction
<6>md0: max total readahead window set to 1024k
<6>md0: 2 data-disks, max readahead per data-disk: 512k
<6>raid5: device hda1 operational as raid disk 0
<6>raid5: device hdc1 operational as raid disk 2
<6>raid5: device hdg1 operational as raid disk 1
<6>raid5: allocated 3284kB for md0
<4>raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
<4>raid5: raid set md0 not clean; reconstructing parity
<4>RAID5 conf printout:
<4> --- rd:3 wd:3 fd:0
<4> disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda1
<4> disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
<4> disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdc1
<4>RAID5 conf printout:
<4> --- rd:3 wd:3 fd:0
<4> disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda1
<4> disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
<4> disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdc1
<6>md: updating md0 RAID superblock on device
<6>md: hda1 [events: 00000058]<6>(write) hda1's sb offset: 120615872
<6>md: syncing RAID array md0
<6>md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
<6>md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
<6>md: using 124k window, over a total of 120615808 blocks.
<6>md: hdc1 [events: 00000058]<6>(write) hdc1's sb offset: 120615872
<6>md: hdg1 [events: 00000058]<6>(write) hdg1's sb offset: 120615872
<6>md: ... autorun DONE.
<4>raid5: switching cache buffer size, 4096 --> 1024
<4>raid5: switching cache buffer size, 1024 --> 4096
<4>raid5: switching cache buffer size, 4096 --> 1024
<4>raid5: switching cache buffer size, 1024 --> 4096
<4>VFS: Mounted root (ext2 filesystem) readonly.
<5>Trying to move old root to /initrd ... failed
<5>Unmounting old root
<5>Trying to free ramdisk memory ... okay
<6>Freeing unused kernel memory: 128k freed
<4>blk: queue c034a800, I/O limit 4095Mb (mask 0xffffffff)
<4>blk: queue c034a93c, I/O limit 4095Mb (mask 0xffffffff)
<4>blk: queue c034ac50, I/O limit 4095Mb (mask 0xffffffff)
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<6>LVM version 1.0.5+(22/07/2002) module loaded
<6>Adding Swap: 530136k swap-space (priority 42)
<6>kjournald starting.  Commit interval 5 seconds
<6>EXT3 FS 2.4-0.9.19, 19 August 2002 on ide2(33,1), internal journal
<6>EXT3-fs: mounted filesystem with ordered data mode.
<4>reiserfs: checking transaction log (device 21:03) ...
<4>Using r5 hash to sort names
<4>ReiserFS version 3.6.25
<4>MSDOS FS: IO charset iso8859-15
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--------------060601050503050207030706--

