Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbTJUJGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbTJUJGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:06:13 -0400
Received: from mail2.intermedia.net ([206.40.48.152]:26382 "EHLO
	mail2.intermedia.net") by vger.kernel.org with ESMTP
	id S262536AbTJUJEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:04:39 -0400
From: "Mario \"jorge\" Di Nitto" <jorge78@inwind.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test8-mm1 failure..
Date: Tue, 21 Oct 2003 11:07:36 +0200
User-Agent: KMail/1.5.4
References: <200310202008.23294.jorge78@inwind.it> <20031020120029.78a69465.akpm@osdl.org>
In-Reply-To: <20031020120029.78a69465.akpm@osdl.org>
MIME-Version: 1.0
Message-Id: <200310211106.19275.jorge78@inwind.it>
Cc: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YdPl//CKvdtEoPH"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YdPl//CKvdtEoPH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew,

Alle 21:00, luned=EC 20 ottobre 2003, hai scritto:
> "Mario \"jorge\" Di Nitto" <jorge78@inwind.it> wrote:
> > I've just tryed 2.6.0-test8-mm1 and I've got this failure at boot (last
> > 100 lines of /var/log/messages):
>
> Please set CONFIG_KALLSYMS=3Dy and resend the oops trace so we can
> see where it crashed, thanks.

I've changed some items in .config, and after next reboot I've got other=20
failures like those I already wrote.
The last boot shows multiple oops (4 I think, in dmesg), see attached files=
=20
for details.
CONFIG_KALLSYMS was set in both last .config.
Regards,
						Jorge =20



--Boundary-00=_YdPl//CKvdtEoPH
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.0-test8-mm1 (root@D998) (gcc version 3.3.2 (Debian)) #3 Tue Oct 21 00:26:48 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001def0000 (usable)
 BIOS-e820: 000000001def0000 - 000000001deff000 (ACPI data)
 BIOS-e820: 000000001deff000 - 000000001df00000 (ACPI NVS)
 BIOS-e820: 000000001df00000 - 000000001e000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
480MB LOWMEM available.
On node 0 totalpages: 122880
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 118784 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f70b0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1defaec7
ACPI: FADT (v001 SiS    650      0x06040000 PTL  0x000f4240) @ 0x1defef8c
ACPI: DSDT (v001 PTLTD      BY25 0x06040000 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6-t8 ro root=304
No local APIC present or hardware disabled
mapped 4G/4G trampoline to fffeb000.
current: 023c9a60
current->thread_info: 0245c000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1593.812 MHz processor.
Console: colour VGA+ 80x25
Memory: 480008k/491520k available (2348k kernel code, 10700k reserved, 1089k data, 188k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 3145.72 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 1908k freed
CPU:     After generic identify, caps: 3febf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 3febf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd98e, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: Embedded Controller [EC0] (gpe 23)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0x020f70f0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9e25, dseg 0x400
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 650 chipset
agpgart: Maximum main memory to use for agp memory: 410M
agpgart: AGP aperture is 64M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0x2082d800, 00:02:3f:ac:dc:96, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0x9480-0x9487, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9488-0x948f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3 p4
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-C2502  Rev: 1011
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[ec002000-ec0027ff]  Max Packet=[2048]
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 15
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f261c0045e8]
intel8x0_measure_ac97_clock: measured 49345 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: SiS SI7012 at 0x8800, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Couldn't find valid RAM disk image starting at 0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
Adding 257032k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
[drm] Initialized sis 1.1.0 20030826 on minor 0
sisfb: Video ROM found and mapped to 020c0000
sisfb: Framebuffer at 0xf0000000, mapped to 0x20907000, size 32768k
sisfb: MMIO at 0xec100000, mapped to 0x20892000, size 128k
sisfb: Memory heap starting at 31744K
sisfb: Using MMIO queue mode
sisfb: Detected SiS302LV video bridge
sisfb: Detected LCD PanelDelayCompensation 1
sisfb: Default mode is 800x600x8 (60Hz)
sisfb: Initial vbflags 0x8000012
sisfb: Added MTRRs
sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
sisfb: Installed SISFB_GET_VBRSTATUS ioctl (80046ef9)
sisfb: 2D acceleration is enabled, scrolling mode ypan
fb0: SIS 65x/M65x/66xFX/M66xFX/74x VGA frame buffer device, Version 1.6.21
sisfb: (C) 2001-2003 Thomas Winischhofer. All rights reserved.
NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS volume version 3.1.
eth0: link down
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
Yenta: CardBus bridge found at 0000:00:09.0 [1025:001a]
Yenta: ISA IRQ list 0000, PCI irq10
Socket status: 30000006
Yenta: CardBus bridge found at 0000:00:09.1 [1025:001a]
Yenta: ISA IRQ list 0098, PCI irq10
Socket status: 30000006
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x20f 0x3c0-0x3df 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Unable to handle kernel paging request at virtual address 00002000
 printing eip:
000067ae
*pde = 00000000
Oops: 0004 [#1]
PREEMPT 
CPU:    0
EIP:    c000:[<000067ae>]    Not tainted VLI
EFLAGS: 00033246
EIP is at 0x67ae
eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1fe6df24
ds: 0000   es: 0000   ss: 0068
Process XFree86 (pid: 351, threadinfo=1fe6c000 task=037006b0)
Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
       00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
       ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Call Trace:

Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 00002000
 printing eip:
000067ae
*pde = 00000000
Oops: 0004 [#2]
PREEMPT 
CPU:    0
EIP:    c000:[<000067ae>]    Not tainted VLI
EFLAGS: 00033246
EIP is at 0x67ae
eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1e381f24
ds: 0000   es: 0000   ss: 0068
Process XFree86 (pid: 383, threadinfo=1e380000 task=1e383940)
Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
       00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
       ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Call Trace:

Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 00002000
 printing eip:
000067ae
*pde = 00000000
Oops: 0004 [#3]
PREEMPT 
CPU:    0
EIP:    c000:[<000067ae>]    Not tainted VLI
EFLAGS: 00033246
EIP is at 0x67ae
eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1fe6df24
ds: 0000   es: 0000   ss: 0068
Process XFree86 (pid: 388, threadinfo=1fe6c000 task=037006b0)
Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
       00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
       ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Call Trace:

Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 00002000
 printing eip:
000067ae
*pde = 00000000
Oops: 0004 [#4]
PREEMPT 
CPU:    0
EIP:    c000:[<000067ae>]    Not tainted VLI
EFLAGS: 00033246
EIP is at 0x67ae
eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1e3d1f24
ds: 0000   es: 0000   ss: 0068
Process XFree86 (pid: 393, threadinfo=1e3d0000 task=1e960080)
Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
       00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
       ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Call Trace:

Code:  Bad EIP value.
 

--Boundary-00=_YdPl//CKvdtEoPH
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kern.log"

Oct 21 10:36:58 D998 kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 21 10:36:58 D998 kernel: loop: loaded (max 8 devices)
Oct 21 10:36:58 D998 kernel: PPP generic driver version 2.4.2
Oct 21 10:36:58 D998 kernel: PPP Deflate Compression module registered
Oct 21 10:36:58 D998 kernel: PPP BSD Compression module registered
Oct 21 10:36:58 D998 kernel: 8139too Fast Ethernet driver 0.9.26
Oct 21 10:36:58 D998 kernel: eth0: RealTek RTL8139 at 0x2082d800, 00:02:3f:ac:dc:96, IRQ 10
Oct 21 10:36:58 D998 kernel: eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Oct 21 10:36:58 D998 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct 21 10:36:58 D998 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 21 10:36:58 D998 kernel: SIS5513: IDE controller at PCI slot 0000:00:02.5
Oct 21 10:36:58 D998 kernel: SIS5513: chipset revision 208
Oct 21 10:36:58 D998 kernel: SIS5513: not 100%% native mode: will probe irqs later
Oct 21 10:36:58 D998 kernel: SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
Oct 21 10:36:58 D998 kernel:     ide0: BM-DMA at 0x9480-0x9487, BIOS settings: hda:DMA, hdb:pio
Oct 21 10:36:58 D998 kernel:     ide1: BM-DMA at 0x9488-0x948f, BIOS settings: hdc:DMA, hdd:pio
Oct 21 10:36:58 D998 kernel: hda: IC25N020ATCS04-0, ATA DISK drive
Oct 21 10:36:58 D998 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 21 10:36:58 D998 kernel: hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
Oct 21 10:36:58 D998 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 21 10:36:58 D998 kernel: hda: max request size: 128KiB
Oct 21 10:36:58 D998 kernel: hda: 39070080 sectors (20003 MB) w/1768KiB Cache, CHS=38760/16/63, UDMA(33)
Oct 21 10:36:58 D998 kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3 p4
Oct 21 10:36:58 D998 kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Oct 21 10:36:58 D998 kernel:   Vendor: TOSHIBA   Model: DVD-ROM SD-C2502  Rev: 1011
Oct 21 10:36:58 D998 kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 21 10:36:58 D998 kernel: sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Oct 21 10:36:58 D998 kernel: Uniform CD-ROM driver Revision: 3.12
Oct 21 10:36:58 D998 kernel: Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Oct 21 10:36:58 D998 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Oct 21 10:36:58 D998 kernel: ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
Oct 21 10:36:58 D998 kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[5]  MMIO=[ec002000-ec0027ff]  Max Packet=[2048]
Oct 21 10:36:58 D998 kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Oct 21 10:36:58 D998 kernel: drivers/usb/core/usb.c: registered new driver usblp
Oct 21 10:36:58 D998 kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Oct 21 10:36:58 D998 kernel: Initializing USB Mass Storage driver...
Oct 21 10:36:58 D998 kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Oct 21 10:36:58 D998 kernel: USB Mass Storage support registered.
Oct 21 10:36:58 D998 kernel: drivers/usb/core/usb.c: registered new driver hiddev
Oct 21 10:36:58 D998 kernel: drivers/usb/core/usb.c: registered new driver hid
Oct 21 10:36:58 D998 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Oct 21 10:36:58 D998 kernel: drivers/usb/core/usb.c: registered new driver usbscanner
Oct 21 10:36:58 D998 kernel: drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
Oct 21 10:36:58 D998 kernel: mice: PS/2 mouse device common for all mice
Oct 21 10:36:58 D998 kernel: input: PS/2 Generic Mouse on isa0060/serio1
Oct 21 10:36:58 D998 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 21 10:36:58 D998 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 21 10:36:58 D998 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 21 10:36:58 D998 kernel: I2O Core - (C) Copyright 1999 Red Hat Software
Oct 21 10:36:58 D998 kernel: I2O: Event thread created as pid 15
Oct 21 10:36:58 D998 kernel: i2o: Checking for PCI I2O controllers...
Oct 21 10:36:58 D998 kernel: I2O configuration manager v 0.04.
Oct 21 10:36:58 D998 kernel:   (C) Copyright 1999 Red Hat Software
Oct 21 10:36:58 D998 kernel: I2O Block Storage OSM v0.9
Oct 21 10:36:58 D998 kernel:    (c) Copyright 1999-2001 Red Hat Software.
Oct 21 10:36:58 D998 kernel: i2o_block: Checking for Boot device...
Oct 21 10:36:58 D998 kernel: i2o_block: Checking for I2O Block devices...
Oct 21 10:36:58 D998 kernel: i2c /dev entries driver
Oct 21 10:36:58 D998 kernel: Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
Oct 21 10:36:58 D998 kernel: request_module: failed /sbin/modprobe -- snd-card-0. error = -16
Oct 21 10:36:58 D998 kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f261c0045e8]
Oct 21 10:36:58 D998 kernel: intel8x0_measure_ac97_clock: measured 49345 usecs
Oct 21 10:36:58 D998 kernel: intel8x0: clocking to 48000
Oct 21 10:36:58 D998 kernel: ALSA device list:
Oct 21 10:36:58 D998 kernel:   #0: SiS SI7012 at 0x8800, irq 5
Oct 21 10:36:58 D998 kernel: NET: Registered protocol family 2
Oct 21 10:36:58 D998 kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Oct 21 10:36:58 D998 kernel: TCP: Hash tables configured (established 32768 bind 65536)
Oct 21 10:36:58 D998 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct 21 10:36:58 D998 kernel: NET: Registered protocol family 1
Oct 21 10:36:58 D998 kernel: NET: Registered protocol family 17
Oct 21 10:36:58 D998 kernel: PM: Reading pmdisk image.
Oct 21 10:36:58 D998 kernel: PM: Resume from disk failed.
Oct 21 10:36:58 D998 kernel: ACPI: (supports S0 S3 S4 S5)
Oct 21 10:36:58 D998 kernel: RAMDISK: Couldn't find valid RAM disk image starting at 0.
Oct 21 10:36:58 D998 kernel: kjournald starting.  Commit interval 5 seconds
Oct 21 10:36:58 D998 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 21 10:36:58 D998 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct 21 10:36:58 D998 kernel: Mounted devfs on /dev
Oct 21 10:36:58 D998 kernel: Freeing unused kernel memory: 188k freed
Oct 21 10:36:58 D998 kernel: Adding 257032k swap on /dev/hda3.  Priority:-1 extents:1
Oct 21 10:36:58 D998 kernel: EXT3 FS on hda4, internal journal
Oct 21 10:36:58 D998 kernel: IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
Oct 21 10:36:58 D998 kernel: ACPI: AC Adapter [ACAD] (on-line)
Oct 21 10:36:58 D998 kernel: ACPI: Battery Slot [BAT1] (battery absent)
Oct 21 10:36:58 D998 kernel: ACPI: Power Button (FF) [PWRF]
Oct 21 10:36:58 D998 kernel: ACPI: Lid Switch [LID]
Oct 21 10:36:58 D998 kernel: ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
Oct 21 10:36:58 D998 kernel: [drm] Initialized sis 1.1.0 20030826 on minor 0
Oct 21 10:36:58 D998 kernel: sisfb: Video ROM found and mapped to 020c0000
Oct 21 10:36:58 D998 kernel: sisfb: Framebuffer at 0xf0000000, mapped to 0x20907000, size 32768k
Oct 21 10:36:58 D998 kernel: sisfb: MMIO at 0xec100000, mapped to 0x20892000, size 128k
Oct 21 10:36:58 D998 kernel: sisfb: Memory heap starting at 31744K
Oct 21 10:36:58 D998 kernel: sisfb: Using MMIO queue mode
Oct 21 10:36:58 D998 kernel: sisfb: Detected SiS302LV video bridge
Oct 21 10:36:58 D998 kernel: sisfb: Detected LCD PanelDelayCompensation 1
Oct 21 10:36:58 D998 kernel: sisfb: Default mode is 800x600x8 (60Hz)
Oct 21 10:36:58 D998 kernel: sisfb: Initial vbflags 0x8000012
Oct 21 10:36:58 D998 kernel: sisfb: Added MTRRs
Oct 21 10:36:58 D998 kernel: sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
Oct 21 10:36:58 D998 kernel: sisfb: Installed SISFB_GET_VBRSTATUS ioctl (80046ef9)
Oct 21 10:36:58 D998 kernel: sisfb: 2D acceleration is enabled, scrolling mode ypan
Oct 21 10:36:58 D998 kernel: fb0: SIS 65x/M65x/66xFX/M66xFX/74x VGA frame buffer device, Version 1.6.21
Oct 21 10:36:58 D998 kernel: sisfb: (C) 2001-2003 Thomas Winischhofer. All rights reserved.
Oct 21 10:36:58 D998 kernel: NTFS driver 2.1.4 [Flags: R/O MODULE].
Oct 21 10:36:58 D998 kernel: NTFS volume version 3.1.
Oct 21 10:36:58 D998 kernel: eth0: link down
Oct 21 10:37:03 D998 kernel: Linux Kernel Card Services
Oct 21 10:37:03 D998 kernel:   options:  [pci] [cardbus] [pm]
Oct 21 10:37:03 D998 kernel: Intel PCIC probe: not found.
Oct 21 10:37:03 D998 kernel: Yenta: CardBus bridge found at 0000:00:09.0 [1025:001a]
Oct 21 10:37:03 D998 kernel: Yenta: ISA IRQ list 0000, PCI irq10
Oct 21 10:37:03 D998 kernel: Socket status: 30000006
Oct 21 10:37:03 D998 kernel: Yenta: CardBus bridge found at 0000:00:09.1 [1025:001a]
Oct 21 10:37:03 D998 kernel: Yenta: ISA IRQ list 0098, PCI irq10
Oct 21 10:37:03 D998 kernel: Socket status: 30000006
Oct 21 10:37:04 D998 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 21 10:37:04 D998 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Oct 21 10:37:04 D998 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x20f 0x3c0-0x3df 0x480-0x48f 0x4d0-0x4d7
Oct 21 10:37:04 D998 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 21 10:37:10 D998 kernel: Unable to handle kernel paging request at virtual address 00002000
Oct 21 10:37:10 D998 kernel:  printing eip:
Oct 21 10:37:10 D998 kernel: 000067ae
Oct 21 10:37:10 D998 kernel: *pde = 00000000
Oct 21 10:37:10 D998 kernel: Oops: 0004 [#1]
Oct 21 10:37:10 D998 kernel: PREEMPT 
Oct 21 10:37:10 D998 kernel: CPU:    0
Oct 21 10:37:10 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 21 10:37:10 D998 kernel: EFLAGS: 00033246
Oct 21 10:37:10 D998 kernel: EIP is at 0x67ae
Oct 21 10:37:10 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
Oct 21 10:37:10 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1fe6df24
Oct 21 10:37:10 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 21 10:37:10 D998 kernel: Process XFree86 (pid: 351, threadinfo=1fe6c000 task=037006b0)
Oct 21 10:37:10 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
Oct 21 10:37:10 D998 kernel:        00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:10 D998 kernel:        ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:10 D998 kernel: Call Trace:
Oct 21 10:37:10 D998 kernel: 
Oct 21 10:37:10 D998 kernel: Code:  Bad EIP value.
Oct 21 10:37:11 D998 kernel:  <1>Unable to handle kernel paging request at virtual address 00002000
Oct 21 10:37:11 D998 kernel:  printing eip:
Oct 21 10:37:11 D998 kernel: 000067ae
Oct 21 10:37:11 D998 kernel: *pde = 00000000
Oct 21 10:37:11 D998 kernel: Oops: 0004 [#2]
Oct 21 10:37:11 D998 kernel: PREEMPT 
Oct 21 10:37:11 D998 kernel: CPU:    0
Oct 21 10:37:11 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 21 10:37:11 D998 kernel: EFLAGS: 00033246
Oct 21 10:37:11 D998 kernel: EIP is at 0x67ae
Oct 21 10:37:11 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
Oct 21 10:37:11 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1e381f24
Oct 21 10:37:11 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 21 10:37:11 D998 kernel: Process XFree86 (pid: 383, threadinfo=1e380000 task=1e383940)
Oct 21 10:37:11 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
Oct 21 10:37:11 D998 kernel:        00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:11 D998 kernel:        ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:11 D998 kernel: Call Trace:
Oct 21 10:37:11 D998 kernel: 
Oct 21 10:37:11 D998 kernel: Code:  Bad EIP value.
Oct 21 10:37:13 D998 kernel:  <1>Unable to handle kernel paging request at virtual address 00002000
Oct 21 10:37:13 D998 kernel:  printing eip:
Oct 21 10:37:13 D998 kernel: 000067ae
Oct 21 10:37:13 D998 kernel: *pde = 00000000
Oct 21 10:37:13 D998 kernel: Oops: 0004 [#3]
Oct 21 10:37:13 D998 kernel: PREEMPT 
Oct 21 10:37:13 D998 kernel: CPU:    0
Oct 21 10:37:13 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 21 10:37:13 D998 kernel: EFLAGS: 00033246
Oct 21 10:37:13 D998 kernel: EIP is at 0x67ae
Oct 21 10:37:13 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
Oct 21 10:37:13 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1fe6df24
Oct 21 10:37:13 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 21 10:37:13 D998 kernel: Process XFree86 (pid: 388, threadinfo=1fe6c000 task=037006b0)
Oct 21 10:37:13 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
Oct 21 10:37:13 D998 kernel:        00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:13 D998 kernel:        ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:13 D998 kernel: Call Trace:
Oct 21 10:37:13 D998 kernel: 
Oct 21 10:37:13 D998 kernel: Code:  Bad EIP value.
Oct 21 10:37:15 D998 kernel:  <1>Unable to handle kernel paging request at virtual address 00002000
Oct 21 10:37:15 D998 kernel:  printing eip:
Oct 21 10:37:15 D998 kernel: 000067ae
Oct 21 10:37:15 D998 kernel: *pde = 00000000
Oct 21 10:37:15 D998 kernel: Oops: 0004 [#4]
Oct 21 10:37:15 D998 kernel: PREEMPT 
Oct 21 10:37:15 D998 kernel: CPU:    0
Oct 21 10:37:15 D998 kernel: EIP:    c000:[<000067ae>]    Not tainted VLI
Oct 21 10:37:15 D998 kernel: EFLAGS: 00033246
Oct 21 10:37:15 D998 kernel: EIP is at 0x67ae
Oct 21 10:37:15 D998 kernel: eax: 00004f00   ebx: 00000000   ecx: 00000000   edx: 00000000
Oct 21 10:37:15 D998 kernel: esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 1e3d1f24
Oct 21 10:37:15 D998 kernel: ds: 0000   es: 0000   ss: 0068
Oct 21 10:37:15 D998 kernel: Process XFree86 (pid: 393, threadinfo=1e3d0000 task=1e960080)
Oct 21 10:37:15 D998 kernel: Stack: 00000fd0 00000100 00000000 00000000 00000000 00000000 00000000 00000000 
Oct 21 10:37:15 D998 kernel:        00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:15 D998 kernel:        ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
Oct 21 10:37:15 D998 kernel: Call Trace:
Oct 21 10:37:15 D998 kernel: 
Oct 21 10:37:15 D998 kernel: Code:  Bad EIP value.

--Boundary-00=_YdPl//CKvdtEoPH
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
# CONFIG_STANDALONE is not set
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_4G=y
CONFIG_X86_SWITCH_PAGETABLES=y
CONFIG_X86_4G_VM_LAYOUT=y
CONFIG_X86_UACCESS_INDIRECT=y
CONFIG_X86_HIGH_ENTRY=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_EDD=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_BOOT_IOREMAP=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_TOSHIBA=m
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_EFI is not set
# CONFIG_ACPI_RELAXED_AML is not set

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=m
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_SMI=m
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_X86_P4_CLOCKMOD=m
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_COMPAQ=m
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=y
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
# CONFIG_HOTPLUG_PCI_CPCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=y

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_BPCK6=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
# CONFIG_PARIDE_EPATC8 is not set
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
CONFIG_BLK_CPQ_CISS_DA=m
# CONFIG_CISS_SCSI_TAPE is not set
CONFIG_BLK_DEV_DAC960=m
CONFIG_BLK_DEV_UMEM=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5520=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
CONFIG_BLK_DEV_PDC202XX_NEW=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SGIIOC4=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_MAX_SD_DISKS=256
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_NINJA_SCSI=m
CONFIG_PCMCIA_QLOGIC=m

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m

#
# I2O device support
#
CONFIG_I2O=y
CONFIG_I2O_PCI=y
CONFIG_I2O_BLOCK=y
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=y

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_DECNET=m
# CONFIG_DECNET_SIOCGIFCONF is not set
# CONFIG_DECNET_ROUTER is not set
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set

#
# Bridge: Netfilter Configuration
#
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
# CONFIG_LTPC is not set
CONFIG_COPS=m
# CONFIG_COPS_DAYNA is not set
# CONFIG_COPS_TANGENT is not set
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
# CONFIG_X25 is not set
CONFIG_LAPB=m
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_LANCE=m
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
CONFIG_AT1700=m
CONFIG_DEPCA=m
CONFIG_HP100=m
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=m
CONFIG_AMD8111_ETH=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_ADAPTEC_STARFIRE_NAPI=y
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_B44=m
CONFIG_CS89x0=m
CONFIG_DGRS=m
CONFIG_EEPRO100=m
CONFIG_EEPRO100_PIO=y
CONFIG_E100=m
CONFIG_FEALNX=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139CP=m
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_SUNDANCE_MMIO=y
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SLIP=m
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=m
# CONFIG_NET_POLL_CONTROLLER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_AXNET=m

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_VORTEX=m
CONFIG_GAMEPORT_FM801=m
CONFIG_GAMEPORT_CS461x=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_INPORT=m
CONFIG_MOUSE_ATIXL=y
CONFIG_MOUSE_LOGIBM=m
CONFIG_MOUSE_PC110PAD=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_TIPAR=m

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_QIC02_TAPE=m
# CONFIG_QIC02_DYNCONF is not set

#
# Edit configuration parameters in ./include/linux/tpqic02.h!
#

#
# IPMI
#
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_R3964=m
CONFIG_APPLICOM=m
CONFIG_SONYPI=m

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
# CONFIG_ZFTAPE is not set
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000
CONFIG_FT_ALPHA_CLOCK=0
CONFIG_AGP=y
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_PM2=m
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=m
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
# CONFIG_FB_VESA is not set
# CONFIG_VIDEO_SELECT is not set
CONFIG_FB_HGA=m
CONFIG_FB_RIVA=m
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
# CONFIG_FB_MATROX_MAVEN is not set
# CONFIG_FB_MATROX_MULTIHEAD is not set
CONFIG_FB_RADEON=m
CONFIG_FB_ATY128=m
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_3DFX=m
CONFIG_FB_VOODOO1=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
CONFIG_SND_AD1848=m
CONFIG_SND_CS4231=m
CONFIG_SND_CS4232=m
CONFIG_SND_CS4236=m
CONFIG_SND_ES1688=m
CONFIG_SND_ES18XX=m
CONFIG_SND_GUSCLASSIC=m
CONFIG_SND_GUSEXTREME=m
CONFIG_SND_GUSMAX=m
CONFIG_SND_INTERWAVE=m
CONFIG_SND_INTERWAVE_STB=m
CONFIG_SND_OPTI92X_AD1848=m
CONFIG_SND_OPTI92X_CS4231=m
CONFIG_SND_OPTI93X=m
CONFIG_SND_SB8=m
CONFIG_SND_SB16=m
CONFIG_SND_SBAWE=m
CONFIG_SND_SB16_CSP=y
CONFIG_SND_WAVEFRONT=m
CONFIG_SND_CMI8330=m
CONFIG_SND_OPL3SA2=m
CONFIG_SND_SGALAXY=m
CONFIG_SND_SSCAPE=m

#
# PCI devices
#
CONFIG_SND_ALI5451=m
CONFIG_SND_AZT3328=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS4281=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_KORG1212=m
CONFIG_SND_NM256=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_HDSP=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_YMFPCI=m
CONFIG_SND_ALS4000=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_FM801=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=y
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VX222=m

#
# ALSA USB devices
#
CONFIG_SND_USB_AUDIO=m

#
# PCMCIA devices
#
CONFIG_SND_VXPOCKET=m
CONFIG_SND_VXP440=m

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_FMIO=388
# CONFIG_SOUND_CMPCI_MIDI is not set
# CONFIG_SOUND_CMPCI_JOYSTICK is not set
# CONFIG_SOUND_CMPCI_CM8738 is not set
CONFIG_SOUND_EMU10K1=m
# CONFIG_MIDI_EMU10K1 is not set
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
CONFIG_MSNDCLAS_INIT_FILE="/etc/sound/msndinit.bin"
CONFIG_MSNDCLAS_PERM_FILE="/etc/sound/msndperm.bin"
CONFIG_SOUND_MSNDPIN=m
CONFIG_MSNDPIN_INIT_FILE="/etc/sound/pndspini.bin"
CONFIG_MSNDPIN_PERM_FILE="/etc/sound/pndsperm.bin"
CONFIG_SOUND_VIA82CXXX=m
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
# CONFIG_MAD16_OLDCARD is not set
CONFIG_SOUND_PAS=m
CONFIG_SOUND_PSS=m
CONFIG_PSS_MIXER=y
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SC6600=y
CONFIG_SC6600_JOY=y
CONFIG_SC6600_CDROM=4
CONFIG_SC6600_CDROMBASE=0
# CONFIG_AEDSP16_MSS is not set
# CONFIG_AEDSP16_SBPRO is not set
# CONFIG_AEDSP16_MPU401 is not set
CONFIG_SOUND_TVMIXER=m
CONFIG_SOUND_KAHLUA=m
CONFIG_SOUND_ALI5455=m
CONFIG_SOUND_FORTE=m
CONFIG_SOUND_RME96XX=m
CONFIG_SOUND_AD1980=m

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=y

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
CONFIG_USB_STORAGE_HP8200e=y
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_XPAD=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=y
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=m

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m

#
# USB Host-to-Host Cables
#
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_GENESYS=y
CONFIG_USB_NET1080=y
CONFIG_USB_PL2301=y

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_ZAURUS=y
CONFIG_USB_CDCETHER=y

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_GENERIC is not set
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_TEST=m
CONFIG_USB_GADGET=m
CONFIG_USB_NET2280=m
CONFIG_USB_ZERO=m
CONFIG_USB_ZERO_NET2280=y
CONFIG_USB_ETH=m
CONFIG_USB_ETH_NET2280=y
CONFIG_USB_GADGETFS=m
CONFIG_USB_GADGETFS_NET2280=y

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_BEFS_FS=m
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
# CONFIG_QNX4FS_RW is not set
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=m
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_CODA_FS=m
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_INTERMEZZO_FS=m
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--Boundary-00=_YdPl//CKvdtEoPH--

