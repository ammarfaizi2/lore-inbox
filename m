Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSFKVkc>; Tue, 11 Jun 2002 17:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316765AbSFKVkb>; Tue, 11 Jun 2002 17:40:31 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:27284 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S316757AbSFKVka>; Tue, 11 Jun 2002 17:40:30 -0400
Message-ID: <20020611214026.28765.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Jun 2002 05:40:26 +0800
Subject: [2.4.18] hdc: command error
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
this is my dmesg output:

Linux version 2.4.18 (root@penguin.work) (gcc version 2.96 20000731 (Mandrake Linux 8.1 2.96-0.62mdk)) #1 Fri May 17 19:43:07 BST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
   BIOS-e820: 00000000000e8400 - 0000000000100000 (reserved)
    BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
     BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)
      BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)
       BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
       On node 0 totalpages: 65520
       zone(0): 4096 pages.
       zone(1): 61424 pages.
       zone(2): 0 pages.
       Kernel command line: BOOT_IMAGE=2418 ro root=306 devfs=mount
       Initializing CPU#0
       Detected 647.193 MHz processor.
       Console: colour VGA+ 80x25
       Calibrating delay loop... 1291.05 BogoMIPS
       Memory: 255620k/262080k available (1223k kernel code, 6072k reserved, 324k data, 204k init, 0k highmem)
       Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
       Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
       Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
       Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
       Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
       CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
       CPU: L1 I cache: 16K, L1 D cache: 16K
       CPU: L2 cache: 256K
       CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
       Intel machine check architecture supported.
       Intel machine check reporting enabled on CPU#0.
       CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
       CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
       CPU: Intel Pentium III (Coppermine) stepping 0a
       Enabling fast FPU save and restore... done.
       Enabling unmasked SIMD FPU exception support... done.
       Checking 'hlt' instruction... OK.
       POSIX conformance testing by UNIFIX
       mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
       mtrr: detected mtrr type: Intel
       PCI: PCI BIOS revision 2.10 entry at 0xfd980, last bus=1
       PCI: Using configuration type 1
       PCI: Probing PCI hardware
       Unknown bridge resource 2: assuming transparent
       PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
       PCI: Found IRQ 10 for device 00:0a.0
       PCI: Sharing IRQ 10 with 00:0b.0
       PCI: Sharing IRQ 10 with 00:0b.1
       PCI: Found IRQ 10 for device 00:0a.1
       PCI: Sharing IRQ 10 with 01:00.0
       Limiting direct PCI/PCI transfers.
       isapnp: Scanning for PnP cards...
       isapnp: No Plug & Play device found
       Linux NET4.0 for Linux 2.4
       Based upon Swansea University Computer Society NET3.039
       Initializing RT netlink socket
       apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
       Starting kswapd
       Journalled Block Device driver loaded
       NTFS driver v1.1.22 [Flags: R/W]
       ACPI: APM is already active, exiting
       parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
       parport0: irq 7 detected
       pty: 256 Unix98 ptys configured
       Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
       ttyS00 at 0x03f8 (irq = 4) is a 16550A
       ttyS01 at 0x02f8 (irq = 3) is a 16550A
       block: 128 slots per queue, batch=32
       RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
       Uniform Multi-Platform E-IDE driver Revision: 6.31
       ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
       PIIX4: IDE controller on PCI bus 00 dev 39
       PIIX4: chipset revision 1
       PIIX4: not 100% native mode: will probe irqs later
           ide0: BM-DMA at 0x1c20-0x1c27, BIOS settings: hda:DMA, hdb:pio
	       ide1: BM-DMA at 0x1c28-0x1c2f, BIOS settings: hdc:pio, hdd:pio
	       hda: IC25N020ATDA04-0, ATA DISK drive
	       hdc: TOSHIBA CD/DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
	       ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	       ide1 at 0x170-0x177,0x376 on irq 15
	       hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=2584/240/63, UDMA(33)
	       hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, DMA
	       Uniform CD-ROM driver Revision: 3.12
	       Partition check:
	        hda: hda1 hda2 < hda5 hda6 hda7 >
		Floppy drive(s): fd0 is 1.44M
		FDC 0 is a National Semiconductor PC87306
		es1371: version v0.30 time 19:45:41 May 17 2002
		Linux Kernel Card Services 3.1.22
		  options:  [pci] [cardbus] [pm]
		  PCI: Found IRQ 10 for device 00:0a.0
		  PCI: Sharing IRQ 10 with 00:0b.0
		  PCI: Sharing IRQ 10 with 00:0b.1
		  PCI: Found IRQ 10 for device 00:0a.1
		  PCI: Sharing IRQ 10 with 01:00.0
		  NET4: Linux TCP/IP 1.0 for NET4.0
		  IP Protocols: ICMP, UDP, TCP, IGMP
		  IP: routing cache hash table of 2048 buckets, 16Kbytes
		  TCP: Hash tables configured (established 16384 bind 16384)
		  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
		  Yenta IRQ list 0898, PCI irq10
		  Socket status: 30000006
		  Yenta IRQ list 0898, PCI irq10
		  Socket status: 30000006
		  kjournald starting.  Commit interval 5 seconds
		  EXT3-fs: mounted filesystem with ordered data mode.
		  VFS: Mounted root (ext3 filesystem) readonly.
		  Freeing unused kernel memory: 204k freed
		  Adding Swap: 264560k swap-space (priority -1)
		  EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
		  VFS: Disk change detected on device ide1(22,0)
		  hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
		  hdc: drive_cmd: error=0x04
		  hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
		  hdc: drive_cmd: error=0x04
		  EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
		  NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
		  PCI: Found IRQ 10 for device 00:0b.0
		  PCI: Sharing IRQ 10 with 00:0a.0
		  PCI: Sharing IRQ 10 with 00:0b.1
		  3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
		  00:0b.0: 3Com PCI 3c556 Laptop Tornado at 0x1000. Vers LK1.1.16
		  cs: IO port probe 0x0c00-0x0cff: clean.
		  cs: IO port probe 0x0800-0x08ff: clean.
		  cs: IO port probe 0x0100-0x04ff: excluding 0x398-0x39f 0x4d0-0x4d7
		  cs: IO port probe 0x0a00-0x0aff: clean.
		  maestro3: version 1.22 built at 19:51:46 May 17 2002
		  PCI: Found IRQ 5 for device 00:0d.0
		  maestro3: Configuring ESS Maestro3(i) found at IO 0x1800 IRQ 5
		  maestro3:  subvendor id: 0x0010103c
		  ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 0
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 4
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 0
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 4
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 0
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 4
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 0
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 4
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 0
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 4
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 0
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 4
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 0
		  hdc: command error: status=0x51 { DriveReady SeekComplete Error }
		  hdc: command error: error=0x51
		  end_request: I/O error, dev 16:00 (hdc), sector 4

What do these error mean?
Some time I got this error running make install
or rebooti.

The machine is work with _no_ problem.

Let me know if you need further information and,
please cc' me 'cause I'm not a subscriber of the list.

Thanks and regards,
-- PC

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
