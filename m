Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTE0UUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbTE0UUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:20:09 -0400
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:6048 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264125AbTE0UTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:19:43 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Date: Tue, 27 May 2003 16:33:40 -0400
User-Agent: KMail/1.5.9
References: <20030527004255.5e32297b.akpm@digeo.com> <200305271238.25935.m.c.p@wolk-project.de>
In-Reply-To: <200305271238.25935.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200305271633.40421.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This one oops on boot 2 out of 3 tries.  

Ideas?
Ed

Linux version 2.5.70-mm1 (ed@oscar) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Tue May 27 11:52:56 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
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
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=2103 console=tty0 console=ttyS0,38400 idebus=33 profile=1
ide_setup: idebus=33
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 400.974 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 790.52 BogoMIPS
Memory: 512884k/524224k available (1450k kernel code, 10580k reserved, 739k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
Enabling new style K6 write allocation for 511 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc160
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc188, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=15500 from BIOS
radeonfb: probed DDR SGRAM 65536k videoram
radeonfb: ATI Radeon VE QY DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
hStart = 664, hEnd = 760, hTotal = 800
vStart = 491, vEnd = 493, vTotal = 525
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c02a2
v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201ea
post div = 0x8
fb_div = 0x1bf
ppll_div_3 = 0x301bf
ron = 1040, roff = 22092
vclk_freq = 2514, per = 789
Console: switching to colour frame buffer device 80x60
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA MVP3 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
hdd: Maxtor 6Y080L0, ATA DISK drive
anticipatory scheduling elevator
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xef000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
anticipatory scheduling elevator
ide2 at 0xac00-0xac07,0xb002 on irq 12
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
anticipatory scheduling elevator
ide3 at 0xb400-0xb407,0xb802 on irq 12
hda: max request size: 128KiB
hda: host protected area => 1
hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdd: max request size: 128KiB
hdd: host protected area => 1
hdd: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(33)
 hdd: hdd1
hde: max request size: 128KiB
hde: host protected area => 1
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
 hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: max request size: 128KiB
hdg: host protected area => 1
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >
Console: switching to colour frame buffer device 80x60
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 10, io base 0000a400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
Reiserfs journal params: device hde3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hde3) for (hde3)
hub 1-1:0: USB hub found
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
hub 1-1:0: 4 ports detected
Freeing unused kernel memory: 112k freed
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
INIT: version 2.84 booting
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 1, assigned address 4
hub 1-1:0: debounce: port 4: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 4, assigned address 5
Loading /etc/console/boottime.kmap.gz
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-00:07.2-2
drivers/usb/core/usb.c: registered new driver hid
SCSI subsystem initialized
Initializing USB Mass Storage driver...
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
scsi0 : SCSI emulation for USB Mass Storage devices
anticipatory scheduling elevator
  Vendor: Sandisk   Model: ImageMate SDDR-0  Rev: 0208
  Type:   Direct-Access                      ANSI SCSI revision: 02
anticipatory scheduling elevator
anticipatory scheduling elevator
mice: PS/2 mouse device common for all mice
anticipatory scheduling elevator
anticipatory scheduling elevator
modprobe: WARNINpl2303: Unknown symbol usb_serial_disconnect
G: Error inserting usbserial (/lpl2303: Unknown symbol usb_serial_probe
ib/modules/2.5.70-mm1/kernel/drianticipatory scheduling elevator
vers/usb/serial/usbserial.ko): Fanticipatory scheduling elevator
ile exists

anticipatory scheduling elevator
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
pl2303: Unknown symbol usb_serial_register
pl2303: Unknown symbol usb_serial_deregister
Unable to handle kernel paging request at virtual address e48e11fc
 printing eip:
c01296b9
*pde = 1fd6d067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01296b9>]    Not tainted VLI
EFLAGS: 00010282
EIP is at load_module+0x7c5/0x800
eax: e48e1120   ebx: e48e1120   ecx: dffea948   edx: dffea958
esi: fffffffe   edi: e48e1120   ebp: df3aff98   esp: df3aff2c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 128, threadinfo=df3ae000 task=df3d12d0)
Stack: df3ae000 c02c321c 00000000 e48e0ae0 0000002c 0000004c 00000048 3ed3bc9b 
       e48d0000 e48e1120 00000000 00000000 00000000 00000000 00000008 0000000d 
       0000000b 00000000 00000000 00000000 00000013 00000012 e48ef38c df76eb7c 
