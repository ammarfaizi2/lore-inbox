Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSAFOin>; Sun, 6 Jan 2002 09:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288962AbSAFOie>; Sun, 6 Jan 2002 09:38:34 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:46656 "EHLO
	tsmtp10.mail.isp") by vger.kernel.org with ESMTP id <S288960AbSAFOiV>;
	Sun, 6 Jan 2002 09:38:21 -0500
Date: Sun, 06 Jan 2002 15:41:45 +0100
From: grundig@teleline.es
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: PCI: Cannot allocate resource region 4 of device 00:01.1
Reply-To: grundig@teleline.es
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20020106143827Z288960-13996+1604@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Micro-star MS-5146 motherboard. Chipset is SIS 5571 Trinity
I get the following message when I boot (linux 2.4.18-pre1).

PCI: Cannot allocate resource region 4 of device 00:01.1

Here is dmesg:

Linux version 2.4.18pre1 (root@diego) (gcc version 2.95.4 20011006 (Debian
prerelease)) #2 Sat Dec 29 13:57:02 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hdc6 vga=0x30a idebus=66
ide_setup: idebus=66
Initializing CPU#0
Detected 200.456 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 399.76 BogoMIPS
Memory: 30424k/32768k available (823k kernel code, 1960k reserved, 198k
data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0080a135 00000000 00000000, vendor = 1
CPU: After vendor init, caps: 0080a135 00000000 00000000 00000004
CPU:     After generic, caps: 0080a135 00000000 00000000 00000004
CPU:             Common caps: 0080a135 00000000 00000000 00000004
CPU: Cyrix 6x86MX 3x Core/Bus Clock stepping 07
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Cyrix ARR
PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 4 of device 00:01.1
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:03
isapnp: CMI8330 quirk - fixing interrupts and dma
isapnp: Card 'CMI8330. Audio Adapter'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
block: 64 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
SIS5513: IDE controller on PCI bus 00 dev 09
SIS5513: chipset revision 193
SIS5513: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: ST32122A, ATA DISK drive
hdb: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
hdc: ST340016A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 4124736 sectors (2112 MB) w/128KiB Cache, CHS=1023/64/63
hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
Partition check:
 hda: hda1 hda2
 hdc: [DM6:DDO] [remap +63] [4865/255/63] hdc1 < hdc5 hdc6 hdc7 > hdc2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
reiserfs: checking transaction log (device 16:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 96348k swap-space (priority -1)
Real Time Clock Driver v1.10e
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
parport0: PC-style at 0x378 [PCSPP]
lp0: using parport0 (polling).
lp0: compatibility mode
lp0: compatibility mode
lp0: compatibility mode
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
PPP BSD Compression module registered
PPP Deflate Compression module registered
[drm] Initialized tdfx 1.0.0 20010216 on minor 0


Here is output of lspci:

root@diego:/# lspci -v -s 00:01.1
00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev c1)
(prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device 0040:0000
        Flags: bus master, fast devsel, latency 32, IRQ 14
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 1000 [size=16]

root@diego:/#


What means this? If I remeber, I've always seen this output since a lot of
time.




