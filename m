Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTFOB3B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 21:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTFOB3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 21:29:01 -0400
Received: from iucha.net ([209.98.146.184]:2922 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S261741AbTFOB2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 21:28:33 -0400
Date: Sat, 14 Jun 2003 20:42:21 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
Message-ID: <20030615014221.GA25303@iucha.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnGs129iAKyuXRcc"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QnGs129iAKyuXRcc
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2003 at 02:17:32PM -0700, Linus Torvalds wrote:
> I think I'll call this kernel the "sticky turtle"...

I booted 2.5.71 and in 3-4 minutes my X froze. I did a SysReq-S and a
SysReq-T.

SysReq-T unfroze the box. I logged out from Gnome, went into a console
and attempted to login. In the middle of typing the id, the nfs/rpc=20
oops came, then the big oops and the box locked up.

2.5.70-bk13 is rock solid for me (workstation load).

florin

Linux version 2.5.71 (root@beaver) (gcc version 3.3 (Debian)) #2 Sat Jun 14=
 19:06:23 CDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ee000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
 BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
767MB LOWMEM available.
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192496 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                        ) @ 0x000fa340
ACPI: RSDT (v001 AMIINT SiS735XX 00000.04096) @ 0x2fff0000
ACPI: FADT (v001 AMIINT SiS735XX 00000.04096) @ 0x2fff0030
ACPI: DSDT (v001    SiS      735 00000.00256) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=3D/dev/hda1 console=3DttyS1,57600n8 console=3Dtty0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1195.238 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2359.29 BogoMIPS
Memory: 774172k/786368k available (2334k kernel code, 11404k reserved, 801k=
 data, 156k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1194.0703 MHz.
=2E.... host bus clock speed is 199.0117 MHz.
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
spurious 8259A interrupt: IRQ7.
ACPI: Subsystem revision 20030522
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 *11 12 14 15)
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS for Linux 2.5.71 with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd800, IRQ 12, 00:07:95:51:00:34.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735    ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8584A, ATAPI CD/DVD-ROM drive
hdd: MAXTOR 6L080L4, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area =3D> 1
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=3D158816/16/63, UDMA=
(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdd: max request size: 128KiB
hdd: host protected area =3D> 1
hdd: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=3D155114/16/63, UDMA=
(100)
 hdd: hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 hdd11 hdd12 hdd13 hdd14 > =
hdd3 hdd4
scsi0 : AdvanSys SCSI 3.3GJ: PCI Ultra-Wide: PCIMEM 0xF0807F00-0xF0807F3F, =
IRQ 0xC
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 01931-XXX  Rev: 5.63
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 5
Attached scsi generic sg1 at scsi0, channel 0, id 5, lun 0,  type 1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 3.0.0-ioctl (2003-03-28) initialised: dm@uk.sistina.com
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
XFS mounting filesystem hda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 497972k swap on /dev/hda5.  Priority:-1 extents:1
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
uhci-hcd 0000:00:09.0: VIA Technologies, In USB
uhci-hcd 0000:00:09.0: irq 5, io base 0000d000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 0000:00:09.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:09.1: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:09.1: irq 12, io base 0000d400
uhci-hcd 0000:00:09.1: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
ohci-hcd 0000:00:02.2: Silicon Integrated S 7001
ohci-hcd 0000:00:02.2: irq 11, pci mem f084d000
ohci-hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 3 ports detected
ohci-hcd 0000:00:02.3: Silicon Integrated S 7001 (#2)
ohci-hcd 0000:00:02.3: irq 11, pci mem f084f000
ohci-hcd 0000:00:02.3: new USB bus registered, assigned bus number 4
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
hub 1-1:0: USB hub found
hub 1-1:0: 4 ports detected
hub 4-0:0: USB hub found
hub 4-0:0: 3 ports detected
ehci-hcd 0000:00:09.2: VIA Technologies, In USB 2.0
ehci-hcd 0000:00:09.2: irq 11, pci mem f0853e00
ehci-hcd 0000:00:09.2: new USB bus registered, assigned bus number 5
ehci-hcd 0000:00:09.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jan-22
hub 5-0:0: USB hub found
hub 5-0:0: 4 ports detected
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.13:USB Scanner Driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 735 chipset
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] Initialized radeon 1.8.0 20020828 on minor 0
i2c /dev entries driver module version 2.7.0 (20021208)
registering 0-0290
ohci1394: $Rev: 948 $ Ben Collins <bcollins@debian.org>
hub 1-0:0: debounce: port 2: delay 400ms stable 0 status 0x100
hub 1-0:0: connect-debounce failed, port 2 disabled
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[12]  MMIO=3D[cffff000-cffff7ff]  Ma=
x Packet=3D[2048]
Linux video capture interface: v1.00
bttv: driver version 0.9.4 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
hub 5-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
bttv: Host bridge is Silicon Integrated S 735 Host
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 00:0f.0, irq: 11, latency: 64, mmio: 0xcfbfe000
bttv0: detected: ATI TV Wonder/VE [card=3D64], PCI subsystem ID is 1002:0003
bttv0: using: BT878(ATI TV-Wonder VE) [card=3D64,insmod option]
tuner: chip found @ 0xc0
tuner(bttv): type forced to 2 (Philips NTSC (FI1236,FM1236 and compatibles)=
) [insmod]
registering 1-0060
tuner: type already set (2)
bttv0: using tuner=3D19
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 =3D> 35468950 ..<6>hub 5-0:0: debounce: port 2: delay =
100ms stable 4 status 0x501
 ok
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hub 5-0:0: new USB device on port 2, assigned address 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: Generic   Model: STORAGE DEVICE    Rev: 0119
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
hub 4-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 4-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse=AE Explorer] o=
n usb-00:02.3-1
usb 1-1: USB disconnect, address 2
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 3
hub 1-1:0: USB hub found
hub 1-1:0: 4 ports detected
cdrom: open failed.
XFS mounting filesystem hda6
XFS mounting filesystem hda7
XFS mounting filesystem hda8
XFS mounting filesystem hda9
Starting XFS recovery on filesystem: hda9 (dev: 3/9)
Ending XFS recovery on filesystem: hda9 (dev: 3/9)
XFS mounting filesystem hda10
XFS mounting filesystem hda11
eth0: Media Link On 100mbps full-duplex=20
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 01:00.0 into 2x mode
[drm] Loading R200 Microcode
SysRq : Emergency Sync
atkbd.c: Unknown key (set 2, scancode 0x1b7, on isa0060/serio0) pressed.
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unR=
aw Sync showTasks Unmount=20
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          R EF9965C0 4294956888     1      0     2               (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

ksoftirqd/0   R C0450728 4294952576     2      1             3       (L-TLB)
Call Trace:
 [<c0121176>] tasklet_action+0x46/0x70
 [<c012138f>] ksoftirqd+0xaf/0xc0
 [<c01212e0>] ksoftirqd+0x0/0xc0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

events/0      R C03C8F40 4294944868     3      1             4     2 (L-TLB)
Call Trace:
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c0262da0>] batch_entropy_process+0x0/0xd0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

