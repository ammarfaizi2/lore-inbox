Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268375AbSIRVFV>; Wed, 18 Sep 2002 17:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268395AbSIRVFV>; Wed, 18 Sep 2002 17:05:21 -0400
Received: from 6-122-ADSL.red.retevision.es ([80.224.122.6]:14788 "EHLO
	jerry.boludo.cjb.net") by vger.kernel.org with ESMTP
	id <S268375AbSIRVFJ>; Wed, 18 Sep 2002 17:05:09 -0400
Date: Wed, 18 Sep 2002 23:10:44 +0200
From: Javier Marcet <jmarcet@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: bttv driver problems on 2.4.19+
Message-ID: <20020918211044.GA8387@jerry.boludo.cjb.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: multipart/mixed; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I've been unable to succesfully use my bttv card on kernels >=3D 2.4.19
(last I tried was 2.4.20-pre5ac6).

I have yet to test some 2.4.18 kernel again. For the time being, though,
whether I remove all my other cards (see the attachments) or not, I
can't use it. Actually, I have two different bttv boards, one from Pinnacle
(PCTV Pro) and one from Hauppauge. Both fail.

I have used the kernel-integrated 0.7.x version of the bttv driiver and also
the 0.8.x branch, with and without v4l2 merged.

PS Although you'll see a lot of PCI cards in the attached logs, the result
is the same whatever slots I place the cards on (not only the bttv
boards, but all the PCI cards), and whether I remove all but the VGA, SCSI
& bttv cards, which I need to boot, or not.


--=20
Javier Marcet <jmarcet@pobox.com>

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.20-p5ac6-rml-ll (root@jerry.boludo.cjb.net) (gcc version 3.2) #1 Sat Sep 14 18:42:31 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017fec000 (usable)
 BIOS-e820: 0000000017fec000 - 0000000017fef000 (ACPI data)
 BIOS-e820: 0000000017fef000 - 0000000017fff000 (reserved)
 BIOS-e820: 0000000017fff000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98284
zone(0): 4096 pages.
zone(1): 94188 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda2 video=matrox:mem:32,xres:1280,yres:960,left:264,right:24,hslen:160,upper:47,lower:1,vslen:3,pixclock:6024,sync:0x03,depth:32,pan,panicblink=2,devfs=mount
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1544.833 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3031.04 BogoMIPS
Memory: 385208k/393136k available (1678k kernel code, 7540k reserved, 337k data, 264k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=48151 max_file_pages=0 max_inodes=0 max_dentries=48151
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
HZ: Currently used HZ value is (1000)
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1544.0318 MHz.
..... host bus clock speed is 268.0577 MHz.
cpu: 0, clocks: 268577, slice: 134288
CPU0<T0:268576,T1:134288,D:0,S:134288,C:268577>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1280x960x32bpp (virtual: 1280x3276)
matroxfb: framebuffer at 0xCE000000, mapped to 0xd8811000, size 33554432
Console: switching to colour frame buffer device 160x60
fb0: MATROX VGA frame buffer device
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
PDC20265: IDE controller at PCI slot 00:11.0
PCI: Found IRQ 10 for device 00:11.0
PCI: Sharing IRQ 10 with 00:0b.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20265: FORCING BURST BIT 0x00->0x01 ACTIVE
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:DMA, hdh:DMA
hda: IBM-DTLA-307045, ATA DISK drive
hda: DMA disabled
blk: queue c0365a60, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 >
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 15 for device 00:0a.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: TEAC      Model: CD-R56S           Rev: 1.0P
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
spurious 8259A interrupt: IRQ7.
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 08:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 264k freed
Adding Swap: 530104k swap-space (priority -1)
reiserfs: checking transaction log (device 08:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:0a) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Real Time Clock Driver v1.10e
PCI: Found IRQ 11 for device 00:0c.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0c.0: 3Com PCI 3c905C Tornado at 0x9400. Vers LK1.1.18-ac
usb-uhci.c: $Revision: 1.275 $ time 18:48:12 Sep 14 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 5 for device 00:04.2
PCI: Sharing IRQ 5 with 00:04.3
PCI: Sharing IRQ 5 with 00:09.0
PCI: Sharing IRQ 5 with 00:0d.0
PCI: Sharing IRQ 5 with 00:0d.1
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:04.3
PCI: Sharing IRQ 5 with 00:04.2
PCI: Sharing IRQ 5 with 00:09.0
PCI: Sharing IRQ 5 with 00:0d.0
PCI: Sharing IRQ 5 with 00:0d.1
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/1, assigned device number 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: USB new device connect on bus1/1/4, assigned device number 3
usb.c: USB device 3 (vend/prod 0x9ef/0x101) is not claimed by any active driver.
hub.c: USB new device connect on bus1/1/5, assigned device number 4
usb.c: USB device 4 (vend/prod 0x43e/0x42bd) is not claimed by any active driver.
i2c-core.o: i2c core module version 2.6.4 (20020719)
Linux video capture interface: v1.00
i2c-core.o: driver VES1893 DVB demodulator registered.
i2c-core.o: driver i2c TV tuner driver registered.
saa7146_core.o: saa7146(1): bus:0, rev:1, mem:0xdad6c000.
i2c-core.o: client [VES1893] registered to adapter [saa7146(1)](pos. 0).
VES1893: attaching VES1893 at 0x10 to adapter saa7146(1)
tuner: chip found @ 0x61
i2c-core.o: client [i2c tv tuner chip] registered to adapter [saa7146(1)](pos. 1).
i2c-core.o: adapter saa7146(1) registered as adapter 0.
dvb0: AV7111569708904 - firm fdccd58b, rtsl 00000000, vid fdccd58b, app e5e2db67
dvb: 1 dvb(s) found!
dvb: 1 dvb(s) released.
free irqs
VES1893: detach_client
i2c-core.o: client [VES1893] unregistered.
i2c-core.o: client [SP5659] unregistered.
i2c-core.o: adapter unregistered: saa7146(1)
i2c-core.o: driver unregistered: VES1893 DVB demodulator
i2c-core.o: driver unregistered: i2c TV tuner driver
i2c-core.o: i2c core module version 2.6.4 (20020719)
Linux video capture interface: v1.00
i2c-core.o: driver VES1893 DVB demodulator registered.
i2c-core.o: driver i2c TV tuner driver registered.
saa7146_core.o: saa7146(1): bus:0, rev:1, mem:0xdad6c000.
i2c-core.o: client [VES1893] registered to adapter [saa7146(1)](pos. 0).
VES1893: attaching VES1893 at 0x10 to adapter saa7146(1)
tuner: chip found @ 0x61
i2c-core.o: client [i2c tv tuner chip] registered to adapter [saa7146(1)](pos. 1).
i2c-core.o: adapter saa7146(1) registered as adapter 0.
dvb0: AV7111 - firm f0240009, rtsl b0250018, vid 71010068, app 00012301
dvb: 1 dvb(s) found!
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
(scsi0:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 16)
sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
hub.c: already running port 5 disabled by hub (EMI?), re-enabling...
usb.c: USB disconnect on device 4
hub.c: USB new device connect on bus1/1/5, assigned device number 5
usb.c: USB device 5 (vend/prod 0x43e/0x42bd) is not claimed by any active driver.

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)
00:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
00:0b.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03)

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=proc_pci
Content-Transfer-Encoding: quoted-printable

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
      Master Capable.  Latency=3D8. =20
      Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0=
).
      Master Capable.  No bursts.  Min Gnt=3D8.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 6=
