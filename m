Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130162AbQKWBos>; Wed, 22 Nov 2000 20:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129529AbQKWBoj>; Wed, 22 Nov 2000 20:44:39 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:4868 "EHLO ibg.colorado.edu")
        by vger.kernel.org with ESMTP id <S130162AbQKWBoX>;
        Wed, 22 Nov 2000 20:44:23 -0500
Message-Id: <200011230114.SAA486161@ibg.colorado.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Inspiron 5000e dmesg from test11-ac2
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2000 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Wed, 22 Nov 2000 18:14:15 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per the request in the 2.4.0-test11-ac2 announcement I am sending
along the dmesg output from bootup on a Dell Inspiron 5000e.  I have
also included the output of cat /proc/apm.  Reading /proc/apm no longer
causes an oops, but the battery information is disabled.  Many thanks
for the fixes to APM, and if there is any more information I can
provide that would be useful in getting full APM support on the 5000e
please e-mail me directly, as I do not normally read linux-kernel.

Linux version 2.4.0-test11-ac2 (root@celis) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Wed Nov 22 15:22:30 MST 2000
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000019800 @ 00000000000e6800 (reserved)
 BIOS-e820: 0000000013ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000fc00 @ 0000000013ff0000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000013fffc00 (ACPI NVS)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
On node 0 totalpages: 81904
zone(0): 4096 pages.
zone(1): 77808 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 mem=327616K
Initializing CPU#0
Detected 497.844 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 992.87 BogoMIPS
Memory: 320464k/327616k available (875k kernel code, 6764k reserved, 67k data, 168k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
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
PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: The same IRQ used for device 00:04.1
PCI: The same IRQ used for device 01:00.0
PCI: Cannot allocate resource region 4 of device 00:07.1
  got res[1080:108f] for resource 4 of Intel Corporation 82371AB PIIX4 IDE
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
50 structures occupying 1487 bytes.
DMI table at 0x000EBDB0.
BIOS Vendor: Phoenix Technologies LTD
BIOS Version: A04
BIOS Release: 08/24/2000
BIOS strings suggest APM bugs, disabling battery reporting.
System Vendor: Dell Computer Corporation.
Product Name: Inspiron 5000e.
Version Revision B0.
Serial Number 123456789.
Board Vendor: Compal Electronics, Inc..
Board Name: 440BX Desktop Reference Platform.
Board Version: None.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1080-0x1087, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1088-0x108f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJSA-230, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 58605120 sectors (30006 MB) w/1874KiB Cache, CHS=3876/240/63, UDMA(33)
Partition check:
 hda: [PTBL] [3648/255/63] hda1 hda2 hda3 hda4
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 168k freed
Adding Swap: 128512k swap-space (priority -1)
ip_conntrack (2559 buckets, 20472 max)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] AGP 0.99 on Intel 440BX @ 0xe0000000 64MB
[drm] Initialized r128 1.0.0 20000928 on minor 63
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.18
maestro: version 0.14 time 15:27:13 Nov 22 2000
maestro: Configuring ESS Maestro 2E found at IO 0x1400 IRQ 5
maestro:  subvendor id: 0x00cc1028
maestro: PCI power managment capability: 0x7622
maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
maestro: 1 channels configured.
Real Time Clock Driver v1.10d
Linux PCMCIA Card Services 3.1.22
  kernel build: 2.4.0-test11-ac2 unknown
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: 
  TI 1225 rev 01 PCI-to-CardBus at slot 00:04, mem 0x68000000
    host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 2/5]
    host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 6/9]
    ISA irqs (scanned) = 3,4,7,9,10,15 PCI status changes
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Sorry: masquerading timeouts set 5DAYS/2MINS/60SECS
cs: memory probe 0xa0000000-0xa0ffffff: clean.
wvlan_cs: WaveLAN/IEEE PCMCIA driver v1.0.5
wvlan_cs: (c) Andreas Neuhaus <andy@fasta.fh-dortmund.de>
wvlan_cs: index 0x01: Vcc 5.0, irq 9, io 0x0100-0x013f
wvlan_cs: Registered netdevice eth0
wvlan_cs: MAC address on eth0 is 00 60 1d 1e 75 c0 
wvlan_cs: MAC address on eth0 is 00 60 1d 1e 75 c0 

And /proc/apm.  The laptop is currently configured with two batteries,
and no mains power.

1.14 1.2 0x03 0xff 0xff 0xff -1% -1 ?

Sorry if this message is redundant, but I didn't see any other
responses at the time I sent this.
--
Jeff Lessem.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
