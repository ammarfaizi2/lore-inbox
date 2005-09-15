Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbVIOV2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbVIOV2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbVIOV2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:28:34 -0400
Received: from itapoa.terra.com.br ([200.176.10.194]:25227 "EHLO
	itapoa.terra.com.br") by vger.kernel.org with ESMTP
	id S1030551AbVIOV2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:28:33 -0400
X-Terra-Karma: -2%
X-Terra-Hash: b93efe979d8a28962043d9434a22e826
Message-ID: <4329E7CE.4000100@terra.com.br>
Date: Thu, 15 Sep 2005 18:29:50 -0300
From: Piter Punk <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with PS2 mouse
Content-Type: multipart/mixed;
 boundary="------------070204070000030509050003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070204070000030509050003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

	A problem with a VCOM PS2 optical mouse.

	In kernel 2.4.31 the machine lost the keyboard when i try
to access the mouse, i tried with gpm and with X, and both loses
the keyboard.

	In kernel 2.6.13 nothing happens. Nothing. The light in
the mouse is off and gpm runs but nothing happens. If i unplug the
VCOM mouse and plug other from MTek (with the machine on) and after
unplug the MTek plug VCOM again, the light starts and the mouse
works fine.

	I think is some problem with the mouse initialisation. Attached
with this mail is the output of lspci and dmesg.

	The VCOM mouse works with other machines.

							Piter PUNK

--------------070204070000030509050003
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.29 (root@midas) (gcc version 3.3.4) #8 Thu Jan 20 16:36:28 PST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
ACPI disabled because your bios is from 2000 and too old
You can enable it with acpi=force
Kernel command line: auto BOOT_IMAGE=Linux ro root=306
Initializing CPU#0
Detected 1100.056 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 2195.45 BogoMIPS
Memory: 515152k/524224k available (1959k kernel code, 8688k reserved, 649k data, 132k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
vesafb: framebuffer at 0xd2400000, mapped to 0xe080d000, size 1536k
vesafb: mode is 1024x768x8, linelength=1024, pages=4
vesafb: protected mode interface info at c972:000c
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdb: LTN486S, ATAPI CD/DVD-ROM drive
blk: queue c03dd8e0, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=2482/255/63
hdb: attached ide-cdrom driver.
hdb: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1576.800 MB/sec
   32regs    :  1050.800 MB/sec
   pII_mmx   :  2574.400 MB/sec
   p5_mmx    :  3289.200 MB/sec
raid5: using function: p5_mmx (3289.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.8(17/11/2003)
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
UMSDOS: msdos_read_super failed, mount aborted.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,6)) ...
for (ide0(3,6))
reiserfs: replayed 17 transactions in 4 seconds
ide0(3,6):Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 132k freed
Adding Swap: 289128k swap-space (priority -1)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 4M @ 0xd2000000
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,1)) ...
for (ide0(3,1))
reiserfs: replayed 1 transactions in 0 seconds
ide0(3,1):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,7)) ...
for (ide0(3,7))
reiserfs: replayed 2 transactions in 0 seconds
ide0(3,7):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,8)) ...
for (ide0(3,8))
reiserfs: replayed 1 transactions in 0 seconds
ide0(3,8):Using r5 hash to sort names
reiserfs: found format "3.6" with standard journal
reiserfs: checking transaction log (device ide0(3,9)) ...
for (ide0(3,9))
reiserfs: replayed 1 transactions in 1 seconds
ide0(3,9):Using r5 hash to sort names
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Intel ISA PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
ds: no socket drivers loaded!
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 11 for device 00:0a.0
eth0: RealTek RTL8139 at 0xe0d51000, 00:e0:7d:a9:05:c6, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
PCI: Found IRQ 10 for device 00:07.5
PCI: Setting latency timer of device 00:07.5 to 64
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 12 for device 00:07.2
PCI: Sharing IRQ 12 with 00:07.3
uhci.c: USB UHCI at I/O 0xd400, IRQ 12
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 12 for device 00:07.3
PCI: Sharing IRQ 12 with 00:07.2
uhci.c: USB UHCI at I/O 0xd800, IRQ 12
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
parport0: PC-style at 0x378 [PCSPP,EPP]
parport_pc: Via 686A parallel port: io=0x378
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.5

--------------070204070000030509050003
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 5598/6326 (rev c3)

--------------070204070000030509050003--