4).
  Bus  0, device   4, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (re=
v 6).
      Master Capable.  Latency=3D64. =20
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. USB (rev 22).
      IRQ 5.
      Master Capable.  Latency=3D64. =20
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 22).
      IRQ 5.
      Master Capable.  Latency=3D64. =20
      I/O at 0xd000 [0xd01f].
  Bus  0, device   4, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
      IRQ 9.
  Bus  0, device   9, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 4).
      IRQ 5.
      Master Capable.  Latency=3D64.  Min Gnt=3D2.Max Lat=3D20.
      I/O at 0xa400 [0xa41f].
  Bus  0, device   9, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 1).
      Master Capable.  Latency=3D64. =20
      I/O at 0xa000 [0xa007].
  Bus  0, device  10, function  0:
    SCSI storage controller: Adaptec AHA-2940U2/U2W (rev 0).
      IRQ 15.
      Master Capable.  Latency=3D64.  Min Gnt=3D39.Max Lat=3D25.
      I/O at 0x9800 [0x98ff].
      Non-prefetchable 64 bit memory at 0xca800000 [0xca800fff].
  Bus  0, device  11, function  0:
    Multimedia controller: Philips Semiconductors SAA7146 (rev 1).
      IRQ 10.
      Master Capable.  Latency=3D64.  Min Gnt=3D15.Max Lat=3D38.
      Non-prefetchable 32 bit memory at 0xca000000 [0xca0001ff].
  Bus  0, device  12, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 116=
).
      IRQ 11.
      Master Capable.  Latency=3D64.  Min Gnt=3D10.Max Lat=3D10.
      I/O at 0x9400 [0x947f].
      Non-prefetchable 32 bit memory at 0xc9800000 [0xc980007f].
  Bus  0, device  13, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 Video Capture =
(rev 17).
      IRQ 5.
      Master Capable.  Latency=3D64.  Min Gnt=3D16.Max Lat=3D40.
      Prefetchable 32 bit memory at 0xcd000000 [0xcd000fff].
  Bus  0, device  13, function  1:
    Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 1=
7).
      IRQ 5.
      Master Capable.  Latency=3D64.  Min Gnt=3D4.Max Lat=3D255.
      Prefetchable 32 bit memory at 0xcc800000 [0xcc800fff].
  Bus  0, device  17, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 2).
      IRQ 10.
      Master Capable.  Latency=3D64. =20
      I/O at 0x9000 [0x9007].
      I/O at 0x8800 [0x8803].
      I/O at 0x8400 [0x8407].
      I/O at 0x8000 [0x8003].
      I/O at 0x7800 [0x783f].
      Non-prefetchable 32 bit memory at 0xc9000000 [0xc901ffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 3).
      IRQ 11.
      Master Capable.  Latency=3D64.  Min Gnt=3D16.Max Lat=3D32.
      Prefetchable 32 bit memory at 0xce000000 [0xcfffffff].
      Non-prefetchable 32 bit memory at 0xcb800000 [0xcb803fff].
      Non-prefetchable 32 bit memory at 0xcb000000 [0xcb7fffff].

--f2QGlHpHGjS2mn6Y--

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iEYEARECAAYFAj2I69QACgkQx/ptJkB7frwN6wCff/pavA5XZdrNiKaPmsrsD84Z
ZOkAn0L7FLQQlSGHaMRaEszTZTU1hP2x
=V/1S
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
