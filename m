Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUKHSve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUKHSve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUKHSud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:50:33 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:61463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261179AbUKHSoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:44:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZsB3k4jP3pCaLrmwxMLoY/uerazqW8iWt3ot/jR2MxadNUNOKT8JcB6z7pr4I5FnOwAouzrpvclFlHHy6DtXvNjGJCdDZxtaSd1uyOnUbSxHQ9ue/Q86SWwSviIm3o08hCkDrsMi3xVm9UbyyXDSgkH7xNyy4K8nuCe7Yn2YLSA=
Message-ID: <84144f0204110810444400761f@mail.gmail.com>
Date: Mon, 8 Nov 2004 20:44:37 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: Oops in 2.6.10-rc1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, alsa-devel@lists.sourceforge.net,
       linux-sound@vger.kernel.org, Greg KH <greg@kroah.com>,
       penberg@cs.helsinki.fi
In-Reply-To: <418F6E33.8080808@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4180F026.9090302@g-house.de> <418D7959.4020206@g-house.de>
	 <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
	 <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de>
	 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
	 <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>
	 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
	 <418F6E33.8080808@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Mon, 08 Nov 2004 14:01:39 +0100, Christian Kujau <evil@g-house.de> wrote:
> i've put everthing on http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/
> the .configs, the oopses are there. i've double checked a kernel built
> from "bk -a a1.2000.7.2" yesterday but the result was the same (no oops)

Just to update, I cannot reproduce the oops with your config (nor
mine) on my machine running 2.6.10-rc1-bk14.

                       Pekka

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365
[KT133/KM133] (rev 03)
        Subsystem: ASUSTeK Computer Inc. A7V133/A7V133-C Mainboard
        Flags: bus master, medium devsel, latency 8
        Memory at e7000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365
[KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: d7000000-d7efffff
        Prefetchable memory behind bridge: d7f00000-e6ffffff
        Expansion ROM at 0000d000 [disabled] [size=4K]
        Capabilities: [80] Power Management version 2

0000:00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
South] (rev 40)
        Subsystem: ASUSTeK Computer Inc. A7V133/A7V133-C Mainboard
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

0000:00:04.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if
 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at b800 [size=16]
        Capabilities: [c0] Power Management version 2

0000:00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
ACPI] (rev 40)
        Subsystem: ASUSTeK Computer Inc. A7V133/A7V133-C Mainboard
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 9400
        Memory at d6800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 04)
        Subsystem: Ensoniq Sound Blaster 16PCI 4.1ch
        Flags: bus master, slow devsel, latency 32, IRQ 11
        I/O ports at 9000
        Capabilities: [dc] Power Management version 2

0000:00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 8800
        Memory at d6000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: Hightech Information System Ltd.: Unknown device 0f02
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64
        Memory at d8000000 (32-bit, prefetchable) [size=d7fe0000]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2



Linux version 2.6.10-rc1-bk14 (root@cherry) (gcc version 3.4.2 (Gentoo
Linux 3.4.2-r2, ssp-3.4.1-1, pie-8.7.6.5)) #8 Mon Nov 8 20:18:45 EET
2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262124
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32748 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a80
ACPI: RSDT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x3ffec000
ACPI: FADT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x3ffec080
ACPI: BOOT (v001 ASUS   A7V133-C 0x30303031 MSFT 0x31313031) @ 0x3ffec040
ACPI: DSDT (v001   ASUS A7V133-C 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
Kernel command line: root=/dev/ram0 init=/linuxrc real_root=/dev/hda3 acpi=force
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1009.328 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034128k/1048496k available (2582k kernel code, 13664k
reserved, 770k data, 148k init, 130992k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1998.84 BogoMIPS (lpj=999424)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff c1c7f9ff 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After all inits, caps:        0383f9ff c1c7f9ff 00000000 00000020
CPU: AMD Duron(tm) Processor stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 885k freed
kobject_uevent: unable to create netlink socket!
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:04.2[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:04.3[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
Simple Boot Flag at 0x3a set to 0x1
highmem bounce pool size: 64 pages
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
SGI XFS with ACLs, realtime, no debug enabled
SGI XFS Quota Management subsystem
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Equalizer2002: Simon Janes (simon@ncm.com) and David S. Miller
(davem@redhat.com)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 4D060H3, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Hewlett-Packard CD-Writer Plus 8200a, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 120069936 sectors (61475 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices:
PWRB PCI0 UAR1 UAR2 USB0 USB1
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 148k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ReiserFS: hda3: warning: sh-2021: reiserfs_fill_super: can not find
reiserfs on hda3
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2040244k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
8139too Fast Ethernet driver 0.9.27
PCI: Enabling device 0000:00:09.0 (0004 -> 0007)
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 10 (level, low) -> IRQ 10
eth0: RealTek RTL8139 at 0xf8814000, 00:06:4f:01:66:57, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
PCI: Enabling device 0000:00:0d.0 (0004 -> 0007)
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 10 (level, low) -> IRQ 10
eth1: RealTek RTL8139 at 0xf8816000, 00:06:4f:01:66:58, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies
Inc Radeon RV100 QY [Radeon 7000/VE]
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 6283 using kernel context 0
inserting floppy driver for 2.6.10-rc1-bk14
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PCI: Enabling device 0000:00:0a.0 (0004 -> 0005)
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
