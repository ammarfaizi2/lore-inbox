Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312684AbSCVGGI>; Fri, 22 Mar 2002 01:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312685AbSCVGF7>; Fri, 22 Mar 2002 01:05:59 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:33920 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S312684AbSCVGFx>; Fri, 22 Mar 2002 01:05:53 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 21 Mar 2002 22:10:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7, IDE, 'handler not null', 'kernel timer added twice'
In-Reply-To: <20020322055523.AAA14461@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.44.0203212207190.1580-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, David Schwartz wrote:

>
> 	I got the following from a 2.5.7 machine.
>
> hdc: ide_set_handler: handler not null; old=c01e5af0, new=c01e5af0
> bug: kernel timer added twice at c01e6925.
> hdc: ide_set_handler: handler not null; old=c01e5af0, new=c01e5af0
> bug: kernel timer added twice at c01e6925.

Same here, IDE guys knows about it. But it's still open :-(
Here's some dust :


Linux version 2.5.7 (root@blue1.dev.mcafeelabs.com) (gcc version 3.0.3) #1 Tue Mar 19 17:41:44 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
256MB LOWMEM available.
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.5.7 ro root=305 BOOT_FILE=/boot/vmlinuz-2.5.7
Initializing CPU#0
Detected 999.563 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 256796k/262144k available (1349k kernel code, 4960k reserved, 347k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb350, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
usb.c: registered new driver hub
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 256 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:14.0
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:02:B3:11:E5:92, IRQ 11.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 32M @ 0xd4000000
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
VIA Technologies, Inc. Bus Master IDE: unknown IDE controller on PCI slot 00:07.1, vendor=1106, device=0571
VIA Technologies, Inc. Bus Master IDE: chipset revision 16
VIA Technologies, Inc. Bus Master IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC WD205BA, ATA DISK drive
hdb: CD-ROM 50X L, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 40088160 sectors (20525 MB) w/2048KiB Cache, CHS=39770/16/63
hdb: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: [PTBL] [2495/255/63] hda1 hda2 < hda5 hda6 hda7 >
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 11 for device 00:07.2
PCI: Sharing IRQ 11 with 00:07.3
PCI: Sharing IRQ 11 with 00:14.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 11
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
PCI: Found IRQ 11 for device 00:07.3
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:14.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 11
hcd.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 530104k swap-space (priority -1)
NFS: NFSv3 not supported.
nfs warning: mount version older than kernel


00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
00:14.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF



/dev/hda:

 Model=WDC WD205BA, FwRev=16.13M16, SerialNo=WD-WM9491746366
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=40088160
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4



/dev/hdb:

 Model=CD-ROM 50X L, FwRev=15, SerialNo=
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:600,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: *mdma0 *mdma1 mdma2 udma0 udma1 *udma2



name			value		min		max		mode
----			-----		---		---		----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                2495            0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
bswap                   0               0               1               r
current_speed           0               0               69              rw
failures                0               0               65535           rw
ide_scsi                0               0               1               rw
init_speed              0               0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
wcache                  0               0               1               rw



name			value		min		max		mode
----			-----		---		---		----
current_speed           0               0               69              rw
dsc_overlap             1               0               1               rw
ide_scsi                0               0               1               rw
init_speed              0               0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
nice1                   1               0               1               rw
number                  1               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw





- Davide



