Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUBJQxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUBJQxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:53:31 -0500
Received: from ns.suse.de ([195.135.220.2]:1488 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266003AbUBJQwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:52:05 -0500
Date: Tue, 10 Feb 2004 17:52:02 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: ieee1394 and fbdev oops in 2.6.3rc2
Message-ID: <20040210165202.GA7590@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The same config worked ok with 2.6.3rc1.


Total memory = 1792MB; using 4096kB for hash table (at c0800000)
Linux version 2.6.3-rc2-olh (olaf@nectarine) (gcc version 3.2.3 (SuSE Linux)) #1
 Tue Feb 10 15:58:16 CET 2004
Found UniNorth memory controller & host bridge, revision: 3
Mapped at 0xfdfc0000
Found a Keylargo mac-io controller, rev: 2, mapped at 0xfdf40000
PowerMac motherboard: PowerMac G4 AGP Graphics
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=46, gen1=45
nvram: Active bank is: 0
nvram: OF partition at 0x210
nvram: XP partition at 0x1220
nvram: NR partition at 0x1320
On node 0 totalpages: 458752
  DMA zone: 196608 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 262144 pages, LIFO batch:16
Built 1 zonelists
Kernel command line: root=/dev/hda11 video=aty128fb:vmode:17 
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc6f1000
OpenPIC timer frequency is 2147.483648 MHz
PID hash table entries: 4096 (order 12: 32768 bytes)
GMT Delta read from XPRAM: 120 minutes, DST: on
via_calibrate_decr: ticks per jiffy = 24907 (1494453 ticks)
Console: colour dummy device 80x25
Memory: 1808000k available (1604k kernel code, 1336k data, 124k init, 1048576k h
ighmem)
AGP special page: 0xeffff000
Calibrating delay loop... 894.97 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs... it is
Freeing initrd memory: 656k freed
POSIX conformance testing by UNIFIX
do_initcalls
init_elf_binfmt
NET: Registered protocol family 16
PCI: Probing PCI hardware
 ... the first call_usermodehelper: pci_bus
Fixing up IO bus PCI Bus #02
PCI: Enabling device 0001:02:03.0 (0014 -> 0017)
Registering openpic with sysfs...
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
fb0: ATY Rage128 frame buffer device on Rage128 Pro PF (AGP)
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
Initializing Cryptographic API
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:0a:27:e2:f3:3e 
PHY ID: 406212, addr: 0
eth0: Found BCM5201 PHY
MacIO PCI driver attached to Keylargo chipset
preparing mdev @effa3000, ofdev @effa3008, dev @effa3018, kobj @effa303c
preparing mdev @c2ab5c00, ofdev @c2ab5c08, dev @c2ab5c18, kobj @c2ab5c3c
preparing mdev @c2ab5800, ofdev @c2ab5808, dev @c2ab5818, kobj @c2ab583c
preparing mdev @c2ab5400, ofdev @c2ab5408, dev @c2ab5418, kobj @c2ab543c
preparing mdev @c2ab5000, ofdev @c2ab5008, dev @c2ab5018, kobj @c2ab503c
preparing mdev @c2ab2c00, ofdev @c2ab2c08, dev @c2ab2c18, kobj @c2ab2c3c
preparing mdev @c2ab2800, ofdev @c2ab2808, dev @c2ab2818, kobj @c2ab283c
preparing mdev @c2ab2400, ofdev @c2ab2408, dev @c2ab2418, kobj @c2ab243c
preparing mdev @c2ab2000, ofdev @c2ab2008, dev @c2ab2018, kobj @c2ab203c
preparing mdev @c2aabc00, ofdev @c2aabc08, dev @c2aabc18, kobj @c2aabc3c
preparing mdev @c2aab800, ofdev @c2aab808, dev @c2aab818, kobj @c2aab83c
preparing mdev @c2aab400, ofdev @c2aab408, dev @c2aab418, kobj @c2aab43c
preparing mdev @c2aab000, ofdev @c2aab008, dev @c2aab018, kobj @c2aab03c
input: Macintosh mouse button emulation
apm_emu: APM Emulation 0.5 initialized.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
adb: starting probe task...
adb: finished probe task...
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2
Probing IDE interface ide0...
hda: WDC WD273BA, ATA DISK drive
hdb: WDC WD273BA, ATA DISK drive
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hda: Enabling Ultra DMA 4
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hdb: Enabling Ultra DMA 4
Using anticipatory io scheduler
ide0 at 0xf2207000-0xf2207007,0xf2207160 on irq 19
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0
Probing IDE interface ide1...
hdc: MATSHITAPD-2 LF-D110, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
hdc: Set MDMA timing for mode 2, reg: 0x00011d26
hdc: Enabling MultiWord DMA 2
ide1 at 0xf220c000-0xf220c007,0xf220c160 on irq 20
ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1
Probing IDE interface ide2...
ide2: Bus empty, interface released.
hda: max request size: 128KiB
hda: 53464320 sectors (27373 MB) w/1961KiB Cache, CHS=53040/16/63, UDMA(66)
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12
hdb: max request size: 128KiB
hdb: 53464320 sectors (27373 MB) w/1961KiB Cache, CHS=53040/16/63, UDMA(66)
 hdb: [mac] hdb1 hdb2 hdb3 hdb4 hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11
Console: switching to colour frame buffer device 128x48
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Enabling device 0001:02:08.0 (0000 -> 0002)
ohci_hcd 0001:02:08.0: OHCI Host Controller
ohci_hcd 0001:02:08.0: irq 27, pci mem f2211000
ohci_hcd 0001:02:08.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0001:02:09.0 (0000 -> 0002)
ohci_hcd 0001:02:09.0: OHCI Host Controller
ohci_hcd 0001:02:09.0: irq 28, pci mem f2213000
ohci_hcd 0001:02:09.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Freeing unused kernel memory: 124k init 4k chrp 8k prep
SCSI subsystem initialized
st: Version 20040122, fixed bufsize 32768, s/g segs 256
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

usb 1-1: new full speed USB device using address 2
usb 2-1: new full speed USB device using address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
usb 2-1.1: new low speed USB device using address 3
input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0001:02:
09.0-1.1
usb 2-1.2: new low speed USB device using address 4
input: USB HID v1.00 Mouse [Mitsumi Apple USB Mouse] on usb-0001:02:09.0-1.2
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: IBM       Model: DNES-309170       Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as devic
e
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: PD-2 LF-D110      Rev: A105
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 0x/0x dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 100           Rev: 14.A
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Apple UniNorth chipset
agpgart: Maximum main memory to use for agp memory: 1675M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0001:02:0a.0 (0010 -> 0012)
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-800807ff]  Max
 Packet=[2048]
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0001a30000009a06]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[000a27fffee2f33e]
Badness in kobject_get at lib/kobject.c:434
Call trace:
 [<c000b798>] dump_stack+0x18/0x28
 [<c0008b04>] check_bug_trap+0x8c/0xb0
 [<c0008c58>] ProgramCheckException+0x130/0x170
 [<c0008214>] ret_from_except_full+0x0/0x4c
 [<c00a8494>] kobject_get+0x14/0x30
 [<c00cd1bc>] bus_for_each_dev+0x78/0x114
 [<f23d96dc>] nodemgr_node_probe+0x58/0x124 [ieee1394]
 [<f23d9ae4>] nodemgr_host_thread+0x13c/0x1c4 [ieee1394]
 [<c000ae50>] kernel_thread+0x44/0x60
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 2C030000 LR: C00A855C SP: EFD3FF20 REGS: efd3fe70 TRAP: 0401    Not tainted
MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0763860[3041] 'knodemgrd_0' Last syscall: -1 
GPR00: 2C030000 EFD3FF20 C0763860 F2428594 EFD3FF98 EFD3FF98 F23D951C 00000000 
GPR08: 00000010 F24285AC 00000000 C00CD144 C2BBDA20 
Call trace:
 [<c00cc110>] put_device+0x14/0x24
 [<c00cd1d8>] bus_for_each_dev+0x94/0x114
 [<f23d96dc>] nodemgr_node_probe+0x58/0x124 [ieee1394]
 [<f23d9ae4>] nodemgr_host_thread+0x13c/0x1c4 [ieee1394]
 [<c000ae50>] kernel_thread+0x44/0x60