Call Trace:
 [<c012976e>] sys_init_module+0x7a/0x240
 [<c0108da7>] syscall_call+0x7/0xb

Code: 45 b8 eb 58 8b 5d b8 53 e8 d5 ea ff ff ff 73 6c 53 e8 d4 8a fe ff 83 c4 0c 8b 7d b8 ff 77 70 57 e8 c5 8a fe ff 83 c4 08 8b 45 b8 <83> b8 dc 00 00 00 00 74 08 0f 0b 61 01 59 4b 27 c0 8b 55 f0 52 
 Activating swap.
<6>Adding 393552k swap on /dev/hda1.  Priority:1 extents:1
Adding 393584k swap on /dev/hde1.  Priority:1 extents:1
Adding 393584k swap on /dev/hdg1.  Priority:1 extents:1
modprobe: FATAL: Module rtc not found.

System time was Tue May 27 19:43:14 UTC 2003.
Setting the System Clock using the Hardware Clock as reference...
modprobe: FATAL: Module rtc not found.

modprobe: FATAL: Module rtc not found.

System Clock set. System local time is now Tue May 27 15:43:16 EDT 2003.
Running 0dns-down to make sure resolv.conf is ok...done.
Loading modules: tulipwarning: process `update' used the obsolete bdflush system call
Fix your initscripts?
Linux version 2.5.70-mm1 (ed@oscar) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Tue May 27 11:52:56 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
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
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=2103 console=tty0 console=ttyS0,38400 idebus=33 profile=1
ide_setup: idebus=33
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 400.936 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 790.52 BogoMIPS
Memory: 512884k/524224k available (1450k kernel code, 10580k reserved, 739k data, 112k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
Enabling new style K6 write allocation for 511 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc160
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc188, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=15500 from BIOS
radeonfb: probed DDR SGRAM 65536k videoram
radeonfb: ATI Radeon VE QY DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
hStart = 664, hEnd = 760, hTotal = 800
vStart = 491, vEnd = 493, vTotal = 525
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c02a2
v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201ea
post div = 0x8
fb_div = 0x1bf
ppll_div_3 = 0x301bf
ron = 1040, roff = 22092
vclk_freq = 2514, per = 789
Console: switching to colour frame buffer device 80x60
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA MVP3 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
hdd: Maxtor 6Y080L0, ATA DISK drive
anticipatory scheduling elevator
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xef000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
anticipatory scheduling elevator
ide2 at 0xac00-0xac07,0xb002 on irq 12
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
anticipatory scheduling elevator
ide3 at 0xb400-0xb407,0xb802 on irq 12
hda: max request size: 128KiB
hda: host protected area => 1
hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdd: max request size: 128KiB
hdd: host protected area => 1
hdd: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(33)
 hdd: hdd1
hde: max request size: 128KiB
hde: host protected area => 1
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
 hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: max request size: 128KiB
hdg: host protected area => 1
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 >
Console: switching to colour frame buffer device 80x60
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 10, io base 0000a400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
Reiserfs journal params: device hde3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hde3) for (hde3)
hub 1-1:0: USB hub found
hub 1-1:0: 4 ports detected
reiserfs: replayed 1 transactions in 0 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 112k freed
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
INIT: version 2.84 booting
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 1, assigned address 4
hub 1-1:0: debounce: port 4: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 4, assigned address 5
Loading /etc/console/boottime.kmap.gz
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-00:07.2-2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Dmodprobe: WARNIN<4>pl2303: Unknown symbol usb_serial_disconnect
G: Error inserting usbserial (/lpl2303: Unknowriver core v2.0
n symbol usb_serial_probe
ib/modules/2.5.70-mm1/kernel/dripl2303: Unknown symbol usb_serial_register
vers/usb/serial/usbserial.ko): Fpl2303: Unknown symbol usb_serial_deregister
ile exists

Unable to handle kernel paging request at virtual address e48ea1fc
 printing eip:
c01296b9
*pde = 1fd6d067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01296b9>]    Not tainted VLI
EFLAGS: 00010282
EIP is at load_module+0x7c5/0x800
eax: e48ea120   ebx: e48ea120   ecx: dffea948   edx: dffea958
esi: fffffffe   edi: e48ea120   ebp: df36ff98   esp: df36ff2c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 118, threadinfo=df36e000 task=df3812d0)
Stack: df36e000 c02c321c 00000000 e48e9ae0 0000002c 0000004c 00000048 3ed3bc9b 
       e48d2000 e48ea120 00000000 00000000 00000000 00000000 00000008 0000000d 
       0000000b 00000000 00000000 00000000 00000013 00000012 e48d038c df6b7444 
Call Trace:
 [<c012976e>] sys_init_module+0x7a/0x240
 [<c0108da7>] syscall_call+0x7/0xb

Code: 45 b8 eb 58 8b 5d b8 53 e8 d5 ea ff ff ff 73 6c 53 e8 d4 8a fe ff 83 c4 0c 8b 7d b8 ff 77 70 57 e8 c5 8a fe ff 83 c4 08 8b 45 b8 <83> b8 dc 00 00 00 00 74 08 0f 0b 61 01 59 4b 27 c0 8b 55 f0 52 
 Activating swap.

-----------------
putting the above Code: thru ksymoops, gives:

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   45                        inc    %ebp
Code;  ffffffd6 <__kernel_rt_sigreturn+1b96/????>
   1:   b8 eb 58 8b 5d            mov    $0x5d8b58eb,%eax
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   b8 53 e8 d5 ea            mov    $0xead5e853,%eax
Code;  ffffffe0 <__kernel_rt_sigreturn+1ba0/????>
   b:   ff                        (bad)
Code;  ffffffe1 <__kernel_rt_sigreturn+1ba1/????>
   c:   ff                        (bad)
Code;  ffffffe2 <__kernel_rt_sigreturn+1ba2/????>
   d:   ff 73 6c                  pushl  0x6c(%ebx)
Code;  ffffffe5 <__kernel_rt_sigreturn+1ba5/????>
  10:   53                        push   %ebx
Code;  ffffffe6 <__kernel_rt_sigreturn+1ba6/????>
  11:   e8 d4 8a fe ff            call   fffe8aea <_EIP+0xfffe8aea>
Code;  ffffffeb <__kernel_rt_sigreturn+1bab/????>
  16:   83 c4 0c                  add    $0xc,%esp
Code;  ffffffee <__kernel_rt_sigreturn+1bae/????>
  19:   8b 7d b8                  mov    0xffffffb8(%ebp),%edi
Code;  fffffff1 <__kernel_rt_sigreturn+1bb1/????>
  1c:   ff 77 70                  pushl  0x70(%edi)
Code;  fffffff4 <__kernel_rt_sigreturn+1bb4/????>
  1f:   57                        push   %edi
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   e8 c5 8a fe ff            call   fffe8aea <_EIP+0xfffe8aea>
Code;  fffffffa <__kernel_rt_sigreturn+1bba/????>
  25:   83 c4 08                  add    $0x8,%esp
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 45 b8                  mov    0xffffffb8(%ebp),%eax
Code;  00000000 Before first symbol
  2b:   83 b8 dc 00 00 00 00      cmpl   $0x0,0xdc(%eax)
Code;  00000007 Before first symbol
  32:   74 08                     je     3c <_EIP+0x3c>
Code;  00000009 Before first symbol
  34:   0f 0b                     ud2a
Code;  0000000b Before first symbol
  36:   61                        popa
Code;  0000000c Before first symbol
  37:   01 59 4b                  add    %ebx,0x4b(%ecx)
Code;  0000000f Before first symbol
  3a:   27                        daa
Code;  00000010 Before first symbol
  3b:   c0                        .byte 0xc0
Code;  00000011 Before first symbol
  3c:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
Code;  00000014 Before first symbol
  3f:   52                        push   %edx