khubd         S EFD21F9E 4292416496     4      1             5     3 (L-TLB)
Call Trace:
 [<c02c5d5e>] hub_thread+0xce/0xf0
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c02c5c90>] hub_thread+0x0/0xf0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

pdflush       R EFCEE000 4292213248     5      1             6     4 (L-TLB)
Call Trace:
 [<c011eaf2>] daemonize+0xd2/0xe0
 [<c013b410>] pdflush+0x0/0x20
 [<c013b2cf>] __pdflush+0x8f/0x1d0
 [<c013b410>] pdflush+0x0/0x20
 [<c013b41f>] pdflush+0xf/0x20
 [<c0151aa0>] do_sync+0x0/0x80
 [<c0108a68>] kernel_thread_helper+0x0/0x18
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

pdflush       R 00000000 4294951360     6      1             7     5 (L-TLB)
Call Trace:
 [<c013b2cf>] __pdflush+0x8f/0x1d0
 [<c013b410>] pdflush+0x0/0x20
 [<c013b41f>] pdflush+0xf/0x20
 [<c013acf0>] wb_kupdate+0x0/0x110
 [<c0108a68>] kernel_thread_helper+0x0/0x18
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

kswapd0       S EFCE8000 4294944704     7      1             8     6 (L-TLB)
Call Trace:
 [<c011eaf2>] daemonize+0xd2/0xe0
 [<c01401eb>] kswapd+0xeb/0x130
 [<c011a14a>] preempt_schedule+0x2a/0x50
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c0140100>] kswapd+0x0/0x130
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

aio/0         S EFCE6000 4294938048     8      1             9     7 (L-TLB)
Call Trace:
 [<c0128ce5>] do_sigaction+0x185/0x260
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfslogd/0     S EFC516D8 4294931392     9      1            10     8 (L-TLB)
Call Trace:
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c021b000>] pagebuf_iodone_work+0x0/0x60
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfsdatad/0    S EFCE2000 4294924736    10      1            11     9 (L-TLB)
Call Trace:
 [<c0128ce5>] do_sigaction+0x185/0x260
 [<c012bc2e>] worker_thread+0x29e/0x2d0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c012b990>] worker_thread+0x0/0x2d0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

