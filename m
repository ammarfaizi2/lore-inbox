Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264243AbTEaJDF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTEaJDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:03:05 -0400
Received: from tag.witbe.net ([81.88.96.48]:41222 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264243AbTEaJC7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:02:59 -0400
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.5.70] - APIC error on CPU0: 00(40)
Date: Sat, 31 May 2003 11:16:18 +0200
Message-ID: <006c01c32755$4baabd10$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've configured and started a 2.5.70, with the same .config I was
using for 2.5.69...

After booting, I found the following messages :

APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
last message repeated 5 times

at boot time...

The dmesg output is just below. The machine is a P4 2.4GHz, on an
Asus P4S8X mobo.

What is it ? Can I safely ignore them ?

I also have a very strange :
USB scanner device (0x03f0/0x2005) now attached to ^ER^VÀ\2003¸ß\200 ¸ß\2003¸ß<7OÀØ6OÀÀ6OÀ

though I had :
USB scanner device (0x03f0/0x2005) now attached to usb/scanner0
with a 2.5.69

Regards,
Paul


klogd 1.4.1, log source = /proc/kmsg started.
 CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

syslog: klogd startup succeeded
portmap: portmap startup succeeded
nfslock: rpc.statd startup succeeded
rpc.statd[336]: Version 1.0.1 Starting
keytable: Loading keymap: 
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2423.0446 MHz.
..... host bus clock speed is 134.0635 MHz.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf11a0, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
keytable: [  
keytable: 
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
keytable: Loading system font: 
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
keytable: 
ACPI: Subsystem revision 20030522
rc: Starting keytable succeeded
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
random: Initializing random number generator:  succeeded
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
netfs: Mounting other filesystems:  succeeded
Enabling SiS 96x SMBus.
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
autofs: automount startup succeeded
ACPI: No IRQ known for interrupt pin A of device 00:03.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O].
udf: registering filesystem
Capability LSM initialized
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Unsupported SiS chipset (device id: 0648), you might want to try agp_try_unsupported=1.
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, HEWLETT-PACKARD DESKJET 920C
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905 Boomerang 100baseTx at 0x7400. Vers LK1.1.19
eth0: Dropping NETIF_F_SG since no checksum feature.
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100%% native mode: will probe irqs later
SiS648    ATA 133 (2nd gen) controller
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD800BB-00CAA1, ATA DISK drive
hdb: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8584A, ATAPI CD/DVD-ROM drive
hdd: TDK CDRW4800B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 > hda4
hdb: max request size: 128KiB
hdb: host protected area => 1
hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 >
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.33
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAN3367MP         Rev: 5507
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ehci-hcd 00:03.3: Silicon Integrated S SiS7002 USB 2.0
ehci-hcd 00:03.3: irq 23, pci mem e081e000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci-hcd 00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 00:03.3
ehci-hcd 00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
ACPI: No IRQ known for interrupt pin A of device 00:03.0
ohci-hcd 00:03.0: Silicon Integrated S 7001
ohci-hcd 00:03.0: irq 9, pci mem e0820000
ohci-hcd 00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
ohci-hcd 00:03.1: Silicon Integrated S 7001 (#2)
ohci-hcd 00:03.1: irq 21, pci mem e0822000
ohci-hcd 00:03.1: new USB bus registered, assigned bus number 3
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
ohci-hcd 00:03.2: Silicon Integrated S 7001 (#3)
ohci-hcd 00:03.2: irq 22, pci mem e0824000
ohci-hcd 00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.11:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 12
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
i2c /dev entries driver module version 2.7.0 (20021208)
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
ALSA device list:
  #0: Sound Blaster Live! (rev.7) at 0x8000, irq 17
NET4: Linux TCP/IP 1.0 for NET4.0
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 392k freed
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2

->
APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
last message repeated 11 times

<-

drivers/usb/image/scanner.c: USB scanner device (0x03f0/0x2005) now attached to ^ER^VÀ\2003¸ß\200 ¸ß\2003¸ß<7OÀØ6OÀÀ6OÀ
hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 4-0:0: new USB device on port 1, assigned address 2

->
APIC error on CPU0: 40(40)
last message repeated 5 times
<-

Adding 2096440k swap on /dev/hda6.  Priority:-1 extents:1
Adding 530104k swap on /dev/hdb1.  Priority:-2 extents:1
Adding 1049576k swap on /dev/sda5.  Priority:-3 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
reiserfs: checking transaction log (sda6) for (sda6)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
reiserfs: checking transaction log (hdb6) for (hdb6)
Using r5 hash to sort names
Disabled Privacy Extensions on device c04eab00(lo)
network: Setting network parameters:  succeeded 
network: Bringing up loopback interface:  succeeded 
xinetd[465]: xinetd Version 2.3.7 started with libwrap options compiled in.
xinetd[465]: Started working: 2 available services
xinetd: xinetd startup succeeded
ntpd: ntpd startup succeeded
ntpd[477]: ntpd 4.1.1a@1.791 Sat Aug 31 18:27:29 EDT 2002 (1)
lpd: lpd startup succeeded
ntpd[477]: precision = 9 usec
ntpd[477]: kernel time discipline status 0040
ntpd[477]: frequency initialized -111.090 from /etc/ntp/drift
sendmail: sendmail startup succeeded
sendmail: sm-client startup succeeded
crond: crond startup succeeded
xfs: listening on port 7100 
xfs: xfs startup succeeded
anacron: anacron startup succeeded
atd: atd startup succeeded
xfs: ignoring font path element /usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
local: sshd2 startup succeeded
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?

