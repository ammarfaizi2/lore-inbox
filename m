Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318101AbSHSHyr>; Mon, 19 Aug 2002 03:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318115AbSHSHyr>; Mon, 19 Aug 2002 03:54:47 -0400
Received: from smtp01.web.de ([194.45.170.210]:49700 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318101AbSHSHym>;
	Mon, 19 Aug 2002 03:54:42 -0400
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre3 boot hang
References: <20020818153145.GA3184@df1tlpc.local.here>
	<87vg6811p6.fsf@plailis.homelinux.net>
	<1029694978.16822.10.camel@irongate.swansea.linux.org.uk>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Mon, 19 Aug 2002 09:57:16 +0200
Message-ID: <87r8gv702r.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Alan!

* Alan Cox writes:
>On Sun, 2002-08-18 at 19:06, Markus Plail wrote:
>>Apart from that, the latest ac series oopses when I try to mount a CD
>>in a drive driven by ide-scsi emulation. And the IDE performance was
>>quite a bit worse than 2.4.18. Sorry for not being able to make more
>>concrete statements, just wanted to mention it.

>Oops log, dmesg boot log of 2.4.18 and 2.4.20pre2-ac3 ?

Here it comes. I tried ac4 this morning and it's still the same.

regards
Markus

PS: Can you tell me if it is theoretically possible to burn CDs DAO/RAW
under Linux with DMA enabled?


--=-=-=
Content-Disposition: attachment; filename=dmesg_2.4.20-pre2-ac4.txt

Aug 19 09:42:49 plailis syslogd 1.4.1: restart.
Aug 19 09:42:49 plailis kernel: klogd 1.4.1, log source = /proc/kmsg started.
Aug 19 09:42:49 plailis kernel: Inspecting /boot/System.map
Aug 19 09:42:49 plailis kernel: Loaded 18159 symbols from /boot/System.map.
Aug 19 09:42:49 plailis kernel: Symbols match kernel version 2.4.20.
Aug 19 09:42:49 plailis kernel: Loaded 61 symbols from 8 modules.
Aug 19 09:42:49 plailis kernel: Linux version 2.4.20-pre2-ac4 (root@plailis_lfs) (gcc version 2.95.3 20010315 (release)) #1 Mon Aug 19 09:28:26 CEST 2002
Aug 19 09:42:49 plailis kernel: BIOS-provided physical RAM map:
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 00000000000ee000 - 0000000000100000 (reserved)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
Aug 19 09:42:49 plailis kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Aug 19 09:42:49 plailis kernel: 255MB LOWMEM available.
Aug 19 09:42:49 plailis kernel: On node 0 totalpages: 65520
Aug 19 09:42:49 plailis kernel: zone(0): 4096 pages.
Aug 19 09:42:49 plailis kernel: zone(1): 61424 pages.
Aug 19 09:42:49 plailis kernel: zone(2): 0 pages.
Aug 19 09:42:49 plailis kernel: Kernel command line: BOOT_IMAGE=lfsneu ro root=307 hdc=ide-scsi hdd=ide-scsi
Aug 19 09:42:49 plailis kernel: ide_setup: hdc=ide-scsi
Aug 19 09:42:49 plailis kernel: ide_setup: hdd=ide-scsi
Aug 19 09:42:49 plailis kernel: Local APIC disabled by BIOS -- reenabling.
Aug 19 09:42:49 plailis kernel: Found and enabled local APIC!
Aug 19 09:42:49 plailis kernel: Initializing CPU#0
Aug 19 09:42:49 plailis kernel: Detected 1526.845 MHz processor.
Aug 19 09:42:49 plailis kernel: Console: colour VGA+ 80x25
Aug 19 09:42:49 plailis kernel: Calibrating delay loop... 3047.42 BogoMIPS
Aug 19 09:42:49 plailis kernel: Memory: 256048k/262080k available (1401k kernel code, 5644k reserved, 551k data, 100k init, 0k highmem)
Aug 19 09:42:49 plailis kernel: Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Aug 19 09:42:49 plailis kernel: Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Aug 19 09:42:49 plailis kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 19 09:42:49 plailis kernel: ramfs: mounted with options: <defaults>
Aug 19 09:42:49 plailis kernel: ramfs: max_pages=32006 max_file_pages=0 max_inodes=0 max_dentries=32006
Aug 19 09:42:49 plailis kernel: Buffer cache hash table entries: 16384 (order: 4, 65536 bytes)
Aug 19 09:42:49 plailis kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 19 09:42:49 plailis kernel: CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Aug 19 09:42:49 plailis kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 19 09:42:49 plailis kernel: CPU: L2 Cache: 256K (64 bytes/line)
Aug 19 09:42:49 plailis kernel: CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Aug 19 09:42:49 plailis kernel: Intel machine check architecture supported.
Aug 19 09:42:49 plailis kernel: Intel machine check reporting enabled on CPU#0.
Aug 19 09:42:49 plailis kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Aug 19 09:42:49 plailis kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Aug 19 09:42:49 plailis kernel: CPU: AMD Athlon(tm) XP 1800+ stepping 02
Aug 19 09:42:49 plailis kernel: Enabling fast FPU save and restore... done.
Aug 19 09:42:49 plailis kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 19 09:42:49 plailis kernel: Checking 'hlt' instruction... OK.
Aug 19 09:42:49 plailis kernel: POSIX conformance testing by UNIFIX
Aug 19 09:42:49 plailis kernel: enabled ExtINT on CPU#0
Aug 19 09:42:49 plailis kernel: ESR value before enabling vector: 00000000
Aug 19 09:42:49 plailis kernel: ESR value after enabling vector: 00000000
Aug 19 09:42:49 plailis kernel: Using local APIC timer interrupts.
Aug 19 09:42:49 plailis kernel: calibrating APIC timer ...
Aug 19 09:42:49 plailis kernel: ..... CPU clock speed is 1526.8678 MHz.
Aug 19 09:42:49 plailis kernel: ..... host bus clock speed is 265.5422 MHz.
Aug 19 09:42:49 plailis kernel: cpu: 0, clocks: 2655422, slice: 1327711
Aug 19 09:42:49 plailis kernel: CPU0<T0:2655408,T1:1327696,D:1,S:1327711,C:2655422>
Aug 19 09:42:49 plailis kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Aug 19 09:42:49 plailis kernel: mtrr: detected mtrr type: Intel
Aug 19 09:42:49 plailis kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
Aug 19 09:42:49 plailis kernel: PCI: Using configuration type 1
Aug 19 09:42:49 plailis kernel: PCI: Probing PCI hardware
Aug 19 09:42:49 plailis kernel: Unknown bridge resource 0: assuming transparent
Aug 19 09:42:49 plailis kernel: PCI: Using IRQ router SIS [1039/0008] at 00:02.0
Aug 19 09:42:49 plailis kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00f7160
Aug 19 09:42:49 plailis kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x5c17, dseg 0xf0000
Aug 19 09:42:49 plailis kernel: PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
Aug 19 09:42:49 plailis kernel: Linux NET4.0 for Linux 2.4
Aug 19 09:42:49 plailis kernel: Based upon Swansea University Computer Society NET3.039
Aug 19 09:42:49 plailis kernel: Initializing RT netlink socket
Aug 19 09:42:49 plailis kernel: Starting kswapd
Aug 19 09:42:49 plailis kernel: Journalled Block Device driver loaded
Aug 19 09:42:49 plailis kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 19 09:42:49 plailis kernel: ACPI: Core Subsystem version [20011018]
Aug 19 09:42:49 plailis kernel: ACPI: Subsystem enabled
Aug 19 09:42:49 plailis kernel: Detected PS/2 Mouse Port.
Aug 19 09:42:49 plailis kernel: pty: 256 Unix98 ptys configured
Aug 19 09:42:49 plailis kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Aug 19 09:42:49 plailis kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Aug 19 09:42:49 plailis kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Aug 19 09:42:49 plailis kernel: Real Time Clock Driver v1.10e
Aug 19 09:42:49 plailis kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Aug 19 09:42:49 plailis kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 19 09:42:49 plailis kernel: SIS5513: IDE controller on PCI bus 00 dev 15
Aug 19 09:42:49 plailis kernel: SIS5513: chipset revision 208
Aug 19 09:42:49 plailis kernel: SIS5513: not 100%% native mode: will probe irqs later
Aug 19 09:42:49 plailis kernel: SiS735    ATA 100 controller
Aug 19 09:42:49 plailis kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
Aug 19 09:42:49 plailis kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Aug 19 09:42:49 plailis kernel: hda: SAMSUNG SV6004H, ATA DISK drive
Aug 19 09:42:49 plailis kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 19 09:42:49 plailis kernel: hdc: 20X10, ATAPI CD/DVD-ROM drive
Aug 19 09:42:49 plailis kernel: hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
Aug 19 09:42:49 plailis kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 19 09:42:49 plailis kernel: hda: host protected area => 1
Aug 19 09:42:49 plailis kernel: hda: 117306000 sectors (60061 MB) w/468KiB Cache, CHS=7301/255/63, UDMA(100)
Aug 19 09:42:49 plailis kernel: ide-floppy driver 0.99.newide
Aug 19 09:42:49 plailis kernel: Partition check:
Aug 19 09:42:49 plailis kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
Aug 19 09:42:49 plailis kernel: Floppy drive(s): fd0 is 1.44M
Aug 19 09:42:49 plailis kernel: FDC 0 is a post-1991 82077
Aug 19 09:42:49 plailis kernel: ide-floppy driver 0.99.newide
Aug 19 09:42:49 plailis kernel: SCSI subsystem driver Revision: 1.00
Aug 19 09:42:49 plailis kernel: PCI: Found IRQ 11 for device 00:09.0
Aug 19 09:42:49 plailis kernel: sym53c8xx: at PCI bus 0, device 9, function 0
Aug 19 09:42:49 plailis kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Aug 19 09:42:49 plailis kernel: sym53c8xx: 53c875 detected 
Aug 19 09:42:49 plailis kernel: sym53c875-0: rev 0x26 on pci bus 0 device 9 function 0 irq 11
Aug 19 09:42:49 plailis kernel: sym53c875-0: ID 7, Fast-20, Parity Checking
Aug 19 09:42:49 plailis kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Aug 19 09:42:49 plailis kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Aug 19 09:42:49 plailis kernel:   Vendor: ATAPI     Model: CD-R/RW 20X10     Rev: H.JH
Aug 19 09:42:49 plailis kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 19 09:42:49 plailis kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
Aug 19 09:42:49 plailis kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 19 09:42:49 plailis kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Aug 19 09:42:49 plailis kernel: Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
Aug 19 09:42:49 plailis kernel: sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Aug 19 09:42:49 plailis kernel: Uniform CD-ROM driver Revision: 3.12
Aug 19 09:42:49 plailis kernel: sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Aug 19 09:42:49 plailis kernel: usb.c: registered new driver usbdevfs
Aug 19 09:42:49 plailis kernel: usb.c: registered new driver hub
Aug 19 09:42:49 plailis kernel: Initializing USB Mass Storage driver...
Aug 19 09:42:49 plailis kernel: usb.c: registered new driver usb-storage
Aug 19 09:42:49 plailis kernel: USB Mass Storage support registered.
Aug 19 09:42:49 plailis kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 19 09:42:49 plailis kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Aug 19 09:42:49 plailis kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Aug 19 09:42:49 plailis kernel: TCP: Hash tables configured (established 16384 bind 32768)
Aug 19 09:42:49 plailis kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 19 09:42:49 plailis kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Aug 19 09:42:49 plailis kernel: EXT3-fs: write access will be enabled during recovery.
Aug 19 09:42:49 plailis kernel: kjournald starting.  Commit interval 5 seconds
Aug 19 09:42:49 plailis kernel: EXT3-fs: recovery complete.
Aug 19 09:42:49 plailis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 19 09:42:49 plailis kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 19 09:42:49 plailis kernel: Freeing unused kernel memory: 100k freed
Aug 19 09:42:49 plailis kernel: Adding Swap: 128480k swap-space (priority -1)
Aug 19 09:42:49 plailis kernel: SiS router pirq escape (99)
Aug 19 09:42:49 plailis kernel: SiS router pirq escape (99)
Aug 19 09:42:49 plailis kernel: usb-ohci.c: USB OHCI at membase 0xd0832000, IRQ 10
Aug 19 09:42:49 plailis kernel: usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
Aug 19 09:42:49 plailis kernel: usb.c: new USB bus registered, assigned bus number 1
Aug 19 09:42:49 plailis kernel: hub.c: USB hub found
Aug 19 09:42:49 plailis kernel: hub.c: 3 ports detected
Aug 19 09:42:49 plailis kernel: PCI: Found IRQ 5 for device 00:02.2
Aug 19 09:42:49 plailis kernel: PCI: Sharing IRQ 5 with 00:0f.0
Aug 19 09:42:49 plailis kernel: usb-ohci.c: USB OHCI at membase 0xd0834000, IRQ 5
Aug 19 09:42:49 plailis kernel: usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
Aug 19 09:42:49 plailis kernel: usb.c: new USB bus registered, assigned bus number 2
Aug 19 09:42:49 plailis kernel: hub.c: USB hub found
Aug 19 09:42:49 plailis kernel: hub.c: 3 ports detected
Aug 19 09:42:49 plailis kernel: usb.c: registered new driver usblp
Aug 19 09:42:49 plailis kernel: printer.c: v0.11: USB Printer Device Class driver
Aug 19 09:42:49 plailis kernel: mice: PS/2 mouse device common for all mice
Aug 19 09:42:49 plailis kernel: usb.c: registered new driver hid
Aug 19 09:42:49 plailis kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Aug 19 09:42:49 plailis kernel: hid-core.c: USB HID support drivers
Aug 19 09:42:49 plailis kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,7), internal journal
Aug 19 09:42:49 plailis kernel: NTFS driver v1.1.22 [Flags: R/O MODULE]
Aug 19 09:42:49 plailis kernel: NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
Aug 19 09:42:49 plailis kernel: kjournald starting.  Commit interval 5 seconds
Aug 19 09:42:49 plailis kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,9), internal journal
Aug 19 09:42:49 plailis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 19 09:42:49 plailis kernel: kjournald starting.  Commit interval 5 seconds
Aug 19 09:42:49 plailis kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,8), internal journal
Aug 19 09:42:49 plailis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 19 09:42:49 plailis kernel: kjournald starting.  Commit interval 5 seconds
Aug 19 09:42:49 plailis kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,10), internal journal
Aug 19 09:42:49 plailis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 19 09:42:49 plailis kernel: kjournald starting.  Commit interval 5 seconds
Aug 19 09:42:49 plailis kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,11), internal journal
Aug 19 09:42:49 plailis kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 19 09:42:49 plailis kernel: devpts: called with bogus options
Aug 19 09:42:49 plailis kernel: hub.c: USB new device connect on bus2/1, assigned device number 2
Aug 19 09:42:49 plailis kernel: input0,hiddev0: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb2:2.0
Aug 19 09:42:49 plailis kernel: input1,hiddev0: USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:2.1
Aug 19 09:42:49 plailis kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
Aug 19 09:42:49 plailis kernel:   http://www.scyld.com/network/ne2k-pci.html
Aug 19 09:42:49 plailis kernel: PCI: Found IRQ 5 for device 00:0f.0
Aug 19 09:42:49 plailis kernel: PCI: Sharing IRQ 5 with 00:02.2
Aug 19 09:42:49 plailis kernel: eth0: RealTek RTL-8029 found at 0xcc00, IRQ 5, 00:40:95:45:11:CF.
Aug 19 09:42:51 plailis kernel: sis900.c: v1.08.04 4/25/2002
Aug 19 09:42:51 plailis kernel: PCI: Assigned IRQ 12 for device 00:03.0
Aug 19 09:42:51 plailis kernel: eth1: Realtek RTL8201 PHY transceiver found at address 1.
Aug 19 09:42:51 plailis kernel: eth1: Using transceiver found at address 1 as default
Aug 19 09:42:51 plailis kernel: eth1: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 12, 00:07:95:a8:9c:f9.
Aug 19 09:42:52 plailis kernel: eth1: Media Link On 10mbps half-duplex 
Aug 19 09:42:52 plailis kernel: CSLIP: code copyright 1989 Regents of the University of California
Aug 19 09:42:52 plailis kernel: PPP generic driver version 2.4.2

