Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRE3Osk>; Wed, 30 May 2001 10:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261247AbRE3Os3>; Wed, 30 May 2001 10:48:29 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:42891 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261198AbRE3OsR>; Wed, 30 May 2001 10:48:17 -0400
Message-ID: <000e01c0e917$60fbacc0$0a01a8c0@w98>
From: "Rose, Daniel" <daniel.rose@datalinesolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: via-rhine DFE-530TX rev A1
Date: Wed, 30 May 2001 10:46:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems as though my card will not reset anymore after running windows 98,
even after a cold boot, and recompiling the kernel. Below is the output of
dmesg, lspci -n and ifconfig. Does anyone have any ideas? (please cc
replies)

Linux version 2.4.5 (root@rocket) (gcc version 2.95.3 20010315 (release)) #4
Tue May 29 13:34:48 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff8000 (ACPI data)
 BIOS-e820: 0000000017ff8000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.4.5 ro root=342
BOOT_FILE=/boot/vmlinuz-2.4.5 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 866.680 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1730.15 BogoMIPS
Memory: 384368k/393152k available (1079k kernel code, 8396k reserved, 348k
data, 204k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Disabled enhanced CPU to PCI posting
PCI: Disabled enhanced CPU to PCI posting #2
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by
other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, Canon BJC-1000
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 255210kB/124138kB, 768 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
hda: FUJITSU MPG3204AH, ATA DISK drive
hdb: WDC WD307AA, ATA DISK drive
hdc: CDU5211, ATAPI CD/DVD-ROM drive
hdd: MATSHITA CD-RW CW-7586, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40031712 sectors (20496 MB) w/2048KiB Cache, CHS=2491/255/63
hdb: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63
hdc: ATAPI 52X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1
 hdb: hdb1 hdb2 hdb3 < hdb5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
via-rhine.c:v1.08b-LK1.1.8  4/17/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 10 for device 00:11.0
PCI: The same IRQ used for device 00:07.2
eth0: VIA VT6102 Rhine-II at 0xd000, 00:00:00:00:00:00, IRQ 10.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xe8000000 64MB
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
[drm] AGP 0.99 on VIA Apollo Pro @ 0xe8000000 64MB
[drm] Initialized radeon 1.0.0 20010105 on minor 62
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: CD-RW  CW-7586    Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 8x/32x writer cd/rw xa/form2 cdda tray
es1371: version v0.30 time 20:29:48 May 28 2001
PCI: Found IRQ 11 for device 00:0e.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xd800 irq 11
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 393552k swap-space (priority -1)
pppoe uses obsolete (PF_INET,SOCK_PACKET)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
cdrom: This disc doesn't have any tracks I recognize!

00:00.0 Class 0600: 1106:0691 (rev c4)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0686 (rev 40)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 16)
00:07.4 Class 0c05: 1106:3057 (rev 40)
00:0e.0 Class 0401: 1274:5880 (rev 02)
00:10.0 Class 0780: 125d:2898 (rev 03)
00:11.0 Class 0200: 1106:3065 (rev 42)
01:00.0 Class 0300: 1002:5246

eth0      Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          UP BROADCAST RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:10 Base address:0xd000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0



