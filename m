Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSJ1UX2>; Mon, 28 Oct 2002 15:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJ1UX2>; Mon, 28 Oct 2002 15:23:28 -0500
Received: from nilus-1942.adsl.datanet.hu ([195.56.95.164]:65408 "EHLO
	sunshine.trey.hu") by vger.kernel.org with ESMTP id <S261529AbSJ1UXU>;
	Mon, 28 Oct 2002 15:23:20 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Gabor MICSKO <gmicsko@szintezis.hu>
Reply-To: gmicsko@szintezis.hu
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac5 [Intel D845GBV dma problem]
Date: Mon, 28 Oct 2002 21:29:39 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E186GW3-0000zF-00@sunshine.trey.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a little dma problem with Intel D845GBV mainboard. This chipset works 
fine with 2.4.20pre10-ac2.

dmesg

Linux version 2.5.44-ac5 (root@sunshine) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #1 Mon Oct 28 19:18:52 CET 2002
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
511MB LOWMEM available.
On node 0 totalpages: 130880
  DMA zone: 4096 pages
  Normal zone: 126784 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.5 ro root=304 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 2533.186 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 4997.12 BogoMIPS
Memory: 515572k/523520k available (1342k kernel code, 7560k reserved, 401k 
data, 256k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.9 (c) Adam Belay
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
Registering system device cpu0
adding '' to cpu class interfaces
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: IRQ 0 for device 00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 9 for device 00:1f.1
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 02:05.0
PCI: Cannot allocate resource region 0 of device 02:05.0
Registering system device pic0
Registering system device rtc0
Starting kswapd
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
vesafb: framebuffer at 0xe8000000, mapped to 0xe0800000, size 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=0
vesafb: protected mode interface info at c000:c220
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Intel i845G chipset
agpgart: AGP aperture is 64M @ 0xf8000000
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Found IRQ 9 for device 00:1f.1
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 02:05.0
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
hdb: WDC WD800BB-22CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hdd: R/RW 4x4x32, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4
hdb: host protected area => 1
hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)
 hdb: hdb1
end_request: I/O error, dev 16:00, sector 0
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev 16:00, sector 0
input: PC Speaker
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,4), size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,4)) for (ide0(3,4))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 256k freed
version 0 swap is no longer supported. Use mkswap -v1 /dev/hda2
NTFS driver 2.1.0 [Flags: R/O DEBUG MODULE].
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IDE-CD    Model: R/RW 4x4x32       Rev: 1.4B
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
bttv: driver version 0.8.42 loaded [v4l]
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
bttv: Bt8xx card found (0).
PCI: Found IRQ 5 for device 02:03.0
PCI: Sharing IRQ 5 with 00:1d.1
PCI: Sharing IRQ 5 with 02:03.1
bttv0: Bt878 (rev 17) at 02:03.0, irq: 5, latency: 32, mmio: 0xf47fe000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is bd11:1200
bttv0: using: BT878(Pinnacle PCTV Studio/Ra) [card=39,autodetected]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=16 tuner=1 radio=fmtuner stereo=no
bttv0: using tuner=1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: 
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 
(PV951)
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
bttv0: i2c attach [client=Philips PAL_I,ok]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 02:08.0
eth0: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet Controller, 
00:03:47:F7:3F:42, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ip_conntrack version 2.1 (4090 buckets, 32720 max) - 296 bytes per conntrack
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,65), size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,65)) for (ide0(3,65))
Using r5 hash to sort names
version 0 swap is no longer supported. Use mkswap -v1 /dev/hda2
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
eth0: speedo_open() irq 11.
eth0: Done speedo_open(), status 00000050.
Creative EMU10K1 PCI Audio Driver, version 0.16, 19:22:51 Oct 28 2002
PCI: Enabling device 02:05.0 (0000 -> 0001)
PCI: Found IRQ 9 for device 02:05.0
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 00:1f.1
PCI: Setting latency timer of device 02:05.0 to 64
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0x1000-0x101f, IRQ 9
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
Creative EMU10K1 PCI Audio Driver, version 0.16, 19:22:51 Oct 28 2002
PCI: Found IRQ 9 for device 02:05.0
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 00:1f.1
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0x1000-0x101f, IRQ 9
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
Creative EMU10K1 PCI Audio Driver, version 0.16, 19:22:51 Oct 28 2002
PCI: Found IRQ 9 for device 02:05.0
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 00:1f.1
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0x1000-0x101f, IRQ 9
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
Creative EMU10K1 PCI Audio Driver, version 0.16, 19:22:51 Oct 28 2002
PCI: Found IRQ 9 for device 02:05.0
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 00:1f.1
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0x1000-0x101f, IRQ 9
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
spurious 8259A interrupt: IRQ7.
Creative EMU10K1 PCI Audio Driver, version 0.16, 19:22:51 Oct 28 2002
PCI: Enabling device 02:05.0 (0004 -> 0005)
PCI: Found IRQ 9 for device 02:05.0
PCI: Sharing IRQ 9 with 00:1d.2
PCI: Sharing IRQ 9 with 00:1f.1
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0x1000-0x101f, IRQ 9
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
version 0 swap is no longer supported. Use mkswap -v1 /dev/hda2
hda: dma_timer_expiry: dma status == 0x60
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status timeout: status=0xd0 { Busy }

