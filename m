Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSGXLhY>; Wed, 24 Jul 2002 07:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSGXLhY>; Wed, 24 Jul 2002 07:37:24 -0400
Received: from [213.69.232.58] ([213.69.232.58]:45323 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S316959AbSGXLhT>;
	Wed, 24 Jul 2002 07:37:19 -0400
Date: Wed, 24 Jul 2002 15:40:26 +0200
From: Nico Schottelius <nicos-mutt@pcsystems.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.27 floppy driver
Message-ID: <20020724134026.GB479@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry to disturb again:
The floppy driver is broken in this kernel, too.
Reading/writing lets the accessing program just 'hang around'.

Luckily the floppy driver is happy and reports its problems to us.

See [hopefully] attached file floppyerr.


Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=floppyerr
Content-Transfer-Encoding: quoted-printable

Linux version 2.5.27 (root@flapp) (gcc version 2.95.3 20010315 (release)) #=
3 Wed Jul 24 13:25:35 CEST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=3Dunstable ro root=3D302 BOOT_FILE=3D/=
boot/2.5/27-24.Jul.2002
Initializing CPU#0
Detected 646.660 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1273.85 BogoMIPS
Memory: 257508k/262080k available (914k kernel code, 4184k reserved, 292k d=
ata, 188k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0387f9ff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel 00/08 stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 2: assuming transparent
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
devfs: v1.17 (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Capability LSM initialized
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Ali M1621 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on ALi M1621 @ 0xe0000000 64MB
[drm] Initialized r128 2.2.0 20010917 on minor 0
block: 256 slots per queue, batch=3D32
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: Acer Laboratories Inc. [ALi] M5229 IDE, PCI slot 00:10.0
ATA: chipset rev.: 195
ATA: non-legacy mode: IRQ probe delayed
    ide0: BM-DMA at 0x6050-0x6057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x6058-0x605f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, DISK drive
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 19640880 sectors w/384KiB Cache, CHS=3D19485/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1222/255/63] p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
Adding 297192k swap on /dev/discs/disc0/part3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
FAT: Using codepage iso8859-15
FAT: Using IO charset iso8859-15
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14=
.9e, 13:21:26 Jul 24 2002
PCI: Guessed IRQ 10 for device 00:06.0
trident: ALi Audio Accelerator found at IO 0x9000, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x4352:0x5934 (Cirrus Logic CS4299 rev D)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
VFS: Disk change detected on device ide1(22,0)
apm: BIOS version 1.2 Flags 0x0f (Driver version 1.16)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
PCI: Guessed IRQ 10 for device 00:0a.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:00:E2:3C:8B:75, IRQ 10.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 620014-144, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
inserting floppy driver for 2.5.27
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
VFS: Disk change detected on device fd(2,0)
generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
Unable to handle kernel NULL pointer dereference at virtual address 00000094
 printing eip:
c0198320
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0198320>]    Not tainted
EFLAGS: 00010086
eax: 00000000   ebx: ca8d7e38   ecx: 00000000   edx: 00000094
esi: ca8d7e54   edi: c11f3208   ebp: c13d42a0   esp: ca8d7e10
ds: 0018   es: 0018   ss: 0018
Process mformat (pid: 481, threadinfo=3Dca8d6000 task=3Dca59f580)
Stack: ca8d7e38 d08a8397 00000000 c13d42a0 00000000 ca8d7e54 c13d42a0 00000=
200=20
       00000001 c0120200 00000001 00000000 ca8d7e40 ca8d7e40 c11f3208 00000=
400=20
       00000000 00000000 00000000 c13d42a0 00000000 00000000 00000001 00000=
000=20
Call Trace: [<d08a8397>] [<c0120200>] [<d08a82d4>] [<d08a8412>] [<d08a855f>=
]=20
   [<d08abec4>] [<c0134ecb>] [<c0120200>] [<d08a8192>] [<c0135013>] [<c0135=
246>]=20
   [<c0166d6e>] [<c012f4ad>] [<c012f3ea>] [<c012f753>] [<c0106ab7>]=20

Code: 8b 99 94 00 00 00 39 d3 74 2a 8b 42 04 89 43 04 89 18 89 91=20
=20
floppy driver state
-------------------
now=3D603599 last interrupt=3D600598 diff=3D3001 last called handler=3Dd08a=
4164
timeout_message=3Dlock fdc
last output bytes:
 8 80 600594
 8 80 600594
 8 80 600594
 8 80 600596
 8 80 600596
 8 80 600596
 8 80 600596
 e 80 600596
13 80 600597
 0 90 600597
1a 90 600597
 0 90 600597
12 80 600597
 0 90 600597
14 80 600597
18 80 600597
 8 80 600598
 8 80 600598
 8 80 600598
 8 80 600598
last result at 600598
last redo_fd_request at 600599

status=3D80
fdc_busy=3D1
cont=3D00000000
CURRENT=3D00000000
command_status=3D-1

floppy0: floppy timeout called
no cont in shutdown!
floppy0: timeout handler died: floppy shutdown

--O5XBE6gyVG5Rl6Rj--

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Pq5KtnlUggLJsX0RApgTAKCkE+iHOnHXlhKTx+3T6+KIKuxMEgCcCtFq
aNvNLmQ2YDhVqv2Ba6gpfrM=
=WuXy
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