pagebufd      R C045DE4C 4294951280    11      1            12    10 (L-TLB)
Call Trace:
 [<c0297065>] ide_do_request+0x205/0x3a0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a4ff>] interruptible_sleep_on+0x4f/0x90
 [<c011a170>] default_wake_function+0x0/0x30
 [<c021bc9e>] pagebuf_daemon+0x21e/0x240
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c021ba50>] pagebuf_daemon_wakeup+0x0/0x30
 [<c021ba80>] pagebuf_daemon+0x0/0x240
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

scsi_eh_0     S 00000046 4294543216    12      1            13    11 (L-TLB)
Call Trace:
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<c02ac90a>] .text.lock.scsi_error+0x41/0x77
 [<c02ac510>] scsi_error_handler+0x0/0x1c0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

kseriod       S EFC38000 4294416308    13      1            14    12 (L-TLB)
Call Trace:
 [<c011eaf2>] daemonize+0xd2/0xe0
 [<c02d7a87>] serio_thread+0x137/0x140
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<c011a170>] default_wake_function+0x0/0x30
 [<c02d7950>] serio_thread+0x0/0x140
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     R EFC4BD30 4291605360    14      1            77    13 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

knodemgrd_0   S EF00A60C 4287395256    77      1           103    14 (L-TLB)
Call Trace:
 [<c0185139>] sysfs_symlink+0x69/0x80
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<f091224e>] .text.lock.nodemgr+0x37/0xa9 [ieee1394]
 [<f0911c10>] nodemgr_host_thread+0x0/0x170 [ieee1394]
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

usb-storage   S 00000020 4292919536   103      1           104    77 (L-TLB)
Call Trace:
 [<f0885d45>] usb_stor_invoke_transport+0x205/0x2d0 [usb_storage]
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0119806>] wake_up_process+0x26/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<f08873fb>] .text.lock.usb+0x5/0x5a [usb_storage]
 [<c010a93e>] ret_from_fork+0x6/0x14
 [<f08868c0>] usb_stor_control_thread+0x0/0x250 [usb_storage]
 [<f08868c0>] usb_stor_control_thread+0x0/0x250 [usb_storage]
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

scsi_eh_1     S 00000046 4292912884   104      1           171   103 (L-TLB)
Call Trace:
 [<c0109947>] __down_interruptible+0xa7/0x130
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0109a47>] __down_failed_interruptible+0x7/0xc
 [<c02ac90a>] .text.lock.scsi_error+0x41/0x77
 [<c02ac510>] scsi_error_handler+0x0/0x1c0
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     R EF172D30 4284607832   171      1           172   104 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     R EF64B1C0 4292350588   172      1           173   171 (L-TLB)
Call Trace:
 [<c0208c3e>] xfs_getsb+0x2e/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     R 00000001 4292424704   173      1           174   172 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     R 00000001 4291623152   174      1           175   173 (L-TLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     R EEE42A80 4294951048   175      1           176   174 (L-TLB)
Call Trace:
 [<c0208c3e>] xfs_getsb+0x2e/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

xfs_syncd     R EEE42880 4294714996   176      1           222   175 (L-TLB)
Call Trace:
 [<c0208c3e>] xfs_getsb+0x2e/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0224715>] syncd+0x45/0x90
 [<c02246d0>] syncd+0x0/0x90
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

dhclient      S C03986E4 4294177392   222      1           226   176 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

portmap       S 00000246 4293618932   226      1           300   222 (NOTLB)
Call Trace:
 [<c02ff864>] tcp_poll+0x34/0x160
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c014fb21>] sys_close+0x61/0xa0
 [<c010aa67>] syscall_call+0x7/0xb

syslog-ng     R EB656CD8 4293065200   300      1           304   226 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

rpc.statd     S C03986E4 4290934896   304      1           311   300 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff864>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

acpid         S 00000000 4292064240   311      1           391   304 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

automount     S BFFFFB94 4289875456   391      1   766     395   311 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c015ca34>] pipe_poll+0x34/0x80
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gpm           R 00000000 4276172544   395      1           400   391 (NOTLB)
Call Trace:
 [<c010cf6c>] do_IRQ+0xfc/0x130
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c0150498>] vfs_write+0xb8/0x130
 [<c010aa67>] syscall_call+0x7/0xb

inetd         S 40049000 4276089652   400      1           406   395 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff864>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

lpd           S C03986E4 4294681008   406      1           494   400 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff864>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c02e2407>] sys_socketcall+0xd7/0x2a0
 [<c0145414>] sys_munmap+0x44/0x70
 [<c010aa67>] syscall_call+0x7/0xb

