Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUDDUvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUDDUvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 16:51:04 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:13953
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262784AbUDDUux convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 16:50:53 -0400
From: "Shawn Starr" <shawn.starr@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a problem with 2.6.5-rc3
Date: Sun, 4 Apr 2004 16:50:47 -0400
Message-ID: <000001c41a86$81ae4c40$0200080a@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [67.60.40.239] using ID <shawn.starr@rogers.com> at Sun, 4 Apr 2004 16:49:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmesg:
 Linux version 2.6.5 (root@coredump) (gcc version 3.3.4 20040313
(prerelease)) #2 Sun Apr 4 04:18:23 EDT 2004
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000023ffd9c0 (usable)
  BIOS-e820: 0000000023ffd9c0 - 0000000024000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
 575MB LOWMEM available.
 On node 0 totalpages: 147453
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 143357 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
 DMI 2.1 present.
 IBM machine detected. Enabling interrupts during APM calls.
 IBM machine detected. Disabling SMBus accesses.
 ACPI: RSDP (v000 IBM                                       ) @ 0x000fdfe0
 ACPI: RSDT (v001 IBM    CDTPWSNV 0x00001010 IBM  0x00000000) @ 0x23ffff80
 ACPI: FADT (v001 IBM    CDTPWSNV 0x00001010 IBM  0x00000000) @ 0x23ffff00
 ACPI: DSDT (v001 IBM    CDTPWSNV 0x00001000 MSFT 0x01000007) @ 0x00000000
 ACPI: PM-Timer IO Port: 0xfd08
 Built 1 zonelists
 Kernel command line: BOOT_IMAGE=linux ro root=301 console=tty0
psmouse_rate=60 psmouse_resolution=200 nmi_watchdog=2 atkbd.softrepeat=1
 Parameter psmouse_rate= is obsolete, ignored
 Parameter psmouse_resolution= is obsolete, ignored
 Local APIC disabled by BIOS -- reenabling.
 Found and enabled local APIC!
 Initializing CPU#0
 PID hash table entries: 4096 (order 12: 32768 bytes)
 Detected 547.805 MHz processor.
 Using pmtmr for high-res timesource
 Console: colour VGA+ 80x25
 Memory: 578720k/589812k available (2453k kernel code, 10304k reserved, 688k
data, 364k init, 0k highmem)
 Checking if this processor honours the WP bit even in supervisor mode...
Ok.
 Calibrating delay loop... 1085.44 BogoMIPS
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
 CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
 CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
 CPU: L1 I cache: 16K, L1 D cache: 16K
 CPU: L2 cache: 512K
 CPU:     After all inits, caps: 0383fbf7 00000000 00000000 00000040
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 CPU: Intel Pentium III (Katmai) stepping 03
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
 POSIX conformance testing by UNIFIX
 enabled ExtINT on CPU#0
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
 testing NMI watchdog ... OK.
 Using local APIC timer interrupts.
 calibrating APIC timer ...
 ..... CPU clock speed is 547.0532 MHz.
 ..... host bus clock speed is 99.0551 MHz.
 NET: Registered protocol family 16
 PCI: PCI BIOS revision 2.10 entry at 0xfd83c, last bus=1
 PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
 ACPI: Subsystem revision 20040326
 ACPI: IRQ9 SCI: Level Trigger.
     ACPI-0179: *** Warning: The ACPI AML in your computer contains errors,
please nag the manufacturer to correct it.
     ACPI-0182: *** Warning: Allowing relaxed access to fields; turn on
