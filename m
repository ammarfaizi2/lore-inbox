Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUJWQYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUJWQYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbUJWQYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:24:46 -0400
Received: from mra04.ex.eclipse.net.uk ([212.104.129.139]:45520 "EHLO
	mra04.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S261225AbUJWQXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:23:07 -0400
From: Alastair Stevens <alastair@altruxsolutions.co.uk>
Organization: Haverhill UK
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
Date: Sat, 23 Oct 2004 17:22:54 +0100
User-Agent: KMail/1.7
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <4179EE45.9080409@kolivas.org> <4179F381.5090200@yahoo.com.au>
In-Reply-To: <4179F381.5090200@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1706828.9uJDYBelHc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410231722.59362.alastair@altruxsolutions.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1706828.9uJDYBelHc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 23 October 2004 7:00, Nick Piggin wrote:
> Alastair, can you compile sysrq support into the kernel, and
> press Alt+SysRq+M when kswapd is going crazy. Then send me
> the output of `dmesg`. That would be very helpful.

OK, here she is.....

It certainly doesn't do it _every_ time.  Going into X and straight into=20
UT2004 seems fine; but once other apps are loaded and memory is tighter,=20
off it goes into a frenzy.

Hope this is useful - thanks for your help!

=2D--------

Linux version 2.6.9-ck1 (root@dolphin.altrux.net) (gcc version 3.3.4=20
20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #5 Sat Oct 23=20
17:04:59 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5f50
ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Built 1 zonelists
Kernel command line: ro root=3D/dev/hda3 video=3Dvesa:ywrap,mtrr vga=3D0x317
Initializing CPU#0
CPU 0 irqstacks, hard=3Dc03c7000 soft=3Dc03c6000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1833.218 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515684k/524272k available (1883k kernel code, 8000k reserved, 776k=
=20
data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...=20
Ok.
Calibrating delay loop... 3612.67 BogoMIPS (lpj=3D1806336)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Level Trigger.
NET: Registered protocol family 16
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 *6 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0b.2[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 3
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 3 (level, low) -> IRQ 3
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 6
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
vesafb: framebuffer at 0xe8000000, mapped to 0xe0880000, size 3072k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D1
vesafb: protected mode interface info at c000:e2d0
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xf0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: VIA Rhine II at 0xe4000000, 00:0e:a6:e0:a8:df, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link=20
45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with=20
idebus=3Dxx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI interrupt 0000:00:11.1[A]: no GSI
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
hda: IRQ probe failed (0xfcfa)
hdb: IRQ probe failed (0xfcfa)
hdb: IRQ probe failed (0xfcfa)
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
hdd: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D16383/255/63,=20
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller
uhci_hcd 0000:00:10.0: irq 3, io base 0000d000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (#2)
uhci_hcd 0000:00:10.1: irq 3, io base 0000b800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1=20
Controller (#3)
uhci_hcd 0000:00:10.2: irq 3, io base 0000b400
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per=20
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. =20
http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
usb 2-2: new full speed USB device using address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 3 ports detected
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first=20
block 18, max trans len 1024, max batch 900, max commit age 30, max trans=20
age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 156k freed
usb 2-2.1: new full speed USB device using address 3
input: USB HID v1.00 Keyboard [ORTEK USB Hub/Keyboard] on=20
usb-0000:00:10.1-2.1
input: USB HID v1.00 Device [ORTEK USB Hub/Keyboard] on=20
usb-0000:00:10.1-2.1
usb 2-2.3: new low speed USB device using address 4
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on=20
usb-0000:00:10.1-2.3
Adding 1662688k swap on /dev/hda7.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first=20
block 18, max trans len 1024, max batch 900, max commit age 30, max trans=20
age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first=20
block 18, max trans len 1024, max batch 900, max commit age 30, max trans=20
age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:0b.2[B] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[11] =20
MMIO=3D[e5800000-e58007ff]  Max Packet=3D[2048]
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 3 (level, low) -> IRQ 3
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: irq 3, pci mem e0fae000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
drivers/usb/input/hid-core.c: input irq status -84 received
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usb 2-2: USB disconnect, address 2
usb 2-2.1: USB disconnect, address 3
usb 2-2.3: USB disconnect, address 4
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 6 (level, low) -> IRQ 6
PCI: Setting latency timer of device 0000:00:11.5 to 64
usb 2-2: new full speed USB device using address 5
codec_read: codec 0 is not valid [0x107e5370]
codec_read: codec 0 is not valid [0x107e5370]
codec_read: codec 0 is not valid [0x107e5370]
codec_read: codec 0 is not valid [0x107e5370]
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 3 ports detected
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c002002fba3]
usb 2-2.1: new full speed USB device using address 6
input: USB HID v1.00 Keyboard [ORTEK USB Hub/Keyboard] on=20
usb-0000:00:10.1-2.1
input: USB HID v1.00 Device [ORTEK USB Hub/Keyboard] on=20
usb-0000:00:10.1-2.1
usb 2-2.3: new low speed USB device using address 7
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on=20
usb-0000:00:10.1-2.3
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
process `named' is using obsolete setsockopt SO_BSDCOMPAT
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0361da0(lo)
IPv6 over IPv4 tunneling driver
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27=20
07:55:38 PDT 2004
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: X passes broken AGP3 flags (1f000a1f). Fixed.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: X passes broken AGP3 flags (1f000a1f). Fixed.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
drivers/usb/input/hid-input.c: event field not found
drivers/usb/input/hid-input.c: event field not found
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

=46ree pages:        3596kB (0kB HighMem)
Active:97415 inactive:15328 dirty:2 writeback:0 unstable:0 free:899=20
slab:2384 mapped:90021 pagetables:523
DMA free:20kB min:20kB low:40kB high:60kB active:2080kB inactive:0kB=20
present:16384kB
protections[]: 0 0 0
Normal free:3576kB min:700kB low:1400kB high:2100kB active:387580kB=20
inactive:61312kB present:507888kB
protections[]: 0 0 0
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB=20
present:0kB
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB=20
0*2048kB 0*4096kB =3D 20kB
Normal: 2*4kB 56*8kB 51*16kB 40*32kB 6*64kB 1*128kB 0*256kB 1*512kB=20
0*1024kB 0*2048kB 0*4096kB =3D 3576kB
HighMem: empty
Swap cache: add 697, delete 476, find 139/162, race 0+0
=46ree swap:       1660584kB
131068 pages of RAM
0 pages of HIGHMEM
2408 reserved pages
86381 pages shared
221 pages swap cached



=2D-=20
                                        o
Alastair Stevens : child of 1976       /-'_              LPI (Level 1)
  www.altruxsolutions.co.uk           |\/(*)   /\__     Linux Certified
_________________________________ . .(*) _____/    \___________________
        Ditch IE and ignite a new web - www.getfirefox.com

--nextPart1706828.9uJDYBelHc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBeoVjZaIQ8KuIK+0RApQuAJ9+qhNQsIjCJWQ0e6hjYTACwifx6wCfYnzQ
8+C32s6GvuPcCXeop/IZGUQ=
=CnqR
-----END PGP SIGNATURE-----

--nextPart1706828.9uJDYBelHc--
