Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRA0Cy4>; Fri, 26 Jan 2001 21:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRA0Cyq>; Fri, 26 Jan 2001 21:54:46 -0500
Received: from adsl-nrp10-C8B0F87C.sao.terra.com.br ([200.176.248.124]:27890
	"EHLO thor.gds-corp.com") by vger.kernel.org with ESMTP
	id <S129610AbRA0Cye> convert rfc822-to-8bit; Fri, 26 Jan 2001 21:54:34 -0500
Date: Sat, 27 Jan 2001 00:55:59 -0200 (BRST)
From: Joel Franco Guzmán <joel@gds-corp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 128M OK but with 192M or more sound problem
Message-ID: <Pine.LNX.4.30.0101270044050.4355-100000@thor.gds-corp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok.
I've written another mail about this problem and just continuing the
relat, with memory changes.

Resuming: when i put more than 128M in my machine with the kernel
2.4.0-test10 or above, the ES1371 sound card generate a noisy sound while
playing a sound using the DSP of the card. The music play ok, but with a
tick, tick, tick sound with the music. To see the problem completely
search by the "PROBLEM: 128M ok but with 192 sound problem."

I've exchanged the memory modules with another of the my friend machine.
He have a 128M and a 64M too.

I've tested two 64M modules and works fine.
128M plus 128M . problem.

then, i think that the problem is with the real quantity of memory in the
machine and don't with the memory modules.

ahh,
and the machine works perfectly with the 2.2.18 production kernel.

Thank you



---------------------------------------------------------------------

Linux thor.gds-corp.com 2.2.18 #2 Wed Dec 13 23:22:24 BRST 2000 i686
unknow


--------------------------------------------------------------------------
Here is the dmesg and above the script ver_linux.


Linux version 2.4.1-pre8 (root@thor.gds-corp.com) (gcc version 2.95.3 19991030 (prerelease)) #2 Wed Jan 17 19:44:31 BRST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000befd000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000002000 @ 000000000bffd000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000000bfff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 49149
zone(0): 4096 pages.
zone(1): 45053 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01334000)
Kernel command line: mem=196596K  root=/dev/hda6 hdd=ide-scsi video=matrox:vesa:0x117
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 598.478 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1192.75 BogoMIPS
Memory: 190532k/196596k available (1428k kernel code, 5676k reserved, 481k data, 216k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU: Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
29 structures occupying 973 bytes.
DMI table at 0x000F58DA.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS P2-99 ACPI BIOS Revision 1011
BIOS Release: 08/09/99
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: P2-99.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
Starting kswapd v1.8
matroxfb: Matrox Millennium G200 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x16bpp (virtual: 1024x4094)
matroxfb: framebuffer at 0xE3000000, mapped to 0xcc805000, size 8388608
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
block: queued sectors max/low 126434kB/94826kB, 384 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CX10.2A, ATA DISK drive
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 8200, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1247/255/63, UDMA(33)
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
PCI: Found IRQ 10 for device 00:0b.0
3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xb800,  00:50:da:25:cf:ec, IRQ 10
  product code 'XB' rev 00.12 date 09-02-99
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 149M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 on Intel 440BX @ 0xe4000000 64MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HP        Model: CD-Writer+ 8200   Rev: 1.0f
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
es1371: version v0.27 time 19:49:02 Jan 17 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
PCI: Found IRQ 12 for device 00:0a.0
es1371: found es1371 rev 6 at io 0xd000 irq 12
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A)
usb.c: registered new driver hub
PCI: Assigned IRQ 5 for device 00:04.2
uhci.c: USB UHCI at I/O 0xd400, IRQ 5
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: System description tables found
ACPI: System description tables loaded
ACPI: Subsystem enabled
ACPI: System firmware supports: C2
ACPI: System firmware supports: S0 S1 S5
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Adding Swap: 72256k swap-space (priority -1)
eth0: using NWAY autonegotiation
-------------------------------------------------------------------------


-----------------------------------------------------------------------
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux thor.gds-corp.com 2.2.18 #2 Wed Dec 13 23:22:24 BRST 2000 i686
unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         nls_cp437

--------------------------------------------------------------------
-- 
    Joel Franco Guzmán
GDS - Global Dynamic Systems
   joelfranco@bigfoot.com
ICQ 19354050 | (16) 270-6867

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