--=-=-=
Content-Disposition: attachment; filename=dmesg_2.4.18.txt

Aug 13 19:01:19 plailis syslogd 1.4.1: restart.
Aug 13 19:01:19 plailis kernel: klogd 1.4.1, log source = /proc/kmsg started.
Aug 13 19:01:19 plailis kernel: Inspecting /boot/System.map
Aug 13 19:01:19 plailis kernel: Loaded 16679 symbols from /boot/System.map.
Aug 13 19:01:19 plailis kernel: Symbols match kernel version 2.4.18.
Aug 13 19:01:19 plailis kernel: Loaded 107 symbols from 11 modules.
Aug 13 19:01:19 plailis kernel: Linux version 2.4.18 (root@plailis_lfs) (gcc version 2.95.3 20010315 (release)) #1 Die Aug 13 18:53:01 CEST 2002
Aug 13 19:01:19 plailis kernel: BIOS-provided physical RAM map:
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 00000000000ee000 - 0000000000100000 (reserved)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
Aug 13 19:01:19 plailis kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Aug 13 19:01:19 plailis kernel: On node 0 totalpages: 65520
Aug 13 19:01:19 plailis kernel: zone(0): 4096 pages.
Aug 13 19:01:19 plailis kernel: zone(1): 61424 pages.
Aug 13 19:01:19 plailis kernel: zone(2): 0 pages.
Aug 13 19:01:19 plailis kernel: Local APIC disabled by BIOS -- reenabling.
Aug 13 19:01:19 plailis kernel: Found and enabled local APIC!
Aug 13 19:01:19 plailis kernel: Kernel command line: BOOT_IMAGE=lfsneu ro root=307 hdc=ide-scsi hdd=ide-scsi
Aug 13 19:01:19 plailis kernel: ide_setup: hdc=ide-scsi
Aug 13 19:01:19 plailis kernel: ide_setup: hdd=ide-scsi
Aug 13 19:01:19 plailis kernel: Initializing CPU#0
Aug 13 19:01:19 plailis kernel: Detected 1526.847 MHz processor.
Aug 13 19:01:19 plailis kernel: Console: colour VGA+ 80x25
Aug 13 19:01:19 plailis kernel: Calibrating delay loop... 3047.42 BogoMIPS
Aug 13 19:01:19 plailis kernel: Memory: 255496k/262080k available (1262k kernel code, 6196k reserved, 366k data, 224k init, 0k highmem)
Aug 13 19:01:19 plailis kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Aug 13 19:01:19 plailis kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Aug 13 19:01:19 plailis kernel: Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Aug 13 19:01:19 plailis kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Aug 13 19:01:19 plailis kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 13 19:01:19 plailis kernel: CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
Aug 13 19:01:19 plailis kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 13 19:01:19 plailis kernel: CPU: L2 Cache: 256K (64 bytes/line)
Aug 13 19:01:19 plailis kernel: CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
Aug 13 19:01:19 plailis kernel: Intel machine check architecture supported.
Aug 13 19:01:19 plailis kernel: Intel machine check reporting enabled on CPU#0.
Aug 13 19:01:19 plailis kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Aug 13 19:01:19 plailis kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Aug 13 19:01:19 plailis kernel: CPU: AMD Athlon(tm) XP 1800+ stepping 02
Aug 13 19:01:19 plailis kernel: Enabling fast FPU save and restore... done.
Aug 13 19:01:19 plailis kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 13 19:01:19 plailis kernel: Checking 'hlt' instruction... OK.
Aug 13 19:01:19 plailis kernel: POSIX conformance testing by UNIFIX
Aug 13 19:01:19 plailis kernel: enabled ExtINT on CPU#0
Aug 13 19:01:19 plailis kernel: ESR value before enabling vector: 00000000
Aug 13 19:01:19 plailis kernel: ESR value after enabling vector: 00000000
Aug 13 19:01:19 plailis kernel: Using local APIC timer interrupts.
Aug 13 19:01:19 plailis kernel: calibrating APIC timer ...
Aug 13 19:01:19 plailis kernel: ..... CPU clock speed is 1526.9051 MHz.
Aug 13 19:01:19 plailis kernel: ..... host bus clock speed is 265.5488 MHz.
Aug 13 19:01:19 plailis kernel: cpu: 0, clocks: 2655488, slice: 1327744
Aug 13 19:01:19 plailis kernel: CPU0<T0:2655488,T1:1327744,D:0,S:1327744,C:2655488>
Aug 13 19:01:19 plailis kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Aug 13 19:01:19 plailis kernel: mtrr: detected mtrr type: Intel
Aug 13 19:01:19 plailis kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
Aug 13 19:01:19 plailis kernel: PCI: Using configuration type 1
Aug 13 19:01:19 plailis kernel: PCI: Probing PCI hardware
Aug 13 19:01:19 plailis kernel: Unknown bridge resource 0: assuming transparent
Aug 13 19:01:19 plailis kernel: PCI: Using IRQ router SIS [1039/0008] at 00:02.0
Aug 13 19:01:19 plailis kernel: Linux NET4.0 for Linux 2.4
Aug 13 19:01:19 plailis kernel: Based upon Swansea University Computer Society NET3.039
Aug 13 19:01:19 plailis kernel: Initializing RT netlink socket
Aug 13 19:01:19 plailis kernel: Starting kswapd
Aug 13 19:01:19 plailis kernel: ACPI: Core Subsystem version [20011018]
Aug 13 19:01:19 plailis kernel: ACPI: Subsystem enabled
Aug 13 19:01:19 plailis kernel: Detected PS/2 Mouse Port.
Aug 13 19:01:19 plailis kernel: pty: 256 Unix98 ptys configured
Aug 13 19:01:19 plailis kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Aug 13 19:01:19 plailis kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Aug 13 19:01:19 plailis kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Aug 13 19:01:19 plailis kernel: Real Time Clock Driver v1.10e
Aug 13 19:01:19 plailis kernel: block: 128 slots per queue, batch=32
Aug 13 19:01:19 plailis kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Aug 13 19:01:19 plailis kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 13 19:01:19 plailis kernel: SIS5513: IDE controller on PCI bus 00 dev 15
Aug 13 19:01:19 plailis kernel: SIS5513: chipset revision 208
Aug 13 19:01:19 plailis kernel: SIS5513: not 100%% native mode: will probe irqs later
Aug 13 19:01:19 plailis kernel: SiS735
Aug 13 19:01:19 plailis kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
Aug 13 19:01:19 plailis kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Aug 13 19:01:19 plailis kernel: hda: SAMSUNG SV6004H, ATA DISK drive
Aug 13 19:01:19 plailis kernel: hdc: 20X10, ATAPI CD/DVD-ROM drive
Aug 13 19:01:19 plailis kernel: hdd: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
Aug 13 19:01:19 plailis kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 13 19:01:19 plailis kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 13 19:01:19 plailis kernel: hda: 117306000 sectors (60061 MB) w/468KiB Cache, CHS=7301/255/63, UDMA(100)
Aug 13 19:01:19 plailis kernel: ide-floppy driver 0.97.sv
Aug 13 19:01:19 plailis kernel: Partition check:
Aug 13 19:01:19 plailis kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
Aug 13 19:01:19 plailis kernel: Floppy drive(s): fd0 is 1.44M
Aug 13 19:01:19 plailis kernel: FDC 0 is a post-1991 82077
Aug 13 19:01:19 plailis kernel: ide-floppy driver 0.97.sv
Aug 13 19:01:19 plailis kernel: SCSI subsystem driver Revision: 1.00
Aug 13 19:01:19 plailis kernel: PCI: Found IRQ 11 for device 00:09.0
Aug 13 19:01:19 plailis kernel: sym53c8xx: at PCI bus 0, device 9, function 0
Aug 13 19:01:19 plailis kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Aug 13 19:01:19 plailis kernel: sym53c8xx: 53c875 detected 
Aug 13 19:01:19 plailis kernel: sym53c875-0: rev 0x26 on pci bus 0 device 9 function 0 irq 11
Aug 13 19:01:19 plailis kernel: sym53c875-0: ID 7, Fast-20, Parity Checking
Aug 13 19:01:19 plailis kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Aug 13 19:01:19 plailis kernel: scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Aug 13 19:01:19 plailis kernel:   Vendor: ATAPI     Model: CD-R/RW 20X10     Rev: H.JH
Aug 13 19:01:19 plailis kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 13 19:01:19 plailis kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-M1612  Rev: 1004
Aug 13 19:01:19 plailis kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Aug 13 19:01:19 plailis kernel: Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Aug 13 19:01:19 plailis kernel: Attached scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
Aug 13 19:01:19 plailis kernel: sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Aug 13 19:01:19 plailis kernel: Uniform CD-ROM driver Revision: 3.12
Aug 13 19:01:19 plailis kernel: sr1: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Aug 13 19:01:19 plailis kernel: usb.c: registered new driver usbdevfs
Aug 13 19:01:19 plailis kernel: usb.c: registered new driver hub
Aug 13 19:01:19 plailis kernel: Initializing USB Mass Storage driver...
Aug 13 19:01:19 plailis kernel: usb.c: registered new driver usb-storage
Aug 13 19:01:19 plailis kernel: USB Mass Storage support registered.
Aug 13 19:01:19 plailis kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Aug 13 19:01:19 plailis kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Aug 13 19:01:19 plailis kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Aug 13 19:01:19 plailis kernel: TCP: Hash tables configured (established 16384 bind 16384)
Aug 13 19:01:19 plailis kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Aug 13 19:01:19 plailis kernel: VFS: Mounted root (ext2 filesystem) readonly.
Aug 13 19:01:19 plailis kernel: Freeing unused kernel memory: 224k freed
Aug 13 19:01:19 plailis kernel: Adding Swap: 128480k swap-space (priority -1)
Aug 13 19:01:19 plailis kernel: SiS router pirq escape (99)
Aug 13 19:01:19 plailis kernel: SiS router pirq escape (99)
Aug 13 19:01:19 plailis kernel: usb-ohci.c: USB OHCI at membase 0xd0832000, IRQ 10
Aug 13 19:01:19 plailis kernel: usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
Aug 13 19:01:19 plailis kernel: usb.c: new USB bus registered, assigned bus number 1
Aug 13 19:01:19 plailis kernel: hub.c: USB hub found
Aug 13 19:01:19 plailis kernel: hub.c: 3 ports detected
Aug 13 19:01:19 plailis kernel: PCI: Found IRQ 5 for device 00:02.2
Aug 13 19:01:19 plailis kernel: PCI: Sharing IRQ 5 with 00:0f.0
Aug 13 19:01:19 plailis kernel: usb-ohci.c: USB OHCI at membase 0xd0834000, IRQ 5
Aug 13 19:01:19 plailis kernel: usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
Aug 13 19:01:19 plailis kernel: usb.c: new USB bus registered, assigned bus number 2
Aug 13 19:01:19 plailis kernel: hub.c: USB hub found
Aug 13 19:01:19 plailis kernel: hub.c: 3 ports detected
Aug 13 19:01:19 plailis kernel: usb.c: registered new driver usblp
Aug 13 19:01:19 plailis kernel: printer.c: v0.8:USB Printer Device Class driver
Aug 13 19:01:19 plailis kernel: mice: PS/2 mouse device common for all mice
Aug 13 19:01:19 plailis kernel: usb.c: registered new driver hid
Aug 13 19:01:19 plailis kernel: hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Aug 13 19:01:19 plailis kernel: hid-core.c: USB HID support drivers
Aug 13 19:01:19 plailis kernel: NTFS driver v1.1.22 [Flags: R/O MODULE]
Aug 13 19:01:19 plailis kernel: NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
Aug 13 19:01:19 plailis kernel: devpts: called with bogus options
Aug 13 19:01:19 plailis kernel: hub.c: USB new device connect on bus2/1, assigned device number 2
Aug 13 19:01:19 plailis kernel: input0: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb2:2.0
Aug 13 19:01:19 plailis kernel: input1: USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:2.1
Aug 13 19:01:19 plailis kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
Aug 13 19:01:19 plailis kernel:   http://www.scyld.com/network/ne2k-pci.html
Aug 13 19:01:19 plailis kernel: PCI: Found IRQ 5 for device 00:0f.0
Aug 13 19:01:19 plailis kernel: PCI: Sharing IRQ 5 with 00:02.2
Aug 13 19:01:19 plailis kernel: eth0: RealTek RTL-8029 found at 0xcc00, IRQ 5, 00:40:95:45:11:CF.
Aug 13 19:01:20 plailis kernel: sis900.c: v1.08.02 11/30/2001
Aug 13 19:01:20 plailis kernel: PCI: Assigned IRQ 12 for device 00:03.0
Aug 13 19:01:20 plailis kernel: eth1: Realtek RTL8201 PHY transceiver found at address 1.
Aug 13 19:01:20 plailis kernel: eth1: Using transceiver found at address 1 as default
Aug 13 19:01:20 plailis kernel: eth1: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 12, 00:07:95:a8:9c:f9.
Aug 13 19:01:21 plailis kernel: eth1: Media Link On 10mbps half-duplex 

