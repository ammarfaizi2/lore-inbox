Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSH0NrW>; Tue, 27 Aug 2002 09:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSH0NrW>; Tue, 27 Aug 2002 09:47:22 -0400
Received: from [216.167.37.170] ([216.167.37.170]:11793 "EHLO cob427.dn.net")
	by vger.kernel.org with ESMTP id <S315928AbSH0NrU>;
	Tue, 27 Aug 2002 09:47:20 -0400
From: lists@corewars.org
Date: Tue, 27 Aug 2002 15:51:36 +0200
To: andy.grover@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19 hangs with ACPI turned on
Message-ID: <20020827155135.A11509@corewars.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using 2.4.19 on my Compaq Armada M700 laptop (PIII-750MHZ/256MB
SDRAM/10 GB IDE HDD with ext2 with the kernel compiled with acpi
enabled.

Roughly 4 out of every 5 times, the system hangs after the msg line
"NET4: Unix domain sockets 1.0/SMP for Linux NET4.0", and every once
in a few times, it boots.

It boots fine if I compile the kernel without ACPI support, or boot
with acpi=off.

Regards,
Sapan

Linux version 2.4.19 (root@solo) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 dim aoû 18 16:34:59 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3800 (reserved)
 BIOS-e820: 000000000fff3800 - 0000000010000000 (ACPI NVS)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=19 ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.19 reboot=warm
Initializing CPU#0
Detected 746.342 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1490.94 BogoMIPS
Memory: 256568k/262080k available (1413k kernel code, 5124k reserved, 567k data, 100k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf0478, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
    ACPI-0430: *** Warning: Global Lock has not be acquired, cannot release
ACPI: Subsystem enabled
Power Resource: found
Power Resource: found
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
ACPI: Power Button (FF) found
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
PCI: Found IRQ 11 for device 00:09.1
PCI: Sharing IRQ 11 with 00:08.0
PCI: Sharing IRQ 11 with 00:09.0
Redundant entry in serial pci_table.  Please send the output of
lspci -vv, this message (11c1,0445,8086,2203)
and the manufacturer and name of serial board or modem board
to serial-pci-info@lists.sourceforge.net.
register_serial(): autoconfig failed
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x3420-0x3427, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x3428-0x342f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23AA-12, ATA DISK drive
hdb: Compaq DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 23579136 sectors (12073 MB) w/512KiB Cache, CHS=1559/240/63, UDMA(33)
hdb: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 00:09.0
PCI: Sharing IRQ 11 with 00:08.0
PCI: Sharing IRQ 11 with 00:09.1
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:59:14:17:3B, IRQ 11.
  Board assembly 98003c-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0x50000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel 440BX @ 0x50000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:04.0
PCI: Sharing IRQ 11 with 00:04.1
PCI: Sharing IRQ 11 with 01:00.0
PCI: Found IRQ 11 for device 00:04.1
PCI: Sharing IRQ 11 with 00:04.0
PCI: Sharing IRQ 11 with 01:00.0
usb.c: registered new driver hub
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.



ACPI=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_CMBATT=y
CONFIG_ACPI_THERMAL=y


