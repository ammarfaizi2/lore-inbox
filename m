Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266487AbSKSP47>; Tue, 19 Nov 2002 10:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSKSP46>; Tue, 19 Nov 2002 10:56:58 -0500
Received: from brokedown.net ([24.217.80.65]:48585 "EHLO ns1.brokedown.net")
	by vger.kernel.org with ESMTP id <S266487AbSKSP44>;
	Tue, 19 Nov 2002 10:56:56 -0500
Subject: Re: Keyboard/Mouse Locking Up On Laptop
From: Josh Grebe <squash2@brokedown.net>
To: Padraig Brady <padraig.brady@corvil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DDA5969.9040809@corvil.com>
References: <1037719215.7701.13.camel@squashlaptop> 
	<3DDA5969.9040809@corvil.com>
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Nov 2002 09:59:40 -0600
Message-Id: <1037721581.7459.2.camel@squashlaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_ns1.brokedown.net-18717-1037721853-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_ns1.brokedown.net-18717-1037721853-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Just tried that and it didn't make a difference. Here are the new boot
messages, and /proc/interrupts, without APIC.

Josh

root@squashlaptop squash # cat /proc/interrupts
           CPU0
  0:      79312          XT-PIC  timer
  1:        641          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
 11:       1555          XT-PIC  Allegro, usb-uhci, usb-uhci, usb-uhci,
eth0
 12:      12535          XT-PIC  PS/2 Mouse
 14:      16380          XT-PIC  ide0
NMI:          0
ERR:          0


Linux version 2.4.18 (root@squashlaptop) (gcc version 3.2) #1 Tue Nov 19
09:39:25 CST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027fd0000 (usable)
 BIOS-e820: 0000000027fd0000 - 0000000027ff0c00 (reserved)
 BIOS-e820: 0000000027ff0c00 - 0000000027ffc000 (ACPI NVS)
 BIOS-e820: 0000000027ffc000 - 0000000028000000 (reserved)
On node 0 totalpages: 163792
zone(0): 4096 pages.
zone(1): 159696 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3D2.4.18-test root=3D303
Initializing CPU#0
Detected 730.913 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1458.17 BogoMIPS
Memory: 642936k/655168k available (1439k kernel code, 11844k reserved,
365k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III Mobile CPU      1066MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf04dd, last bus=3D4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 05 [IRQ]
PCI: Using IRQ router default [8086/248c] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS02 at 0x03e8 (irq =3D 4) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=3D32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4060-0x4067, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4068-0x406f, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK2018GAP, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 39070080 sectors (20004 MB), CHS=3D2584/240/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:A5:B4:E3:CD, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: Detected Intel i830M chipset
agpgart: AGP aperture is 256M @ 0x60000000
[drm] AGP 0.99 on Unknown @ 0x60000000 256MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
maestro3: version 1.22 built at 09:40:39 Nov 19 2002
maestro3: Configuring ESS Allegro found at IO 0x2400 IRQ 11
maestro3:  subvendor id: 0x00940e11
ac97_codec: AC97 Audio codec, id: 0x4583:0x8308 (ESS Allegro ES1988)
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 09:40:45 Nov 19 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x4000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x4020, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
usb-uhci.c: USB UHCI at I/O 0x4040, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver rio500
rio500.c: v1.1:USB Rio 500 driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack (5118 buckets, 40944 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 264592k swap-space (priority -1)


On Tue, 2002-11-19 at 09:31, Padraig Brady wrote:
> Josh Grebe wrote:
> > Hi All,
> >=20
> > I have a Compaq Evo n600c laptop. This unit works great while plugged
> > in, but when it runs on battery power, after a couple of minutes of
> > idle, the keyboard and mouse will stop responding. The BIOS is pretty
> > limited in options, and doesn't have anything to adjust APM settings,
> > and compiling the kernel with apm enabled or disabled also makes no
> > difference.
>=20
> Does disabling local APIC help?
>=20
> P=E1draig
>=20



--=_ns1.brokedown.net-18717-1037721853-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA92l/sqO3cwDbBqFwRAif+AJ9rJiSyIWr9ZN2s/jWHQPYUWdcpnQCgkYNF
9KG46doYWGV6O1F/FMxksn0=
=V8FB
-----END PGP SIGNATURE-----

--=_ns1.brokedown.net-18717-1037721853-0001-2--
