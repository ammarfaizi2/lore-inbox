Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312803AbSDYMev>; Thu, 25 Apr 2002 08:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDYMeu>; Thu, 25 Apr 2002 08:34:50 -0400
Received: from smokey.blackcatnetworks.co.uk ([212.135.138.139]:739 "EHLO
	smokey.blackcatnetworks.co.uk") by vger.kernel.org with ESMTP
	id <S312803AbSDYMer>; Thu, 25 Apr 2002 08:34:47 -0400
Date: Thu, 25 Apr 2002 13:34:45 +0100
From: Alex Walker <alex@x3ja.co.uk>
To: LKML <linux-kernel@vger.kernel.org>
Subject: "Unable to reserve I/O region" on tulip network card.
Message-ID: <20020425133445.P23497@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Please CC me in replies - not subscribed]

Hiya,

Thanks for the help on the usb OOPSs.

Now I have a problem with my network card in 2.5.10 - I cannot make it
ifup, although the link lights are on.  2.4.18 works fine with the card,
so it's not fitted wrong or anything.

Anyway, the error is as follows:

Linux Tulip driver version 1.1.12 (Mar 07, 2002)
PCI: Could not assign IRQ 21 to device 02:09.0
eth0: Lite-On PNIC-II rev 37 at 0xd4bcec00, 00:C0:F0:76:95:0A, IRQ 21.
PCI: Could not assign IRQ 22 to device 02:0a.0

The relevant part of lspci is:
02:09.0 Ethernet controller: Lite-On Communications INC LNE100TX [Linksys EtherFast 10/100] (rev 25)

I have tried compiling the tulip driver in and having it as a module,
but with the same results.

Attached are my config, and the log of bootup, with a bit of fiddling
with loading and unloading the module at the end.

Thankyou for serial consoles so I don't have to copy all the info by
hand!

Any more info needed, just ask.

Alex.

-- 
\\\\\\\\               Getting into trouble is easy.                ////////
\\\\\\                   -- D. Winkel and F. Prosser                  //////
\\\\                                                                    ////
\\                                                                        //

--f+W+jCU1fRNres8c
Content-Type: application/octet-stream
Content-Description: My config for 2.5.10
Content-Disposition: attachment; filename="config-2.5.10.gz"
Content-Transfer-Encoding: base64

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
So3w/9kgbJcPWQAA

--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Description: My kernel boot log for 2.5.10
Content-Disposition: attachment; filename="boot-2.5.10"

LILO 22.2 boot: 2.5.10
Loading 2.5.10..................
Linux version 2.5.10 (alex@numbers) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Thu Apr 25 10:46:15 BST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000013fc0000 (usable)
 BIOS-e820: 0000000013fc0000 - 0000000013ff8000 (ACPI data)
 BIOS-e820: 0000000013ff8000 - 0000000014000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
319MB LOWMEM available.
On node 0 totalpages: 81856
zone(0): 4096 pages.
zone(1): 77760 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 AMI                        ) @ 0x000ff980
ACPI: RSDT (v001 GATEWA EA81510A 08193.01059) @ 0x13ff0000
ACPI: FADT (v001 GATEWA EA81510A 08193.01059) @ 0x13ff1000
ACPI: BOOT (v001 GATEWA EA81510A 08193.01059) @ 0x13ff4000
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=2.5.10 ro root=306 console=ttyS0 console=tty0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 930.241 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1854.66 BogoMIPS
Memory: 321828k/327424k available (1390k kernel code, 5208k reserved, 447k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
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
..... CPU clock speed is 930.2335 MHz.
..... host bus clock speed is 132.8904 MHz.
cpu: 0, clocks: 1328904, slice: 664452
CPU0<T0:1328896,T1:664432,D:12,S:664452,C:1328904>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
ACPI: Bus Driver revision 20020404
ACPI: Core Subsystem revision 20020403
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00:00.00)
Unknown bridge resource 0: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
usb.c: registered new driver usbfs
usb.c: registered new driver hub
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU1] (supports C1)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.11
block: 256 slots per queue, batch=32
Linux video capture interface: v1.00
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 64M @ 0xf8000000
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: IDE controller on PCI slot 00:1f.1
Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: chipset revision 2
Intel Corp. 82820 820 (Camino 2) Chipset IDE U100: not 100% native mode: will probe irqs later
PIIX: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 UDMA100 controller on pci00:1f.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdb: SAMSUNG SV2044D, ATA DISK drive
hdc: MATSHITADVD-ROM SR-8586, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt 0 14
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63, (U)DMA
hdb: 39862368 sectors (20410 MB) w/472KiB Cache, CHS=39546/16/63, UDMA(66)
Partition check:
 hda: [PTBL] [2482/255/63] hda1 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
usb-uhci.c: $Revision: 1.275 $ time 10:36:47 Apr 25 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Could not assign IRQ 19 to device 00:1f.2
PCI: Setting latency timer of device 00:1f.2 to 64
usb-uhci.c: USB UHCI at I/O 0xef40, IRQ 19
usb-uhci.c: Detected 2 ports
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
PCI: Could not assign IRQ 23 to device 00:1f.4
PCI: Setting latency timer of device 00:1f.4 to 64
usb-uhci.c: USB UHCI at I/O 0xef80, IRQ 23
usb-uhci.c: Detected 2 ports
hcd.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.31:USB HID core driver
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device 03:06, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,6)) for (ide0(3,6))
Using tea hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 220k freed
hub.c: new USB device 00:1f.2-2, assigned address 2
Adding Swap: 489940k swap-space (priority -1)
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device 03:09, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,9)) for (ide0(3,9))
Using tea hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device 03:08, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,8)) for (ide0(3,8))
Using tea hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device 03:07, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,7)) for (ide0(3,7))
Using tea hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device 03:0a, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (ide0(3,10)) for (ide0(3,10))
Using tea hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,13), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: Using codepage cp437
FAT: Using IO charset iso8859-1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,74), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Tulip driver version 1.1.12 (Mar 07, 2002)
PCI: Could not assign IRQ 21 to device 02:09.0
eth0: Lite-On PNIC-II rev 37 at 0xd4bcec00, 00:C0:F0:76:95:0A, IRQ 21.
PCI: Could not assign IRQ 22 to device 02:0a.0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
error: nfsd[349] exited with preempt_count 1
error: nfsd[348] exited with preempt_count 1
error: nfsd[347] exited with preempt_count 1
error: nfsd[346] exited with preempt_count 1
error: nfsd[345] exited with preempt_count 1
error: nfsd[344] exited with preempt_count 1
error: nfsd[343] exited with preempt_count 1
Linux Tulip driver version 1.1.12 (Mar 07, 2002)
PCI: Could not assign IRQ 21 to device 02:09.0
PCI: Unable to reserve I/O region #1:100@d800 for device 02:09.0


--f+W+jCU1fRNres8c--
