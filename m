Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285443AbRLGJPZ>; Fri, 7 Dec 2001 04:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285444AbRLGJPI>; Fri, 7 Dec 2001 04:15:08 -0500
Received: from NS.iNES.RO ([193.230.220.1]:2510 "EHLO Master.iNES.RO")
	by vger.kernel.org with ESMTP id <S285443AbRLGJO5>;
	Fri, 7 Dec 2001 04:14:57 -0500
Subject: Re: [PATCH] 2.4.17-pre4 pnpbios driver available for testing
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1007668712.1384.52.camel@thanatos>
In-Reply-To: <1007668712.1384.52.camel@thanatos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 11:14:25 +0200
Message-Id: <1007716465.1660.0.camel@LNX.iNES.RO>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Also applies cleanly to 2.4.17-pre5

The machine is an Toshiba Satellite 1700-400

Works ok for me.

dmesg and lspnp -v output follows:

Linux version 2.4.17-pre5 (root@LNX.iNES.RO) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #2 Vi dec 7 10:42:53 EET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000eb800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
 BIOS-e820: 000000000bff0000 - 000000000bfffc00 (ACPI data)
 BIOS-e820: 000000000bfffc00 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda3 video=vesa:ywrap,mtrr vga=791 
Initializing CPU#0
Detected 696.589 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1389.36 BogoMIPS
Memory: 191548k/196544k available (883k kernel code, 4608k reserved, 214k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9be, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 10 for device 00:04.0
PCI: Sharing IRQ 10 with 01:00.0
PCI: Found IRQ 10 for device 00:04.1
PCI: Cannot allocate resource region 4 of device 00:07.1
Limiting direct PCI/PCI transfers.
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7470.
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa905, dseg 0x400.
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver.
PnPBIOS: PNP0c02: ioport range 0x4d0-0x4d1 has been reserved.
PnPBIOS: PNP0c02: ioport range 0x1000-0x103f has been reserved.
PnPBIOS: PNP0c02: ioport range 0x1040-0x104f has been reserved.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
Journalled Block Device driver loaded
vesafb: framebuffer at 0xfd000000, mapped to 0xcc800000, size 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:4f7c
vesafb: pmi: set display start = c00c4fe2, set palette = c00c503c
vesafb: pmi: ports = 2085 201f 20b4 20b8 2018 2014 20c0 20c3 20c1 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=2048
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Software Watchdog Timer: 0.05, timer margin: 60 sec
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1090-0x1097, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1098-0x109f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=1222/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Real Time Clock Driver v1.10e
Adding Swap: 136544k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 10:52:25 Dec  7 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:07.2 (0000 -> 0001)
PCI: Found IRQ 10 for device 00:07.2
PCI: Sharing IRQ 10 with 00:10.0
usb-uhci.c: USB UHCI at I/O 0x1060, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: USB device 2 (vend/prod 0x458/0x3) is not claimed by any active driver.
usb.c: registered new driver hid
input0: USB HID v1.00 Mouse [KYE Systems Genius USB Wheel Mouse   ] on usb1:2.0
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,3), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ip_conntrack (1535 buckets, 12280 max)
Linux Kernel Card Services 3.1.30
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 10 for device 00:04.0
PCI: Sharing IRQ 10 with 01:00.0
PCI: Found IRQ 10 for device 00:04.1
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000006
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000010
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: NE2000 Compatible: io 0x300, irq 3, hw_addr 00:A0:0C:80:12:B4
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
VFS: Disk change detected on device ide1(22,0)
cs4281: version v1.13.32 time 10:52:06 Dec  7 2001
PCI: Enabling device 00:08.0 (0000 -> 0002)
PCI: Found IRQ 5 for device 00:08.0


00 PNP0c02 system peripheral: other
	io 0x0080-0x0080
	mem 0xfff80000-0xffffffff

01 PNP0c01 memory controller: RAM
	mem 0x00000000-0x0009ffff
	mem 0x000e8000-0x000fffff
	mem 0x00100000-0x0c0fffff

02 PNP0200 system peripheral: DMA controller
	io 0x0000-0x000f
	io 0x0081-0x008f
	io 0x00c0-0x00df
	dma 4

03 PNP0000 system peripheral: programmable interrupt controller
	io 0x0020-0x0021
	io 0x00a0-0x00a1
	irq 2

04 PNP0100 system peripheral: system timer
	io 0x0040-0x0043
	irq 0

05 PNP0b00 system peripheral: real time clock
	io 0x0070-0x0071
	irq 8

06 PNP0303 input device: keyboard
	io 0x0060-0x0060
	io 0x0064-0x0064
	irq 1

07 PNP0c04 reserved: other
	io 0x00f0-0x00ff
	irq 13

08 PNP0800 multimedia controller: audio
	io 0x0061-0x0061

09 PNP0a03 bridge controller: PCI
	io 0x0cf8-0x0cff

0a PNP0c02 bridge controller: ISA
	io 0x04d0-0x04d1
	io 0x1000-0x103f
	io 0x1040-0x104f
	io 0x0010-0x0018
	io 0x001f-0x001f
	io 0x0024-0x0025
	io 0x0028-0x0029
	io 0x002c-0x002d
	io 0x0030-0x0031
	io 0x0034-0x0035
	io 0x0038-0x0039
	io 0x003c-0x003d
	io 0x0050-0x0052
	io 0x0072-0x0077
	io 0x0090-0x009f
	io 0x00a4-0x00a5
	io 0x00a8-0x00a9
	io 0x00ac-0x00ad
	io 0x00b0-0x00bd

0b PNP0c02 memory controller: RAM
	mem 0x000e4000-0x000e7fff

0c PNP0c02 memory controller: RAM
	mem disabled
	mem disabled
	mem disabled
	mem disabled
	mem disabled
	mem disabled

11 PNP0f13 input device: mouse
	irq 12

15 PNP0700 mass storage device: floppy
	io 0x03f0-0x03f5
	io 0x03f7-0x03f7
	irq 6
	dma 2

17 PNP0400 communications device: AT parallel port
	io 0x0378-0x037f
	irq 7


On Jo, 2001-12-06 at 21:58, Thomas Hood wrote:
> The pnpbios driver which was being developed in the 2.4.x-acy kernel
> series is now available as a patch against 2.4.17-pre4:
>   http://panopticon.csustan.edu/thood/patch-2.4.17-pre4-pnpbios_1
> 
> A link to the patch can be found at:
>   http://panopticon.csustan.edu/thood/tp600lnx.htm
> 
> Interested parties: Please test and report back.
> 
> Because this is the first cut of the patch and because the
> driver hasn't been tested in the non-ac kernel series before,
> I recommend caution, especially to Sony Vaio and Dell laptop
> users.
> 
> Thomas Hood
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


