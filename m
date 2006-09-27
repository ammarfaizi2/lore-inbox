Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965577AbWI0L0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965577AbWI0L0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965580AbWI0L0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:26:17 -0400
Received: from zeus.pimb.org ([80.68.88.21]:22532 "EHLO zeus.pimb.org")
	by vger.kernel.org with ESMTP id S965577AbWI0L0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:26:15 -0400
Date: Wed, 27 Sep 2006 12:43:12 +0100
From: Jody Belka <lists-lkml@pimb.org>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: ACPI Video wierdness
Message-ID: <20060927114312.GD2808@pimb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I was looking around /proc/acpi on my system the other day, purely out of
curiosity, when I noticed something rather odd. Inside /proc/acpi/video,
there are two VID entries, both with the same inode.

I guess these are the relevant lines from my dmesg:

[  134.199530] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[  134.199927] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[  134.199986] ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)


I'm currently running 2.6.18-rc6, but have verified that it happens as far
back as 2.6.13.2. I've attached the full dmesg, along with a copy of my
systems (Dell Inspiron 6000) dsdt. Please let me know if there's anything
else you need.


Please cc me on any replies, as i'm not subscribed to either list. Thanks.


-- 
Jody Belka
knew (at) pimb (dot) org

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=dmesg

[    0.000000] Linux version 2.6.18-rc6-local-evms (jmb@atlas) (gcc version 4.0.2 20050808 (prerelease) (Ubuntu 4.0.1-4ubuntu9)) #1 PREEMPT Tue Sep 12 14:37:12 BST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000005ffd3800 (usable)
[    0.000000]  BIOS-e820: 000000005ffd3800 - 0000000060000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0007000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000fee10000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] 383MB HIGHMEM available.
[    0.000000] 1152MB LOWMEM available.
[    0.000000] On node 0 totalpages: 393171
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 290816 pages, LIFO batch:31
[    0.000000]   HighMem zone: 98259 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 DELL                                  ) @ 0x000fc9b0
[    0.000000] ACPI: RSDT (v001 DELL    CPi R   0x27d50716 ASL  0x00000061) @ 0x5ffd3fd3
[    0.000000] ACPI: FADT (v001 DELL    CPi R   0x27d50716 ASL  0x00000061) @ 0x5ffd4c00
[    0.000000] ACPI: MADT (v001 DELL    CPi R   0x27d50716 ASL  0x00000047) @ 0x5ffd5400
[    0.000000] ACPI: MCFG (v016 DELL    CPi R   0x27d50716 ASL  0x00000061) @ 0x5ffd53c0
[    0.000000] ACPI: BOOT (v001 DELL    CPi R   0x27d50716 ASL  0x00000061) @ 0x5ffd4fc0
[    0.000000] ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20030522) @ 0x5ffd43e6
[    0.000000] ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20030522) @ 0x5ffd420e
[    0.000000] ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030522) @ 0x5ffd4013
[    0.000000] ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:13 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 68000000 (gap: 60000000:80000000)
[    0.000000] Detected 1596.160 MHz processor.
[    9.718354] Built 1 zonelists.  Total pages: 393171
[    9.718357] Kernel command line: root=/dev/evms/dom0/root ro vga=795 quiet splash
[    9.718600] mapped APIC to ffffd000 (fee00000)
[    9.718603] mapped IOAPIC to ffffc000 (fec00000)
[    9.718606] Enabling fast FPU save and restore... done.
[    9.718609] Enabling unmasked SIMD FPU exception support... done.
[    9.718611] Initializing CPU#0
[    9.718685] CPU 0 irqstacks, hard=b0437000 soft=b0438000
[    9.718688] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    9.718796] Console: colour dummy device 80x25
[    9.719710] Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
[    9.720900] Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
[    9.766785] Memory: 1550892k/1572684k available (2016k kernel code, 20504k reserved, 664k data, 284k init, 393036k highmem)
[    9.766789] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    9.846583] Calibrating delay using timer specific routine.. 3195.56 BogoMIPS (lpj=6391122)
[    9.846612] Security Framework v1.0.0 initialized
[    9.846632] Mount-cache hash table entries: 512
[    9.846772] CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[    9.846784] CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[    9.846794] CPU: L1 I cache: 32K, L1 D cache: 32K
[    9.846797] CPU: L2 cache: 2048K
[    9.846800] CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
[    9.846811] Compat vDSO mapped to ffffe000.
[    9.846823] CPU: Intel(R) Pentium(R) M processor 1.60GHz stepping 08
[    9.846831] Checking 'hlt' instruction... OK.
[    9.862680] ACPI: Core revision 20060707
[    9.875565] ENABLING IO-APIC IRQs
[    9.875761] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   10.022559] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[   10.189254] Freeing initrd memory: 3074k freed
[   10.189618] NET: Registered protocol family 16
[   10.189721] EISA bus registered
[   10.189726] ACPI: bus type pci registered
[   10.189733] PCI: Using MMCONFIG
[   10.190461] Setting up standard PCI resources
[   10.208977] ACPI: Interpreter enabled
[   10.208980] ACPI: Using IOAPIC for interrupt routing
[   10.209595] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   10.209599] PCI: Probing PCI hardware (bus 00)
[   10.209694] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   10.224850] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[   10.224855] PCI quirk: region 1080-10bf claimed by ICH6 GPIO
[   10.224903] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
[   10.225022] Boot video device is 0000:01:00.0
[   10.225398] PCI: Transparent bridge - 0000:00:1e.0
[   10.225457] PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try 'pci=assign-busses')
[   10.225460] Please report the result to linux-kernel to fix this permanently
[   10.225484] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   10.246321] ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
[   10.246593] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *10
[   10.246859] ACPI: PCI Interrupt Link [LNKC] (IRQs *9 10 11)
[   10.247124] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 *7 9 10 11)
[   10.247376] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   10.247632] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   10.247891] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   10.248299] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   10.249399] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
[   10.249772] Linux Plug and Play Support v0.97 (c) Adam Belay
[   10.249785] pnp: PnP ACPI init
[   10.282308] pnp: PnP ACPI: found 11 devices
[   10.282313] PnPBIOS: Disabled by ACPI PNP
[   10.282428] SCSI subsystem initialized
[   10.282483] PCI: Using ACPI for IRQ routing
[   10.282486] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   10.299886] pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved
[   10.299890] pnp: 00:02: ioport range 0x1000-0x1005 could not be reserved
[   10.299893] pnp: 00:02: ioport range 0x1008-0x100f could not be reserved
[   10.299898] pnp: 00:03: ioport range 0xf400-0xf4fe has been reserved
[   10.299902] pnp: 00:03: ioport range 0x1006-0x1007 has been reserved
[   10.299905] pnp: 00:03: ioport range 0x100a-0x1059 could not be reserved
[   10.299908] pnp: 00:03: ioport range 0x1060-0x107f has been reserved
[   10.299911] pnp: 00:03: ioport range 0x1080-0x10bf has been reserved
[   10.299914] pnp: 00:03: ioport range 0x10c0-0x10df has been reserved
[   10.299921] pnp: 00:08: ioport range 0x900-0x90f has been reserved
[   10.299924] pnp: 00:08: ioport range 0x910-0x91f has been reserved
[   10.299927] pnp: 00:08: ioport range 0x920-0x92f has been reserved
[   10.299930] pnp: 00:08: ioport range 0x930-0x93f has been reserved
[   10.299933] pnp: 00:08: ioport range 0x940-0x97f has been reserved
[   10.300130] PCI: Bridge: 0000:00:01.0
[   10.300132]   IO window: d000-dfff
[   10.300136]   MEM window: dfd00000-dfefffff
[   10.300139]   PREFETCH window: d0000000-d7ffffff
[   10.300147] PCI: Bus 4, cardbus bridge: 0000:03:01.0
[   10.300150]   IO window: 00002000-000020ff
[   10.300154]   IO window: 00002400-000024ff
[   10.300158]   PREFETCH window: 68000000-69ffffff
[   10.300162]   MEM window: 6a000000-6bffffff
[   10.300166] PCI: Bridge: 0000:00:1e.0
[   10.300169]   IO window: 2000-2fff
[   10.300174]   MEM window: dfc00000-dfcfffff
[   10.300178]   PREFETCH window: 68000000-69ffffff
[   10.300192] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   10.300197] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   10.300208] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   10.300222] PCI: Enabling device 0000:03:01.0 (0000 -> 0003)
[   10.300226] ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 19 (level, low) -> IRQ 17
[   10.300249] NET: Registered protocol family 2
[   10.334201] IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
[   10.334409] TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
[   10.335349] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   10.335635] TCP: Hash tables configured (established 262144 bind 65536)
[   10.335639] TCP reno registered
[   10.335835] Simple Boot Flag at 0x79 set to 0x1
[   10.336535] audit: initializing netlink socket (disabled)
[   10.336548] audit(1159354562.696:1): initialized
[   10.336606] highmem bounce pool size: 64 pages
[   10.336664] VFS: Disk quotas dquot_6.5.1
[   10.336684] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   10.336732] Initializing Cryptographic API
[   10.336738] io scheduler noop registered
[   10.336743] io scheduler anticipatory registered
[   10.336747] io scheduler deadline registered
[   10.336755] io scheduler cfq registered (default)
[   10.337035] vesafb: framebuffer at 0xd0000000, mapped to 0xf8880000, using 7680k, total 32768k
[   10.337039] vesafb: mode is 1280x1024x24, linelength=3840, pages=7
[   10.337042] vesafb: protected mode interface info at c000:581b
[   10.337045] vesafb: pmi: set display start = b00c5889, set palette = b00c58c3
[   10.337047] vesafb: pmi: ports = de10 de16 de54 de38 de3c de5c de00 de04 deb0 deb2 deb4 
[   10.337054] vesafb: scrolling: redraw
[   10.337058] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[   10.410411] Console: switching to colour frame buffer device 160x64
[   10.478248] fb0: VESA VGA frame buffer device
[   10.478295] isapnp: Scanning for PnP cards...
[   10.788727] isapnp: No Plug & Play device found
[   10.811282] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   10.812146] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   10.812925] libata version 2.00 loaded.
[   10.812965] ahci 0000:00:1f.2: version 2.0
[   10.812992] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
[   10.813009] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
[   10.813012] ahci: probe of 0000:00:1f.2 failed with error -12
[   10.813045] ata_piix 0000:00:1f.2: version 2.00
[   10.813050] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[   10.965626] PCI: Enabling device 0000:00:1f.2 (0000 -> 0001)
[   10.965630] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
[   10.965642] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   10.965687] ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
[   10.965784] scsi0 : ata_piix
[   11.122950] ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48 
[   11.122953] ata1.00: ata1: dev 0 multi count 8
[   11.122955] ata1.00: applying bridge limits
[   11.124449] ata1.00: configured for UDMA/100
[   11.124561]   Vendor: ATA       Model: HTS726060M9AT00   Rev: MH4O
[   11.124573]   Type:   Direct-Access                      ANSI SCSI revision: 05
[   11.124658] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
[   11.124673] scsi1 : ata_piix
[   11.433721] ata2.00: ATAPI, max UDMA/33
[   11.589586] ata2.00: configured for UDMA/33
[   11.590161]   Vendor: SONY      Model: DVD+-RW DW-D56A   Rev: PDS7
[   11.590172]   Type:   CD-ROM                             ANSI SCSI revision: 05
[   11.590315] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   11.590326] sda: Write Protect is off
[   11.590329] sda: Mode Sense: 00 3a 00 00
[   11.590343] SCSI device sda: drive cache: write back
[   11.590388] SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
[   11.590397] sda: Write Protect is off
[   11.590399] sda: Mode Sense: 00 3a 00 00
[   11.590412] SCSI device sda: drive cache: write back
[   11.590414]  sda: sda1 sda2 sda3
[   11.611772] sd 0:0:0:0: Attached scsi disk sda
[   11.615940] sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
[   11.615944] Uniform CD-ROM driver Revision: 3.20
[   11.616000] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   11.616041] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   11.616069] sr 1:0:0:0: Attached scsi generic sg1 type 5
[   11.616143] PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   11.619637] serio: i8042 AUX port at 0x60,0x64 irq 12
[   11.620085] serio: i8042 KBD port at 0x60,0x64 irq 1
[   11.620181] device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
[   11.620920] EISA: Probing bus 0 at eisa.0
[   11.620928] Cannot allocate resource for EISA slot 1
[   11.620931] Cannot allocate resource for EISA slot 2
[   11.620956] EISA: Detected 0 cards.
[   11.620975] Netfilter messages via NETLINK v0.30.
[   11.621060] TCP bic registered
[   11.621063] NET: Registered protocol family 8
[   11.621065] NET: Registered protocol family 20
[   11.621078] Using IPI Shortcut mode
[   11.621133] ACPI: (supports S0 S3 S4 S5)
[   11.621184] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   11.621289] RAMDISK: Compressed image found at block 0
[   11.625053] Time: tsc clocksource has been installed.
[   11.793547] input: AT Translated Set 2 keyboard as /class/input/input0
[   11.793603] VFS: Mounted root (ext2 filesystem).
[   12.222792] EXT2-fs warning (device dm-17): ext2_fill_super: mounting ext3 filesystem as ext2
[   12.547829] Freeing unused kernel memory: 284k freed
[   12.980860] NET: Registered protocol family 1
[   16.006777] mice: PS/2 mouse device common for all mice
[   16.325446] input: PS/2 Mouse as /class/input/input1
[   16.347729] input: AlpsPS/2 ALPS GlidePoint as /class/input/input2
[   24.445783] ts: Compaq touchscreen protocol output
[  123.304556] kjournald starting.  Commit interval 5 seconds
[  123.304867] EXT3 FS on dm-11, internal journal
[  123.304872] EXT3-fs: mounted filesystem with ordered data mode.
[  123.352255] kjournald starting.  Commit interval 5 seconds
[  123.352554] EXT3 FS on dm-13, internal journal
[  123.352558] EXT3-fs: mounted filesystem with ordered data mode.
[  123.356218] kjournald starting.  Commit interval 5 seconds
[  123.356536] EXT3 FS on dm-21, internal journal
[  123.356540] EXT3-fs: mounted filesystem with ordered data mode.
[  123.360106] kjournald starting.  Commit interval 5 seconds
[  123.360375] EXT3 FS on dm-7, internal journal
[  123.360379] EXT3-fs: mounted filesystem with ordered data mode.
[  123.427622] kjournald starting.  Commit interval 5 seconds
[  123.427937] EXT3 FS on dm-9, internal journal
[  123.427941] EXT3-fs: mounted filesystem with ordered data mode.
[  123.431290] kjournald starting.  Commit interval 5 seconds
[  123.431571] EXT3 FS on dm-29, internal journal
[  123.431575] EXT3-fs: mounted filesystem with ordered data mode.
[  123.470787] Adding 1048564k swap on /dev/evms/dom0/swap/0.  Priority:-1 extents:1 across:1048564k
[  124.969075] Linux agpgart interface v0.101 (c) Dave Jones
[  124.975803] agpgart: Detected an Intel 915GM Chipset.
[  125.008495] agpgart: AGP aperture is 256M @ 0x0
[  125.163238] usbcore: registered new driver usbfs
[  125.165953] usbcore: registered new driver hub
[  125.199831] USB Universal Host Controller Interface driver v3.0
[  125.202339] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
[  125.202353] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[  125.202357] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[  125.214118] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[  125.214156] uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000bf80
[  125.217880] usb usb1: configuration #1 chosen from 1 choice
[  125.218472] hub 1-0:1.0: USB hub found
[  125.218481] hub 1-0:1.0: 2 ports detected
[  125.320663] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 18
[  125.320677] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[  125.320681] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[  125.339880] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[  125.339921] uhci_hcd 0000:00:1d.1: irq 18, io base 0x0000bf60
[  125.343482] usb usb2: configuration #1 chosen from 1 choice
[  125.344179] hub 2-0:1.0: USB hub found
[  125.344189] hub 2-0:1.0: 2 ports detected
[  125.452611] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
[  125.452626] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[  125.452630] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[  125.453339] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[  125.453374] uhci_hcd 0000:00:1d.2: irq 19, io base 0x0000bf40
[  125.454705] usb usb3: configuration #1 chosen from 1 choice
[  125.455316] hub 3-0:1.0: USB hub found
[  125.455323] hub 3-0:1.0: 2 ports detected
[  125.560600] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 17
[  125.560616] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[  125.560620] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[  125.561327] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[  125.561360] uhci_hcd 0000:00:1d.3: irq 17, io base 0x0000bf20
[  125.562689] usb usb4: configuration #1 chosen from 1 choice
[  125.563285] hub 4-0:1.0: USB hub found
[  125.563292] hub 4-0:1.0: 2 ports detected
[  126.057147] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 16 (level, low) -> IRQ 16
[  126.057165] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[  126.057170] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[  126.063527] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[  126.063565] ehci_hcd 0000:00:1d.7: debug port 1
[  126.063571] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[  126.063580] ehci_hcd 0000:00:1d.7: irq 16, io mem 0xffa80800
[  126.067464] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[  126.071189] usb usb5: configuration #1 chosen from 1 choice
[  126.071796] hub 5-0:1.0: USB hub found
[  126.071805] hub 5-0:1.0: 8 ports detected
[  126.261866] Intel 82802 RNG detected
[  126.261875] intel_rng: cannot enable RNG, aborting
[  126.261877] intel_rng: RNG registering failed (-5)
[  126.985095] ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 16 (level, low) -> IRQ 16
[  126.985124] PCI: Setting latency timer of device 0000:00:1e.2 to 64
[  127.801250] intel8x0_measure_ac97_clock: measured 55471 usecs
[  127.801253] intel8x0: clocking to 48000
[  128.140916] b44.c:v1.01 (Jun 16, 2006)
[  128.140939] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 19
[  128.147807] eth0: Broadcom 4400 10/100BaseT Ethernet 00:12:3f:e5:f1:e3
[  128.250444] Yenta: CardBus bridge found at 0000:03:01.0 [1028:0188]
[  128.377521] Yenta: ISA IRQ mask 0x04b8, PCI irq 17
[  128.377527] Socket status: 30000006
[  128.377530] Yenta: Raising subordinate bus# of parent bus (#03) from #04 to #07
[  128.377537] pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
[  128.377541] cs: IO port probe 0x2000-0x2fff: clean.
[  128.377806] pcmcia: parent PCI bridge Memory window: 0xdfc00000 - 0xdfcfffff
[  128.377809] pcmcia: parent PCI bridge Memory window: 0x68000000 - 0x69ffffff
[  128.457569] ieee1394: Initialized config rom entry `ip1394'
[  128.464734] ACPI: PCI Interrupt 0000:03:01.1[B] -> GSI 18 (level, low) -> IRQ 19
[  128.520656] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[dfcfc800-dfcfcfff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[  128.596210] sdhci: Secure Digital Host Controller Interface driver, 0.12
[  128.596215] sdhci: Copyright(c) Pierre Ossman
[  128.598807] sdhci: SDHCI controller found at 0000:03:01.2 [1180:0822] (rev 17)
[  128.598828] ACPI: PCI Interrupt 0000:03:01.2[C] -> GSI 17 (level, low) -> IRQ 18
[  128.611709] mmc0: SDHCI at 0xdfcfc700 irq 18 DMA
[  128.700994] ieee80211_crypt: registered algorithm 'NULL'
[  128.709819] ieee80211: 802.11 data/management/control stack, git-1.1.13
[  128.709823] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[  128.725489] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.2kmprq
[  128.725493] ipw2200: Copyright(c) 2003-2006 Intel Corporation
[  128.728127] ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 17 (level, low) -> IRQ 18
[  128.728168] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
[  128.991270] ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
[  129.800742] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[484fc0002f116830]
[  130.146613] Real Time Clock Driver v1.12ac
[  130.174862] input: PC Speaker as /class/input/input3
[  133.615643] ACPI: AC Adapter [AC] (off-line)
[  133.912047] ACPI: Battery Slot [BAT0] (battery present)
[  133.975273] ACPI: Lid Switch [LID]
[  133.975284] ACPI: Power Button (CM) [PBTN]
[  133.975290] ACPI: Sleep Button (CM) [SBTN]
[  134.132071] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
[  134.132079] ACPI: Processor [CPU0] (supports 8 throttling states)
[  134.132084] ACPI: Getting cpuindex for acpiid 0x1
[  134.183835] ACPI: Thermal Zone [THM] (54 C)
[  134.199530] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[  134.199927] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[  134.199986] ACPI: Video Device [VID2] (multi-head: yes  rom: no  post: no)
[  124.548000] Time: acpi_pm clocksource has been installed.
[  131.276000] pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
[  131.276000] pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
[  131.276000] pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
[  131.276000] cs: IO port probe 0x100-0x4ff: excluding 0x370-0x377 0x3f0-0x3f7
[  131.280000] cs: IO port probe 0xc00-0xcf7: clean.
[  131.280000] cs: IO port probe 0xa00-0xaff: clean.
[  132.712000] NET: Registered protocol family 10
[  132.712000] lo: Disabled Privacy Extensions
[  132.712000] IPv6 over IPv4 tunneling driver
[  132.948000] Bluetooth: Core ver 2.10
[  132.948000] NET: Registered protocol family 31
[  132.948000] Bluetooth: HCI device and connection manager initialized
[  132.948000] Bluetooth: HCI socket layer initialized
[  132.976000] Bluetooth: L2CAP ver 2.8
[  132.976000] Bluetooth: L2CAP socket layer initialized
[  133.012000] Bluetooth: RFCOMM socket layer initialized
[  133.012000] Bluetooth: RFCOMM TTY layer initialized
[  133.012000] Bluetooth: RFCOMM ver 1.8

--ew6BAiZeqk4r7MaW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=dsdt
Content-Transfer-Encoding: base64

RFNEVIgwAAABWUlOVDQzMFNZU0ZleHh4ARAAAE1TRlQOAAABCFZFUlMSOQMNUHJvamVjdDog
REVMTCBEMDUgICAgAA1EYXRlOiAxMS8xMi8yMDAzAA1WZXI6IDEuMDAuMDAACE1JU0MRCgoH
AAAAAAAAAIxNSVNDCgBNSVMwjE1JU0MKA01JUzOMTUlTQwoETUlTNIxNSVNDCgZNSVM2WwFT
TUlYARRKBVNNSV8CWyNTTUlY//9waVwuX1NCX1NNSUFwaFwuX1NCX1NNSUNwXC5fU0JfU01J
Q2CiEpKTYAoAcFwuX1NCX1NNSUNgcFwuX1NCX1NNSUFhWydTTUlYpGEIU1hYMBEECwABCFNY
WDERAwoIi1NYWDEKAFNYWDKLU1hYMQoEU1hYMxQVU1gxMABbI1NNSVj//3AKAFNYWDIUMVNY
MzABcFNYWDJgdWCgIpKUYIdTWFgwjFNYWDBTWFgyU1gyMHBoU1gyMHBgU1hYMhQ0U1gzMQFw
U1hYMmByYAoCYKAikpRgh1NYWDCLU1hYMFNYWDJTWDIxcGhTWDIxcGBTWFgyFDRTWDMyAXBT
WFgyYHJgCgRgoCKSlGCHU1hYMIpTWFgwU1hYMlNYMjJwaFNYMjJwYFNYWDIUG1NYMzMCoBSV
aYdojGhpU1gyMFNYMzBTWDIwFBdTWDM0AnAKAGCiDJVgaVNYMzNoYHVgFEkEU1hYNgJwaVwu
X1NCX1NNSUFwaFwuX1NCX1NNSUNwXC5fU0JfU01JQ2CiEpKTYAoAcFwuX1NCX1NNSUNgpFwu
X1NCX1NNSUEUHVNYWDUCoBaVaYdojGhpU1gyMFNYWDYKfFNYMjAUJVNYWDQAU1hYNgp7CgBw
CgBgohKVYFNYWDJTWFg1U1hYMGB1YBQgU1hYOAKgGZVph2iMaGlTWDIwcFNYWDYKfQoAU1gy
MBQkU1hYNwBwCgBgohmVYFNYWDNyU1hYMmBhU1hYOFNYWDBhdWAUQwRTWDExAFNYWDRwU1hY
Ngp5CgBTWFgzclNYWDJTWFgzYKAclYdTWFgwYHCHU1hYMGB0YFNYWDJgcGBTWFgzU1hYNxQz
U1g0MABwU1hYMmB1YKAhkpRgh1NYWDCMU1hYMFNYWDJTWDIwcGBTWFgypFNYMjCkCgAUNlNY
NDEAcFNYWDJgcmAKAmCgIZKUYIdTWFgwi1NYWDBTWFgyU1gyMXBgU1hYMqRTWDIxpAoAFDZT
WDQyAHBTWFgyYHJgCgRgoCGSlGCHU1hYMIpTWFgwU1hYMlNYMjJwYFNYWDKkU1gyMqQKABQc
U1g0MwKgFZVph2iMaGlTWDIwcFNYNDBTWDIwFBdTWDQ0AnAKAGCiDJVgaVNYNDNoYHVgFCJT
WDQ1AHBTWDQwYAhTWDIzEQJgU1g0NFNYMjNgpFNYMjMUDFNYMTIAWydTTUlYFCJQU1dfAlNY
MTBTWDMwCgZTWDMwaFNYMzBpU1gxMVNYMTIUIkRTU18CU1gxMFNYMzAKCFNYMzBoU1gzMmlT
WDExU1gxMhQgR01FTQBTWDEwU1gzMAoHU1gxMXBTWDQyYFNYMTKkYBQgR09STABTWDEwU1gz
MAoJU1gxMXBTWDQyYFNYMTKkYAhXOThTDU1pY3Jvc29mdCBXaW5kb3dzAAhOVDVTDU1pY3Jv
c29mdCBXaW5kb3dzIE5UAAhXSU5NDU1pY3Jvc29mdCBXaW5kb3dzTUU6IE1pbGxlbm5pdW0g
RWRpdGlvbgAIV1hQXw1XaW5kb3dzIDIwMDEAFBJHRVRDAoxoaVRDSFKkVENIUhRABVNUUkUC
CFNUUjERAwpQCFNUUjIRAwpQcGhTVFIxcGlTVFIycABgcAFhoiJhcEdFVENTVFIxYGFwR0VU
Q1NUUjJgYqAHkpNhYqQAdWCkARROB09TSUQAoEEHk01JUzMKAHAKAU1JUzOgG1sSXF9PU0lg
oBFcX09TSVdYUF9wChBNSVMzoUQEoBVTVFJFXF9PU19XOThTcAoCTUlTM6AVU1RSRVxfT1Nf
TlQ1U3AKCE1JUzOgFVNUUkVcX09TX1dJTk1wCgRNSVMzpE1JUzMUJFNPU1QAU1gxMFNYMzAK
Ck9TSURTWDMwTUlTM1NYMTFTWDEyCFdBS0UKABRKBU5FVlQAcFNNSV8KjAoAYKATe2AKAQCG
XC5fU0JfUEJUTgqAoAp7YAoEAExJREWgCntgCggAUFdSRaATe2AKQACGXC5fU0JfU0JUTgqA
oAp7YAqAAFNNSUUURAtMSURFAHBTTUlfCkMKAGCgRQmQkpNgCgCSk2AKD3BTTUlfCm0KAGCg
TQeTYAoDoBqTT1NJRAoQhlwuX1NCX1BDSTAKAFsiC+gDoTOgMZNPU0lECgiGXC8DX1NCX1BD
STBWSURfCgCGXC8DX1NCX1BDSTBWSUQyCgBbIgvuAoZcLwNfU0JfUENJMFZJRF8KgIZcLwRf
U0JfUENJMEFHUF9WSURfCoCGXC5fU0JfTElEXwqAFEgJUFdSRQBwU01JXwqYCgBgf2BNSVMw
YXtgfQoBfQoCChAAAE1JUzCgE3thCgEAhlwuX1NCX0FDX18KgHtNSVMwCgJioCV7YQoCAKAP
YoZcLl9TQl9CQVQwCoGhDoZcLl9TQl9CQVQwCoGgFnthCgQAoA9ihlwuX1NCX0JBVDAKgKAW
e2EKCACgD2KGXC5fU0JfQkFUMAqAFE4QU01JRQBwU01JXwqWCgBgoBN7YAoBAIZcLl9UWl9U
SE1fCoCgLntgCiAAhlwvA19TQl9QQ0kwVklEXwqBhlwvBF9TQl9QQ0kwQUdQX1ZJRF8KgaBB
CXtgCgIAcFNNSV8KbQoAYKBHBpNgCgOgGpNPU0lEChCGXC5fU0JfUENJMAoAWyIL6AOhM6Ax
k09TSUQKCIZcLwNfU0JfUENJMFZJRF8KAIZcLwNfU0JfUENJMFZJRDIKAFsiC+4ChlwvA19T
Ql9QQ0kwVklEXwqAoReGXC8EX1NCX1BDSTBBR1BfVklEXwqAoBN7YAoEAIZcLl9TQl9CQVQw
CoGgE3tgCggAhlwuX1BSX0NQVTAKgBQOXF9QVFMBU01JXwqKaBRHBFxfV0FLAVNNSV8Kmmig
KpNoCgSGXC5fU0JfUEJUTgoCcFNNSV8KmAoATUlTMHAKAU1JUzRTT1NUhlwuX1NCX0FDX18K
gBROB05XQUsAcAoBV0FLRXBTTUlfCokKAGBwCgBhoAmTYAoAcAoBYaAKe2AKAQBwCgFhoAp7
YAoCAExJREWgE3tgCiAAoAyTT1NJRAoCcAoBYYZcLl9TQl9CQVQwCoGgCZNgCgRwCgFhoA9h
hlwuX1NCX1BCVE4KAnAKAFdBS0UQRg1cX0dQRRQKX0wxRABORVZUFApfTDFDAE5XQUsUF19M
MEIAcAoAYIZcLl9TQl9QQ0kwCgIUCl9MMTgAcAoAYBQYX0wwMwCGXC8DX1NCX1BDSTBVU0Iw
CgIUGF9MMDQAhlwvA19TQl9QQ0kwVVNCMQoCFBhfTDBDAIZcLwNfU0JfUENJMFVTQjIKAhQY
X0wwRACGXC8DX1NCX1BDSTBVU0IzCgIUGF9MMEUAhlwvA19TQl9QQ0kwVVNCNAoCFBhfTDA1
AIZcLwNfU0JfUENJME1PRE0KAghDUlMwEQQLkgGLQ1JTMAuQAUNSUzEUDUNSUzMAcAoAQ1JT
MRQeQ1JTNAGMQ1JTMENSUzFDUlMycGhDUlMydUNSUzEUI0NSUzUBi0NSUzBDUlMxQ1JTMnBo
Q1JTMnVDUlMxdUNSUzEUJENSUzYBikNSUzBDUlMxQ1JTMnBoQ1JTMnJDUlMxCgRDUlMxFCFD
Ul8wA0NSUzQKhkNSUzUKCUNSUzRoQ1JTNmlDUlM2ahQmQ1JfMQRDUlM0CkdDUlM0CgFDUlM1
aENSUzVpQ1JTNGpDUlM0axRGBENSXzICQ1JTNAqIQ1JTNQoNQ1JTNAoCQ1JTNAoMQ1JTNAoA
Q1JTNQoAQ1JTNWhyaGlgdmBDUlM1YENSUzUKAENSUzVpFEYEQ1JfMwJDUlM0CohDUlM1Cg1D
UlM0CgFDUlM0CgxDUlM0CgNDUlM1CgBDUlM1aHJoaWB2YENSUzVgQ1JTNQoAQ1JTNWkURgRD
Ul80AkNSUzQKh0NSUzUKF0NSUzQKAENSUzQKDENSUzQKA0NSUzYKAENSUzZocmhpYHZgQ1JT
NmBDUlM2CgBDUlM2aRQtQ1JfNQBDUlM1CnlwQ1JTMWB0C5IBCgJhogyVYGFDUlM0CgB1YHAK
eUNSUzEQIFxfUFJfW4MLQ1BVMADgEAAABluDC0NQVTEB4BAAAAYIXF9TMF8SCAMKAAoACgAI
XF9TM18SCAMKBQoACgAIXF9TNF8SCAMKBwoACgAIXF9TNV8SCAMKBwoACgAQTQVcX1RaX1uF
RAVUSE1fFBBfQ1JUAHBHSU5GChFgpGAUEF9UTVAAcEdJTkYKBGCkYBQrR0lORgFTWDEwU1gz
MGhTWDExcFNYNDFgU1gxMqALlWALpgtwC6YLYKRgEBdcAAhHUElDCgAUDF9QSUMBcGhHUElD
EI0zAlxfU0JfW4BTTUlSAQqyCgJbgRBTTUlSAVNNSUMIU01JRAhbgFNNUjIBCoYKAVuBC1NN
UjIBU01JQQhbgkgEQUNfXwhfSElEDUFDUEkwMDAzAAhfUENMEgsCXF9TQl9CQVQwFBdfUFNS
AHBTTUlfCoUKAGB7YAoBYKRgFAlfU1RBAKQKDwhCSUZQEgINFEwMQklGXwFTWDEwU1gzMAoB
U1gzMGhTWDExcFNYNDKIQklGUAoAAHBTWDQyiEJJRlAKAQBwU1g0MohCSUZQCgIAcFNYNDKI
QklGUAoDAHBTWDQyiEJJRlAKBABwU1g0MohCSUZQCgUAcFNYNDKIQklGUAoGAHBTWDQyiEJJ
RlAKBwBwU1g0MohCSUZQCggAcFNYNDWIQklGUAoJAHBTWDQ1iEJJRlAKCgBwU1g0NYhCSUZQ
CgsAcFNYNDWIQklGUAoMAFNYMTKkQklGUFuCQw1CQVQwCF9ISUQMQdAMCghfVUlECgEIX1BD
TBIHAVxfU0JfFBdfU1RBAHtNSVMwCgJgoAVgpAofpAoPFA1fQklGAKRCSUZfCgEUQAZfQlNU
AFNYMTBTWDMwCgJTWDMwCgFTWDExCEJTVDASAgRwU1g0MohCU1QwCgAAcFNYNDKIQlNUMAoB
AHBTWDQyiEJTVDAKAgBwU1g0MohCU1QwCgMAU1gxMqRCU1QwFCdfQlRQAVNYMTBTWDMwCgNT
WDMwCgFTWDMyaFNYMTFbIgr6U1gxMluCPExJRF8IX0hJRAxB0AwNFBJfTElEAHBTTUlfCoQK
AGCkYAhfUFJXEgYCChwKAxQNX1BTVwFQU1dfaAoCW4IpUEJUTghfSElEDEHQDAwIX1BSVxIG
AgocCgQUDV9QU1cBUFNXX2gKAVuCD1NCVE4IX0hJRAxB0AwOW4JPF01CMV8IX0hJRAxB0AwB
CF9VSUQKARRHFl9DUlMAQ1JTM0NSXzAKAQoADAD8CQBDUl8wCgEMAPwJAAsABKAikZNPU0lE
CgiTT1NJRAoQcEdPUkxgQ1JfMAoADAAADABgQ1JfMAoADAAADgAMAAACAHBHTUVNYHRgDADI
AgBhQ1JfMAoBDAAAEABhcmEMAAAQAGFDUl8wCgFhDADIAgByYQwAyAIAYXBTTUlfCm0KAGCg
EZNgCgNDUl8wCgBhDAAAgABDUl8wCgEMAADa/gwAAAYAdAz/////DAAAsP9gcmAKAWBDUl8w
CgAMAACw/2BDUl8wCgEMAADA/gwAAAEAQ1JfMAoBDAAA4P4MAAABAENSXzAKAAwAANL+DAAA
CABDUl8wCgEMAAAA8AsAQENSXzAKAQwAQADwCwAQQ1JfMAoBDABQAPALABBDUl8wCgEMAGAA
8AsAEENSXzAKAQwAgADwCwBAQ1JfMAoBDAAAAOAMAAAAEENSXzWkQ1JTMFuCj/ABUENJMAhf
SElEDEHQCgMIX0FEUgoACF9QUlcSBgIKCwoDFDFfSU5JAHBTTUlfCpgKAE1JUzB7TUlTMH0K
AX0KAgoQAABNSVMwcAoBTUlTNFNPU1QUTBBfQ1JTAENSUzNDUl8yCgALAAFDUl8zCgAL+AxD
Ul8xC/gMC/gMCgEKCENSXzMLAA0LAPNDUl80DAAACgAMAAACAENSXzQMAAANAAwAAAEAcgwA
ABAAR01FTWBwU01JXwptCgBjoA2TYwoDcmAMAACAAGB0DAAAAOBgYUNSXzRgYXIMAGAA8AsA
EGB0DACAAPBgYUNSXzRgYXIMAIAA8AsAQGB0DAAAwP5gYUNSXzRgYXIMAADA/gwAAAEAYHQM
AADS/mBhoAhhQ1JfNGBhcgwAANL+DAAACABgdAwAANr+YGFDUl80YGFyDAAA4P4MAAABAGB0
DAAAsP9gYUNSXzRgYUNSXzWkQ1JTMFuCSgZNQjJfCF9ISUQMQdAMAQhfVUlECgIIQ1JTXxFB
BAo9RwGSAJIAAgFHAbIAsgACAUcBIAAgABACRwGgAKAAEAIiAQBHAdAE0AQQAkcBABAAEBAG
RwEIEAgQCAh5ABQLX0NSUwCkQ1JTX1uCRwdNQjNfCF9ISUQMQdAMAQhfVUlECgMIQ1JTXxFO
BApKRwEA9AD0Af9HAYYAhgACAUcBswCzAAEBRwEGEAYQAgJHAQoQChABUEcBYBBgEBAgRwGA
EIAQEEBHAcAQwBAQIEcB4BDgEBAgeQAUC19DUlMApENSU19bgkcvSVNBQghfQURSDAAAHwBb
gFBJUjECCmAKBFuAUElSMgIKaAoEW4BGRElTAgryCgJbgilQUzJNCF9ISUQMQdAPEwhDUlNf
EQgKBSIAEHkAFAtfQ1JTAKRDUlNfW4JKBEtCQ18IX0hJRAxB0AMDCENSU18RKAolRwFgAGAA
EAFHAWQAZAAEAUcBYgBiAAIBRwFmAGYABgEiAgB5ABQLX0NSUwCkQ1JTX1uCOVJUQ18IX0hJ
RAxB0AsACENSU18RGAoVRwFwAHAAEAIiAAFHAXIAcgACBnkAFAtfQ1JTAKRDUlNfW4I5VE1S
XwhfSElEDEHQAQAIQ1JTXxEYChVHAUAAQAAQBCIEAEcBUABQABAEeQAUC19DUlMApENSU19b
gkcEU1BLUghfSElEDEHQCAAIQ1JTXxElCiJHAWEAYQABAUcBYwBjAAEBRwFlAGUAAQFHAWcA
ZwABAXkAFAtfQ1JTAKRDUlNfW4JOBU1CNF8IX0hJRAxB0AwBCF9VSUQKBAhDUlNfETUKMkcB
LgAuAAICRwEACQAJEBBHARAJEAkQEEcBIAkgCRAQRwEwCTAJEBBHAUAJQAkQQHkAFAtfQ1JT
AKRDUlNfW4JGCVBJQ18IX0hJRAtB0AhDUlNfEUYHCnJHASQAJAAEAkcBKAAoAAQCRwEsACwA
BAJHATAAMAAEAkcBNAA0AAQCRwE4ADgABAJHATwAPAAEAkcBpACkAAQCRwGoAKgABAJHAawA
rAAEAkcBsACwAAQCRwG0ALQABAJHAbgAuAAEAkcBvAC8AAQCeQAUC19DUlMApENSU19bgkMG
TUFEXwhfSElEDEHQAgAIQ1JTXxFBBAo9KhAERwEAAAAAEBBHAYAAgAAQBkcBhwCHAAEJRwHA
AMAAECBHARAAEAAQEEcBkACQABACRwGTAJMAAQ15ABQLX0NSUwCkQ1JTX1uCMUNPUFIIX0hJ
RAxB0AwECENSU18REAoNRwHwAPAAEBAiACB5ABQLX0NSUwCkQ1JTXxQvVUNNRANTWDEwU1gz
MAoPU1gzMGhTWDMwaVNYMzBqU1gxMXBTWDQwYFNYMTKkYBQPVVBTVwKkVUNNRAoCaGkUD1VQ
UlcCpFVDTUQKAWhpW4JBClVTQjAIX0FEUgwAAB0AFCNfUzBEAHBTTUlfCoUKAGB7YAoBYKAI
k2AKAKQKA6EEpAoAFDRfUFJXAHBVUFJXCgAKAGCgDZNgCgOkEgYCCgMKA6ANk2AKAaQSBgIK
AwoBpBIGAgoDCgAUDV9QU1cBVVBTV2gKAFuCKEhVQjAIX0FEUgoAW4IMQ0gwXwhfQURSCgFb
ggxDSDFfCF9BRFIKAluCQQpVU0IxCF9BRFIMAQAdABQjX1MwRABwU01JXwqFCgBge2AKAWCg
CJNgCgCkCgOhBKQKABQ0X1BSVwBwVVBSVwoACgFgoA2TYAoDpBIGAgoECgOgDZNgCgGkEgYC
CgQKAaQSBgIKBAoAFA1fUFNXAVVQU1doCgFbgihIVUIxCF9BRFIKAFuCDENIMTAIX0FEUgoB
W4IMQ0gxMQhfQURSCgJbgkEKVVNCMghfQURSDAIAHQAUI19TMEQAcFNNSV8KhQoAYHtgCgFg
oAiTYAoApAoDoQSkCgAUNF9QUlcAcFVQUlcKAAoCYKANk2AKA6QSBgIKDAoDoA2TYAoBpBIG
AgoMCgGkEgYCCgwKABQNX1BTVwFVUFNXaAoCW4IoSFVCMghfQURSCgBbggxDSDIwCF9BRFIK
AVuCDENIMjEIX0FEUgoCW4JBClVTQjQIX0FEUgwDAB0AFCNfUzBEAHBTTUlfCoUKAGB7YAoB
YKAIk2AKAKQKA6EEpAoAFDRfUFJXAHBVUFJXCgAKA2CgDZNgCgOkEgYCCg4KA6ANk2AKAaQS
BgIKDgoBpBIGAgoOCgAUDV9QU1cBVVBTV2gKA1uCKEhVQjQIX0FEUgoAW4IMQ0g0MAhfQURS
CgFbggxDSDQxCF9BRFIKAluCRQhVU0IzCF9BRFIMBwAdABQjX1MwRABwU01JXwqFCgBge2AK
AWCgCJNgCgCkCgOhBKQKAAhfUzFECgIIX1MzRAoCFDRfUFJXAHBVUFJXCgAKB2CgDZNgCgOk
EgYCCg0KA6ANk2AKAaQSBgIKDQoBpBIGAgoNCgAUDV9QU1cBVVBTV2gKBwhQSUMwEkkeEhIa
BAz//x8ACgBcLwNfU0JfUENJMExOS0MKABIaBAz//x8ACgFcLwNfU0JfUENJMExOS0IKABIa
BAz//x8ACgJcLwNfU0JfUENJMExOS0MKABIaBAz//x8ACgNcLwNfU0JfUENJMExOS0QKABIa
BAz//x4ACgBcLwNfU0JfUENJMExOS0EKABIaBAz//x4ACgFcLwNfU0JfUENJMExOS0IKABIa
BAz//x4ACgJcLwNfU0JfUENJMExOS0MKABIaBAz//x4ACgNcLwNfU0JfUENJMExOS0QKABIa
BAz//x0ACgBcLwNfU0JfUENJMExOS0EKABIaBAz//x0ACgFcLwNfU0JfUENJMExOS0IKABIa
BAz//x0ACgJcLwNfU0JfUENJMExOS0MKABIaBAz//x0ACgNcLwNfU0JfUENJMExOS0QKABIa
BAz//xwACgBcLwNfU0JfUENJMExOS0EKABIaBAz//xwACgFcLwNfU0JfUENJMExOS0IKABIa
BAz//xwACgJcLwNfU0JfUENJMExOS0MKABIaBAz//xwACgNcLwNfU0JfUENJMExOS0QKABIa
BAz//wIACgBcLwNfU0JfUENJMExOS0EKABIaBAz//wEACgBcLwNfU0JfUENJMExOS0EKAAhB
UEkwEk8PEhINBAz//x8ACgAKAAoQEg0EDP//HwAKAQoAChESDQQM//8fAAoCCgAKEhINBAz/
/x8ACgMKAAoTEg0EDP//HgAKAAoAChASDQQM//8eAAoBCgAKERINBAz//x4ACgIKAAoSEg0E
DP//HgAKAwoAChMSDQQM//8dAAoACgAKEBINBAz//x0ACgEKAAoREg0EDP//HQAKAgoAChIS
DQQM//8dAAoDCgAKExINBAz//xwACgAKAAoQEg0EDP//HAAKAQoAChESDQQM//8cAAoCCgAK
EhINBAz//xwACgMKAAoTEg0EDP//AgAKAAoAChASDQQM//8BAAoACgAKEBQbX1BSVABwQVBJ
MGCgDJJHUElDcFBJQzBgpGBbgSlcLwRfU0JfUENJMElTQUJQSVIxAVBJUkEIUElSQghQSVJD
CFBJUkQIW4EpXC8EX1NCX1BDSTBJU0FCUElSMgFQSVJFCFBJUkYIUElSRwhQSVJICFuCRAxM
TktBCF9ISUQMQdAMDwhfVUlECgEIX1BSUxEJCgYjAA4YeQAUHV9TVEEAcFBJUkFge2AKgGCg
CJNgCoCkCgmkCgsUF19ESVMAcFBJUkFgfWAKgGBwYFBJUkEUSgRfQ1JTAAhCVUZBEQkKBiMA
ABh5AItCVUZBCgFJUkFfcFBJUkFge2AKj2CgGJVgCoB7YAoPAHAKAWF5YWBhcGFJUkFfpEJV
RkEUHF9TUlMBi2gKAUlSUUGBSVJRQWB2YHBgUElSQVuCRAxMTktCCF9ISUQMQdAMDwhfVUlE
CgIIX1BSUxEJCgYjoAAYeQAUHV9TVEEAcFBJUkJge2AKgGCgCJNgCoCkCgmkCgsUF19ESVMA
cFBJUkJgfWAKgGBwYFBJUkIUSgRfQ1JTAAhCVUZCEQkKBiMAABh5AItCVUZCCgFJUkJfcFBJ
UkJge2AKj2CgGJVgCoB7YAoPAHAKAWF5YWBhcGFJUkJfpEJVRkIUHF9TUlMBi2gKAUlSUUKB
SVJRQmB2YHBgUElSQluCRAxMTktDCF9ISUQMQdAMDwhfVUlECgMIX1BSUxEJCgYjAA4YeQAU
HV9TVEEAcFBJUkNge2AKgGCgCJNgCoCkCgmkCgsUF19ESVMAcFBJUkNgfWAKgGBwYFBJUkMU
SgRfQ1JTAAhCVUZDEQkKBiMAABh5AItCVUZDCgFJUkNfcFBJUkNge2AKj2CgGJVgCoB7YAoP
AHAKAWF5YWBhcGFJUkNfpEJVRkMUHF9TUlMBi2gKAUlSUUOBSVJRQ2B2YHBgUElSQ1uCRAxM
TktECF9ISUQMQdAMDwhfVUlECgQIX1BSUxEJCgYjoA4YeQAUHV9TVEEAcFBJUkRge2AKgGCg
CJNgCoCkCgmkCgsUF19ESVMAcFBJUkRgfWAKgGBwYFBJUkQUSgRfQ1JTAAhCVUZEEQkKBiMA
ABh5AItCVUZECgFJUkRfcFBJUkRge2AKj2CgGJVgCoB7YAoPAHAKAWF5YWBhcGFJUkRfpEJV
RkQUHF9TUlMBi2gKAUlSUUSBSVJRRGB2YHBgUElSRFuCRAxMTktFCF9ISUQMQdAMDwhfVUlE
CgUIX1BSUxEJCgYj+N4YeQAUHV9TVEEAcFBJUkVge2AKgGCgCJNgCoCkCgmkCgsUF19ESVMA
cFBJUkVgfWAKgGBwYFBJUkUUSgRfQ1JTAAhCVUZFEQkKBiMAABh5AItCVUZFCgFJUkVfcFBJ
UkVge2AKj2CgGJVgCoB7YAoPAHAKAWF5YWBhcGFJUkVfpEJVRkUUHF9TUlMBi2gKAUlSUUWB
SVJRRWB2YHBgUElSRVuCRAxMTktGCF9ISUQMQdAMDwhfVUlECggIX1BSUxEJCgYj+N4YeQAU
HV9TVEEAcFBJUkZge2AKgGCgCJNgCoCkCgmkCgsUF19ESVMAcFBJUkZgfWAKgGBwYFBJUkYU
SgRfQ1JTAAhCVUZGEQkKBiMAABh5AItCVUZGCgFJUlFGcFBJUkZge2AKj2CgGJVgCoB7YAoP
AHAKAWF5YWBhcGFJUlFGpEJVRkYUHF9TUlMBi2gKAUlSUUaBSVJRRmB2YHBgUElSRluCRAxM
TktICF9ISUQMQdAMDwhfVUlECggIX1BSUxEJCgYj+N4YeQAUHV9TVEEAcFBJUkhge2AKgGCg
CJNgCoCkCgmkCgsUF19ESVMAcFBJUkhgfWAKgGBwYFBJUkgUSgRfQ1JTAAhCVUZIEQkKBiMA
ABh5AItCVUZICgFJUkhfcFBJUkhge2AKj2CgGJVgCoB7YAoPAHAKAWF5YWBhcGFJUkhfpEJV
RkgUHF9TUlMBi2gKAUlSUUiBSVJRSGB2YHBgUElSSFuCSj9JREUwCF9BRFIMAgAfAFuAUENG
RwIKAAsAAVuBQxFQQ0ZHAwBAIFRQRjABVFBJMAFUUFAwAVRQRDABVFBGMQFUUEkxAVRQUDEB
VFBEMQFUUFJUAgACVFBJUwJUUFRSAVRQREUBVFNGMAFUU0kwAVRTUDABVFNEMAFUU0YxAVRT
STEBVFNQMQFUU0QxAVRTUlQCAAJUU0lTAlRTVFIBVFNERQFQUlRTAlBJT1MCU1JUUwJTSU9T
AgAYU0NQMAFTQ1AxAVNDUzABU0NTMQEADFBDVDACAAJQQ1QxAgACU0NUMAIAAlNDVDECAAIA
QARQQ0IwAVBDQjEBU0NCMAFTQ0IxAQACUE1DUgFQU0NSAQAERlBDMAFGUEMxAUZTQzABRlND
MQFQU0lHAlNTSUcCAAwIR1RNVBEXChT/////////////////////EQAAAIpHVE1UCgBQSU8w
ikdUTVQKBERNQTCKR1RNVAoIUElPMYpHVE1UCgxETUExikdUTVQKEElGTEcUJUdUTUkAcP9Q
SU8wcP9ETUEwcP9QSU8xcP9ETUExcAoQSUZMRxQqVURNQQOgBWikChSgEGmgCJNqCgKkCjyh
BKQKWqEMd3QKBGoACh5gpGAUGVBJT00CcAoJYHRgaGB0YGlgd2AKHmCkYBRLDUdUTVAAR1RN
SaANk1RQREUKAKRHVE1UfVNDUDBJRkxHSUZMR3lUUEkwCgFgfWBJRkxHSUZMR3lTQ1AxCgJg
fWBJRkxHSUZMR3lUUEkxCgNgfWBJRkxHSUZMR3BQSU9NVFBJU1RQUlRQSU8wcFBJT01QUlRT
UElPU1BJTzGgGlNDUDBwVURNQUZQQzBQQ0IwUENUMERNQTChEKAOVFBEMHBQSU8wRE1BMKAa
U0NQMXBVRE1BRlBDMVBDQjFQQ1QxRE1BMaEQoA5UUEQxcFBJTzFETUExpEdUTVQUSw1HVE1T
AEdUTUmgDZNUU0RFCgCkR1RNVH1TQ1MwSUZMR0lGTEd5VFNJMAoBYH1gSUZMR0lGTEd5U0NT
MQoCYH1gSUZMR0lGTEd5VFNJMQoDYH1gSUZMR0lGTEdwUElPTVRTSVNUU1JUUElPMHBQSU9N
U1JUU1NJT1NQSU8xoBpTQ1MwcFVETUFGU0MwU0NCMFNDVDBETUEwoRCgDlRTRDBwUElPMERN
QTCgGlNDUzFwVURNQUZTQzFTQ0IxU0NUMURNQTGhEKAOVFNEMXBQSU8xRE1BMaRHVE1UFAlf
U1RBAKQKD1uCIlBSSV8IX0FEUgoAFAtfR1RNAKRHVE1QFAlfU1RBAKQKD1uCIlNFQzAIX0FE
UgoBFAlfU1RBAKQKDxQLX0dUTQCkR1RNU1uCD0FVRF8IX0FEUgwCAB4AW4IbTU9ETQhfQURS
DAMAHgAIX1BSVxIGAgoFCgNbgkMgQUdQXwhfQURSDAAAAQAIUElDMRIbARIYBAv//woAXC8D
X1NCX1BDSTBMTktBCgAIQVBJMRIOARILBAv//woACgAKEBQbX1BSVABwQVBJMWCgDJJHUElD
cFBJQzFgpGBbgkAaVklEXwhfQURSCgAUFl9ET1MBcGhNSVM0U01JXwqeTUlTNBRJBF9ET0QA
cFNNSV8KbQoAYKAdk2AKAaQSFgQMAAEBAAwAAgEADBABAQAMEAIBAKEZpBIWBAwAAQEADAAC
AQAMEAEBAAwgAQEAW4JFBFRWX18UCl9BRFIApAsAAhQSX0RDUwBwU01JXwqOCgRgpGAUEl9E
R1MAcFNNSV8KmQoEYKRgFA1fRFNTAURTU18KBGhbgkUEQ1JUXxQKX0FEUgCkCwABFBJfRENT
AHBTTUlfCo4KAmCkYBQSX0RHUwBwU01JXwqZCgJgpGAUDV9EU1MBRFNTXwoCaFuCRQRMQ0Rf
FApfQURSAKQLEAEUEl9EQ1MAcFNNSV8KjgoBYKRgFBJfREdTAHBTTUlfCpkKAWCkYBQNX0RT
UwFEU1NfCgFoW4JLBURWSV8UIF9BRFIAcFNNSV8KbQoAYKAJk2AKAaQLEAKhBaQLIAEUEl9E
Q1MAcFNNSV8KjgoIYKRgFBJfREdTAHBTTUlfCpkKCGCkYBQNX0RTUwFEU1NfCghoW4JCFlZJ
RF8IX0FEUgwAAAIAFBZfRE9TAXBoTUlTNFNNSV8Knk1JUzQUHl9ET0QApBIWBAwAAQEADAAC
AQAMAAQBAAwAAwEAW4JFBFRWX18UCl9BRFIApAsAAhQSX0RDUwBwU01JXwqOCgRgpGAUEl9E
R1MAcFNNSV8KmQoEYKRgFA1fRFNTAURTU18KBGhbgkUEQ1JUXxQKX0FEUgCkCwABFBJfRENT
AHBTTUlfCo4KAmCkYBQSX0RHUwBwU01JXwqZCgJgpGAUDV9EU1MBRFNTXwoCaFuCRQRMQ0Rf
FApfQURSAKQLAAQUEl9EQ1MAcFNNSV8KjgoBYKRgFBJfREdTAHBTTUlfCpkKAWCkYBQNX0RT
UwFEU1NfCgFoW4JFBERWSV8UCl9BRFIApAsAAxQSX0RDUwBwU01JXwqOCghgpGAUEl9ER1MA
cFNNSV8KmQoIYKRgFA1fRFNTAURTU18KCGhbgiFWSUQyCF9BRFIMAQACABQGX0RPUwEUCl9E
T0QApBICAFuCSURNQjdfCF9ISUQMQdAMAQhfVUlECgcUNF9TVEEAcFNNSV8KbQoAYKAgk2AK
A6ALk09TSUQKCKQKC6ALk09TSUQKEKQKC6QKAKQKAAhfQ1JTEUc/C/IDRwGwB7AHEAxHAcAH
wAcQIEcBsAuwCxAMRwHAC8ALECBHAbAPsA8QDEcBwA/ADxAgRwGwE7ATEAxHAcATwBMQIEcB
sBewFxAMRwHAF8AXECBHAbAbsBsQDEcBwBvAGxAgRwGwH7AfEAxHAcAfwB8QIEcBsCOwIxAM
RwHAI8AjECBHAbAnsCcQDEcBwCfAJxAgRwGwK7ArEAxHAcArwCsQIEcBsC+wLxAMRwHAL8Av
ECBHAbAzsDMQDEcBwDPAMxAgRwGwN7A3EAxHAcA3wDcQIEcBsDuwOxAMRwHAO8A7ECBHAbA/
sD8QDEcBwD/APxAgRwGwQ7BDEAxHAcBDwEMQIEcBsEewRxAMRwHAR8BHECBHAbBLsEsQDEcB
wEvASxAgRwGwT7BPEAxHAcBPwE8QIEcBsFOwUxAMRwHAU8BTECBHAbBXsFcQDEcBwFfAVxAg
RwGwW7BbEAxHAcBbwFsQIEcBsF+wXxAMRwHAX8BfECBHAbBjsGMQDEcBwGPAYxAgRwGwZ7Bn
EAxHAcBnwGcQIEcBsGuwaxAMRwHAa8BrECBHAbBvsG8QDEcBwG/AbxAgRwGwc7BzEAxHAcBz
wHMQIEcBsHewdxAMRwHAd8B3ECBHAbB7sHsQDEcBwHvAexAgRwGwf7B/EAxHAcB/wH8QIEcB
sIOwgxAMRwHAg8CDECBHAbCHsIcQDEcBwIfAhxAgRwGwi7CLEAxHAcCLwIsQIEcBsI+wjxAM
RwHAj8CPECBHAbCTsJMQDEcBwJPAkxAgRwGwl7CXEAxHAcCXwJcQIEcBsJuwmxAMRwHAm8Cb
ECBHAbCfsJ8QDEcBwJ/AnxAgRwGwo7CjEAxHAcCjwKMQIEcBsKewpxAMRwHAp8CnECBHAbCr
sKsQDEcBwKvAqxAgRwGwr7CvEAxHAcCvwK8QIEcBsLOwsxAMRwHAs8CzECBHAbC3sLcQDEcB
wLfAtxAgRwGwu7C7EAxHAcC7wLsQIEcBsL+wvxAMRwHAv8C/ECBHAbDDsMMQDEcBwMPAwxAg
RwGwx7DHEAxHAcDHwMcQIEcBsMuwyxAMRwHAy8DLECBHAbDPsM8QDEcBwM/AzxAgRwGw07DT
EAxHAcDTwNMQIEcBsNew1xAMRwHA18DXECBHAbDbsNsQDEcBwNvA2xAgRwGw37DfEAxHAcDf
wN8QIEcBsOOw4xAMRwHA48DjECBHAbDnsOcQDEcBwOfA5xAgRwGw67DrEAxHAcDrwOsQIEcB
sO+w7xAMRwHA78DvECBHAbDzsPMQDEcBwPPA8xAgRwGw97D3EAxHAcD3wPcQIEcBsPuw+xAM
RwHA+8D7ECBHAbD/sP8QDEcBwP/A/xAgeQBbgkgZUENJRQhfQURSDAAAHgAIX1BSVxIGAgoL
CgQIUElDRRJDCgYSGgQM//8BAAoAXC8DX1NCX1BDSTBMTktECgASGgQM//8BAAoBXC8DX1NC
X1BDSTBMTktDCgASGgQM//8BAAoCXC8DX1NCX1BDSTBMTktCCgASGgQM//8DAAoAXC8DX1NC
X1BDSTBMTktCCgASGgQM//8DAAoBXC8DX1NCX1BDSTBMTktECgASGAQL//8KAFwvA19TQl9Q
Q0kwTE5LQwoACEFQSUUSRQUGEg0EDP//AQAKAAoAChMSDQQM//8BAAoBCgAKEhINBAz//wEA
CgIKAAoREg0EDP//AwAKAAoAChESDQQM//8DAAoBCgAKExILBAv//woACgAKEhQbX1BSVABw
QVBJRWCgDJJHUElDcFBJQ0VgpGBbgixDUkQwCF9BRFIMAAABABQOX0lOSQBTTUlfCpUKBAhf
UzFECgAIX1MzRAoDW4IsQ1JEMQhfQURSDAUAAQAUDl9JTkkAU01JXwqdCgQIX1MxRAoACF9T
M0QKAw==

--ew6BAiZeqk4r7MaW--
