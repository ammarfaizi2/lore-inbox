Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUBJVge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 16:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUBJVge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 16:36:34 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:22400 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261492AbUBJVgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 16:36:22 -0500
From: tabris <tabris@tabris.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: console/gpm mouse breakage 2.6.3-rc1-mm1
Date: Tue, 10 Feb 2004 16:36:13 -0500
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200402100605.25115.tabris@tabris.net> <20040210201102.GB261@ucw.cz>
In-Reply-To: <20040210201102.GB261@ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N7UKAcJf9HQdqIK"
Message-Id: <200402101636.15752.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_N7UKAcJf9HQdqIK
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 10 February 2004 3:11 pm, Vojtech Pavlik wrote:
> On Tue, Feb 10, 2004 at 06:05:19AM -0500, tabris wrote:
>
> This is very interesting. Can you post your /proc/bus/input/devices and
> dmesg?
Here it is. sorry for the delay.

- --
tabris
- -
The fashion wears out more apparel than the man.
		-- William Shakespeare, "Much Ado About Nothing"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKU7N1U5ZaPMbKQcRAkvtAJ48TeqiizccFwP9DHstezsywlAMFwCaAt47
5UU3H8cILuCoN/T3Gg/TGo4=
=HD0k
-----END PGP SIGNATURE-----

--Boundary-00=_N7UKAcJf9HQdqIK
Content-Type: application/x-zerosize;
  name="devices"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="devices"

I: Bus=0011 Vendor=0002 Product=0005 Version=0000
N: Name="ImPS/2 Generic Wheel Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=103 

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd 
B: EV=120003 
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe 
B: LED=7 

I: Bus=0003 Vendor=046d Product=c504 Version=1310
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:11.2-1/input0
H: Handlers=kbd 
B: EV=12000b 
B: KEY=10000 7 ff800000 7ff febeffdf ffefffff ffffffff fffffffe 
B: ABS=100 0 
B: LED=fc1f 

I: Bus=0003 Vendor=046d Product=c504 Version=1310
N: Name="Logitech USB Receiver"
P: Phys=usb-0000:00:11.2-1/input1
H: Handlers=kbd mouse1 
B: EV=12000f 
B: KEY=ffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 0 0 1878 d800d100 1e0000 0 0 0 
B: REL=30f 
B: ABS=100 0 
B: LED=fc00 


--Boundary-00=_N7UKAcJf9HQdqIK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.3-rc1-mm1 (tabris@tabriel.tabris.net) (gcc version 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)) #1 Tue Feb 10 05:13:31 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6e20
ACPI: RSDT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V266-E 0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
current: c0325a60
current->thread_info: c0360000
Initializing CPU#0
Kernel command line: root=/dev/hda3 vga=8
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1544.719 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 132x43
Memory: 515312k/524208k available (1854k kernel code, 8152k reserved, 576k data, 332k init, 0k highmem)
Calibrating delay loop... 3039.23 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1544.0186 MHz.
..... host bus clock speed is 268.0554 MHz.
NET: Registered protocol family 16
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xf0ed0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-0109: *** Error: No object was returned from [\_SB_.PCI0.PX40.UAR2._STA] (Node dff664e0), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller at PCI slot 0000:00:06.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 4
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:DMA, hdh:DMA
hde: WDC WD200BB-32BSA0, ATA DISK drive
Using anticipatory io scheduler
ide2 at 0xd800-0xd807,0xd402 on irq 4
hdg: Maxtor 4D060H3, ATA DISK drive
hdh: Maxtor 4D060H3, ATA DISK drive
ide3 at 0xd000-0xd007,0xb802 on irq 4
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC28400R, ATA DISK drive
hdb: Maxtor 93652U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TDK CDRW241040B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 128KiB
hde: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1
hdg: max request size: 1024KiB
hdg: 120069936 sectors (61475 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 /dev/ide/host2/bus1/target0/lun0: p1 p2
hdh: max request size: 128KiB
hdh: 120069936 sectors (61475 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus1/target1/lun0: p1
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 > p3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
journal-1153: found in header: first_unflushed_offset 595, last_flushed_trans_id 9719008
journal-1206: Starting replay from offset 595, trans_id 9719009
journal-1299: Setting newest_mount_id to 398
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 332k freed
Real Time Clock Driver v1.12
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1
Adding 999896k swap on /dev/hdb5.  Priority:-2 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
reiserfs:warning: CONFIG_REISERFS_CHECK is set ON
reiserfs:warning: - it is slow mode for debugging.
Reiserfs journal params: device hdb3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb3) for (hdb3)
journal-1153: found in header: first_unflushed_offset 8158, last_flushed_trans_id 2445557
journal-1206: Starting replay from offset 8158, trans_id 2445558
journal-1299: Setting newest_mount_id to 474
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
reiserfs:warning: CONFIG_REISERFS_CHECK is set ON
reiserfs:warning: - it is slow mode for debugging.
Reiserfs journal params: device hde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hde1) for (hde1)
journal-1153: found in header: first_unflushed_offset 1734, last_flushed_trans_id 734307
journal-1206: Starting replay from offset 1734, trans_id 734308
journal-1299: Setting newest_mount_id to 298
Using tea hash to sort names
SGI XFS with ACLs, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hdh1
Ending clean XFS mount for filesystem: hdh1
XFS mounting filesystem hdg2
Ending clean XFS mount for filesystem: hdg2
8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:00:0d.0 (0004 -> 0007)
eth0: RealTek RTL8139 at 0xe0ae0000, 00:50:ba:5f:1c:4d, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'

--Boundary-00=_N7UKAcJf9HQdqIK--

