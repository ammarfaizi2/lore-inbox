Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTH0NKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTH0NKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:10:47 -0400
Received: from mail-07.iinet.net.au ([203.59.3.39]:56782 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263386AbTH0NKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:10:22 -0400
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1410)
From: Sven Dowideit <svenud@ozemail.com.au>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Tom Marshall <tommy@home.tig-grr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200308270056.33190.daniel.ritz@gmx.ch>
References: <200308270056.33190.daniel.ritz@gmx.ch>
Content-Type: text/plain
Message-Id: <1062025496.720.0.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 09:04:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 08:56, Daniel Ritz wrote: 
> can you please retest with -test4 and russell's yenta patches?
> http://patches.arm.linux.org.uk/pcmcia/yenta-20030817.tar
> 
> if that doesn't work out: could you please add these lines to in yenta_socket.c?
(this is the TI PCI1450)
mmm it seems to work fine every time except if i boot with the card
inserted. (same result as test4 only)

this log (with the yenta patch) is from insertting and removing the card
- cardctl insert and remove look the same..

sven......

Linux version 2.6.0-test4 (root@sven) (gcc version 3.3.2 20030812
(Debian prerelease)) #5 Thu Aug 28 08:02:48 EST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
BIOS-e820: 000000001fff0000 - 000000001fffec00 (ACPI data)
BIOS-e820: 000000001fffec00 - 0000000020000000 (ACPI NVS)
BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v000 PTLTD                                     ) @
0x000f7120
ACPI: RSDT (v001 PTLTD    RSDT   0x06041150  LTP 0x00000000) @
0x1fff4c5d
ACPI: FADT (v001 IBM    TP-T21   0x06041150  0x00000000) @ 0x1fffeb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06041150  LTP 0x00000001) @
0x1fffebd9
ACPI: DSDT (v001 IBM    TP-T21   0x06041150 MSFT 0x0100000c) @
0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux26 ro root=303
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 846.433 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1675.26 BogoMIPS
Memory: 515036k/524224k available (2045k kernel code, 8444k reserved,
788k data, 160k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000
00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000
00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.1
PM: Adding info for pci:0000:00:03.0
PM: Adding info for pci:0000:00:03.1
PM: Adding info for pci:0000:00:05.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:07.1
PM: Adding info for pci:0000:00:07.2
PM: Adding info for pci:0000:00:07.3
PM: Adding info for pci:0000:01:00.0
PM: Adding info for No Bus:pci0000:08
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
ikconfig 0.5 with /proc/ikconfig
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Limiting direct PCI/PCI transfers.
Real Time Clock Driver v1.11a
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
PM: Adding info for platform:floppy0
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25T048ATDA05-0, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 93759120 sectors (48004 MB) w/1806KiB Cache, CHS=65535/16/63
hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 10
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
EXT3 FS on hda3, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
PCI: Found IRQ 11 for device 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:03.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1800. Vers LK1.1.19
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
PCI: Found IRQ 9 for device 0000:00:02.0
PCI: Sharing IRQ 9 with 0000:00:05.0
PCI: Sharing IRQ 9 with 0000:01:00.0
Yenta: CardBus bridge found at 0000:00:02.0 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 00b8, PCI irq9
Socket status: 30000010
PCI: Found IRQ 9 for device 0000:00:02.1
Yenta: CardBus bridge found at 0000:00:02.1 [1014:0130]
Yenta: Using INTVAL to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ list 00b8, PCI irq9
Socket status: 30000006
yenta_get_status: socket dfafdc00, state: 30000410
yenta_get_status: socket dfafdc00, state: 30000410
yenta_get_status: socket dfafd000, state: 30000086
yenta_get_status: socket dfafdc00, state: 30000410
yenta_get_status: socket dfafdc00, state: 30000419
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
yenta_get_status: socket dfafdc00, state: 30000419
yenta_get_status: socket dfafdc00, state: 30000419
yenta_get_status: socket dfafdc00, state: 30000419
yenta_get_status: socket dfafdc00, state: 30000459
yenta_get_status: socket dfafdc00, state: 30000459
yenta_events: socket dfafdc00, cb: 0, csc: 8
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 6, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000011f
yenta_events: socket dfafdc00, cb: c, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 4, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 30000086
yenta_events: socket dfafdc00, cb: 0, csc: 8
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 6, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 30000410
yenta_get_status: socket dfafdc00, state: 30000410
yenta_get_status: socket dfafdc00, state: 30000410
yenta_get_status: socket dfafdc00, state: 30000419
yenta_get_status: socket dfafdc00, state: 30000419
yenta_get_status: socket dfafdc00, state: 30000419
yenta_get_status: socket dfafdc00, state: 30000459
yenta_get_status: socket dfafdc00, state: 30000459
yenta_get_status: socket dfafdc00, state: 30000459
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:33:e:a4
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
yenta_events: socket dfafdc00, cb: 0, csc: 8
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 6, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000001f
yenta_events: socket dfafdc00, cb: 4, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000028a
yenta_events: socket dfafdc00, cb: 4, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000028e
yenta_events: socket dfafdc00, cb: c, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 4, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 30000286
yenta_events: socket dfafdc00, cb: 0, csc: 8
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 6, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 30000610
yenta_get_status: socket dfafdc00, state: 30000610
yenta_get_status: socket dfafdc00, state: 30000610
yenta_get_status: socket dfafdc00, state: 30000619
yenta_get_status: socket dfafdc00, state: 30000619
yenta_get_status: socket dfafdc00, state: 30000619
yenta_get_status: socket dfafdc00, state: 30000659
yenta_get_status: socket dfafdc00, state: 30000659
yenta_get_status: socket dfafdc00, state: 30000659
airo:  Probing for PCI adapters
kobject_register failed for airo (-17)
Call Trace:
[<c0201f59>] kobject_register+0x59/0x60
[<c02281b2>] bus_add_driver+0x52/0xb0
[<c022862f>] driver_register+0x2f/0x40
[<c0184094>] create_proc_entry+0x84/0xd0
[<c020bd5c>] pci_register_driver+0x5c/0x90
[<e08790e8>] airo_init_module+0xe8/0x10d [airo]
[<c0133d98>] sys_init_module+0x118/0x230
[<c010ae9b>] syscall_call+0x7/0xb

airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:33:e:a4
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
yenta_events: socket dfafdc00, cb: 0, csc: 8
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 6, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000021f
yenta_events: socket dfafdc00, cb: 4, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000028a
yenta_events: socket dfafdc00, cb: 4, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000028e
yenta_events: socket dfafdc00, cb: c, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 4, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 30000286
yenta_get_status: socket dfafdc00, state: 30000286
yenta_events: socket dfafdc00, cb: 0, csc: 8
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 6, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 30000610
yenta_get_status: socket dfafdc00, state: 30000610
yenta_get_status: socket dfafdc00, state: 30000610
yenta_get_status: socket dfafdc00, state: 30000619
yenta_get_status: socket dfafdc00, state: 30000619
yenta_get_status: socket dfafdc00, state: 30000619
yenta_get_status: socket dfafdc00, state: 30000659
yenta_get_status: socket dfafdc00, state: 30000659
airo:  Probing for PCI adapters
kobject_register failed for airo (-17)
Call Trace:
[<c0201f59>] kobject_register+0x59/0x60
[<c02281b2>] bus_add_driver+0x52/0xb0
[<c022862f>] driver_register+0x2f/0x40
[<c0184094>] create_proc_entry+0x84/0xd0
[<c020bd5c>] pci_register_driver+0x5c/0x90
[<e08790e8>] airo_init_module+0xe8/0x10d [airo]
[<c0133d98>] sys_init_module+0x118/0x230
[<c010ae9b>] syscall_call+0x7/0xb

airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:40:96:33:e:a4
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 3, io 0x0100-0x013f
yenta_events: socket dfafdc00, cb: 0, csc: 8
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_events: socket dfafdc00, cb: 6, csc: 0
yenta_events: socket dfafd000, cb: 0, csc: 0
yenta_get_status: socket dfafdc00, state: 3000021f