CONFIG_ACPI_DEBUG for details.
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Link [PIN1] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
 ACPI: PCI Interrupt Link [PIN2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
 ACPI: PCI Interrupt Link [PIN3] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
 ACPI: PCI Interrupt Link [PIN4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
 Linux Plug and Play Support v0.97 (c) Adam Belay
 pnp: the driver 'system' has been registered
 PnPBIOS: Scanning system for PnP BIOS support...
 PnPBIOS: Found PnP BIOS installation structure at 0xc00fde50
 PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x587a, dseg 0xf0000
 pnp: match found with the PnP device '00:09' and the driver 'system'
 pnp: match found with the PnP device '00:0a' and the driver 'system'
 pnp: match found with the PnP device '00:0c' and the driver 'system'
 pnp: match found with the PnP device '00:0d' and the driver 'system'
 pnp: match found with the PnP device '00:0e' and the driver 'system'
 pnp: 00:0e: ioport range 0x370-0x371 has been reserved
 pnp: 00:0e: ioport range 0x4d0-0x4d1 has been reserved
 pnp: match found with the PnP device '00:0f' and the driver 'system'
 pnp: 00:0f: ioport range 0x290-0x297 has been reserved
 pnp: match found with the PnP device '00:10' and the driver 'system'
 pnp: 00:10: ioport range 0xfd00-0xfd3f has been reserved
 pnp: 00:10: ioport range 0xfe00-0xfe0f has been reserved
 pnp: match found with the PnP device '00:15' and the driver 'system'
 PnPBIOS: 21 nodes reported by PnP BIOS; 21 recorded by driver
 SCSI subsystem initialized
 drivers/usb/core/usb.c: registered new driver usbfs
 drivers/usb/core/usb.c: registered new driver hub
 ACPI: PCI Interrupt Link [PIN4] enabled at IRQ 11
 ACPI: PCI Interrupt Link [PIN3] enabled at IRQ 9
 ACPI: PCI Interrupt Link [PIN2] enabled at IRQ 5
 PCI: Using ACPI for IRQ routing
 PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
 IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
 Limiting direct PCI/PCI transfers.
 ACPI: Power Button (FF) [PWRF]
 ACPI: Processor [CPU0] (supports C1)
 isapnp: Scanning for PnP cards...
 pnp: Calling quirk for 01:01.00
 pnp: SB audio device quirk - increasing port range
 pnp: Calling quirk for 01:01.02
 pnp: AWE32 quirk - adding two ports
 isapnp: Card 'Creative SB32 PnP'
 isapnp: Card 'U.S. Robotics Sportster 33600 FAX/Voice Int'
 isapnp: 2 Plug & Play cards detected total
 lp: driver loaded but no devices found
 Real Time Clock Driver v1.12
 Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is
60 seconds).
 Serial: 8250/16550 driver $Revision: 1.90 $ 7 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
 pnp: the driver 'serial' has been registered
 pnp: match found with the PnP device '00:12' and the driver 'serial'
 pnp: match found with the PnP device '00:13' and the driver 'serial'
 pnp: match found with the PnP device '01:02.00' and the driver 'serial'
 pnp: Unable to assign resources to device 01:02.00.
 serial: probe of 01:02.00 failed with error -16
 pnp: the driver 'parport_pc' has been registered
 pnp: match found with the PnP device '00:14' and the driver 'parport_pc'
 parport: PnPBIOS parport detected.
 parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
 lp0: using parport0 (interrupt-driven).
 Using anticipatory io scheduler
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 e100: Intel(R) PRO/100 Network Driver, 3.0.17
 e100: Copyright(c) 1999-2004 Intel Corporation
 e100: eth0: e100_probe: addr 0xf3cff000, irq 11, MAC addr 00:06:29:CE:07:04
 e100: eth1: e100_probe: addr 0xf3dff000, irq 5, MAC addr 00:D0:B7:4E:F0:7D
 netconsole: not configured, aborting
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 PIIX4: IDE controller at PCI slot 0000:00:02.1
 PIIX4: chipset revision 1
 PIIX4: not 100%% native mode: will probe irqs later
     ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:pio, hdd:pio
 hda: MAXTOR 6L040L2, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hdc: CRD-8400B, ATAPI CD/DVD-ROM drive
 hdc: Disabling (U)DMA for CRD-8400B (blacklisted)
 ide1 at 0x170-0x177,0x376 on irq 15
 hda: max request size: 128KiB
 hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(33)
  hda: hda1 hda2
 hdc: ATAPI 40X CD-ROM drive, 128kB Cache
 Uniform CD-ROM driver Revision: 3.20
 scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

   Vendor: HP        Model: T4000s            Rev: 1.10
   Type:   Sequential-Access                  ANSI SCSI revision: 02
 ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
 ohci_hcd: block sizes: ed 64 td 64
 USB Universal Host Controller Interface driver v2.2
 PCI: Enabling device 0000:00:02.2 (0000 -> 0001)
 uhci_hcd 0000:00:02.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
 uhci_hcd 0000:00:02.2: irq 11, io base 00001000
 uhci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 2 ports detected
 mice: PS/2 mouse device common for all mice
 input: PC Speaker
 serio: i8042 AUX port at 0x60,0x64 irq 12
 input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
 serio: i8042 KBD port at 0x60,0x64 irq 1
 input: AT Translated Set 2 keyboard on isa0060/serio0
 i2c /dev entries driver
 i2c-core: driver dev_driver registered.
 sb: Init: Starting Probe...
 pnp: the driver 'OSS SndBlstr' has been registered
 pnp: match found with the PnP device '01:01.00' and the driver 'OSS
SndBlstr'
 pnp: Device 01:01.00 activated.
 sb: PnP: Found Card Named = "Creative SB32 PnP", Card PnP id = CTL0048,
Device PnP id =CTL0031
 sb: PnP:      Detected at: io=0x220, irq=10, dma=1, dma16=5
 <Sound Blaster 16 (4.13)> at 0x220 irq 10 dma 1,5
 sb: Turning on MPU
 <Sound Blaster 16> at 0x300 irq 10
 sb: Init: Done
 AWE32: Probing for WaveTable...
 pnp: the driver 'AWE32' has been registered
 pnp: match found with the PnP device '01:01.02' and the driver 'AWE32'
 pnp: Device 01:01.02 activated.
 AWE32: A PnP Wave Table was detected at IO's 0x620,0xa20,0xe20
 .<6><SoundBlaster EMU8000 (RAM2048k)>
 NET: Registered protocol family 2
 IP: routing cache hash table of 1024 buckets, 32Kbytes
 TCP: Hash tables configured (established 262144 bind 37449)
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 364k freed
 Adding 72284k swap on /dev/hda2.  Priority:1 extents:1
 EXT3 FS on hda1, internal journal
 e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
 e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex

When I try to access the eth0 device I get:

Apr  4 15:39:01 coredump kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr  4 16:22:12 coredump kernel: NETDEV WATCHDOG: eth0: transmit timed out

And then the eth0 device stops responding to traffic until I shut down and
cut power fo the machine by removing the power cable.

Can someone confirm problems with the changes from 2.6.5-rc3 -> 2.6.5 final?

Thanks

Shawn.