master        R EE4BFECC 4292963760   494      1   497     500   406 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

pickup        R C03986E4 4287760368   497    494           498       (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

nqmgr         S C03986E4 4293060528   498    494                 497 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c014fb21>] sys_close+0x61/0xa0
 [<c010aa67>] syscall_call+0x7/0xb

nmbd          R C03986E4 4289412804   500      1           506   494 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

sshd          S C03984CC 4290568560   506      1           572   500 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02ff864>] tcp_poll+0x34/0x160
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c0145414>] sys_munmap+0x44/0x70
 [<c010aa67>] syscall_call+0x7/0xb

bash          S C011FC9E 4289707424   570      1   573     584   572 (NOTLB)
Call Trace:
 [<c011fc9e>] wait_task_zombie+0x13e/0x190
 [<c0120024>] sys_wait4+0x194/0x260
 [<c0129130>] sys_rt_sigaction+0xe0/0xf0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010aa67>] syscall_call+0x7/0xb

Xprt          S C03986E4 126208   572      1           570   506 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

tee           S EDE37404 4294359344   573    570           574       (NOTLB)
Call Trace:
 [<c014184b>] zap_pmd_range+0x4b/0x70
 [<c015c43b>] pipe_wait+0x7b/0xa0
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c015c59f>] pipe_read+0x13f/0x240
 [<c014507b>] unmap_region+0x9b/0xe0
 [<c0144f70>] unmap_vma+0x40/0x80
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

logger        S EDF8F240 4286863796   574    570                 573 (NOTLB)
Call Trace:
 [<c014404a>] __vma_link+0x3a/0xa0
 [<c015c43b>] pipe_wait+0x7b/0xa0
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c015c59f>] pipe_read+0x13f/0x240
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

ntpd          R C03986E4 4292454128   584      1           588   570 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e677b>] datagram_poll+0x2b/0xf0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c01504b1>] vfs_write+0xd1/0x130
 [<c010aa67>] syscall_call+0x7/0xb

usbmgr        S EDEA6140 4285929840   588      1           592   584 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c02cfcb0>] usb_device_lseek+0x0/0x9d
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

atd           S EDB79F20 4291209008   592      1           596   588 (NOTLB)
Call Trace:
 [<c012ee39>] do_clock_nanosleep+0x199/0x2f0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0129130>] sys_rt_sigaction+0xe0/0xf0
 [<c012ea90>] nanosleep_wake_up+0x0/0x10
 [<c012eb52>] sys_nanosleep+0x92/0xe0
 [<c010aa67>] syscall_call+0x7/0xb

cron          R EDB05F20 4290736952   596      1           601   592 (NOTLB)
Call Trace:
 [<c012ee39>] do_clock_nanosleep+0x199/0x2f0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c0129130>] sys_rt_sigaction+0xe0/0xf0
 [<c012ea90>] nanosleep_wake_up+0x0/0x10
 [<c012eb52>] sys_nanosleep+0x92/0xe0
 [<c010aa67>] syscall_call+0x7/0xb

gdm           S EDB7F818 4286456048   601      1   603     605   596 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gdm           S 00000004 4279913840   603    601   611               (NOTLB)
Call Trace:
 [<c0128928>] sys_kill+0x58/0x60
 [<c0120024>] sys_wait4+0x194/0x260
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4258950400   605      1           606   601 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4287021648   606      1           607   605 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4285508912   607      1           608   606 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4286313200   608      1           609   607 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4280158064   609      1           610   608 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

getty         S 00000008 4286535920   610      1           649   609 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

XFree86       R BFFFF450 4294951088   611    603           618       (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

gnome-session S EB656E58 4248568304   618    603   646           611 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

ssh-agent     R C03986E4 4271576652   646    618                     (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0332b8b>] unix_poll+0x2b/0xa0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

gconfd-2      R EB656B58 4260567216   649      1           651   610 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

bonobo-activa S EB6560D8 4265405616   651      1           653   649 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gnome-setting S 00000000 4294951024   653      1           659   651 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

xscreensaver  R C03986E4 4290819596   659      1           662   653 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

gnome-smproxy S C03986E4 4285197424   662      1           664   659 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0332b8b>] unix_poll+0x2b/0xa0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0162aef>] do_select+0x18f/0x2d0
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c0162f1f>] sys_select+0x2bf/0x4c0
 [<c010aa67>] syscall_call+0x7/0xb