--=-=-=
Content-Disposition: attachment; filename=oops.txt

Aug 19 09:41:22 plailis kernel: kernel BUG in header file at line 157
Aug 19 09:41:22 plailis kernel: kernel BUG at panic.c:286!
Aug 19 09:41:22 plailis kernel: invalid operand: 0000
Aug 19 09:41:22 plailis kernel: CPU:    0
Aug 19 09:41:22 plailis kernel: EIP:    0010:[__out_of_line_bug+15/32]    Not tainted
Aug 19 09:41:22 plailis kernel: EIP:    0010:[<c01168df>]    Not tainted
Aug 19 09:41:22 plailis kernel: EFLAGS: 00010282
Aug 19 09:41:22 plailis kernel: eax: 00000026   ebx: 00001000   ecx: c0309948   edx: ce872000
Aug 19 09:41:22 plailis kernel: esi: 00000001   edi: c13fe000   ebp: 00000000   esp: ce873d30
Aug 19 09:41:22 plailis kernel: ds: 0018   es: 0018   ss: 0018
Aug 19 09:41:22 plailis kernel: Process mount (pid: 564, stackpage=ce873000)
Aug 19 09:41:22 plailis kernel: Stack: c0265e00 0000009d c01cc6b1 0000009d cff01000 c0332f9c cee54d40 cee51000 
Aug 19 09:41:22 plailis kernel:        00000000 c13fe000 00000001 c13fe000 c01cc8ab c0332db0 cee54d40 c0332db0 
Aug 19 09:41:22 plailis kernel:        c0332f9c cee54d40 cee51000 00000000 00000000 c0332db0 c01ccd39 c0332f9c 
Aug 19 09:41:22 plailis kernel: Call Trace:    [ide_build_sglist+321/384] [ide_build_dmatable+91/416] [__ide_dma_read+41/288] [idescsi_issue_pc+115/448] [idescsi_do_request+27/64]
Aug 19 09:41:22 plailis kernel: Call Trace:    [<c01cc6b1>] [<c01cc8ab>] [<c01ccd39>] [<c01ecb63>] [<c01ecccb>]
Aug 19 09:41:22 plailis kernel:   [start_request+374/464] [ide_do_request+618/704] [ide_do_drive_cmd+218/272] [idescsi_queue+1362/1440] [scsi_dispatch_cmd+426/544] [scsi_old_done+0/1472]
Aug 19 09:41:22 plailis kernel:   [<c01c9576>] [<c01c988a>] [<c01c9e8a>] [<c01ed842>] [<c01db5aa>] [<c01e0340>]
Aug 19 09:41:22 plailis kernel:   [scsi_request_fn+769/832] [generic_unplug_device+32/48] [__run_task_queue+76/96] [block_sync_page+22/32] [___wait_on_page+134/192] [do_generic_file_read+693/1024]
Aug 19 09:41:22 plailis kernel:   [<c01e1b61>] [<c01bb650>] [<c011b0dc>] [<c0138ee6>] [<c0126946>] [<c0127255>]
Aug 19 09:41:22 plailis kernel:   [generic_file_read+133/320] [file_read_actor+0/144] [sys_read+150/240] [system_call+51/56]
Aug 19 09:41:22 plailis kernel:   [<c0127695>] [<c0127580>] [<c0135316>] [<c0106cd3>]
Aug 19 09:41:22 plailis kernel: 
Aug 19 09:41:22 plailis kernel: Code: 0f 0b 1e 01 26 5e 26 c0 eb fe 8d b4 26 00 00 00 00 83 ec 18 