hdb: DMA disabled
hda: drive not ready for command
ide0: reset: success
blk: queue c034467c, I/O limit 4095Mb (mask 0xffffffff)

lspci

00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2561 (rev 01)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev 
b2)
02:03.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
02:03.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
02:05.0 VGA compatible unclassified device: Creative Labs SB Live! EMU10k1 
(rev 08)
02:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
08)
02:08.0 Ethernet controller: Intel Corp.: Unknown device 1039 (rev 81)

cat /proc/pci

sunshine:/home/trey# cat -vvv /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 
1).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 
1).
      Master Capable.  Latency=32.  Min Gnt=8.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 1).
      IRQ 11.
      I/O at 0xe800 [0xe81f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 1).
      IRQ 5.
      I/O at 0xe880 [0xe89f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 1).
      IRQ 9.
      I/O at 0xec00 [0xec1f].
  Bus  0, device  29, function  7:
    USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 1).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0xfebffc00 [0xfebfffff].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 129).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 1).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 1).
      IRQ 9.
      I/O at 0xffa0 [0xffaf].
      Non-prefetchable 32 bit memory at 0x20000000 [0x200003ff].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801DB SMBus (rev 1).
      IRQ 3.
      I/O at 0xe000 [0xe01f].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 1).
      IRQ 3.
      I/O at 0xe400 [0xe4ff].
      I/O at 0xe080 [0xe0bf].
      Non-prefetchable 32 bit memory at 0xfebff800 [0xfebff9ff].
      Non-prefetchable 32 bit memory at 0xfebff400 [0xfebff4ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev 
178).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
  Bus  2, device   3, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 17).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xf47fe000 [0xf47fefff].
  Bus  2, device   3, function  1:
    Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 17).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xf47ff000 [0xf47fffff].
  Bus  2, device   5, function  0:
    VGA compatible unclassified device: Creative Labs SB Live! EMU10k1 (rev 
8).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=20.
      I/O at 0x1000 [0x101f].
  Bus  2, device   5, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 8).
      Master Capable.  Latency=32.
      I/O at 0xdc00 [0xdc07].
  Bus  2, device   8, function  0:
    Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet 
Controller (rev 129).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeaff000 [0xfeafffff].
      I/O at 0xd880 [0xd8bf].

Cheers,

-----------------------------------
Gabor MICSKO
Compaq Accredited Platform Specialist, System Engineer (APS, ASE)
Szintézis Computer Rendszerház Kft.
H-9021 Gyor, Tihanyi Árpád út. 2.
Tel: +36-96-502-216
Fax: +36-96-318-658
E-mail: gmicsko@szintezis.hu