metacity      S EAA439D8 4283257556   664      1           666   662 (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gnome-panel   R 00000000 4276500592   666      1           668   664 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

mixer_applet2 R 00000000 4294951408   668      1           670   666 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

multiload-app R 00000000 4293371888   670      1           672   668 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gnome-termina R E9426000 4291661296   672      1   673     692   670 (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c025cde0>] tty_poll+0x60/0x80
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

gnome-pty-hel S EF3E2C00 4221940400   673    672           674       (NOTLB)
Call Trace:
 [<c020cea8>] xfs_trans_tail_ail+0x28/0x60
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c033235b>] unix_stream_data_wait+0xcb/0x120
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c010b3f6>] apic_timer_interrupt+0x1a/0x20
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c03328c2>] unix_stream_recvmsg+0x512/0x570
 [<c020c680>] xfs_trans_commit+0x230/0x3c0
 [<c02e07a8>] sock_aio_read+0xb8/0xd0
 [<c01501bb>] do_sync_read+0x8b/0xc0
 [<c020d169>] xfs_trans_unlocked_item+0x39/0x60
 [<c01668e2>] dput+0x22/0x200
 [<c01502e0>] vfs_read+0xf0/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

bash          S 00000000 4286157808   674    672                 673 (NOTLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c0135da5>] unlock_page+0x15/0x60
 [<c0260ee1>] read_chan+0x6e1/0x860
 [<c02611c2>] write_chan+0x162/0x230
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c025bb24>] tty_write+0x1e4/0x300
 [<c0260800>] read_chan+0x0/0x860
 [<c025b91c>] tty_read+0x11c/0x140
 [<c025b940>] tty_write+0x0/0x300
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

rpciod        S E8E0C000 4293119408   692      1           693   672 (L-TLB)
Call Trace:
 [<c033ac13>] __rpc_schedule+0xe3/0x120
 [<c033b66b>] rpciod+0x1fb/0x250
 [<c011a170>] default_wake_function+0x0/0x30
 [<c033b470>] rpciod+0x0/0x250
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

lockd         S 00000000 4293058996   693      1           699   692 (L-TLB)
Call Trace:
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c033df59>] svc_sock_release+0xc9/0x1e0
 [<c033fae9>] svc_recv+0x3d9/0x520
 [<c014fa82>] filp_close+0x92/0xd0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011e874>] reparent_to_init+0xe4/0x170
 [<c011a170>] default_wake_function+0x0/0x30
 [<c01a8fd9>] lockd+0x109/0x250
 [<c01a8ed0>] lockd+0x0/0x250
 [<c0108a6d>] kernel_thread_helper+0x5/0x18

run-mozilla.s S E8E15FC4 4293155248   699      1   724           693 (NOTLB)
Call Trace:
 [<c0120024>] sys_wait4+0x194/0x260
 [<c0129130>] sys_rt_sigaction+0xe0/0xf0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c010aa67>] syscall_call+0x7/0xb

MozillaFirebi S E90E6058 4284013040   724    699   727               (NOTLB)
Call Trace:
 [<c0139cca>] __get_free_pages+0x1a/0x50
 [<c0162835>] __pollwait+0x85/0xd0
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c015ca34>] pipe_poll+0x34/0x80
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

MozillaFirebi R BEC00000 4283369392   727    724   728               (NOTLB)
Call Trace:
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

MozillaFirebi R 00200246 4285790576   728    727           729       (NOTLB)
Call Trace:
 [<c02ff864>] tcp_poll+0x34/0x160
 [<c01252c1>] schedule_timeout+0xb1/0xc0
 [<c02e0dc9>] sock_poll+0x29/0x40
 [<c016316f>] do_pollfd+0x4f/0x90
 [<c016325a>] do_poll+0xaa/0xd0
 [<c01633df>] sys_poll+0x15f/0x240
 [<c01627b0>] __pollwait+0x0/0xd0
 [<c010aa67>] syscall_call+0x7/0xb

MozillaFirebi S E8DB60C0 4285776240   729    727           730   728 (NOTLB)
Call Trace:
 [<c01504b1>] vfs_write+0xd1/0x130
 [<c0109bd0>] sys_rt_sigsuspend+0xc0/0xf0
 [<c010aa67>] syscall_call+0x7/0xb

MozillaFirebi R E7F3BF20 4280002416   730    727                 729 (NOTLB)
Call Trace:
 [<c012ee39>] do_clock_nanosleep+0x199/0x2f0
 [<c011a170>] default_wake_function+0x0/0x30
 [<c011a170>] default_wake_function+0x0/0x30
 [<c015c6a0>] pipe_write+0x0/0x2e0
 [<c012ea90>] nanosleep_wake_up+0x0/0x10
 [<c012eb52>] sys_nanosleep+0x92/0xe0
 [<c010aa67>] syscall_call+0x7/0xb

