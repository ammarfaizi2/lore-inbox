Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130044AbRCAVNf>; Thu, 1 Mar 2001 16:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRCAVMv>; Thu, 1 Mar 2001 16:12:51 -0500
Received: from host217-32-147-231.hg.mdip.bt.net ([217.32.147.231]:25604 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130016AbRCAVLh>;
	Thu, 1 Mar 2001 16:11:37 -0500
Date: Thu, 1 Mar 2001 21:11:27 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: José Luis Domingo López 
	<jldomingo@crosswinds.net>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.2ac7
In-Reply-To: <20010301211643.B1559@dardhal.mired.net>
Message-ID: <Pine.LNX.4.21.0103012106050.754-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, José Luis Domingo López wrote:
> Linux 2.4.2-ac7 reports wrong CPU speed and model name for a Pentium III
> correctly detected on, at least, 2.2.18, 2.4.2 and 2.4.2-ac4. The
> processor is a 600 MHz one, with a 133 MHz front bus.

same here with PIII550MHz/100MHz bus. Actually, it is wrong in 2.4.2-ac6
as well -- don't know about ac5:

here is info from bootlog:

NT 05
Int: type 0, pol 0, trig 0, bus 3, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 3, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 3, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 3, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 3, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 3, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 3, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 3, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 3, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 3, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 24, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 29, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 2, IRQ 10, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 2, IRQ 14, APIC ID 2, APIC INT 10
Int: type 2, pol 3, trig 1, bus 3, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=242-ac6 ro root=341 BOOT_FILE=/boot/vmlinuz-2.4.2-ac6 video=matrox:vesa:0x118 parport=0x378,7 console=ttyS1,38400 console=tty0 nmi_watchdog=0
Initializing CPU#0
Detected 548.547 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1094.45 BogoMIPS
Memory: 1026616k/1048512k available (1855k kernel code, 21508k reserved, 477k data, 248k init, 131008k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU speed 363Mhz, Bus Speed 66MHz
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU speed 363Mhz, Bus Speed 66MHz
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1462.42 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
Startup point 1.
CPU#1 (phys ID: 1) waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1094.45 BogoMIPS
Stack at about c221dfbc
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU speed 363Mhz, Bus Speed 66MHz
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Katmai) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (2188.90 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 548.5637 MHz.
..... host bus clock speed is 99.7387 MHz.
cpu: 0, clocks: 997387, slice: 332462
CPU0<T0:997376,T1:664912,D:2,S:332462,C:997387>
cpu: 1, clocks: 997387, slice: 332462
CPU1<T0:997376,T1:332448,D:4,S:332462,C:997387>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb200, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I4,P0) -> 19
PCI->APIC IRQ transform: (B2,I5,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
matroxfb: Matrox Millennium G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x32bpp (virtual: 1024x2047)
matroxfb: framebuffer at 0xEE000000, mapped to 0xf8805000, size 8388608
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Linux video capture interface: v1.00
block: queued sectors max/low 682322kB/551250kB, 2048 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST328040A, ATA DISK drive
hdb: IBM-DTLA-307075, ATA DISK drive
hdc: QUANTUM FIREBALL ST6.4A, ATA DISK drive
hdd: Maxtor 96147U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 55704096 sectors (28520 MB) w/512KiB Cache, CHS=3467/255/63, UDMA(33)
hdb: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(33)
hdc: 12594960 sectors (6449 MB) w/81KiB Cache, CHS=13328/15/63, UDMA(33)
hdd: 120060864 sectors (61471 MB) w/2048KiB Cache, CHS=119108/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
 hda2: <bsd: hda8 hda9 hda10 >
 hda3: <unixware: hda11 hda12 hda13 hda14 hda15 hda16 hda17 hda18 >
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 >
 hdc: [PTBL] [784/255/63] hdc1
 hdd: [PTBL] [7473/255/63] hdd1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 48 45 80 6d 38
eth0: NE2000 found at 0x300, using IRQ 5.
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth1: Intel Corporation 82557 [Ethernet Pro 100], 00:D0:B7:61:37:E2, IRQ 19.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 711269-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth2: Intel Corporation 82557 [Ethernet Pro 100] (#2), 00:D0:B7:61:37:E3, IRQ 16.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 711269-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
i2c-core.o: driver i2c msp3400 driver registered.
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951)
i2c-core.o: driver generic i2c audio driver registered.
i2c-core.o: driver i2c TV tuner driver registered.
bttv: driver version 0.7.57 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 00:0a.0, irq: 18, latency: 64, memory: 0xef102000
bttv0: subsystem: 0070:13eb  =>  Hauppauge WinTV  =>  card=10
bttv0: model: BT878(Hauppauge new (bt878)) [autodetected]
bttv0: enabling 430FX/VP3 compatibilty
bttv0: Hauppauge msp34xx: reset line init
i2c-dev.o: Registered 'bt848 #0' as minor 0
tuner: chip found @ 0x61
bttv0: i2c attach [(unset)]
i2c-core.o: client [(unset)] registered to adapter [bt848 #0](pos. 0).
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: Hauppauge eeprom: model=38065, tuner=Philips FI1246 MK2 (1), radio=no
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on Intel 440BX @ 0xe0000000 64MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/9/0
(scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.3/5.2.0
       <Adaptec AHA-294X SCSI host adapter>
  Vendor: FUJITSU   Model: M2684S-512        Rev: 2036
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 04687-XXX  Rev: 6610
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 1, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
(scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 15.
SCSI device sda: 1039329 512-byte hdwr sectors (532 MB)
 sda: sda4 < sda5 sda6 >
SCSI device sdb: 196608 512-byte hdwr sectors (101 MB)
sdb: Write Protect is off
 sdb: sdb4 < sdb5 sdb6 >
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
es1371: version v0.27 time 15:20:58 Feb 28 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
es1371: found es1371 rev 6 at io 0xe800 irq 16
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x5452:0x4103 (TriTech TR28023)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 32768 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 248k freed
Adding Swap: 1945904k swap-space (priority -1)
(scsi0:0:1:0) Synchronous at 6.67 Mbyte/sec, offset 15.
st0: Block limits 1 - 16777215 bytes.