sbp2: $Rev: 1096 $ Ben Collins <bcollins@debian.org>
drivers/usb/net/pegasus.c: v0.5.12 (2003/06/06):Pegasus/Pegasus II USB Ethernet 
driver
eth1: D-Link DSB-650TX
drivers/usb/core/usb.c: registered new driver pegasus
PHY ID: 406212, addr: 0
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
nfs warning: mount version older than kernel
process `host' is using obsolete setsockopt SO_BSDCOMPAT
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
[drm] Initialized r128 2.5.0 20030725 on minor 0
agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
Oops: Exception in kernel mode, sig: 4 [#2]
NIP: C0101000 LR: C0100F90 SP: EF185CF0 REGS: ef185c40 TRAP: 0700    Not tainted
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = ef1938a0[4325] 'X' Last syscall: 54 
GPR00: 00000002 EF185CF0 EF1938A0 EFFA3C00 EF185CF8 00000000 EF185D94 00000000 
GPR08: 00000000 FFFFFF00 00000001 00000000 28004884 101E6A58 101EEE08 101EED88 
GPR16: 101EF108 101EEF88 101EEE08 7FFFF438 101ECCF8 101E0000 101E0000 101E0000 
GPR24: 00000001 C02EBA40 000000A0 00000040 00000400 00000010 EFFA3C00 00000008 
Call trace:
 [<c01011ac>] fbcon_switch+0x11c/0x288
 [<c00c56c4>] redraw_screen+0x1c0/0x22c
 [<c00c027c>] complete_change_console+0x44/0xf8
 [<c00bfa34>] vt_ioctl+0x16c0/0x1d60
 [<c00b8604>] tty_ioctl+0x160/0x5d4
 [<c006c51c>] sys_ioctl+0xdc/0x2fc
 [<c0007c7c>] ret_from_syscall+0x0/0x44


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
