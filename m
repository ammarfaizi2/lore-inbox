Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276318AbRJGLt4>; Sun, 7 Oct 2001 07:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276327AbRJGLtg>; Sun, 7 Oct 2001 07:49:36 -0400
Received: from viefep12-int.chello.at ([213.46.255.25]:14415 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id <S276318AbRJGLtY> convert rfc822-to-8bit; Sun, 7 Oct 2001 07:49:24 -0400
Subject: hdc: driver not present (cdrom) in 2.4.10
From: Florian Scandella <flo.scandella@aon.at>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15 (Preview Release)
Date: 07 Oct 2001 13:47:15 +0200
Message-Id: <1002455236.8341.14.camel@Spellcaster>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello

since i switched from 2.4.2 ( offizial rh7.1 ) to the new 2.4.10 kernel
i have the problem that the cdrom driver doesn't work anymore. i have an
sis735 chipset ( with athlon ). at boot time my cdrom drive is detected
but then it doesnt work ... 'dmesg' shows :

Linux version 2.4.10 (root@Spellcaster) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 Mon Okt 1 16:47:24 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ee000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=307
BOOT_FILE=/boot/vmlinuz-2.4.10 hdc=cdrom hdc=ide-scsi
ide_setup: hdc=cdrom
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1194.925 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2385.51 BogoMIPS
Memory: 255876k/262080k available (1013k kernel code, 5816k reserved,
270k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340823A, ATA DISK drive
hdc: RICOH DVD/CDRW MP9120, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78165360 sectors (40021 MB) w/1024KiB Cache, CHS=4865/255/63,
UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 > hda3
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected SiS 735 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on SiS @ 0xd0000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Real Time Clock Driver v1.10e
Adding Swap: 257000k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
SiS router pirq escape (99)
SiS router pirq escape (99)
usb-ohci.c: USB OHCI at membase 0xd0852000, IRQ 12
usb-ohci.c: usb-00:02.3, Silicon Integrated Systems [SiS] 7001 (#2)
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Found IRQ 11 for device 00:02.2
usb-ohci.c: USB OHCI at membase 0xd0854000, IRQ 11
usb-ohci.c: usb-00:02.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x45e/0x25) is not claimed by any active
driver.
usb.c: registered new driver hid
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with
IntelliEye] on usb1:2.0
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 11 for device 00:0b.0
PCI: Sharing IRQ 11 with 00:11.0
PCI: Sharing IRQ 11 with 00:11.1
eth0: RealTek RTL-8029 found at 0xd400, IRQ 11, 00:4F:49:0B:E7:83.
hdc: driver not present
hdc: driver not present

lsdmod shows the modules are loaded ..

Module                  Size  Used by
soundcore               3620   0  (autoclean)
ne2k-pci                5088   1  (autoclean)
8390                    6176   0  (autoclean) [ne2k-pci]
serial                 43840   0  (autoclean)
ide-cd                 27616   0 
cdrom                  28608   0  [ide-cd]
nls_iso8859-1           2848   2  (autoclean)
nls_cp437               4384   2  (autoclean)
vfat                    9308   2  (autoclean)
fat                    31512   0  (autoclean) [vfat]
mousedev                4000   1 
hid                    13120   0  (unused)
input                   3424   0  [mousedev hid]
usb-ohci               18624   0  (unused)
usbcore                48704   1  [hid usb-ohci]
rtc                     5752   0  (autoclean)
unix                   14340 216  (autoclean)

any ideas ? i would be very happy if i could use my cdrom :-)


flo

ps: if this problem is allready solved i'm sorry but i haven't found
anything in the kernel-archives ...