automount     S 00000000 4258426224   766    391           767       (NOTLB)
Call Trace:
 [<c011a4ff>] interruptible_sleep_on+0x4f/0x90
 [<c011a170>] default_wake_function+0x0/0x30
 [<f08759ca>] autofs4_wait+0x1ea/0x2b0 [autofs4]
 [<f0875f56>] autofs4_expire_multi+0x76/0xa0 [autofs4]
 [<c0161ff3>] sys_ioctl+0xf3/0x280
 [<c014fb21>] sys_close+0x61/0xa0
 [<c010aa67>] syscall_call+0x7/0xb

automount     S C0145684 4259951472   767    391   768           766 (NOTLB)
Call Trace:
 [<c0145684>] build_mmap_rb+0x34/0x50
 [<c015c43b>] pipe_wait+0x7b/0xa0
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c011b7f0>] autoremove_wake_function+0x0/0x50
 [<c015c59f>] pipe_read+0x13f/0x240
 [<c01502a8>] vfs_read+0xb8/0x130
 [<c0150552>] sys_read+0x42/0x70
 [<c010aa67>] syscall_call+0x7/0xb

umount        R current  4255232944   768    767                     (NOTLB)
Call Trace:
 [<c0345aaf>] rpc_rmdir+0x7f/0xc0
 [<c033639f>] rpc_destroy_client+0x5f/0x90
 [<c018925f>] nfs_put_super+0x1f/0x50
 [<c0156706>] generic_shutdown_super+0x176/0x190
 [<c0156fc7>] kill_anon_super+0x17/0x50
 [<c018b7d9>] nfs_kill_super+0x19/0x30
 [<c015644e>] deactivate_super+0x5e/0xc0
 [<c016bfcf>] sys_umount+0x3f/0x90
 [<c016c037>] sys_oldumount+0x17/0x20
 [<c010aa67>] syscall_call+0x7/0xb

atkbd.c: Unknown key (set 2, scancode 0x1b7, on isa0060/serio0) pressed.
Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c0166951
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0166951>]    Not tainted
EFLAGS: 00010286
EIP is at dput+0x91/0x200
eax: 00100100   ebx: e8ea3500   ecx: e8ea3514   edx: 00200200
esi: e69ea000   edi: e8ea3514   ebp: e8ea35dc   esp: e69ebea4
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 768, threadinfo=3De69ea000 task=3De8fce680)
Stack: e8ea3500 c0454c50 e8ea3500 00000000 e8ea3514 c03454bc e8ea3500 e8ea3=
500=20
       e8e33528 e8e334c0 e8ea3570 e8ea35c0 e8ea35c0 e8e339a8 e8e33940 c0345=
aaf=20
       e8ea35c0 e8ea3800 e8ea3800 effe4d80 e8e97e19 00000005 10ee271a 00000=
010=20
Call Trace:
 [<c03454bc>] rpc_depopulate+0xac/0x150
 [<c0345aaf>] rpc_rmdir+0x7f/0xc0
 [<c033639f>] rpc_destroy_client+0x5f/0x90
 [<c018925f>] nfs_put_super+0x1f/0x50
 [<c0156706>] generic_shutdown_super+0x176/0x190
 [<c0156fc7>] kill_anon_super+0x17/0x50
 [<c018b7d9>] nfs_kill_super+0x19/0x30
 [<c015644e>] deactivate_super+0x5e/0xc0
 [<c016bfcf>] sys_umount+0x3f/0x90
 [<c016c037>] sys_oldumount+0x17/0x20
 [<c010aa67>] syscall_call+0x7/0xb

Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 43 14 00 01 10 00 ff=20
 <6>note: umount[768] exited with preempt_count 3
