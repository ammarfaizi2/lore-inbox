Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265168AbUE1Xh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUE1Xh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 19:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUE1Xh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 19:37:29 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:13907 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S265168AbUE1XhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 19:37:03 -0400
Message-ID: <40B7CD1D.1070606@blueyonder.co.uk>
Date: Sat, 29 May 2004 00:37:01 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc1-mm1 lockup
Content-Type: multipart/mixed;
 boundary="------------060408020608030501090402"
X-OriginalArrivalTime: 28 May 2004 23:37:05.0365 (UTC) FILETIME=[AF261850:01C4450C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408020608030501090402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A7N8X-E motherboard, IDE HD's hda and hdc. Hangs forever as shown below. 
SYSRQ does nothing, needs a hard reset. 2.6.5-mm5 boots OK as does 
vanilla 2.6.7-rc1 which was built after 3 reboots of 2.6.7-rc1-mm1 hung.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.


--------------060408020608030501090402
Content-Type: text/plain;
 name="267rc1mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="267rc1mm1"

Linux version 2.6.7-rc1-mm1 (root@barrabas) (gcc version 3.3.3 (SuSE Linux)) #2 Fri May 28 22:03:20 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f75e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7640
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Built 1 zonelists
Found and enabled local APIC!
Initializing CPU#0
Kernel command line: root=/dev/hda1 vga=0x31a desktop hdb=ide-cd splash=silent 3 console=ttyS1
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2079.320 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 514960k/524224k available (2237k kernel code, 8500k reserved, 1182k data, 176k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4120.57 BogoMIPS
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2079.0160 MHz.
..... host bus clock speed is 332.0665 MHz.
NET: Registered protocol family 16
EISA bus registered
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..................................................................................
..............................................................................................................
....................................................................
Table [DSDT](id F004) - 701 Objects with 75 Devices 260 Methods 27 Regions
ACPI Namespace successfully loaded at root c049871c
ACPI: IRQ9 SCI: Level Trigger.
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000004020 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 9 Runtime GPEs in this block
evgpeblk-0867 [06] ev_create_gpe_block   : GPE 32 to 95 [_GPE] 8 regs at 00000000000044A0 on int 9
evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:........................................................
........................
Initialized 27/27 Regions 1/1 Fields 28/28 Buffers 24/24 Packages (710 nodes)
Executing all Device _STA and_INI methods:....................................................................
.........
77 Devices found containing: 77 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbef0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf20, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 9
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 5
ACPI: PCI interrupt 0000:01:04.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 9
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 9 (level, low) -> IRQ 9
vesafb: framebuffer at 0xd8000000, mapped to 0xe0808000, size 5120k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:dfe0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1085783638.219:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 160x64
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: Maxtor 6Y120L0, ATA DISK drive
hdb: ATAPI COMBO48XMAX, ATAPI CD/DVD-ROM drive
hdc: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63
hda: cache flushes supported
 hda: hda1 hda2
hdc: max request size: 1024KiB
hdc: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63
hdc: cache flushes supported
 hdc: hdc1 hdc2
hdb: ATAPI 40X DVD-ROM CD-R/RW CD-MRW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 184
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
SMBIOS facility v1.0 2004-04-19
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed


--------------060408020608030501090402--
