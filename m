Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276632AbRJHAYY>; Sun, 7 Oct 2001 20:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276718AbRJHAYP>; Sun, 7 Oct 2001 20:24:15 -0400
Received: from na-148-243-251-224.na.avantel.net.mx ([148.243.251.224]:55051
	"EHLO beboiden.maquito.org") by vger.kernel.org with ESMTP
	id <S276632AbRJHAYB>; Sun, 7 Oct 2001 20:24:01 -0400
Message-ID: <3BC0F254.C6482C4C@casitadelterror.com>
Date: Sun, 07 Oct 2001 19:24:52 -0500
From: Arquimedes Canedo <boig@casitadelterror.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.14-1.1.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compaq 1202, pcmcia trouble
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.

I bought a compaq laptop 1202, I've installed Slackware 8.0, kernel
2.4.5.

I bought a pcmcia realtek 8139 NIC, in windows works fine.

Donald Becker told me that this might be a pcmcia issue.
I've tried with kernel 2.2.x and rtl8139.c and I haven't been luckly.

This is my complete dmesg :
------------------------
Linux version 2.4.5 (root@bigkitty) (gcc version 2.95.3 20010315
(release)) #10 Fri Jun 22 02:20:21 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ea400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007bf0000 (usable)
 BIOS-e820: 0000000007bf0000 - 0000000007bffc00 (ACPI data)
 BIOS-e820: 0000000007bffc00 - 0000000007c00000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
On node 0 totalpages: 31728
zone(0): 4096 pages.
zone(1): 27632 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=302
Initializing CPU#0
Detected 850.060 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 121144k/126912k available (1787k kernel code, 5380k reserved,
878k data, 300k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)

Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd83e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Address space collision on region 9 of device VIA Technologies,
Inc. VT82C686 [Apollo Super ACPI] [8080:808f]
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Found IRQ 11 for device 00:0b.0
PCI: The same IRQ used for device 00:07.2
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1410
PC card Cardbus Controller
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
pty: 512 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with HUB-6 MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI enabled
Real Time Clock Driver v1.10d
block: queued sectors max/low 80410kB/26803kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x1420-0x1427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N010ATDA04-0, ATA DISK drive
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/347KiB Cache, CHS=1222/255/63,
UDMA(33)
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
SCSI subsystem driver Revision: 1.00
scsi: <fdomain> Detection failed (no card)
NCR53c406a: no available ports found
3w-xxxx: tw_findcards(): No cards found.
linear personality registered
raid0 personality registered
raid1 personality registered
raid5 personality registered
raid5: measuring checksumming speed
   8regs     :  1407.600 MB/sec
   32regs    :   969.200 MB/sec
   pIII_sse  :  1723.600 MB/sec
   pII_mmx   :  1922.800 MB/sec
   p5_mmx    :  2004.800 MB/sec
raid5: using function: pIII_sse (1723.600 MB/sec)
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
fatfs: bogus logical sector size 0
fatfs: bogus logical sector size 0
fatfs: bogus logical sector size 0
UMSDOS: msdos_read_super failed, mount aborted.
reiserfs: checking transaction log (device 03:02) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 300k freed
Adding Swap: 128484k swap-space (priority -1)
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by
other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).
SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256).
SLIP linefill/keepalive option.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
Linux PCMCIA Card Services 3.1.26
  kernel build: 2.4.5 #6 Fri Jun 22 01:38:20 PDT 2001
  options:  [pci] [cardbus]
Intel PCIC probe: <6>PCI: Found IRQ 11 for device 00:0b.0
PCI: The same IRQ used for device 00:07.2

  TI 1410 rev 01 PCI-to-CardBus at slot 00:0b, mem 0x10000000
    host opts [0]: [ring] [pci + serial irq] [pci irq 11] [lat 32/176]
[bus 2/5]    ISA irqs (scanned) = 3,4,10 PCI status changes
cs: cb_alloc(bus 2): vendor 0x10ec, device 0x8139
Via 686a audio driver 1.1.14b
PCI: Found IRQ 9 for device 00:07.5
via82cxxx: timeout while reading AC97 codec (0xAA0000)
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
via82cxxx: board #1 at 0x1000, IRQ 9
------------------------


if i try a 'cardctl ident'
dumps this :

Socket 0:
        product info: "CardBus", "10/100Mbps Ethernet Card","",""
        manfid: 0x0000, 0x024c
        function: 6(network)
        PCI id: 0x10ec, 0x8139


When I try to load the 8139too dumps this :

'modprobe 8139too'

/lib/modules/2.4.5/kernel/drivers/net/8139too.o.gz : init_module: No
such device
...: Hint: insmod errors can be caused by incorrect module parameters,
including IO or IRQ parameters
...: insmod 8139too failed



my lspci dumps this

pcilib: Cannot open /proc/bus/pci/02/00.0
lspci: Unable to read 64 bytes of configuration space


and someone told me that I should send here this

lspci -vxxx -s 00:0b.0

00:0b.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device b103
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001
00: 4c 10 50 ac 07 00 10 02 01 00 07 06 08 20 02 00
10: 00 00 00 10 a0 00 00 22 00 02 05 b0 00 00 00 60
20: 00 00 00 60 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 80 06
40: 11 0e 03 b1 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 60 90 44 c0 00 00 00 00 00 00 00 00 02 10 00 00
90: c0 82 64 61 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 11 fe 00 81 c0 00 03 08 00 00 1f 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


My laptop has Phoenix Bios 4.0 Release 6 and I cannot change the
'advanced options', PnP OS to off.


Thank You

Arquimedes Canedo