bad: scheduling while atomic!
Call Trace:
 [<c011a11b>] schedule+0x39b/0x3a0
 [<c01418b3>] unmap_page_range+0x43/0x70
 [<c0141a95>] unmap_vmas+0x1b5/0x210
 [<c014571b>] exit_mmap+0x7b/0x190
 [<c011bab4>] mmput+0x64/0xc0
 [<c011f675>] do_exit+0x105/0x410
 [<c0118760>] do_page_fault+0x0/0x451
 [<c010bac0>] do_divide_error+0x0/0x100
 [<c011888c>] do_page_fault+0x12c/0x451
 [<c011585c>] mark_offset_tsc+0x20c/0x270
 [<c0119aee>] scheduler_tick+0x5e/0x2e0
 [<c0124e46>] update_process_times+0x46/0x60
 [<c0124f8a>] run_timer_softirq+0x10a/0x1b0
 [<c012511f>] do_timer+0xdf/0xf0
 [<c012c803>] rcu_process_callbacks+0x83/0x100
 [<c0121176>] tasklet_action+0x46/0x70
 [<c0118760>] do_page_fault+0x0/0x451
 [<c010b471>] error_code+0x2d/0x38
 [<c0166951>] dput+0x91/0x200
 [<c03454bc>] rpc_depopulate+0xac/0x150
 [<c0345aaf>] rpc_rmdir+0x7f/0xc0
 [<c033639f>] rpc_destroy_client+0x5f/0x90
 [<c018925f>] nfs_put_super+0x1f/0x50
 [<c0156706>] generic_shutdown_super+0x176/0x190
 [<c0156fc7>] kill_anon_super+0x17/0x50
 [<c018b7d9>] nfs_kill_super+0x19/0x30
 [<c015644e>] deactivate_super+0x5e/0xc0
 [<c016bfcf>] sys_umount+0x3f/0x90
 [<c016c037>] sys_oldumount+0x17/0x20
 [<c010aa67>] syscall_call+0x7/0xb

SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unR=
aw Sync showTasks Unmount=20
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unR=
aw Sync showTasks Unmount=20
agpgart: Found an AGP 2.0 compliant device at 00:00.0.
agpgart: Putting AGP V2 device at 00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 01:00.0 into 2x mode
[drm] Loading R200 Microcode
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unR=
aw Sync showTasks Unmount=20
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unR=
aw Sync showTasks Unmount=20
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unR=
aw Sync showTasks Unmount=20
SysRq : Keyboard mode set to XLATE
SysRq : Power Off

acpi_power_off called
bad: scheduling while atomic!
Call Trace:
 [<c011a11b>] schedule+0x39b/0x3a0
 [<c024da51>] acpi_ut_allocate_object_desc_dbg+0x7/0x31
 [<c01246af>] add_timer+0x8f/0xa0
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0241057>] acpi_ex_system_do_suspend+0x1f/0x28
 [<c0240054>] acpi_ex_opcode_1A_0T_0R+0x48/0x8d
 [<c023a272>] acpi_ds_exec_end_op+0xa2/0x228
 [<c02470e2>] acpi_ps_parse_loop+0x516/0x821
 [<c0239881>] acpi_ds_store_object_to_local+0xc8/0xd3
 [<c024c456>] acpi_ut_acquire_mutex+0x5c/0x72
 [<c024c4d3>] acpi_ut_release_mutex+0x67/0x6c
 [<c024b625>] acpi_ut_acquire_from_cache+0x44/0x9e
 [<c024743b>] acpi_ps_parse_aml+0x4e/0x17b
 [<c0247ce5>] acpi_psx_execute+0x155/0x1a0
 [<c02450b5>] acpi_ns_execute_control_method+0x43/0x52
 [<c024504e>] acpi_ns_evaluate_by_handle+0x6f/0x93
 [<c0244fc5>] acpi_ns_evaluate_by_name+0x6d/0x87
 [<c0244814>] acpi_evaluate_object+0xcf/0x1be
 [<c0243a51>] acpi_enter_sleep_state_prep+0x55/0x84
 [<c024dbea>] acpi_power_off+0x16/0x22
 [<c0133a1d>] handle_poweroff+0xd/0x10
 [<c026f713>] __handle_sysrq_nolock+0x73/0xe0
 [<c026f68a>] handle_sysrq+0x4a/0x60
 [<c0269c83>] kbd_event+0x33/0x60
 [<c02d3c60>] input_event+0xe0/0x360
 [<c02d6d7c>] atkbd_interrupt+0xfc/0x220
 [<c02d7b5f>] serio_interrupt+0x5f/0x70
 [<c02d829f>] i8042_interrupt+0xef/0x220
 [<c0119737>] try_to_wake_up+0xa7/0x150
 [<c011a19a>] default_wake_function+0x2a/0x30
 [<c011a1d1>] __wake_up_common+0x31/0x60
 [<c0119737>] try_to_wake_up+0xa7/0x150
 [<c0119836>] wake_up_process_kick+0x26/0x30
 [<c0124e46>] update_process_times+0x46/0x60
 [<c0124cab>] update_wall_time+0xb/0x40
 [<c012511f>] do_timer+0xdf/0xf0
 [<c010cbaa>] handle_IRQ_event+0x3a/0x70
 [<c010cf01>] do_IRQ+0x91/0x130
 [<c0108870>] default_idle+0x0/0x30
 [<c010b3d4>] common_interrupt+0x18/0x20
 [<c0108870>] default_idle+0x0/0x30
 [<c0108893>] default_idle+0x23/0x30
 [<c01088ff>] cpu_idle+0x2f/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c041472d>] start_kernel+0x16d/0x1a0
 [<c0414480>] unknown_bootoption+0x0/0x100

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0119e0a
*pde =3D 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c0119e0a>]    Not tainted
EFLAGS: 00010097
EIP is at schedule+0x8a/0x3a0
eax: 00000001   ebx: c0394380   ecx: c03943a0   edx: ffffffff
esi: 00000000   edi: c040f400   ebp: c0413b7c   esp: c0413b54
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=3Dc0412000 task=3Dc0394380)
Stack: c0358480 00000208 c024da51 00000246 00000000 c01246af c0450980 0004e=
ac9=20
       c0413b90 efee96a0 00000000 c012526f c0413b90 ec026a40 00000000 c0450=
