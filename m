Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRAPLzj>; Tue, 16 Jan 2001 06:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131131AbRAPLz3>; Tue, 16 Jan 2001 06:55:29 -0500
Received: from pop.gmx.net ([194.221.183.20]:13980 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S131061AbRAPLzJ>;
	Tue, 16 Jan 2001 06:55:09 -0500
From: Martin Maciaszek <mmaciaszek@gmx.net>
Date: Tue, 16 Jan 2001 12:54:49 +0100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.0 and grub (0.5.96.1)
Message-ID: <20010116125449.A1923@nexus.shadowrun.not>
Mail-Followup-To: mmaciaszek@gmx.net,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I had to reinstall grub on my machine (because windoze has the
bad habit of deleting any bootloader in the MBR). This is what
happened:
[...]
grub> root (hd0,0)
 Filesystem type is ext2fs, partition type 0x83

grub> setup (hd0)
 Checking if "/boot/grub/stage1" exists... yes
 Checking if "/boot/grub/stage2" exists... yes
 Checking if "/boot/grub/e2fs_stage1_5" exists... yes
 Running "embed /boot/grub/e2fs_stage1_5 (hd0)"...  15 sectors are embedded.
succeeded
 Running "install /boot/grub/stage1 d (hd0) (hd0)1+15 p (hd0,0)/boot/grub/s=
tage 2"... failed

Error 22: No such partition
[...]

When I try the same in 2.2.18 grub installs just fine. I looked
into my syslog and dmesg but didn't find any new messages. Attached
you'll find the output dmesg

Cheers
Martin

--=20
"I don't know why, but first C programs tend to look a lot worse than
first programs in any other language (maybe except for fortran, but then
I suspect all fortran programs look like `firsts')"
(By Olaf Kirch)

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.output"

Linux version 2.4.0-aic7xxx (root@nexus) (gcc version 2.95.3 20010111 (prerelease)) #2 Sun Jan 14 17:44:55 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01223000)
Kernel command line: root=/dev/sda1 video=matrox:vesa:282:accel,mtrr,init,sgram,hwcursor,noblink,maxclk:110,fh:64,fv:100,font:SUN12x22 mem=131072K
Initializing CPU#0
Detected 433.988 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 865.07 BogoMIPS
Memory: 126024k/131072k available (1464k kernel code, 4660k reserved, 538k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb340, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
29 structures occupying 747 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 01/21/99
Board Vendor: Shuttle Inc..
Board Name: (HOT-661)Intel i440BX .
Board Version: 2A69KH2B .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x40
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: No more nibble data (0 bytes)
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP
matroxfb: Matrox Millennium G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x16bpp (virtual: 1280x3275)
matroxfb: framebuffer at 0xA0000000, mapped to 0xc8805000, size 8388608
Console: switching to colour frame buffer device 106x46
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
loop: enabling 8 loop devices
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905C Tornado at 0x6c00,  00:50:da:11:76:1e, IRQ 10
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] AGP 0.99 on Intel 440BX @ 0xe0000000 128MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.0.8 BETA
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-318350W      Rev: S80K
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): synchronous at 10.0MHz, offset 0xf, 8bit
  Vendor: IBM       Model: DDRS-39130        Rev: S92A
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:1): synchronous at 10.0MHz, offset 0xf, 8bit
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.04
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:2): synchronous at 10.0MHz, offset 0xf, 8bit
  Vendor: PLEXTOR   Model: CD-R   PX-R820T   Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): synchronous at 5.0MHz, offset 0x8, 8bit
  Vendor: CONNER    Model: CFP2105S  2.14GB  Rev: 2D4D
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:5): synchronous at 10.0MHz, offset 0xf, 8bit
  Vendor: QUANTUM   Model: FIREBALL_TM2110S  Rev: 300X
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:6): synchronous at 10.0MHz, offset 0xf, 8bit
(scsi0:A:0): synchronous at 10.0MHz, offset 0xf, 8bit
scsi0:0:0:0: Tagged Queuing enabled.  Depth 254
(scsi0:A:1): synchronous at 10.0MHz, offset 0xf, 8bit
scsi0:0:1:0: Tagged Queuing enabled.  Depth 254
(scsi0:A:5): synchronous at 10.0MHz, offset 0xf, 8bit
scsi0:0:5:0: Tagged Queuing enabled.  Depth 254
(scsi0:A:6): synchronous at 10.0MHz, offset 0xf, 8bit
scsi0:0:6:0: Tagged Queuing enabled.  Depth 254
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 5, lun 0
Detected scsi disk sdd at scsi0, channel 0, id 6, lun 0
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 >
SCSI device sdb: 17850000 512-byte hdwr sectors (9139 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1
 sdb1: <solaris: [s0] p5 [s1] p6 [s2] p7 [s7] p8 >
SCSI device sdc: 4194304 512-byte hdwr sectors (2147 MB)
 /dev/scsi/host0/bus0/target5/lun0: p4
 sdc4: <openbsd: p5 p6 >
SCSI device sdd: 4124736 512-byte hdwr sectors (2112 MB)
 /dev/scsi/host0/bus0/target6/lun0: p1
 sdd1: <bsd: p5 p6 p7 p8 >
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ACPI: System description tables not found
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
Adding Swap: 248968k swap-space (priority -1)
es1371: version v0.27 time 17:55:49 Jan 14 2001
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0x6800 irq 11
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
Linux video capture interface: v1.00
bttv: driver version 0.7.50 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 00:0c.0, irq: 9, latency: 64, memory: 0xe8002000
bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
bttv0: Hauppauge msp34xx: reset line init
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: Hauppauge eeprom: model=61324, tuner=Philips FI1216 MK2 (5)
bttv0: i2c: checking for MSP34xx @ 0x80... found
i2c-core.o: driver i2c msp3400 driver registered.
msp34xx: init: chip=MSP3415D-A2, has NICAM support
msp3410: daemon started
bttv0: i2c attach [MSP3415D-A2]
i2c-core.o: client [MSP3415D-A2] registered to adapter [bt848 #0](pos. 0).
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0x61
bttv0: i2c attach [Philips PAL]
i2c-core.o: client [Philips PAL] registered to adapter [bt848 #0](pos. 1).
MSDOS FS: Using codepage 850
fat_read_super: Bad fsinfo_offset
VFS: Can't find a valid MSDOS filesystem on dev 08:03.
eth0: using NWAY autonegotiation
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
microcode: CPU0 updated from revision 48 to 64, date=05251999
microcode: freed 2048 bytes
eth0: no IPv6 routers present
mtrr: 0xa0000000,0x1000000 overlaps existing 0xa0000000,0x800000
VFS: Disk change detected on device fd(2,0)
end_request: I/O error, dev 02:00 (floppy), sector 0
VFS: Disk change detected on device fd(2,0)
end_request: I/O error, dev 02:00 (floppy), sector 0
(scsi0:A:0:0): Locking max tag count at 64

--1yeeQ81UyVL57Vl7--

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ZDaJtOa6aqYVgUYRAu0BAKCGI85Fi39N3QxLAdrFwMI+g6Z01wCgoSIW
Gmho5cMTKImiQfhhqBfYc4s=
=k/rA
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
