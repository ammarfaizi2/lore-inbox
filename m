Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbVKRS27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbVKRS27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbVKRS27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:28:59 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:53403 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1161108AbVKRS26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:28:58 -0500
Date: Fri, 18 Nov 2005 19:29:11 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine
Message-ID: <20051118182910.GJ6640@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I didn't manage to read all the archive yet and I'm new to the list
anyways. I wanted to report that 2.6.15-rc1-mm2 is unusable in an X
enviroment due to the mouse pointer hanging, jumping or not even working
at all. The behaviour occurs randomly.

The messages state oops like these:

Nov 18 12:57:44 stiffy kernel: klogd 1.4.1#17, log source =3D /proc/kmsg st=
arted.
Nov 18 12:57:44 stiffy kernel: Inspecting /boot/System.map-2.6.15-rc1-mm2-m=
arc
Nov 18 12:57:44 stiffy kernel: Loaded 21818 symbols from /boot/System.map-2=
=2E6.15-rc1-mm2-marc.
Nov 18 12:57:44 stiffy kernel: Symbols match kernel version 2.6.15.
Nov 18 12:57:45 stiffy kernel: No module symbols loaded - kernel modules no=
t enabled.=20
Nov 18 12:57:45 stiffy kernel: /GPIO/TCO
Nov 18 12:57:45 stiffy kernel: PCI quirk: region 0880-08bf claimed by ICH4 =
GPIO
Nov 18 12:57:45 stiffy kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:=
00:1f.1
Nov 18 12:57:45 stiffy kernel: PCI: Transparent bridge - 0000:00:1e.0
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *=
11)
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *=
11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *=
11)
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 =
10 *11)
Nov 18 12:57:45 stiffy kernel: ACPI: Power Resource [PADA] (on)
Nov 18 12:57:45 stiffy kernel: Linux Plug and Play Support v0.97 (c) Adam B=
elay
Nov 18 12:57:45 stiffy kernel: pnp: PnP ACPI init
Nov 18 12:57:45 stiffy kernel: pnp: PnP ACPI: found 18 devices
Nov 18 12:57:45 stiffy kernel: PCI: Using ACPI for IRQ routing
Nov 18 12:57:45 stiffy kernel: PCI: Routing PCI interrupts for all devices =
because "pci=3Drouteirq" specified
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKA] enabled at I=
RQ 11
Nov 18 12:57:45 stiffy kernel: PCI: setting IRQ 11 as level-triggered
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link =
[LNKA] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKC] enabled at I=
RQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link =
[LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link =
[LNKA] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKB] enabled at I=
RQ 5
Nov 18 12:57:45 stiffy kernel: PCI: setting IRQ 5 as level-triggered
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link =
[LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link =
[LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link =
[LNKA] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link =
[LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKD] enabled at I=
RQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.1[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.2[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:45 stiffy kernel: pnp: 00:02: ioport range 0x4d0-0x4d1 has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:02: ioport range 0x800-0x805 could n=
ot be reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:02: ioport range 0x808-0x80f could n=
ot be reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:03: ioport range 0x806-0x807 has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:03: ioport range 0x810-0x85f could n=
ot be reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:03: ioport range 0x860-0x87f has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:03: ioport range 0x880-0x8bf has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:03: ioport range 0x8c0-0x8df has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:03: ioport range 0x8e0-0x8ff has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf000-0xf0fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf100-0xf1fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf200-0xf2fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf400-0xf4fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf500-0xf5fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf600-0xf6fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf800-0xf8fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:04: ioport range 0xf900-0xf9fe has b=
een reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:09: ioport range 0x900-0x91f has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:09: ioport range 0x3f0-0x3f1 has bee=
n reserved
Nov 18 12:57:45 stiffy kernel: pnp: 00:10: ioport range 0xbf40-0xbf5f has b=
een reserved
Nov 18 12:57:45 stiffy kernel: PCI: Bridge: 0000:00:01.0
Nov 18 12:57:45 stiffy kernel:   IO window: c000-cfff
Nov 18 12:57:45 stiffy kernel:   MEM window: fc000000-fdffffff
Nov 18 12:57:45 stiffy kernel:   PREFETCH window: e0000000-e7ffffff
Nov 18 12:57:45 stiffy kernel: PCI: Bus 3, cardbus bridge: 0000:02:01.0
Nov 18 12:57:45 stiffy kernel:   IO window: 0000e000-0000e0ff
Nov 18 12:57:46 stiffy kernel:   IO window: 0000e400-0000e4ff
Nov 18 12:57:46 stiffy kernel:   PREFETCH window: 30000000-31ffffff
Nov 18 12:57:46 stiffy kernel:   MEM window: f4000000-f5ffffff
Nov 18 12:57:46 stiffy kernel: PCI: Bus 7, cardbus bridge: 0000:02:01.1
Nov 18 12:57:46 stiffy kernel:   IO window: 0000e800-0000e8ff
Nov 18 12:57:47 stiffy kernel:   IO window: 00001000-000010ff
Nov 18 12:57:47 stiffy kernel:   PREFETCH window: 32000000-33ffffff
Nov 18 12:57:47 stiffy kernel:   MEM window: f6000000-f7ffffff
Nov 18 12:57:47 stiffy kernel: PCI: Bridge: 0000:00:1e.0
Nov 18 12:57:47 stiffy kernel:   IO window: e000-ffff
Nov 18 12:57:47 stiffy kernel:   MEM window: f4000000-fbffffff
Nov 18 12:57:48 stiffy kernel:   PREFETCH window: 30000000-34ffffff
Nov 18 12:57:49 stiffy kernel: PCI: Enabling device 0000:02:01.0 (0000 -> 0=
003)
Nov 18 12:57:49 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:49 stiffy kernel: PCI: Enabling device 0000:02:01.1 (0000 -> 0=
003)
Nov 18 12:57:49 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.1[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:49 stiffy kernel: audit: initializing netlink socket (disabled)
Nov 18 12:57:49 stiffy kernel: audit(1132315003.646:1): initialized
Nov 18 12:57:49 stiffy kernel: VFS: Disk quotas dquot_6.5.1
Nov 18 12:57:49 stiffy kernel: Dquot-cache hash table entries: 1024 (order =
0, 4096 bytes)
Nov 18 12:57:49 stiffy kernel: Initializing Cryptographic API
Nov 18 12:57:49 stiffy kernel: io scheduler noop registered
Nov 18 12:57:49 stiffy kernel: io scheduler anticipatory registered
Nov 18 12:57:49 stiffy kernel: io scheduler deadline registered
Nov 18 12:57:49 stiffy kernel: io scheduler cfq registered
Nov 18 12:57:49 stiffy kernel: vesafb: framebuffer at 0xe0000000, mapped to=
 0xe0880000, using 5120k, total 32768k
Nov 18 12:57:49 stiffy kernel: vesafb: mode is 1280x1024x16, linelength=3D2=
560, pages=3D1
Nov 18 12:57:49 stiffy kernel: vesafb: protected mode interface info at c00=
0:d6a0
Nov 18 12:57:49 stiffy kernel: vesafb: scrolling: redraw
Nov 18 12:57:49 stiffy kernel: vesafb: Truecolor: size=3D0:5:6:5, shift=3D0=
:11:5:0
Nov 18 12:57:49 stiffy kernel: Console: switching to colour frame buffer de=
vice 160x64
Nov 18 12:57:49 stiffy kernel: fb0: VESA VGA frame buffer device
Nov 18 12:57:49 stiffy kernel: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS=
2M] at 0x60,0x64 irq 1,12
Nov 18 12:57:49 stiffy kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 18 12:57:49 stiffy kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 18 12:57:49 stiffy kernel: Serial: 8250/16550 driver $Revision: 1.90 $ =
4 ports, IRQ sharing enabled
Nov 18 12:57:49 stiffy kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) i=
s a 16550A
Nov 18 12:57:49 stiffy kernel: serial8250: ttyS3 at I/O 0x2e8 (irq =3D 3) i=
s a 16550A
Nov 18 12:57:49 stiffy kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) i=
s a 16550A
Nov 18 12:57:49 stiffy kernel: 00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 1=
6550A
Nov 18 12:57:49 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link =
[LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 18 12:57:49 stiffy kernel: ACPI: PCI interrupt for device 0000:00:1f.6 =
disabled
Nov 18 12:57:49 stiffy kernel: RAMDISK driver initialized: 4 RAM disks of 8=
192K size 1024 blocksize
Nov 18 12:57:49 stiffy kernel: Uniform Multi-Platform E-IDE driver Revision=
: 7.00alpha2
Nov 18 12:57:50 stiffy kernel: ide: Assuming 33MHz system bus speed for PIO=
 modes; override with idebus=3Dxx
Nov 18 12:57:50 stiffy kernel: ICH3M: IDE controller at PCI slot 0000:00:1f=
=2E1
Nov 18 12:57:50 stiffy kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0=
007)
Nov 18 12:57:50 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link =
[LNKA] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:50 stiffy kernel: ICH3M: chipset revision 2
Nov 18 12:57:50 stiffy kernel: ICH3M: not 100%% native mode: will probe irq=
s later
Nov 18 12:57:50 stiffy kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS sett=
ings: hda:DMA, hdb:DMA
Nov 18 12:57:50 stiffy kernel:     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS sett=
ings: hdc:pio, hdd:pio
Nov 18 12:57:50 stiffy kernel: input: AT Translated Set 2 keyboard as /clas=
s/input/input0
Nov 18 12:57:50 stiffy kernel: hda: HTS726060M9AT00, ATA DISK drive
Nov 18 12:57:50 stiffy kernel: hdb: HL-DT-STCD-RW/DVD-ROM GCC-4240N, ATAPI =
CD/DVD-ROM drive
Nov 18 12:57:51 stiffy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 18 12:57:51 stiffy kernel: hda: max request size: 1024KiB
Nov 18 12:57:51 stiffy kernel: hda: 117210240 sectors (60011 MB) w/7877KiB =
Cache, CHS=3D16383/255/63
Nov 18 12:57:51 stiffy kernel: hda: cache flushes supported
Nov 18 12:57:51 stiffy kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Nov 18 12:57:51 stiffy kernel: EISA: Probing bus 0 at eisa.0
Nov 18 12:57:51 stiffy kernel: NET: Registered protocol family 2
Nov 18 12:57:51 stiffy kernel: IP route cache hash table entries: 8192 (ord=
er: 3, 32768 bytes)
Nov 18 12:57:51 stiffy kernel: TCP established hash table entries: 32768 (o=
rder: 5, 131072 bytes)
Nov 18 12:57:51 stiffy kernel: TCP bind hash table entries: 32768 (order: 5=
, 131072 bytes)
Nov 18 12:57:51 stiffy irattach: executing: 'echo stiffy > /proc/sys/net/ir=
da/devname'
Nov 18 12:57:51 stiffy kernel: TCP: Hash tables configured (established 327=
68 bind 32768)
Nov 18 12:57:52 stiffy irattach: executing: 'echo 1 > /proc/sys/net/irda/di=
scovery'
Nov 18 12:57:52 stiffy kernel: TCP reno registered
Nov 18 12:57:54 stiffy irattach: Starting device irda0
Nov 18 12:57:54 stiffy kernel: TCP bic registered
Nov 18 12:57:55 stiffy kernel: NET: Registered protocol family 8
Nov 18 12:57:55 stiffy kernel: NET: Registered protocol family 20
Nov 18 12:57:55 stiffy kernel: Using IPI Shortcut mode
Nov 18 12:57:55 stiffy kernel: ACPI wakeup devices:=20
Nov 18 12:57:56 stiffy kernel:  LID PBTN PCI0 UAR1 USB0 USB1 USB2 MODM PCIE=
 MPCI=20
Nov 18 12:57:56 stiffy kernel: ACPI: (supports S0 S1 S3 S4 S5)
Nov 18 12:57:56 stiffy kernel: BIOS EDD facility v0.16 2004-Jun-25, 1 devic=
es found
Nov 18 12:57:56 stiffy kernel: RAMDISK: cramfs filesystem found at block 0
Nov 18 12:57:56 stiffy kernel: RAMDISK: Loading 1184KiB [1 disk] into ram d=
isk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^=
H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^=
H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^=
H/^Hdone.
Nov 18 12:57:56 stiffy kernel: VFS: Mounted root (cramfs filesystem) readon=
ly.
Nov 18 12:57:56 stiffy kernel: Freeing unused kernel memory: 236k freed
Nov 18 12:57:56 stiffy kernel: NET: Registered protocol family 1
Nov 18 12:57:56 stiffy kernel: ReiserFS: hda7: found reiserfs format "3.6" =
with standard journal
Nov 18 12:57:56 stiffy kernel: ReiserFS: hda7: using ordered data mode
Nov 18 12:57:57 stiffy kernel: ReiserFS: hda7: journal params: device hda7,=
 size 8192, journal first block 18, max trans len 1024, max batch 900, max =
commit age 30, max trans age 30
Nov 18 12:57:57 stiffy kernel: ReiserFS: hda7: checking transaction log (hd=
a7)
Nov 18 12:57:57 stiffy kernel: ReiserFS: hda7: Using r5 hash to sort names
Nov 18 12:57:57 stiffy kernel: Linux agpgart interface v0.101 (c) Dave Jones
Nov 18 12:57:57 stiffy kernel: agpgart: Detected an Intel i845 Chipset.
Nov 18 12:57:57 stiffy kernel: agpgart: AGP aperture is 64M @ 0xe8000000
Nov 18 12:57:57 stiffy kernel: usbcore: registered new driver usbfs
Nov 18 12:57:57 stiffy kernel: usbcore: registered new driver hub
Nov 18 12:57:57 stiffy kernel: USB Universal Host Controller Interface driv=
er v2.3
Nov 18 12:57:57 stiffy kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link =
[LNKA] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:57 stiffy kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Nov 18 12:57:57 stiffy kernel: uhci_hcd 0000:00:1d.0: new USB bus registere=
d, assigned bus number 1
Nov 18 12:57:57 stiffy kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x000=
0bf80
Nov 18 12:57:57 stiffy kernel: hub 1-0:1.0: USB hub found
Nov 18 12:57:57 stiffy kernel: hub 1-0:1.0: 2 ports detected
Nov 18 12:57:57 stiffy kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link =
[LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:57 stiffy kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Nov 18 12:57:57 stiffy kernel: uhci_hcd 0000:00:1d.2: new USB bus registere=
d, assigned bus number 2
Nov 18 12:57:58 stiffy kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 0x000=
0bf20
Nov 18 12:57:58 stiffy kernel: hub 2-0:1.0: USB hub found
Nov 18 12:57:58 stiffy kernel: hub 2-0:1.0: 2 ports detected
Nov 18 12:57:58 stiffy kernel: usb 2-1: new full speed USB device using uhc=
i_hcd and address 2
Nov 18 12:57:58 stiffy kernel: hw_random hardware driver 1.0.0 loaded
Nov 18 12:57:58 stiffy kernel: hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB=
 Cache
Nov 18 12:57:58 stiffy kernel: Uniform CD-ROM driver Revision: 3.20
Nov 18 12:57:58 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link =
[LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 18 12:57:58 stiffy kernel: MC'97 1 converters and GPIO not ready (0xff0=
0)
Nov 18 12:57:58 stiffy kernel: Real Time Clock Driver v1.12
Nov 18 12:57:58 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.2[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:58 stiffy kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=
=3D[11]  MMIO=3D[f8fff000-f8fff7ff]  Max Packet=3D[2048]
Nov 18 12:57:58 stiffy kernel: input: PC Speaker as /class/input/input1
Nov 18 12:57:58 stiffy kernel: Floppy drive(s): fd0 is 1.44M
Nov 18 12:57:58 stiffy kernel: FDC 0 is a post-1991 82077
Nov 18 12:57:59 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:59 stiffy kernel: Yenta: CardBus bridge found at 0000:02:01.0 =
[1028:00d4]
Nov 18 12:57:59 stiffy kernel: Yenta: Using CSCINT to route CSC interrupts =
to PCI
Nov 18 12:57:59 stiffy kernel: Yenta: Routing CardBus interrupts to PCI
Nov 18 12:57:59 stiffy kernel: Yenta TI: socket 0000:02:01.0, mfunc 0x05033=
002, devctl 0x64
Nov 18 12:57:59 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link =
[LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 18 12:57:59 stiffy kernel: Yenta: ISA IRQ mask 0x0498, PCI irq 11
Nov 18 12:57:59 stiffy kernel: Socket status: 30000010
Nov 18 12:57:59 stiffy kernel: pcmcia: parent PCI bridge I/O window: 0xe000=
 - 0xffff
Nov 18 12:57:59 stiffy kernel: cs: IO port probe 0xe000-0xffff: clean.
Nov 18 12:57:59 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0xf=
4000000 - 0xfbffffff
Nov 18 12:57:59 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0x3=
0000000 - 0x34ffffff
Nov 18 12:57:59 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.1[A] -> Link =
[LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:59 stiffy kernel: Yenta: CardBus bridge found at 0000:02:01.1 =
[1028:00d4]
Nov 18 12:57:59 stiffy kernel: Yenta: Using CSCINT to route CSC interrupts =
to PCI
Nov 18 12:57:59 stiffy kernel: Yenta: Routing CardBus interrupts to PCI
Nov 18 12:57:59 stiffy kernel: Yenta TI: socket 0000:02:01.1, mfunc 0x05033=
002, devctl 0x64
Nov 18 12:57:59 stiffy kernel: parport: PnPBIOS parport detected.
Nov 18 12:57:59 stiffy kernel: parport0: PC-style at 0x378 (0x778), irq 7, =
dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Nov 18 12:57:59 stiffy kernel: intel8x0_measure_ac97_clock: measured 50346 =
usecs
Nov 18 12:57:59 stiffy kernel: intel8x0: clocking to 48000
Nov 18 12:57:59 stiffy kernel: Yenta: ISA IRQ mask 0x0418, PCI irq 11
Nov 18 12:57:59 stiffy kernel: Socket status: 30000006
Nov 18 12:57:59 stiffy kernel: pcmcia: parent PCI bridge I/O window: 0xe000=
 - 0xffff
Nov 18 12:57:59 stiffy kernel: cs: IO port probe 0xe000-0xffff: clean.
Nov 18 12:57:59 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0xf=
4000000 - 0xfbffffff
Nov 18 12:57:59 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0x3=
0000000 - 0x34ffffff
Nov 18 12:57:59 stiffy kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link =
[LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:57:59 stiffy kernel: 3c59x: Donald Becker and others. www.scyld.c=
om/network/vortex.html
Nov 18 12:57:59 stiffy kernel: 0000:02:00.0: 3Com PCI 3c905C Tornado at e0f=
2ac00. Vers LK1.1.19
Nov 18 12:57:59 stiffy kernel: input: ImPS/2 Generic Wheel Mouse as /class/=
input/input2
Nov 18 12:57:59 stiffy kernel: pccard: PCMCIA card inserted into slot 0
Nov 18 12:57:59 stiffy kernel: SCSI subsystem initialized
Nov 18 12:57:59 stiffy kernel: Initializing USB Mass Storage driver...
Nov 18 12:57:59 stiffy kernel: scsi0 : SCSI emulation for USB Mass Storage =
devices
Nov 18 12:57:59 stiffy kernel: usbcore: registered new driver usb-storage
Nov 18 12:57:59 stiffy kernel: USB Mass Storage support registered.
Nov 18 12:57:59 stiffy kernel: eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethe=
rnet (fw-host0)
Nov 18 12:57:59 stiffy kernel: Adding 1461872k swap on /dev/hda8.  Priority=
:-1 extents:1 across:1461872k
Nov 18 12:57:59 stiffy kernel:   Vendor: IC25N040  Model: ATCS04-0         =
 Rev: CA4O
Nov 18 12:57:59 stiffy kernel:   Type:   Direct-Access                     =
 ANSI SCSI revision: 00
Nov 18 12:57:59 stiffy kernel: SCSI device sda: 78140160 512-byte hdwr sect=
ors (40008 MB)
Nov 18 12:57:59 stiffy kernel: SCSI device sda: 78140160 512-byte hdwr sect=
ors (40008 MB)
Nov 18 12:57:59 stiffy kernel:  sda: sda1
Nov 18 12:57:59 stiffy kernel: sd 0:0:0:0: Attached scsi disk sda
Nov 18 12:57:59 stiffy kernel: mice: PS/2 mouse device common for all mice
Nov 18 12:57:59 stiffy kernel: usbcore: registered new driver usbmouse
Nov 18 12:57:59 stiffy kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID B=
oot Protocol mouse driver
Nov 18 12:57:59 stiffy kernel: Bluetooth: Core ver 2.8
Nov 18 12:57:59 stiffy kernel: NET: Registered protocol family 31
Nov 18 12:57:59 stiffy kernel: Bluetooth: HCI device and connection manager=
 initialized
Nov 18 12:57:59 stiffy kernel: Bluetooth: HCI socket layer initialized
Nov 18 12:57:59 stiffy kernel: Bluetooth: HCI UART driver ver 2.2
Nov 18 12:57:59 stiffy kernel: Bluetooth: HCI H4 protocol initialized
Nov 18 12:57:59 stiffy kernel: Bluetooth: HCI BCSP protocol initialized
Nov 18 12:58:00 stiffy kernel: Dell laptop SMM driver v1.14 21/02/2005 Mass=
imo Dal Zotto (dz@debian.org)
Nov 18 12:58:00 stiffy kernel: Bluetooth: L2CAP ver 2.8
Nov 18 12:58:00 stiffy kernel: Bluetooth: L2CAP socket layer initialized
Nov 18 12:58:00 stiffy kernel: Bluetooth: HIDP (Human Interface Emulation) =
ver 1.1
Nov 18 12:58:00 stiffy kernel: Bluetooth: RFCOMM socket layer initialized
Nov 18 12:58:00 stiffy kernel: Bluetooth: RFCOMM TTY layer initialized
Nov 18 12:58:00 stiffy kernel: Bluetooth: RFCOMM ver 1.6
Nov 18 12:58:00 stiffy kernel: EXT2-fs warning: mounting unchecked fs, runn=
ing e2fsck is recommended
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda6: found reiserfs format "3.6" =
with standard journal
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda6: using ordered data mode
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda6: journal params: device hda6,=
 size 8192, journal first block 18, max trans len 1024, max batch 900, max =
commit age 30, max trans age 30
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda6: checking transaction log (hd=
a6)
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda6: Using r5 hash to sort names
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda5: found reiserfs format "3.6" =
with standard journal
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda5: using ordered data mode
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda5: journal params: device hda5,=
 size 8192, journal first block 18, max trans len 1024, max batch 900, max =
commit age 30, max trans age 30
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda5: checking transaction log (hd=
a5)
Nov 18 12:58:00 stiffy kernel: ReiserFS: hda5: Using r5 hash to sort names
Nov 18 12:58:00 stiffy kernel: ReiserFS: sda1: found reiserfs format "3.6" =
with standard journal
Nov 18 12:58:00 stiffy kernel: ReiserFS: sda1: using ordered data mode
Nov 18 12:58:00 stiffy kernel: ReiserFS: sda1: journal params: device sda1,=
 size 8192, journal first block 18, max trans len 1024, max batch 900, max =
commit age 30, max trans age 30
Nov 18 12:58:00 stiffy kernel: ReiserFS: sda1: checking transaction log (sd=
a1)
Nov 18 12:58:00 stiffy kernel: ReiserFS: sda1: Using r5 hash to sort names
Nov 18 12:58:00 stiffy kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link =
[LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 18 12:58:00 stiffy kernel: cs: memory probe 0xf4000000-0xfbffffff: excl=
uding 0xf4000000-0xf8ffffff
Nov 18 12:58:00 stiffy kernel: pcmcia: registering new device pcmcia0.0
Nov 18 12:58:01 stiffy kernel: pcmcia: Detected deprecated PCMCIA ioctl usa=
ge.
Nov 18 12:58:01 stiffy kernel: pcmcia: This interface will soon be removed =
=66rom the kernel; please expect breakage unless you upgrade to new tools.
Nov 18 12:58:01 stiffy kernel: pcmcia: see http://www.kernel.org/pub/linux/=
utils/kernel/pcmcia/pcmcia.html for details.
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0x100-0x4ff: excluding 0x1=
70-0x177 0x300-0x307 0x370-0x37f
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0x100-0x4ff: excluding 0x1=
70-0x177 0x300-0x307 0x370-0x37f
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0x800-0x8ff: clean.
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0x800-0x8ff: clean.
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0xc00-0xcff: clean.
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0xc00-0xcff: clean.
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0xa00-0xaff: clean.
Nov 18 12:58:01 stiffy kernel: cs: IO port probe 0xa00-0xaff: clean.
Nov 18 12:58:01 stiffy kernel: ttyS1: detected caps 00000700 should be 0000=
0100
Nov 18 12:58:01 stiffy kernel: 0.0: ttyS1 at I/O 0xe100 (irq =3D 3) is a 16=
C950/954
Nov 18 12:58:01 stiffy kernel: 0.0: ttyS2 at I/O 0xe108 (irq =3D 3) is a 82=
50
Nov 18 12:58:01 stiffy kernel: ip_conntrack version 2.4 (4095 buckets, 3276=
0 max) - 212 bytes per conntrack
Nov 18 12:58:01 stiffy kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 18 12:58:01 stiffy kernel: IA-32 Microcode Update Driver: v1.14 <tigran=
@veritas.com>
Nov 18 12:58:01 stiffy kernel: microcode: CPU0 updated from revision 0x9 to=
 0x20, date =3D 06052003=20
Nov 18 12:58:01 stiffy kernel: IA-32 Microcode Update Driver v1.14 unregist=
ered
Nov 18 12:58:01 stiffy kernel: NET: Registered protocol family 10
Nov 18 12:58:01 stiffy kernel: Disabled Privacy Extensions on device c0340d=
00(lo)
Nov 18 12:58:01 stiffy kernel: IPv6 over IPv4 tunneling driver
Nov 18 12:58:01 stiffy kernel: ACPI: Battery Slot [BAT0] (battery present)
Nov 18 12:58:01 stiffy kernel: ACPI: Battery Slot [BAT1] (battery present)
Nov 18 12:58:01 stiffy kernel: ACPI: AC Adapter [AC] (on-line)
Nov 18 12:58:02 stiffy kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Nov 18 12:58:02 stiffy kernel: ACPI: Processor [CPU0] (supports 8 throttlin=
g states)
Nov 18 12:58:02 stiffy kernel: ACPI: Lid Switch [LID]
Nov 18 12:58:02 stiffy kernel: ACPI: Power Button (CM) [PBTN]
Nov 18 12:58:02 stiffy kernel: ACPI: Sleep Button (CM) [SBTN]
Nov 18 12:58:02 stiffy kernel: ACPI: Thermal Zone [THM] (56 C)
Nov 18 12:58:02 stiffy kernel: NET: Registered protocol family 23
Nov 18 12:58:37 stiffy kernel: psmouse.c: Wheel Mouse at isa0060/serio1/inp=
ut0 lost synchronization, throwing 1 bytes away.

SOME STUFF MISSING? HUH?

Nov 18 13:03:14 stiffy kernel: psmouse.c: resync failed, issuing reconnect =
request

SOME STUFF MISSING? HUH?

Nov 18 13:05:10 stiffy kernel: 2/0x11d
Nov 18 13:05:10 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:10 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:10 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:10 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:10 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:11 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:11 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:11 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:12 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:12 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:13 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:13 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:13 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:13 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:13 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:13 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:13 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:13 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:14 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:14 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:14 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:14 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:14 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:14 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:14 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:14 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:15 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:15 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:19 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:19 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:19 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:19 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:20 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:20 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:20 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:20 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:20 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:20 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:24 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:24 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:24 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:24 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:24 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:24 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:24 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:24 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:24 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:24 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:32 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:32 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:32 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:32 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:32 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:32 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:32 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:32 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:32 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:32 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:36 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:36 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:36 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:36 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:36 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:36 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:36 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:36 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:36 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:37 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:41 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:42 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:42 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:42 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:42 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:42 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:42 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:42 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:42 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:42 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:45 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:45 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:45 stiffy kernel:  [do_gettimeofday+20/188] do_gettimeofday+0x=
14/0xbc
Nov 18 13:05:45 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:45 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:45 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:45 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:45 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:45 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:45 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:47 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:47 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:47 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:47 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:47 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:47 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:47 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:47 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:47 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:05:52 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:05:53 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:05:53 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:05:53 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:05:53 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:05:53 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:05:53 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:05:53 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:05:53 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:06:00 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:06:00 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:06:00 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:06:00 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:06:00 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:06:00 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:06:00 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:06:00 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:06:00 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:06:04 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:06:04 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:06:04 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:06:04 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:06:04 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:06:04 stiffy kernel:  [unmap_region+150/289] unmap_region+0x96/0x=
121
Nov 18 13:06:04 stiffy kernel:  [do_munmap+235/300] do_munmap+0xeb/0x12c
Nov 18 13:06:04 stiffy kernel:  [sys_munmap+62/88] sys_munmap+0x3e/0x58
Nov 18 13:06:04 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:07:39 stiffy shutdown[7944]: shutting down for system reboot
Nov 18 13:07:41 stiffy gconfd (marc-7214): Signal 15 erhalten, ordungsgem=
=E4=DFes Herunterfahren
Nov 18 13:07:42 stiffy gconfd (marc-7214): Beenden
Nov 18 13:07:46 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:07:46 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:07:46 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:07:46 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:07:46 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:07:46 stiffy kernel:  [exit_mmap+120/255] exit_mmap+0x78/0xff
Nov 18 13:07:46 stiffy kernel:  [mmput+51/239] mmput+0x33/0xef
Nov 18 13:07:46 stiffy kernel:  [do_exit+257/1168] do_exit+0x101/0x490
Nov 18 13:07:47 stiffy kernel:  [do_group_exit+46/153] do_group_exit+0x2e/0=
x99
Nov 18 13:07:47 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:07:49 stiffy irattach: got SIGTERM or SIGINT=20
Nov 18 13:07:49 stiffy irattach: Stopping device irda0
Nov 18 13:07:49 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:07:49 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:07:49 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:07:49 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:07:49 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:07:49 stiffy kernel:  [exit_mmap+120/255] exit_mmap+0x78/0xff
Nov 18 13:07:49 stiffy kernel:  [mmput+51/239] mmput+0x33/0xef
Nov 18 13:07:49 stiffy kernel:  [do_exit+257/1168] do_exit+0x101/0x490
Nov 18 13:07:49 stiffy kernel:  [do_group_exit+46/153] do_group_exit+0x2e/0=
x99
Nov 18 13:07:49 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:07:51 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:07:51 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:07:51 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:07:51 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:07:51 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:07:51 stiffy kernel:  [exit_mmap+120/255] exit_mmap+0x78/0xff
Nov 18 13:07:51 stiffy kernel:  [mmput+51/239] mmput+0x33/0xef
Nov 18 13:07:51 stiffy kernel:  [do_exit+257/1168] do_exit+0x101/0x490
Nov 18 13:07:51 stiffy kernel:  [do_group_exit+46/153] do_group_exit+0x2e/0=
x99
Nov 18 13:07:51 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:07:52 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:07:52 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:07:53 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:07:53 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:07:53 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:07:53 stiffy kernel:  [exit_mmap+120/255] exit_mmap+0x78/0xff
Nov 18 13:07:53 stiffy kernel:  [mmput+51/239] mmput+0x33/0xef
Nov 18 13:07:53 stiffy kernel:  [do_exit+257/1168] do_exit+0x101/0x490
Nov 18 13:07:53 stiffy kernel:  [do_group_exit+46/153] do_group_exit+0x2e/0=
x99
Nov 18 13:07:53 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:07:53 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:07:54 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:07:54 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:07:54 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:07:54 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:07:54 stiffy kernel:  [exit_mmap+120/255] exit_mmap+0x78/0xff
Nov 18 13:07:54 stiffy kernel:  [mmput+51/239] mmput+0x33/0xef
Nov 18 13:07:54 stiffy kernel:  [do_exit+257/1168] do_exit+0x101/0x490
Nov 18 13:07:54 stiffy kernel:  [do_group_exit+46/153] do_group_exit+0x2e/0=
x99
Nov 18 13:07:54 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:07:55 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:07:55 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:07:55 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:07:55 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:07:55 stiffy kernel:  [unmap_vmas+193/476] unmap_vmas+0xc1/0x1dc
Nov 18 13:07:56 stiffy kernel:  [exit_mmap+120/255] exit_mmap+0x78/0xff
Nov 18 13:07:56 stiffy kernel:  [mmput+51/239] mmput+0x33/0xef
Nov 18 13:07:56 stiffy kernel:  [do_exit+257/1168] do_exit+0x101/0x490
Nov 18 13:07:56 stiffy kernel:  [do_group_exit+46/153] do_group_exit+0x2e/0=
x99
Nov 18 13:07:56 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 18 13:07:56 stiffy kernel:  [bad_page+134/318] bad_page+0x86/0x13e
Nov 18 13:07:56 stiffy kernel:  [free_hot_cold_page+66/285] free_hot_cold_p=
age+0x42/0x11d
Nov 18 13:07:56 stiffy kernel:  [zap_pte_range+305/719] zap_pte_range+0x131=
/0x2cf
Nov 18 13:07:56 stiffy kernel:  [unmap_page_range+236/273] unmap_page_range=
+0xec/0x111
Nov 18 13:07:57 stiffy exiting on signal 15

REBOOT ... using 2.6.15-rc1.

Nov 18 13:09:21 stiffy syslogd 1.4.1#17: restart.
Nov 18 13:09:22 stiffy kernel: klogd 1.4.1#17, log source =3D /proc/kmsg st=
arted.
Nov 18 13:09:23 stiffy kernel: Inspecting /boot/System.map-2.6.15-rc1-marc
Nov 18 13:09:23 stiffy kernel: Loaded 21499 symbols from /boot/System.map-2=
=2E6.15-rc1-marc.

Please ask if this information is not enough. I'll try to gather some more =
if you ask for it.
It's my first report, guys.. ;)

Ragards,
	Marc

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDfh12Xs/lvTQwq/URAhkfAJ9+1mjh8JG4WrWtYdsR0CFdxIeurgCePJNI
lvarLhvhYA6RK7eq5tWHal8=
=ugW9
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