fd0=20
       c0450fd0 0004eac9 4b87ad6e c0125200 c0394380 c0450980 00000001 00000=
3e8=20
Call Trace:
 [<c024da51>] acpi_ut_allocate_object_desc_dbg+0x7/0x31
 [<c01246af>] add_timer+0x8f/0xa0
 [<c012526f>] schedule_timeout+0x5f/0xc0
 [<c0125200>] process_timeout+0x0/0x10
 [<c0241057>] acpi_ex_system_do_suspend+0x1f/0x28
 [<c0240054>] acpi_ex_opcode_1A_0T_0R+0x48/0x8d
 [<c023a272>] acpi_ds_exec_end_op+0xa2/0x228
 [<c02470e2>] acpi_ps_parse_loop+0x516/0x821
 [<c0239881>] acpi_ds_store_object_to_local+0xc8/0xd3
 [<c024c456>] acpi_ut_acquire_mutex+0x5c/0x72
 [<c024c4d3>] acpi_ut_release_mutex+0x67/0x6c
 [<c024b625>] acpi_ut_acquire_from_cache+0x44/0x9e
 [<c024743b>] acpi_ps_parse_aml+0x4e/0x17b
 [<c0247ce5>] acpi_psx_execute+0x155/0x1a0
 [<c02450b5>] acpi_ns_execute_control_method+0x43/0x52
 [<c024504e>] acpi_ns_evaluate_by_handle+0x6f/0x93
 [<c0244fc5>] acpi_ns_evaluate_by_name+0x6d/0x87
 [<c0244814>] acpi_evaluate_object+0xcf/0x1be
 [<c0243a51>] acpi_enter_sleep_state_prep+0x55/0x84
 [<c024dbea>] acpi_power_off+0x16/0x22
 [<c0133a1d>] handle_poweroff+0xd/0x10
 [<c026f713>] __handle_sysrq_nolock+0x73/0xe0
 [<c026f68a>] handle_sysrq+0x4a/0x60
 [<c0269c83>] kbd_event+0x33/0x60
 [<c02d3c60>] input_event+0xe0/0x360
 [<c02d6d7c>] atkbd_interrupt+0xfc/0x220
 [<c02d7b5f>] serio_interrupt+0x5f/0x70
 [<c02d829f>] i8042_interrupt+0xef/0x220
 [<c0119737>] try_to_wake_up+0xa7/0x150
 [<c011a19a>] default_wake_function+0x2a/0x30
 [<c011a1d1>] __wake_up_common+0x31/0x60
 [<c0119737>] try_to_wake_up+0xa7/0x150
 [<c0119836>] wake_up_process_kick+0x26/0x30
 [<c0124e46>] update_process_times+0x46/0x60
 [<c0124cab>] update_wall_time+0xb/0x40
 [<c012511f>] do_timer+0xdf/0xf0
 [<c010cbaa>] handle_IRQ_event+0x3a/0x70
 [<c010cf01>] do_IRQ+0x91/0x130
 [<c0108870>] default_idle+0x0/0x30
 [<c010b3d4>] common_interrupt+0x18/0x20
 [<c0108870>] default_idle+0x0/0x30
 [<c0108893>] default_idle+0x23/0x30
 [<c01088ff>] cpu_idle+0x2f/0x40
 [<c0105000>] rest_init+0x0/0x60
 [<c041472d>] start_kernel+0x16d/0x1a0
 [<c0414480>] unknown_bootoption+0x0/0x100

Code: ff 0e 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20 00=20
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--QnGs129iAKyuXRcc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6879NLPgdTuQ3+QRAnEWAKCZsyk+kLOGIKyhhmXntMmGxGVk7gCfYaNi
sFaq5fNa3o8zGLe+HGAK4Q0=
=y53i
-----END PGP SIGNATURE-----

--QnGs129iAKyuXRcc--
