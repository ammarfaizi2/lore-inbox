Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSGHOa3>; Mon, 8 Jul 2002 10:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSGHOa2>; Mon, 8 Jul 2002 10:30:28 -0400
Received: from msgdirector2.onetel.net.uk ([212.67.96.149]:45935 "EHLO
	msgdirector2.onetel.net.uk") by vger.kernel.org with ESMTP
	id <S316916AbSGHOa0>; Mon, 8 Jul 2002 10:30:26 -0400
Message-ID: <3D29A2D9.CD8936DB@onetel.net.uk>
Date: Mon, 08 Jul 2002 16:34:02 +0200
From: Matthias Fricke <matthiasfricke@onetel.net.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Ooops 
Content-Type: multipart/mixed;
 boundary="------------8DFE04DB900FAC867573BBD7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8DFE04DB900FAC867573BBD7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hallo,

I am using 2.4.18 Kernel on a 512MB RAM Mashine.
Kernel detects only 256 MB.
If I am booting lilo with mem=512M the kernel Ooopses and panics.

The kernel is patched with kernel patch of kernel.org from februar 18
th.

Your documentation told me that memory assigment problems should have
gone
with 2.4 kernels. So I think maybe it is really a problem.

Best Regards

Matthias




--------------8DFE04DB900FAC867573BBD7
Content-Type: text/plain; charset=us-ascii;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.18 (root@BLN7777) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Mon Jul 8 15:02:22 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e5800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fe70000 (usable)
 BIOS-e820: 000000000fe70000 - 000000000fe7f800 (ACPI data)
 BIOS-e820: 000000000fe7f800 - 000000000fe80000 (ACPI NVS)
 BIOS-e820: 000000000fe80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
On node 0 totalpages: 65136
zone(0): 4096 pages.
zone(1): 61040 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=2.4.18 ro root=303
Initializing CPU#0
Detected 844.625 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1684.27 BogoMIPS
Memory: 253220k/260544k available (1815k kernel code, 6936k reserved, 514k data, 256k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 844.6774 MHz.
..... host bus clock speed is 99.3737 MHz.
cpu: 0, clocks: 993737, slice: 496868
CPU0<T0:993728,T1:496848,D:12,S:496868,C:993737>
PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Sony Vaio laptop detected.
Starting kswapd
Journalled Block Device driver loaded
NTFS driver v1.1.22 [Flags: R/O]
udf: registering filesystem
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Found IRQ 5 for device 00:1f.6
PCI: Sharing IRQ 5 with 00:1f.3
PCI: Sharing IRQ 5 with 00:1f.5
sonypi: Sony Programmable I/O Controller Driver v1.10.
sonypi: detected type2 model, camera = off, compat = off
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 3
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1808-0x180f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-230, ATA DISK drive
hdc: UJDA710, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58605120 sectors (30006 MB) w/1874KiB Cache, CHS=3648/255/63, UDMA(66)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
eth1: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
eth2: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
eth3: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
eth4: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
eth5: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
eth6: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
eth7: D-Link DE-600 pocket adapter: not at I/O 0x378.
D-Link DE-620 pocket adapter not identified in the printer port
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 9 for device 01:08.0
eth0: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller, 08:00:46:11:58:33, IRQ 9.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 202M
agpgart: agpgart: Detected an Intel i815 Chipset.
agpgart: detected 4MB dedicated video ram.
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] AGP 0.99 on Intel i810 @ 0xf8000000 64MB
[drm] Initialized i810 1.1.0 20010616 on minor 0
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[f4105000-f4105800]  Max Packet=[2048]
raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
scsi1 : IEEE-1394 SBP-2 protocol driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: No IRQ known for interrupt pin A of device 01:02.0. Please try using pci=biosirq.
PCI: No IRQ known for interrupt pin B of device 01:02.1. Please try using pci=biosirq.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Yenta IRQ list 0098, PCI irq0
Socket status: 30000006
Yenta IRQ list 0098, PCI irq0
Socket status: 30000410
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 9 for device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0x1820, IRQ 9
ieee1394: sbp2: Node 1:1023: Max speed [S400] - Max payload [2048]
ieee1394: Device added: node 1:1023, GUID 0010b900220008e0
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:1f.4
PCI: Setting latency timer of device 00:1f.4 to 64
uhci.c: USB UHCI at I/O 0x1840, IRQ 11
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 256k freed
Adding Swap: 481940k swap-space (priority -1)

--------------8DFE04DB900FAC867573BBD7
Content-Type: text/plain; charset=us-ascii;
 name="mem.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mem.out"

        total:    used:    free:  shared: buffers:  cached:
Mem:  259559424 255049728  4509696        0  2060288 192716800
Swap: 493506560 19259392 474247168
MemTotal:       253476 kB
MemFree:          4404 kB
MemShared:           0 kB
Buffers:          2012 kB
Cached:         187684 kB
SwapCached:        516 kB
Active:          13800 kB
Inactive:       219924 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       253476 kB
LowFree:          4404 kB
SwapTotal:      481940 kB
SwapFree:       463132 kB

--------------8DFE04DB900FAC867573BBD7
Content-Type: text/plain; charset=us-ascii;
 name="version.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="version.out"

Linux version 2.4.18 (root@BLN7777) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 Mon Jul 8 15:02:22 CEST 2002

--------------8DFE04DB900FAC867573BBD7--

