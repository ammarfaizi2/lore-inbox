Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUIWEIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUIWEIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIWEHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:07:38 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:29534 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268251AbUIWEAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:00:21 -0400
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: undecoded slave?
Date: Wed, 22 Sep 2004 23:57:30 -0400
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tmkUBs4yutlUtsd"
Message-Id: <200409222357.39492.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tmkUBs4yutlUtsd
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Probing IDE interface ide3...
hdg: Maxtor 4D060H3, ATA DISK drive
hdh: Maxtor 4D060H3, ATA DISK drive
ide-probe: ignoring undecoded slave

Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error above seems=20
to be the only [stated] reason why.

back on 2.6.8-rc1-mm1+idefix2 (lba48 FLUSH CACHE bug) for now.

=2D --
tabris
=2D -
The surest sign that a man is in love is when he divorces his wife.
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUkmx1U5ZaPMbKQcRAl1AAJ9730bWgzrMY5qJmTCyfqJDeUzhOgCfbtG7
+Ge2J6Gm6F2KOi/h3DswRa8=3D
=3DHUlK
=2D----END PGP SIGNATURE-----

--Boundary-00=_tmkUBs4yutlUtsd
Content-Type: text/x-log;
  charset="us-ascii";
  name="missing_HD.dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="missing_HD.dmesg.log"

Linux version 2.6.9-rc2-mm2 (tabris@tabriel.tabris.net) (gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #1 Wed Sep 22 21:42:49 EDT 2004
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
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6e20
ACPI: RSDT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V266-E 0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda3 vga=8 nodevfs
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1544.719 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 132x43
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515580k/524208k available (1830k kernel code, 8108k reserved, 982k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3039.23 BogoMIPS (lpj=1519616)
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0ed0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.PX40.UAR2._STA] (Node c14e5900), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
spurious 8259A interrupt: IRQ7.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Simple Boot Flag at 0x3a set to 0x80
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller at PCI slot 0000:00:06.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 4
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 4 (level, low) -> IRQ 4
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 4
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:DMA, hdh:DMA
Probing IDE interface ide2...
hde: MAXTOR 4K060H3, ATA DISK drive
Using anticipatory io scheduler
ide2 at 0xd800-0xd807,0xd402 on irq 4
Probing IDE interface ide3...
hdg: Maxtor 4D060H3, ATA DISK drive
hdh: Maxtor 4D060H3, ATA DISK drive
ide-probe: ignoring undecoded slave
ide3 at 0xd000-0xd007,0xb802 on irq 4
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:11.1[A] -> GSI 11 (level, low) -> IRQ 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC AC28400R, ATA DISK drive
hdb: Maxtor 93652U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TDK CDRW241040B, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-604, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 128KiB
hde: 117266688 sectors (60040 MB) w/2000KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2 < hde5 >
hdg: max request size: 128KiB
hdg: 120069936 sectors (61475 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hdg: cache flushes not supported
 hdg: hdg1 hdg2
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=16383/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
hdb: cache flushes not supported
 hdb: hdb1 hdb2 < hdb5 > hdb3
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:11.2[D] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:11.2: irq 4, io base 0x9800
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:11.3[D] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:11.3: irq 4, io base 0x9400
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:11.4[D] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:11.4: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:11.4: irq 4, io base 0x9000
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
usb 1-2: new full speed USB device using address 3
usbcore: registered new driver hiddev
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:11.2-1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:11.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI0 PCI1 USB0 USB1 USB2 
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: replayed 11 transactions in 3 seconds
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 136k freed
ReiserFS: hda3: Removing [401113 3810 0x0 SD]..done
ReiserFS: hda3: Removing [401113 2601 0x0 SD]..done
ReiserFS: hda3: There were 2 uncompleted unlinks/truncates. Completed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1
Adding 999896k swap on /dev/hdb5.  Priority:-2 extents:1
ReiserFS: hdb3: found reiserfs format "3.6" with standard journal
ReiserFS: hdb3: using ordered data mode
ReiserFS: hdb3: journal params: device hdb3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb3: checking transaction log (hdb3)
ReiserFS: hdb3: Using r5 hash to sort names
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hde1
Ending clean XFS mount for filesystem: hde1
XFS mounting filesystem hdg2
Ending clean XFS mount for filesystem: hdg2
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xb000. Vers LK1.1.19

--Boundary-00=_tmkUBs4yutlUtsd--
