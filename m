Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTJFXpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 19:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTJFXpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 19:45:03 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:27135 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S261750AbTJFXo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 19:44:56 -0400
Date: Tue, 07 Oct 2003 01:44:47 +0200
From: Domen Puncer <domen@coderock.org>
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
In-reply-to: <Pine.LNX.4.53.0310061842030.19396@montezuma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200310070144.47822.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200310061529.56959.domen@coderock.org>
 <200310070033.53590.domen@coderock.org>
 <Pine.LNX.4.53.0310061842030.19396@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 of October 2003 00:43, Zwane Mwaikambo wrote:
> On Tue, 7 Oct 2003, Domen Puncer wrote:
> > > Ok, could you send your .config too, i use the 3c59x driver and haven't
> > > noticed this in 2.6.0-test5-mm4. My card is;
> >
> > .config at the end of mail
>
> Sorry i forgot to ask for a dmesg too (from a kernel exhibiting the
> problem)

Linux version 2.6.0-test6 (root@nd47) (gcc version 3.2.3) #27 Tue Oct 7 01:23:09 CEST 2003
Video mode to be used for restore is 305
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f7400
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=latest_kernel ro root=303 3
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1467.314 MHz processor.
Console: colour VGA+ 80x25
Memory: 513500k/524224k available (2972k kernel code, 9988k reserved, 895k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2891.77 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1c3f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9f7 c1c3f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP processor 1700+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb0d0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:11.2, from 11 to 10
PCI: Via IRQ fixup for 0000:00:11.3, from 11 to 10
PCI: Via IRQ fixup for 0000:00:11.4, from 11 to 10
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
ACPI: Thermal Zone [THRM] (47 C)
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xc0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L060AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k freed
Adding 530104k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400. Vers LK1.1.19
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 324 bytes per conntrack
eth0: no IPv6 routers present

Same dmesg is with the test2 driver, but when i reload test2 driver i get:
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400. Vers LK1.1.19
eth0: no IPv6 routers present
eth0: Setting full-duplex based on MII #24 link partner capability of 0141.

Might be relevant... the last line is lagged a couple of seconds, and network
works fine before i see that line in dmesg.