--=-=-=
Content-Disposition: attachment; filename=ksymoops.txt

ksymoops 2.4.6 on i686 2.4.20-pre2-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-pre2-ac4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 19 09:41:22 plailis kernel: kernel BUG in header file at line 157
Aug 19 09:41:22 plailis kernel: kernel BUG at panic.c:286!
Aug 19 09:41:22 plailis kernel: invalid operand: 0000
Aug 19 09:41:22 plailis kernel: CPU:    0
Aug 19 09:41:22 plailis kernel: EIP:    0010:[__out_of_line_bug+15/32]    Not tainted
Aug 19 09:41:22 plailis kernel: EIP:    0010:[<c01168df>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 19 09:41:22 plailis kernel: EFLAGS: 00010282
Aug 19 09:41:22 plailis kernel: eax: 00000026   ebx: 00001000   ecx: c0309948   edx: ce872000
Aug 19 09:41:22 plailis kernel: esi: 00000001   edi: c13fe000   ebp: 00000000   esp: ce873d30
Aug 19 09:41:22 plailis kernel: ds: 0018   es: 0018   ss: 0018
Aug 19 09:41:22 plailis kernel: Process mount (pid: 564, stackpage=ce873000)
Aug 19 09:41:22 plailis kernel: Stack: c0265e00 0000009d c01cc6b1 0000009d cff01000 c0332f9c cee54d40 cee51000 
Aug 19 09:41:22 plailis kernel:        00000000 c13fe000 00000001 c13fe000 c01cc8ab c0332db0 cee54d40 c0332db0 
Aug 19 09:41:22 plailis kernel:        c0332f9c cee54d40 cee51000 00000000 00000000 c0332db0 c01ccd39 c0332f9c 
Aug 19 09:41:22 plailis kernel: Call Trace:    [ide_build_sglist+321/384] [ide_build_dmatable+91/416] [__ide_dma_read+41/288] [idescsi_issue_pc+115/448] [idescsi_do_request+27/64]
Aug 19 09:41:22 plailis kernel: Call Trace:    [<c01cc6b1>] [<c01cc8ab>] [<c01ccd39>] [<c01ecb63>] [<c01ecccb>]
Aug 19 09:41:22 plailis kernel:   [<c01c9576>] [<c01c988a>] [<c01c9e8a>] [<c01ed842>] [<c01db5aa>] [<c01e0340>]
Aug 19 09:41:22 plailis kernel:   [<c01e1b61>] [<c01bb650>] [<c011b0dc>] [<c0138ee6>] [<c0126946>] [<c0127255>]
Aug 19 09:41:22 plailis kernel:   [<c0127695>] [<c0127580>] [<c0135316>] [<c0106cd3>]
Aug 19 09:41:22 plailis kernel: Code: 0f 0b 1e 01 26 5e 26 c0 eb fe 8d b4 26 00 00 00 00 83 ec 18 


>>EIP; c01168df <__out_of_line_bug+f/20>   <=====

>>ecx; c0309948 <runqueues+848/940>
>>edx; ce872000 <_end+e538b24/104f2b24>
>>edi; c13fe000 <_end+10c4b24/104f2b24>
>>esp; ce873d30 <_end+e53a854/104f2b24>

Trace; c01cc6b1 <ide_build_sglist+141/180>
Trace; c01cc8ab <ide_build_dmatable+5b/1a0>
Trace; c01ccd39 <__ide_dma_read+29/120>
Trace; c01ecb63 <idescsi_issue_pc+73/1c0>
Trace; c01ecccb <idescsi_do_request+1b/40>
Trace; c01c9576 <start_request+176/1d0>
Trace; c01c988a <ide_do_request+26a/2c0>
Trace; c01c9e8a <ide_do_drive_cmd+da/110>
Trace; c01ed842 <idescsi_queue+552/5a0>
Trace; c01db5aa <scsi_dispatch_cmd+1aa/220>
Trace; c01e0340 <scsi_old_done+0/5c0>
Trace; c01e1b61 <scsi_request_fn+301/340>
Trace; c01bb650 <generic_unplug_device+20/30>
Trace; c011b0dc <__run_task_queue+4c/60>
Trace; c0138ee6 <block_sync_page+16/20>
Trace; c0126946 <___wait_on_page+86/c0>
Trace; c0127255 <do_generic_file_read+2b5/400>
Trace; c0127695 <generic_file_read+85/140>
Trace; c0127580 <file_read_actor+0/90>
Trace; c0135316 <sys_read+96/f0>
Trace; c0106cd3 <system_call+33/38>

Code;  c01168df <__out_of_line_bug+f/20>
00000000 <_EIP>:
Code;  c01168df <__out_of_line_bug+f/20>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01168e1 <__out_of_line_bug+11/20>
   2:   1e                        push   %ds
Code;  c01168e2 <__out_of_line_bug+12/20>
   3:   01 26                     add    %esp,(%esi)
Code;  c01168e4 <__out_of_line_bug+14/20>
   5:   5e                        pop    %esi
Code;  c01168e5 <__out_of_line_bug+15/20>
   6:   26                        es
Code;  c01168e6 <__out_of_line_bug+16/20>
   7:   c0 eb fe                  shr    $0xfe,%bl
Code;  c01168e9 <__out_of_line_bug+19/20>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01168f0 <do_syslog+0/2e0>
  11:   83 ec 18                  sub    $0x18,%esp


1 warning issued.  Results may not be reliable.

--=-=-=--

