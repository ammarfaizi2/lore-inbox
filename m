Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262166AbSIZDae>; Wed, 25 Sep 2002 23:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262164AbSIZDad>; Wed, 25 Sep 2002 23:30:33 -0400
Received: from adsl-67-36-120-9.dsl.klmzmi.ameritech.net ([67.36.120.9]:25255
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id <S262162AbSIZDaU>; Wed, 25 Sep 2002 23:30:20 -0400
From: Tabris <root@tabris.net>
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: [Repost x2] Unknown APIC on 2.4.19-ac4+preempt
Date: Wed, 25 Sep 2002 23:35:32 -0400
User-Agent: KMail/1.4.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_8N01EC1JGLT23P42R6BL"
Message-Id: <200209252335.32612.root@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_8N01EC1JGLT23P42R6BL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok. I've posted this problem at least once with this kernel.

This is an Abit KX7-333 with an AMD Athlon 6:6:2 XP1800

This time I'm including a more complete syslog excerpt. If you need more =
info,=20
please, please, let me know and I'll do what I can to help.

TIA
--
tabris
--------------Boundary-00=_8N01EC1JGLT23P42R6BL
Content-Type: text/plain;
  charset="us-ascii";
  name="syslog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="syslog.txt"

Sep 20 11:10:05 tabriel syslogd 1.4.1: restart.
Sep 20 11:10:05 tabriel kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep 20 11:10:05 tabriel kernel: Inspecting /boot/System.map
Sep 20 11:10:05 tabriel kernel: Symbol table has incorrect version number. 
Sep 20 11:10:05 tabriel kernel: Cannot find map file.
Sep 20 11:10:05 tabriel kernel: Loaded 290 symbols from 11 modules.
Sep 20 11:10:05 tabriel kernel: Linux version 2.4.19 (tabris@tabriel.tabris.net) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #2 Wed Aug 28 13:52:55 EDT 2002
Sep 20 11:10:05 tabriel kernel: BIOS-provided physical RAM map:
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Sep 20 11:10:05 tabriel kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Sep 20 11:10:06 tabriel kernel: 255MB LOWMEM available.
Sep 20 11:10:06 tabriel kernel: found SMP MP-table at 000f55b0
Sep 20 11:10:06 tabriel kernel: hm, page 000f5000 reserved twice.
Sep 20 11:10:06 tabriel kernel: hm, page 000f6000 reserved twice.
Sep 20 11:10:06 tabriel kernel: hm, page 000f1000 reserved twice.
Sep 20 11:10:06 tabriel kernel: hm, page 000f2000 reserved twice.
Sep 20 11:10:06 tabriel kernel: Advanced speculative caching feature present
Sep 20 11:10:06 tabriel kernel: On node 0 totalpages: 65520
Sep 20 11:10:06 tabriel kernel: zone(0): 4096 pages.
Sep 20 11:10:06 tabriel kernel: zone(1): 61424 pages.
Sep 20 11:10:06 tabriel kernel: zone(2): 0 pages.
Sep 20 11:10:06 tabriel kernel: Intel MultiProcessor Specification v1.1
Sep 20 11:10:06 tabriel kernel:     Virtual Wire compatibility mode.
Sep 20 11:10:06 tabriel kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Sep 20 11:10:06 tabriel kernel: Processor #0 Pentium(tm) Pro APIC version 17
Sep 20 11:10:06 tabriel kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Sep 20 11:10:06 tabriel kernel: Processors: 1
Sep 20 11:10:06 tabriel kernel: Kernel command line: root=/dev/hda3 vga=8 noacpi
Sep 20 11:10:06 tabriel kernel: Initializing CPU#0
Sep 20 11:10:06 tabriel kernel: Detected 1534.019 MHz processor.
Sep 20 11:10:06 tabriel kernel: Console: colour VGA+ 132x43
Sep 20 11:10:06 tabriel kernel: Calibrating delay loop... 3060.53 BogoMIPS
Sep 20 11:10:06 tabriel kernel: Memory: 256568k/262080k available (1263k kernel code, 5124k reserved, 448k data, 88k init, 0k highmem)
Sep 20 11:10:06 tabriel kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Sep 20 11:10:06 tabriel kernel: Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Sep 20 11:10:06 tabriel kernel: Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Sep 20 11:10:06 tabriel kernel: Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Sep 20 11:10:06 tabriel kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Sep 20 11:10:06 tabriel kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sep 20 11:10:06 tabriel kernel: Advanced speculative caching feature present
Sep 20 11:10:06 tabriel kernel: Disabling advanced speculative caching
Sep 20 11:10:06 tabriel kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Sep 20 11:10:06 tabriel kernel: CPU: L2 Cache: 256K (64 bytes/line)
Sep 20 11:10:06 tabriel kernel: Intel machine check architecture supported.
Sep 20 11:10:06 tabriel kernel: Intel machine check reporting enabled on CPU#0.
Sep 20 11:10:06 tabriel kernel: CPU: AMD Athlon(tm) XP 1800+ stepping 02
Sep 20 11:10:06 tabriel kernel: Enabling fast FPU save and restore... done.
Sep 20 11:10:06 tabriel kernel: Enabling unmasked SIMD FPU exception support... done.
Sep 20 11:10:06 tabriel kernel: Checking 'hlt' instruction... OK.
Sep 20 11:10:06 tabriel kernel: POSIX conformance testing by UNIFIX
Sep 20 11:10:06 tabriel kernel: enabled ExtINT on CPU#0
Sep 20 11:10:06 tabriel kernel: ESR value before enabling vector: 00000000
Sep 20 11:10:06 tabriel kernel: ESR value after enabling vector: 00000000
Sep 20 11:10:06 tabriel kernel: ENABLING IO-APIC IRQs
Sep 20 11:10:06 tabriel kernel: Setting 2 in the phys_id_present_map
Sep 20 11:10:06 tabriel kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Sep 20 11:10:06 tabriel kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Sep 20 11:10:06 tabriel kernel: testing the IO APIC.......................
Sep 20 11:10:06 tabriel kernel: 
Sep 20 11:10:06 tabriel kernel:  WARNING: unexpected IO-APIC, please mail
Sep 20 11:10:06 tabriel kernel:           to linux-smp@vger.kernel.org
Sep 20 11:10:06 tabriel kernel: .................................... done.
Sep 20 11:10:06 tabriel kernel: Using local APIC timer interrupts.
Sep 20 11:10:06 tabriel kernel: calibrating APIC timer ...
Sep 20 11:10:06 tabriel kernel: ..... CPU clock speed is 1533.9693 MHz.
Sep 20 11:10:06 tabriel kernel: ..... host bus clock speed is 266.7771 MHz.
Sep 20 11:10:06 tabriel kernel: cpu: 0, clocks: 2667771, slice: 1333885
Sep 20 11:10:06 tabriel kernel: CPU0<T0:2667760,T1:1333872,D:3,S:1333885,C:2667771>
Sep 20 11:10:06 tabriel kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=1
Sep 20 11:10:06 tabriel kernel: PCI: Using configuration type 1
Sep 20 11:10:06 tabriel kernel: PCI: Probing PCI hardware
Sep 20 11:10:06 tabriel kernel: Unknown bridge resource 0: assuming transparent
Sep 20 11:10:06 tabriel kernel: PCI: Using IRQ router default [1106/3099] at 00:00.0
Sep 20 11:10:06 tabriel kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 18
Sep 20 11:10:06 tabriel kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 17
Sep 20 11:10:06 tabriel kernel: PCI->APIC IRQ transform: (B0,I17,P0) -> 11
Sep 20 11:10:06 tabriel kernel: PCI->APIC IRQ transform: (B0,I17,P3) -> 21
Sep 20 11:10:06 tabriel kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Sep 20 11:10:06 tabriel kernel: PCI: Via IRQ fixup for 00:11.2, from 11 to 5
Sep 20 11:10:06 tabriel kernel: Linux NET4.0 for Linux 2.4
Sep 20 11:10:06 tabriel kernel: Based upon Swansea University Computer Society NET3.039
Sep 20 11:10:06 tabriel kernel: Initializing RT netlink socket
Sep 20 11:10:06 tabriel kernel: Starting kswapd
Sep 20 11:10:06 tabriel kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Sep 20 11:10:06 tabriel kernel: devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
Sep 20 11:10:06 tabriel kernel: devfs: boot_options: 0x1
Sep 20 11:10:06 tabriel kernel: ACPI: Core Subsystem version [20011018]
Sep 20 11:10:06 tabriel kernel: ACPI: Subsystem enabled
Sep 20 11:10:06 tabriel kernel: pty: 256 Unix98 ptys configured
Sep 20 11:10:06 tabriel kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Sep 20 11:10:06 tabriel kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Sep 20 11:10:06 tabriel kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Sep 20 11:10:06 tabriel kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 20 11:10:06 tabriel kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Sep 20 11:10:06 tabriel kernel: VP_IDE: chipset revision 6
Sep 20 11:10:06 tabriel kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep 20 11:10:06 tabriel kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep 20 11:10:06 tabriel kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
Sep 20 11:10:06 tabriel kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
Sep 20 11:10:06 tabriel kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
Sep 20 11:10:06 tabriel kernel: hdb: C/H/S=17486/16/255 from BIOS ignored
Sep 20 11:10:06 tabriel kernel: hda: WDC AC28400R, ATA DISK drive
Sep 20 11:10:06 tabriel kernel: hdb: Maxtor 93652U8, ATA DISK drive
Sep 20 11:10:06 tabriel kernel: hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI CD/DVD-ROM drive
Sep 20 11:10:06 tabriel kernel: hdd: WDC WD200BB-32BSA0, ATA DISK drive
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 00(02)
Sep 20 11:10:06 tabriel kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 20 11:10:06 tabriel kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 20 11:10:06 tabriel kernel: hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63, (U)DMA
Sep 20 11:10:06 tabriel kernel: hdb: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63, UDMA(66)
Sep 20 11:10:06 tabriel kernel: hdd: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
Sep 20 11:10:06 tabriel kernel: Partition check:
Sep 20 11:10:06 tabriel kernel:  /dev/ide/host0/bus0/target0/lun0:<3>APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel:  p1 p2 p3
Sep 20 11:10:06 tabriel kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 > p3
Sep 20 11:10:06 tabriel kernel:  /dev/ide/host0/bus1/target1/lun0: [PTBL] [2434/255/63] p1
Sep 20 11:10:06 tabriel kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep 20 11:10:06 tabriel kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Sep 20 11:10:06 tabriel kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Sep 20 11:10:06 tabriel kernel: TCP: Hash tables configured (established 16384 bind 32768)
Sep 20 11:10:06 tabriel kernel: Linux IP multicast router 0.06 plus PIM-SM
Sep 20 11:10:06 tabriel kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: reiserfs:warning: CONFIG_REISERFS_CHECK is set ON
Sep 20 11:10:06 tabriel kernel: reiserfs:warning: - it is slow mode for debugging.
Sep 20 11:10:06 tabriel kernel: reiserfs: checking transaction log (device 03:03) ...
Sep 20 11:10:06 tabriel kernel: Using r5 hash to sort names
Sep 20 11:10:06 tabriel kernel: ReiserFS version 3.6.25
Sep 20 11:10:06 tabriel kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Sep 20 11:10:06 tabriel kernel: Mounted devfs on /dev
Sep 20 11:10:06 tabriel kernel: Freeing unused kernel memory: 88k freed
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 18 times
Sep 20 11:10:06 tabriel kernel: Real Time Clock Driver v1.10e
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: Adding Swap: 265064k swap-space (priority -1)
Sep 20 11:10:06 tabriel kernel: Adding Swap: 999896k swap-space (priority -2)
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 3 times
Sep 20 11:10:06 tabriel kernel: hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, DMA
Sep 20 11:10:06 tabriel kernel: Uniform CD-ROM driver Revision: 3.12
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 2 times
Sep 20 11:10:06 tabriel kernel: Journalled Block Device driver loaded
Sep 20 11:10:06 tabriel kernel: kjournald starting.  Commit interval 5 seconds
Sep 20 11:10:06 tabriel kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
Sep 20 11:10:06 tabriel kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 2 times
Sep 20 11:10:06 tabriel kernel: reiserfs:warning: CONFIG_REISERFS_CHECK is set ON
Sep 20 11:10:06 tabriel kernel: reiserfs:warning: - it is slow mode for debugging.
Sep 20 11:10:06 tabriel kernel: reiserfs: checking transaction log (device 03:43) ...
Sep 20 11:10:06 tabriel kernel: Using r5 hash to sort names
Sep 20 11:10:06 tabriel kernel: ReiserFS version 3.6.25
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 2 times
Sep 20 11:10:06 tabriel kernel: reiserfs:warning: CONFIG_REISERFS_CHECK is set ON
Sep 20 11:10:06 tabriel kernel: reiserfs:warning: - it is slow mode for debugging.
Sep 20 11:10:06 tabriel kernel: reiserfs: checking transaction log (device 16:41) ...
Sep 20 11:10:06 tabriel kernel: Using tea hash to sort names
Sep 20 11:10:06 tabriel kernel: ReiserFS version 3.6.25
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 5 times
Sep 20 11:10:06 tabriel kernel: Linux Tulip driver version 0.9.15-pre11 (May 11, 2002)
Sep 20 11:10:06 tabriel kernel: tulip0:  EEPROM default media type 100baseTx.
Sep 20 11:10:06 tabriel kernel: tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
Sep 20 11:10:06 tabriel kernel: tulip0:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
Sep 20 11:10:06 tabriel kernel: tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
Sep 20 11:10:06 tabriel kernel: tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
Sep 20 11:10:06 tabriel kernel: eth0: Macronix 98713 PMAC rev 0 at 0xd0af8000, 00:40:33:A5:0F:5B, IRQ 17.
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: usb.c: registered new driver hub
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: eth0: Using EEPROM-set media 100baseTx.
Sep 20 11:10:06 tabriel kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Sep 20 11:10:06 tabriel kernel: uhci.c: USB UHCI at I/O 0xdc00, IRQ 21
Sep 20 11:10:06 tabriel kernel: usb.c: new USB bus registered, assigned bus number 1
Sep 20 11:10:06 tabriel kernel: hub.c: USB hub found
Sep 20 11:10:06 tabriel kernel: hub.c: 2 ports detected
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
Sep 20 11:10:06 tabriel kernel: usb.c: USB device 2 (vend/prod 0x7ab/0xfc01) is not claimed by any active driver.
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: unexpected IRQ trap at vector 6b
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 6 times
Sep 20 11:10:06 tabriel kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Sep 20 11:10:06 tabriel kernel: hda: lost interrupt
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 5 times
Sep 20 11:10:06 tabriel kernel: SCSI subsystem driver Revision: 1.00
Sep 20 11:10:06 tabriel kernel: Initializing USB Mass Storage driver...
Sep 20 11:10:06 tabriel kernel: usb.c: registered new driver usb-storage
Sep 20 11:10:06 tabriel kernel: i2c-core.o: i2c core module
Sep 20 11:10:06 tabriel kernel: i2c-proc.o version 2.6.1 (20010825)
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 2 times
Sep 20 11:10:06 tabriel kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Sep 20 11:10:06 tabriel kernel:   Vendor: PHILIPS   Model: PCRW404           Rev: 1.4B
Sep 20 11:10:06 tabriel kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Sep 20 11:10:06 tabriel kernel: USB Mass Storage support registered.
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel last message repeated 18 times
Sep 20 11:10:06 tabriel kernel: es1371: version v0.30 time 13:49:32 Aug 28 2002
Sep 20 11:10:06 tabriel kernel: es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x02
Sep 20 11:10:06 tabriel kernel: es1371: found es1371 rev 2 at io 0xd000 irq 18
Sep 20 11:10:06 tabriel kernel: es1371: features: joystick 0x0
Sep 20 11:10:06 tabriel kernel: ac97_codec: AC97  codec, id: 0x5452:0x4103 (TriTech TR28023)
Sep 20 11:10:06 tabriel sound: Loading sound module (es1371) succeeded
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:06 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:07 tabriel aumix: vol set to 94, 94
Sep 20 11:10:07 tabriel aumix: pcm set to 94, 94
Sep 20 11:10:07 tabriel aumix: speaker set to 64, 0
Sep 20 11:10:07 tabriel aumix: line set to 64, 64, R
Sep 20 11:10:07 tabriel aumix: mic set to 64, 0, P
Sep 20 11:10:07 tabriel aumix: cd set to 80, 80, P
Sep 20 11:10:07 tabriel aumix: igain set to 64, 64, P
Sep 20 11:10:07 tabriel aumix: line1 set to 64, 64, P
Sep 20 11:10:07 tabriel aumix: phin set to 64, 0, P
Sep 20 11:10:07 tabriel aumix: phout set to 64, 0
Sep 20 11:10:07 tabriel aumix: video set to 64, 64, P
Sep 20 11:10:07 tabriel sound: Loading mixer settings succeeded
Sep 20 11:10:07 tabriel random: Initializing random number generator:  succeeded
Sep 20 11:10:07 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:07 tabriel xfs: xfs startup succeeded
Sep 20 11:10:07 tabriel xfs: listening on port -1 
Sep 20 11:10:07 tabriel modprobe: modprobe: Can't locate module devpts
Sep 20 11:10:07 tabriel mount: mount: fs type devpts not supported by kernel
Sep 20 11:10:07 tabriel netfs: Mounting other filesystems:  failed
Sep 20 11:10:07 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:07 tabriel identd: identd startup succeeded
Sep 20 11:10:07 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:07 tabriel xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/drakfont (unreadable) 
Sep 20 11:10:08 tabriel atd: atd startup succeeded
Sep 20 11:09:30 tabriel devfsd: Started device management daemon v1.3.25 for /dev 
Sep 20 11:09:30 tabriel devfsd: unknown group: video, defaulting to GID=0 
Sep 20 11:09:35 tabriel devfsd: error calling: symlink in GLOBAL 
Sep 20 11:09:35 tabriel rc.sysinit: Running DevFs daemon succeeded 
Sep 20 11:09:35 tabriel devfsd[114]: error calling: "unlink" in "GLOBAL"  
Sep 20 11:09:35 tabriel rc.sysinit: Configuring kernel parameters:  succeeded 
Sep 20 11:09:36 tabriel date: Fri Sep 20 11:09:36 EDT 2002 
Sep 20 11:09:36 tabriel rc.sysinit: Setting clock  (utc): Fri Sep 20 11:09:36 EDT 2002 succeeded 
Sep 20 11:09:36 tabriel rc.sysinit: Loading default keymap succeeded 
Sep 20 11:09:36 tabriel rc.sysinit: Setting hostname tabriel.tabris.net:  succeeded 
Sep 20 11:09:36 tabriel rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Sep 20 11:09:36 tabriel rc.sysinit: Activating swap partitions:  succeeded 
Sep 20 11:09:37 tabriel rc.sysinit: Finding module dependencies:  succeeded 
Sep 20 11:09:37 tabriel fsck: /dev/hda1: clean, 52/14056 files, 11743/56196 blocks 
Sep 20 11:09:38 tabriel modprobe: modprobe: Can't locate module devpts 
Sep 20 11:09:38 tabriel mount: mount: fs type devpts not supported by kernel 
Sep 20 11:09:41 tabriel rc.sysinit: Mounting local filesystems:  failed 
Sep 20 11:09:41 tabriel rc.sysinit: Mounting loopback filesystems:  succeeded 
Sep 20 11:09:41 tabriel loadkeys: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz 
Sep 20 11:09:41 tabriel keytable: Loading keymap: us succeeded 
Sep 20 11:09:42 tabriel loadkeys: Loading /usr/lib/kbd/keymaps/include/compose.latin.inc.gz 
Sep 20 11:09:42 tabriel keytable: Loading compose keys: compose.latin.inc succeeded 
Sep 20 11:09:42 tabriel keytable:  succeeded 
Sep 20 11:09:42 tabriel rc.sysinit: Enabling local filesystem quotas:  succeeded 
Sep 20 11:09:42 tabriel rc.sysinit: Turning on user and group quotas for local filesystems:  succeeded 
Sep 20 11:09:43 tabriel rc.sysinit: Enabling swap space:  succeeded 
Sep 20 11:09:44 tabriel mandrake_everytime: Building Window Manager Sessions succeeded 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth2 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth3 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth4 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth5 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth6 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth7 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth8 
Sep 20 11:09:44 tabriel modprobe: modprobe: Can't locate module eth9 
Sep 20 11:09:44 tabriel init: Entering runlevel: 3 
Sep 20 11:10:08 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:10 tabriel last message repeated 8 times
Sep 20 11:10:10 tabriel xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/pcf_drakfont:unscaled (unreadable) 
Sep 20 11:10:10 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:10 tabriel last message repeated 3 times
Sep 20 11:10:10 tabriel named[1145]: starting BIND 9.2.1 -u named
Sep 20 11:10:10 tabriel named[1145]: using 1 CPU
Sep 20 11:10:10 tabriel named: named startup succeeded
Sep 20 11:10:10 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:10 tabriel ntpd: ntpd startup succeeded
Sep 20 11:10:10 tabriel ntpd[1164]: ntpd 4.1.1@1.786 Tue May  7 02:44:50 EDT 2002 (1)
Sep 20 11:10:10 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:11 tabriel named[1147]: loading configuration from '/etc/named.conf'
Sep 20 11:10:11 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:11 tabriel named[1147]: no IPv6 interfaces found
Sep 20 11:10:11 tabriel named[1147]: listening on IPv4 interface lo, 127.0.0.1#53
Sep 20 11:10:11 tabriel named[1147]: listening on IPv4 interface eth0, 67.36.120.9#53
Sep 20 11:10:11 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:11 tabriel ntpd[1164]: precision = 9 usec
Sep 20 11:10:11 tabriel named[1147]: couldn't add command channel 127.0.0.1#953: not found
Sep 20 11:10:11 tabriel ntpd[1164]: kernel time discipline status 0040
Sep 20 11:10:11 tabriel named[1147]: zone 0.0.127.in-addr.arpa/IN: loaded serial 1997022700
Sep 20 11:10:11 tabriel named[1147]: running
Sep 20 11:10:11 tabriel ntpd[1164]: frequency initialized -133.208 from /etc/ntp/drift
Sep 20 11:10:11 tabriel ntpd[1164]: bind() fd 9, family 2, port 123, addr 224.0.1.1, in_classd=1 flags=0 fails: Address already in use
Sep 20 11:10:11 tabriel ntpd[1164]: ...multicast address 224.0.1.1 using wildcard socket
Sep 20 11:10:11 tabriel popper: popper startup succeeded
Sep 20 11:10:11 tabriel sshd: Starting sshd:
Sep 20 11:10:11 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:11 tabriel last message repeated 2 times
Sep 20 11:10:11 tabriel sshd:  succeeded
Sep 20 11:10:11 tabriel sshd: ^[[65G[^[[1;32m
Sep 20 11:10:11 tabriel sshd[1200]: Server listening on 0.0.0.0 port 22.
Sep 20 11:10:11 tabriel sshd: 
Sep 20 11:10:11 tabriel rc: Starting sshd:  succeeded
Sep 20 11:10:12 tabriel rawdevices:  failed
Sep 20 11:10:12 tabriel xinetd[1237]: Service ftp: attribute already set: disable [line=16]
Sep 20 11:10:13 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:10:13 tabriel kernel: eth0: 21140 transmit timed out, status fc675455, SIA fffffeff ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:10:13 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:10:13 tabriel xinetd[1237]: xinetd Version 2.3.7 started with libwrap options compiled in.
Sep 20 11:10:13 tabriel xinetd[1237]: Started working: 1 available service
Sep 20 11:10:15 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:15 tabriel xinetd: xinetd startup succeeded
Sep 20 11:10:15 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:20 tabriel last message repeated 21 times
Sep 20 11:10:21 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:10:21 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:10:21 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:10:21 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:26 tabriel last message repeated 21 times
Sep 20 11:10:26 tabriel cups: cupsd startup succeeded
Sep 20 11:10:26 tabriel loadkeys: Loading /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Sep 20 11:10:27 tabriel keytable: Loading keymap: us succeeded
Sep 20 11:10:27 tabriel loadkeys: Loading /usr/lib/kbd/keymaps/include/compose.latin.inc.gz
Sep 20 11:10:27 tabriel keytable: Loading compose keys: compose.latin.inc succeeded
Sep 20 11:10:27 tabriel keytable:  succeeded
Sep 20 11:10:27 tabriel postfix: Starting postfix: 
Sep 20 11:10:27 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:29 tabriel last message repeated 3 times
Sep 20 11:10:29 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:10:29 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:10:29 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:10:30 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:30 tabriel last message repeated 4 times
Sep 20 11:10:31 tabriel postfix:  succeeded
Sep 20 11:10:31 tabriel postfix: ^[[65G[^[[1;32m
Sep 20 11:10:31 tabriel postfix: 
Sep 20 11:10:31 tabriel rc: Starting postfix:  succeeded
Sep 20 11:10:31 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:31 tabriel numlock: Starting numlock: ^[[65G[^[[1;32m
Sep 20 11:10:31 tabriel numlock: 
Sep 20 11:10:31 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:31 tabriel rc: Starting numlock:  succeeded
Sep 20 11:10:31 tabriel internet: Checking internet connections to start at boot succeeded
Sep 20 11:10:31 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:31 tabriel crond[1610]: (CRON) STARTUP (fork ok) 
Sep 20 11:10:32 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:32 tabriel crond: crond startup succeeded
Sep 20 11:10:32 tabriel anacron[1626]: Anacron 2.3 started on 2002-09-20
Sep 20 11:10:32 tabriel anacron: anacron startup succeeded
Sep 20 11:10:32 tabriel anacron[1626]: Normal exit (0 jobs run)
Sep 20 11:10:32 tabriel rc: Starting kheader:  succeeded
Sep 20 11:10:32 tabriel devfsd: Running devfsd actions:  succeeded
Sep 20 11:10:32 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:34 tabriel last message repeated 8 times
Sep 20 11:10:34 tabriel netconf:   Checking kernel configuration
Sep 20 11:10:34 tabriel linuxconf: Running Linuxconf hooks:  succeeded
Sep 20 11:10:35 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:36 tabriel last message repeated 3 times
Sep 20 11:10:36 tabriel rc: Starting wine:  succeeded
Sep 20 11:10:37 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:10:37 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:10:37 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:10:39 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:45 tabriel last message repeated 5 times
Sep 20 11:10:45 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:10:45 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:10:45 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:10:46 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:50 tabriel last message repeated 7 times
Sep 20 11:10:53 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:10:53 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:10:53 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:10:54 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:10:59 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:01 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:01 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:01 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:11:03 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:06 tabriel last message repeated 3 times
Sep 20 11:11:08 tabriel login(pam_unix)[1805]: session opened for user root by (uid=0)
Sep 20 11:11:08 tabriel  -- root[1805]: ROOT LOGIN ON vc/1
Sep 20 11:11:08 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:09 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:09 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:09 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:09 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:11:13 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:14 tabriel last message repeated 4 times
Sep 20 11:11:17 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:17 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:17 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:11:18 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:19 tabriel last message repeated 3 times
Sep 20 11:11:19 tabriel kernel: usb.c: deregistering driver usb-storage
Sep 20 11:11:19 tabriel kernel: scsi : 0 hosts left.
Sep 20 11:11:20 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:24 tabriel last message repeated 4 times
Sep 20 11:11:25 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:25 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:25 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:11:26 tabriel modprobe: modprobe: Can't locate module scsi_hostadapter
Sep 20 11:11:28 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:29 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:33 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:33 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:33 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:11:34 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:39 tabriel last message repeated 6 times
Sep 20 11:11:41 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:41 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:41 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:11:43 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:47 tabriel last message repeated 4 times
Sep 20 11:11:49 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:49 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:49 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:11:49 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:11:56 tabriel last message repeated 4 times
Sep 20 11:11:57 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:11:57 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:11:57 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:11:57 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:05 tabriel last message repeated 10 times
Sep 20 11:12:05 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:12:05 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:12:05 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:12:07 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:10 tabriel last message repeated 4 times
Sep 20 11:12:10 tabriel modprobe: modprobe: Can't locate module scsi_hostadapter
Sep 20 11:12:12 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:13 tabriel last message repeated 2 times
Sep 20 11:12:13 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:12:13 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:12:13 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:12:13 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:15 tabriel last message repeated 5 times
Sep 20 11:12:17 tabriel modprobe: modprobe: Can't locate module scsi_hostadapter
Sep 20 11:12:17 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:20 tabriel last message repeated 4 times
Sep 20 11:12:21 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:12:21 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:12:21 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:12:21 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:25 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:27 tabriel kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Sep 20 11:12:27 tabriel kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-M1202  Rev: 1020
Sep 20 11:12:27 tabriel kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Sep 20 11:12:27 tabriel kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Sep 20 11:12:27 tabriel kernel: sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Sep 20 11:12:28 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:29 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:12:29 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:12:29 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:12:29 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:36 tabriel last message repeated 10 times
Sep 20 11:12:37 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:12:37 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:12:37 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:12:40 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:43 tabriel last message repeated 7 times
Sep 20 11:12:44 tabriel init: Switching to runlevel: 6
Sep 20 11:12:45 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:45 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:45 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:12:45 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:12:45 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:12:45 tabriel devfsd: devfsd shutdown succeeded
Sep 20 11:12:45 tabriel devfsd: Stopping devfsd daemon:  succeeded
Sep 20 11:12:45 tabriel ntpd[1164]: ntpd exiting on signal 15
Sep 20 11:12:45 tabriel ntpd_initres[1180]: ntpd exiting on signal 15
Sep 20 11:12:45 tabriel ntpd: ntpd shutdown succeeded
Sep 20 11:12:45 tabriel rc: Stopping wine:  succeeded
Sep 20 11:12:45 tabriel Font Server[1058]: terminating 
Sep 20 11:12:45 tabriel xfs: xfs shutdown succeeded
Sep 20 11:12:45 tabriel internet: Stopping internet connection if needed:  succeeded
Sep 20 11:12:46 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:50 tabriel last message repeated 4 times
Sep 20 11:12:53 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:12:53 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:12:53 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:12:54 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:12:57 tabriel last message repeated 2 times
Sep 20 11:13:01 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:13:01 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:13:01 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:13:01 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:13:08 tabriel last message repeated 5 times
Sep 20 11:13:09 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:13:09 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:13:09 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:13:16 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:13:16 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:13:17 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:13:17 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe1b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:13:17 tabriel kernel: eth0: transmit timed out, switching to 10baseT media.
Sep 20 11:13:18 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:13:23 tabriel last message repeated 3 times
Sep 20 11:13:25 tabriel kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep 20 11:13:25 tabriel kernel: eth0: 21140 transmit timed out, status fc69d5d7, SIA fffffe0b ffffffff 1c09fdc0 fffffec8, resetting...
Sep 20 11:13:25 tabriel kernel: eth0: transmit timed out, switching to 100baseTx-FDX media.
Sep 20 11:13:26 tabriel wnnkill: JSERVER Terminated
Sep 20 11:13:26 tabriel jserver: Shutting down jserver:  succeeded
Sep 20 11:13:26 tabriel gpm: gpm shutdown succeeded
Sep 20 11:13:26 tabriel numlock: Disabling numlocks on ttys: 
Sep 20 11:13:26 tabriel numlock: ^[[65G[^[[1;32m
Sep 20 11:13:26 tabriel numlock: 
Sep 20 11:13:26 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:13:26 tabriel rc: Stopping numlock:  succeeded
Sep 20 11:13:26 tabriel kernel: APIC error on CPU0: 02(02)
Sep 20 11:13:26 tabriel rc: Stopping kheader:  succeeded
Sep 20 11:13:26 tabriel sshd[1200]: Received signal 15; terminating.
Sep 20 11:13:26 tabriel sshd: sshd -TERM succeeded
Sep 20 11:13:26 tabriel postfix: Shutting down postfix: 
Sep 20 11:13:26 tabriel postfix:  succeeded
Sep 20 11:13:26 tabriel postfix: ^[[65G[^[[1;32m
Sep 20 11:13:27 tabriel postfix: 
Sep 20 11:13:27 tabriel rc: Stopping postfix:  succeeded
Sep 20 11:13:27 tabriel named[1147]: shutting down
Sep 20 11:13:27 tabriel named[1147]: no longer listening on 127.0.0.1#53
Sep 20 11:13:27 tabriel named[1147]: no longer listening on 67.36.120.9#53
Sep 20 11:13:27 tabriel named[1145]: exiting
Sep 20 11:13:27 tabriel named: named shutdown succeeded
Sep 20 11:13:27 tabriel xinetd[1237]: Exiting...
Sep 20 11:13:27 tabriel xinetd: xinetd shutdown succeeded
Sep 20 11:13:27 tabriel atd: atd shutdown succeeded
Sep 20 11:13:27 tabriel crond: crond shutdown succeeded
Sep 20 11:13:27 tabriel cups: cupsd shutdown succeeded
Sep 20 11:13:27 tabriel identd: identd shutdown succeeded
Sep 20 11:13:27 tabriel sound: Saving mixer settings succeeded
Sep 20 11:13:28 tabriel dd: 1+0 records in
Sep 20 11:13:28 tabriel dd: 1+0 records out
Sep 20 11:13:28 tabriel random: Saving random seed:  succeeded
Sep 20 11:13:28 tabriel kernel: Kernel logging (proc) stopped.
Sep 20 11:13:28 tabriel kernel: Kernel log daemon terminating.
Sep 20 11:13:29 tabriel exiting on signal 15

--------------Boundary-00=_8N01EC1JGLT23P42R6BL--

