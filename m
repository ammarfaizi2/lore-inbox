Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRBTIuw>; Tue, 20 Feb 2001 03:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRBTIun>; Tue, 20 Feb 2001 03:50:43 -0500
Received: from blondy.mnz.si ([193.189.185.136]:32523 "EHLO blondy.mnz.si")
	by vger.kernel.org with ESMTP id <S129396AbRBTIui>;
	Tue, 20 Feb 2001 03:50:38 -0500
Message-ID: <3A923176.3EE76624@kud-kontrabant.si>
Date: Tue, 20 Feb 2001 09:57:26 +0100
From: Janez Vrenjak <janez@kud-kontrabant.si>
Organization: KUD Kontrabant
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac18 i686)
X-Accept-Language: sl, en
MIME-Version: 1.0
To: linux-alert <linux-alert@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel problems
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello I'm getting this messages all the time.
After two or three such messages my computer freeses :-(=
I tried with 2.2, 2.4.0, 2.4.1, 2.4.1ac7-ac18 kernels
and the same thing happened.
Does any body have any idea what could be wrong.
This is a error:

---------------------------------------------------------------------------------------

Feb 19 12:53:33 trol kernel: Unable to handle kernel paging request at
virtual address 2e170722
Feb 19 12:53:33 trol kernel:  printing eip:
Feb 19 12:53:33 trol kernel: c014296f
Feb 19 12:53:33 trol kernel: *pde = 00000000
Feb 19 12:53:33 trol kernel: Oops: 0000
Feb 19 12:53:33 trol kernel: CPU:    0
Feb 19 12:53:33 trol kernel: EIP:    0010:[__d_path+159/272]
Feb 19 12:53:33 trol kernel: EFLAGS: 00010207
Feb 19 12:53:33 trol kernel: eax: c14c8260   ebx: cde19fff   ecx:
ccf55840   edx: ccf55840
Feb 19 12:53:33 trol kernel: esi: c1449320   edi: 00000fff   ebp:
2e170716   esp: ca491eb8
Feb 19 12:53:33 trol kernel: ds: 0018   es: 0018   ss: 0018
Feb 19 12:53:33 trol kernel: Process mozilla-bin (pid: 3838,
stackpage=ca491000)
Feb 19 12:53:33 trol kernel: Stack: ccff4c20 cde19ffe 00000069 c1449320
c14c8260 c14c8260 c0134c46 ccff4c20
Feb 19 12:53:33 trol kernel:        c14c8260 c1449320 c14c8260 cde19000
00000fff cde19ff7 ccff4c20 ccf55840
Feb 19 12:53:33 trol kernel:        cde19000 00000069 ccf5587c c5e760c0
00000000 c01222a2 c86569a0 ca491f64
Feb 19 12:53:33 trol kernel: Call Trace: [get_filesystem_info+214/1024]
[do_mmap_pgoff+818/992] [mounts_read_proc+34/80]
[proc_file_read+205/448] [sys_read+150/208] [system_call+51/64]
Feb 19 12:53:33 trol kernel:
Feb 19 12:53:33 trol kernel: Code: 8b 45 0c 89 04 24 39 c5 75 17 8b 54
24 20 8b 42 08 39 d0 74

---------------------------------------------------------------------------------------

And this is my system:

---------------------------------------------------------------------------------------

Linux version 2.4.1-ac18 (root@trol.kud-kontrabant.si) (gcc version 2.96
20000731 (Red Hat Linux 7.0)) #1 Mon Feb 19 14:51:43 CET
2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 000000000fefd8c0 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000000100 @ 000000000fffff00 (reserved)
 BIOS-e820: 0000000000002640 @ 000000000fffd8c0 (ACPI data)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000040000 @ 00000000fffc0000 (reserved)
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=l2.4.1ac18 ro root=301
BOOT_FILE=/boot/vmlinuz-2.4.1-ac18
video=matrox:vesa:0x117,fv=100
Initializing CPU#0
Detected 398.274 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 794.62 BogoMIPS
Memory: 255004k/262132k available (1349k kernel code, 6740k reserved,
536k data, 240k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd83c, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:02.0
PCI: Found IRQ 11 for device 00:02.2
PCI: The same IRQ used for device 00:03.0
  got res[1000:101f] for resource 4 of Intel Corporation 82371AB PIIX4
USB
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: Card 'Crystal Audio'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x0b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try
using pci=biosirq.
matroxfb: Matrox unknown G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x16bpp (virtual: 1024x8190)
matroxfb: framebuffer at 0xF4000000, mapped to 0xd0805000, size 16777216

Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169373kB/56457kB, 512 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 11
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL CX6.4A, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=784/255/63, UDMA(33)

hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf0000000
[drm] AGP 0.99 on Intel 440BX @ 0xf0000000 64MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 16, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c895 detected with Tekram NVRAM
sym53c895-0: rev 0x1 on pci bus 0 device 16 function 0 irq 10
sym53c895-0: Tekram format NVRAM, ID 7, Fast-40, Parity Checking
sym53c895-0: on-chip RAM at 0xf75ff000
sym53c895-0: restart (scsi reset).
sym53c895-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c895-0-<1,0>: tagged command queue depth set to 8
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
sym53c895-0-<1,0>: wide msgout: 1-2-3-1.
sym53c895-0-<1,0>: wide msgin: 1-2-3-1.
sym53c895-0-<1,0>: wide: wide=1 chg=0.
sym53c895-0-<1,0>: wide msgout: 1-2-3-1.
sym53c895-0-<1,0>: wide msgin: 1-2-3-1.
sym53c895-0-<1,0>: wide: wide=1 chg=0.
sym53c895-0-<1,0>: sync msgout: 1-3-1-a-1f.
sym53c895-0-<1,0>: sync msg in: 1-3-1-a-1f.
sym53c895-0-<1,0>: sync: per=10 scntl3=0x90 scntl4=0x0 ofs=31 fak=0
chg=0.
sym53c895-0-<1,*>: FAST-40 WIDE SCSI 80.0 MB/s (25 ns, offset 31)
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
 sda: sda1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 136512k swap-space (priority -1)
ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
<Crystal audio controller (CS4235)> at 0x534 irq 5 dma 1,0
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
<Yamaha OPL3> at 0x388
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:03.0
PCI: The same IRQ used for device 00:02.2
eth0: OEM i82557/i82558 10/100 Ethernet, 00:06:29:05:11:53, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000001-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
tr0: Unexpected interrupt from tr adapter
ibmtr.c: v1.3.57   8/ 7/94 Peter De Schrijver and Mark Swanson
         v2.1.125 10/20/98 Paul Norton <pnorton@ieee.org>
         v2.2.0   12/30/98 Joel Sloan <jjs@c-me.com>
         v2.2.1   02/08/00 Mike Sullivan <sullivam@us.ibm.com>
tr0: ISA 16/4 Adapter/A (short) | 16/4 ISA-16 Adapter found
tr0: using irq 3, PIOaddr a20, 16K shared RAM.
tr0: Hardware address : 08:00:5A:48:A9:85
tr0: Shared RAM paging enabled. Page size: 16K Shared Ram size 63K
tr0: Maximum MTU 16Mbps: 16344, 4Mbps: 6104
tr0: Initial interrupt : 16 Mbps, shared RAM base 000d0000.
tr0: Opend adapter: Xmit bfrs: 2 X 2048, Rcv bfrs: 16 X 1032
tr0: Adapter initialized and opened.
tr0: Setting functional address: 00 00 00 00
tr0: Setting functional address: 00 04 00 00
tr0: Setting functional address: 00 04 00 00
tr0: Setting functional address: 00 04 00 00
mtrr: 0xf4000000,0x2000000 overlaps existing 0xf4000000,0x1000000

--

                          \\\___///
                         \\  - -  //
                          (  @ @  )
+-----------------------oOOo-(_)-oOOo---------------------------+
|                                                               |
|                     WWW.KUD-KONTRABANT.SI                     |
|                         Janez Vrenjak                         |
|                 mailto:janez@kud-kontrabant.si                |
|                    tel.: +386-(0)41-406 089                   |
|                                                               |
+------------------------------------Oooo-----------------------+
                      oooO          (    )
                     (    )          )  /
                      \  (           (_/
                       \_)



