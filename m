Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVKWRun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVKWRun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVKWRun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:50:43 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:53935 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932113AbVKWRu2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:50:28 -0500
Date: Wed, 23 Nov 2005 18:50:45 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-ID: <20051123175045.GA6760@stiffy.osknowledge.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20051123033550.00d6a6e8.akpm@osdl.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [2005-11-23 03:35:50 -0800]:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/
> 
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.15-rc2-mm1.gz)
> 
> - Added git-sym2.patch to the -mm lineup: updates to the sym2 scsi driver
>   (Matthew Wilcox).  
> 
> - The JSM tty driver still doesn't compile.
> 
> - The git-powerpc tree is included now.

Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
persists, moreover, some stuff's now really not gonna work anymore. I logged in
via gdm once and rebooted. 

Ragards,
	Marc


Nov 23 18:33:43 stiffy syslogd 1.4.1#17: restart.
Nov 23 18:33:44 stiffy kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Nov 23 18:33:44 stiffy kernel: Inspecting /boot/System.map-2.6.15-rc2-mm1-marc
Nov 23 18:33:44 stiffy kernel: Loaded 21947 symbols from /boot/System.map-2.6.15-rc2-mm1-marc.
Nov 23 18:33:44 stiffy kernel: Symbols match kernel version 2.6.15.
Nov 23 18:33:44 stiffy kernel: No module symbols loaded - kernel modules not enabled. 
Nov 23 18:33:44 stiffy kernel: 024x16, linelength=2560, pages=1
Nov 23 18:33:44 stiffy kernel: vesafb: protected mode interface info at c000:d6a0
Nov 23 18:33:44 stiffy kernel: vesafb: scrolling: redraw
Nov 23 18:33:44 stiffy kernel: vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Nov 23 18:33:44 stiffy kernel: Console: switching to colour frame buffer device 160x64
Nov 23 18:33:44 stiffy kernel: fb0: VESA VGA frame buffer device
Nov 23 18:33:45 stiffy kernel: PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Nov 23 18:33:45 stiffy kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Nov 23 18:33:45 stiffy kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Nov 23 18:33:45 stiffy kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Nov 23 18:33:45 stiffy kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 23 18:33:45 stiffy kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Nov 23 18:33:45 stiffy kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 23 18:33:45 stiffy kernel: 00:0d: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Nov 23 18:33:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Nov 23 18:33:45 stiffy kernel: PCI: setting IRQ 5 as level-triggered
Nov 23 18:33:45 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 23 18:33:45 stiffy kernel: ACPI: PCI interrupt for device 0000:00:1f.6 disabled
Nov 23 18:33:45 stiffy kernel: RAMDISK driver initialized: 4 RAM disks of 8192K size 1024 blocksize
Nov 23 18:33:45 stiffy kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Nov 23 18:33:45 stiffy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 23 18:33:45 stiffy kernel: ICH3M: IDE controller at PCI slot 0000:00:1f.1
Nov 23 18:33:45 stiffy kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Nov 23 18:33:45 stiffy kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Nov 23 18:33:45 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:45 stiffy kernel: ICH3M: chipset revision 2
Nov 23 18:33:45 stiffy kernel: ICH3M: not 100%% native mode: will probe irqs later
Nov 23 18:33:45 stiffy kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
Nov 23 18:33:45 stiffy kernel:     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
Nov 23 18:33:45 stiffy kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Nov 23 18:33:45 stiffy kernel: hda: HTS726060M9AT00, ATA DISK drive
Nov 23 18:33:45 stiffy kernel: hdb: HL-DT-STCD-RW/DVD-ROM GCC-4240N, ATAPI CD/DVD-ROM drive
Nov 23 18:33:45 stiffy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 23 18:33:45 stiffy kernel: hda: max request size: 1024KiB
Nov 23 18:33:45 stiffy kernel: hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63
Nov 23 18:33:45 stiffy kernel: hda: cache flushes supported
Nov 23 18:33:45 stiffy kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Nov 23 18:33:45 stiffy kernel: EISA: Probing bus 0 at eisa.0
Nov 23 18:33:45 stiffy kernel: NET: Registered protocol family 2
Nov 23 18:33:45 stiffy kernel: IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
Nov 23 18:33:45 stiffy kernel: TCP established hash table entries: 32768 (order: 5, 131072 bytes)
Nov 23 18:33:45 stiffy kernel: TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
Nov 23 18:33:45 stiffy kernel: TCP: Hash tables configured (established 32768 bind 32768)
Nov 23 18:33:45 stiffy kernel: TCP reno registered
Nov 23 18:33:45 stiffy kernel: TCP bic registered
Nov 23 18:33:45 stiffy kernel: NET: Registered protocol family 8
Nov 23 18:33:45 stiffy kernel: NET: Registered protocol family 20
Nov 23 18:33:45 stiffy kernel: Using IPI Shortcut mode
Nov 23 18:33:45 stiffy kernel: ACPI wakeup devices: 
Nov 23 18:33:45 stiffy kernel:  LID PBTN PCI0 UAR1 USB0 USB1 USB2 MODM PCIE MPCI 
Nov 23 18:33:46 stiffy kernel: ACPI: (supports S0 S1 S3 S4 S5)
Nov 23 18:33:46 stiffy kernel: BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Nov 23 18:33:46 stiffy kernel: RAMDISK: cramfs filesystem found at block 0
Nov 23 18:33:46 stiffy kernel: RAMDISK: Loading 1192KiB [1 disk] into ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^Hdone.
Nov 23 18:33:47 stiffy kernel: VFS: Mounted root (cramfs filesystem) readonly.
Nov 23 18:33:47 stiffy kernel: Freeing unused kernel memory: 248k freed
Nov 23 18:33:47 stiffy kernel: NET: Registered protocol family 1
Nov 23 18:33:48 stiffy kernel: ReiserFS: hda7: found reiserfs format "3.6" with standard journal
Nov 23 18:33:48 stiffy kernel: ReiserFS: hda7: using ordered data mode
Nov 23 18:33:48 stiffy kernel: ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov 23 18:33:48 stiffy kernel: ReiserFS: hda7: checking transaction log (hda7)
Nov 23 18:33:48 stiffy kernel: ReiserFS: hda7: Using r5 hash to sort names
Nov 23 18:33:48 stiffy kernel: Linux agpgart interface v0.101 (c) Dave Jones
Nov 23 18:33:48 stiffy kernel: agpgart: Detected an Intel i845 Chipset.
Nov 23 18:33:48 stiffy kernel: agpgart: AGP aperture is 64M @ 0xe8000000
Nov 23 18:33:48 stiffy kernel: usbcore: registered new driver usbfs
Nov 23 18:33:48 stiffy kernel: usbcore: registered new driver hub
Nov 23 18:33:48 stiffy kernel: USB Universal Host Controller Interface driver v2.3
Nov 23 18:33:48 stiffy kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:48 stiffy kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Nov 23 18:33:48 stiffy kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
Nov 23 18:33:48 stiffy kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
Nov 23 18:33:48 stiffy kernel: hub 1-0:1.0: USB hub found
Nov 23 18:33:48 stiffy kernel: hub 1-0:1.0: 2 ports detected
Nov 23 18:33:48 stiffy kernel: hw_random hardware driver 1.0.0 loaded
Nov 23 18:33:48 stiffy kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
Nov 23 18:33:48 stiffy kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:48 stiffy kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Nov 23 18:33:48 stiffy kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
Nov 23 18:33:48 stiffy kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
Nov 23 18:33:48 stiffy kernel: hub 2-0:1.0: USB hub found
Nov 23 18:33:48 stiffy kernel: hub 2-0:1.0: 2 ports detected
Nov 23 18:33:48 stiffy kernel: hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
Nov 23 18:33:48 stiffy kernel: Uniform CD-ROM driver Revision: 3.20
Nov 23 18:33:48 stiffy kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:48 stiffy kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Nov 23 18:33:48 stiffy kernel: 0000:02:00.0: 3Com PCI 3c905C Tornado at e085cc00. Vers LK1.1.19
Nov 23 18:33:48 stiffy kernel: usb 2-1: new full speed USB device using uhci_hcd and address 2
Nov 23 18:33:48 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:48 stiffy kernel: Yenta: CardBus bridge found at 0000:02:01.0 [1028:00d4]
Nov 23 18:33:48 stiffy kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Nov 23 18:33:48 stiffy kernel: Yenta: Routing CardBus interrupts to PCI
Nov 23 18:33:49 stiffy kernel: Yenta TI: socket 0000:02:01.0, mfunc 0x05033002, devctl 0x64
Nov 23 18:33:49 stiffy kernel: Real Time Clock Driver v1.12
Nov 23 18:33:49 stiffy kernel: Yenta: ISA IRQ mask 0x0498, PCI irq 11
Nov 23 18:33:49 stiffy kernel: Socket status: 30000010
Nov 23 18:33:49 stiffy kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
Nov 23 18:33:49 stiffy kernel: cs: IO port probe 0xe000-0xffff: clean.
Nov 23 18:33:49 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
Nov 23 18:33:49 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
Nov 23 18:33:49 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.1[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:49 stiffy kernel: Yenta: CardBus bridge found at 0000:02:01.1 [1028:00d4]
Nov 23 18:33:49 stiffy kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Nov 23 18:33:49 stiffy kernel: Yenta: Routing CardBus interrupts to PCI
Nov 23 18:33:49 stiffy kernel: Yenta TI: socket 0000:02:01.1, mfunc 0x05033002, devctl 0x64
Nov 23 18:33:49 stiffy kernel: Floppy drive(s): fd0 is 1.44M
Nov 23 18:33:49 stiffy kernel: FDC 0 is a post-1991 82077
Nov 23 18:33:49 stiffy kernel: Yenta: ISA IRQ mask 0x0498, PCI irq 11
Nov 23 18:33:49 stiffy kernel: Socket status: 30000006
Nov 23 18:33:49 stiffy kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xffff
Nov 23 18:33:49 stiffy kernel: cs: IO port probe 0xe000-0xffff: clean.
Nov 23 18:33:49 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0xf4000000 - 0xfbffffff
Nov 23 18:33:49 stiffy kernel: pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
Nov 23 18:33:49 stiffy kernel: pccard: PCMCIA card inserted into slot 0
Nov 23 18:33:49 stiffy kernel: input: ImPS/2 Generic Wheel Mouse as /class/input/input1
Nov 23 18:33:49 stiffy kernel: input: PC Speaker as /class/input/input2
Nov 23 18:33:49 stiffy kernel: parport: PnPBIOS parport detected.
Nov 23 18:33:49 stiffy kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Nov 23 18:33:49 stiffy kernel: ACPI: PCI Interrupt 0000:02:01.2[A] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:49 stiffy kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[f8fff000-f8fff7ff]  Max Packet=[2048]
Nov 23 18:33:49 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 23 18:33:49 stiffy kernel: intel8x0_measure_ac97_clock: measured 50398 usecs
Nov 23 18:33:49 stiffy kernel: intel8x0: clocking to 48000
Nov 23 18:33:49 stiffy kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
Nov 23 18:33:49 stiffy kernel: MC'97 1 converters and GPIO not ready (0xff00)
Nov 23 18:33:49 stiffy kernel: SCSI subsystem initialized
Nov 23 18:33:49 stiffy kernel: Initializing USB Mass Storage driver...
Nov 23 18:33:49 stiffy kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Nov 23 18:33:49 stiffy kernel: usbcore: registered new driver usb-storage
Nov 23 18:33:49 stiffy kernel: USB Mass Storage support registered.
Nov 23 18:33:49 stiffy kernel: eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Nov 23 18:33:49 stiffy kernel:   Vendor: IC25N040  Model: ATCS04-0          Rev: CA4O
Nov 23 18:33:49 stiffy kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Nov 23 18:33:49 stiffy kernel: SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
Nov 23 18:33:49 stiffy kernel: SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
Nov 23 18:33:49 stiffy kernel:  sda: sda1
Nov 23 18:33:49 stiffy kernel: sd 0:0:0:0: Attached scsi disk sda
Nov 23 18:33:49 stiffy kernel: Adding 1461872k swap on /dev/hda8.  Priority:-1 extents:1 across:1461872k
Nov 23 18:33:49 stiffy kernel: mice: PS/2 mouse device common for all mice
Nov 23 18:33:49 stiffy kernel: usbcore: registered new driver usbmouse
Nov 23 18:33:49 stiffy kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Nov 23 18:33:49 stiffy kernel: Dell laptop SMM driver v1.14 21/02/2005 Massimo Dal Zotto (dz@debian.org)
Nov 23 18:33:49 stiffy kernel: Bluetooth: Core ver 2.8
Nov 23 18:33:49 stiffy kernel: NET: Registered protocol family 31
Nov 23 18:33:49 stiffy kernel: Bluetooth: HCI device and connection manager initialized
Nov 23 18:33:49 stiffy kernel: Bluetooth: HCI socket layer initialized
Nov 23 18:33:49 stiffy kernel: Bluetooth: L2CAP ver 2.8
Nov 23 18:33:49 stiffy kernel: Bluetooth: L2CAP socket layer initialized
Nov 23 18:33:49 stiffy kernel: Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Nov 23 18:33:49 stiffy kernel: Bluetooth: RFCOMM socket layer initialized
Nov 23 18:33:49 stiffy kernel: Bluetooth: RFCOMM TTY layer initialized
Nov 23 18:33:49 stiffy kernel: Bluetooth: RFCOMM ver 1.6
Nov 23 18:33:49 stiffy kernel: Bluetooth: HCI UART driver ver 2.2
Nov 23 18:33:49 stiffy kernel: Bluetooth: HCI H4 protocol initialized
Nov 23 18:33:49 stiffy kernel: Bluetooth: HCI BCSP protocol initialized
Nov 23 18:33:49 stiffy kernel: NET: Registered protocol family 23
Nov 23 18:33:49 stiffy kernel: IrCOMM protocol (Dag Brattli)
Nov 23 18:33:49 stiffy kernel: EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda6: found reiserfs format "3.6" with standard journal
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda6: using ordered data mode
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda6: checking transaction log (hda6)
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda6: Using r5 hash to sort names
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda5: found reiserfs format "3.6" with standard journal
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda5: using ordered data mode
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda5: checking transaction log (hda5)
Nov 23 18:33:49 stiffy kernel: ReiserFS: hda5: Using r5 hash to sort names
Nov 23 18:33:50 stiffy kernel: ReiserFS: sda1: found reiserfs format "3.6" with standard journal
Nov 23 18:33:51 stiffy kernel: ReiserFS: sda1: using ordered data mode
Nov 23 18:33:53 stiffy kernel: ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Nov 23 18:33:53 stiffy kernel: ReiserFS: sda1: checking transaction log (sda1)
Nov 23 18:33:55 stiffy kernel: ReiserFS: sda1: Using r5 hash to sort names
Nov 23 18:33:55 stiffy kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Nov 23 18:33:56 stiffy kernel: cs: memory probe 0xf4000000-0xfbffffff: excluding 0xf4000000-0xf8ffffff
Nov 23 18:33:57 stiffy kernel: pcmcia: registering new device pcmcia0.0
Nov 23 18:33:57 stiffy kernel: pcmcia: Detected deprecated PCMCIA ioctl usage.
Nov 23 18:33:57 stiffy kernel: pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
Nov 23 18:33:58 stiffy kernel: pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x280-0x287 0x370-0x37f
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x280-0x287 0x370-0x37f
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0x800-0x8ff: clean.
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0x800-0x8ff: clean.
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0xc00-0xcff: clean.
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0xc00-0xcff: clean.
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0xa00-0xaff: clean.
Nov 23 18:33:59 stiffy kernel: cs: IO port probe 0xa00-0xaff: clean.
Nov 23 18:33:59 stiffy kernel: ttyS2: detected caps 00000700 should be 00000100
Nov 23 18:34:00 stiffy kernel: 0.0: ttyS2 at I/O 0xe100 (irq = 3) is a 16C950/954
Nov 23 18:34:01 stiffy kernel: 0.0: ttyS3 at I/O 0xe108 (irq = 3) is a 8250
Nov 23 18:34:01 stiffy kernel: ip_conntrack version 2.4 (4095 buckets, 32760 max) - 212 bytes per conntrack
Nov 23 18:34:01 stiffy kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 23 18:34:01 stiffy kernel:  [schedule+1453/1679] schedule+0x5ad/0x68f
Nov 23 18:34:01 stiffy kernel:  [__wake_up_common+60/94] __wake_up_common+0x3c/0x5e
Nov 23 18:34:01 stiffy kernel:  [wait_for_completion+134/242] wait_for_completion+0x86/0xf2
Nov 23 18:34:01 stiffy kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
Nov 23 18:34:01 stiffy kernel:  [call_usermodehelper_keys+175/186] call_usermodehelper_keys+0xaf/0xba
Nov 23 18:34:01 stiffy kernel:  [__call_usermodehelper+0/110] __call_usermodehelper+0x0/0x6e
Nov 23 18:34:01 stiffy kernel:  [request_module+175/240] request_module+0xaf/0xf0
Nov 23 18:34:01 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
Nov 23 18:34:01 stiffy kernel:  [get_page_from_freelist+136/162] get_page_from_freelist+0x88/0xa2
Nov 23 18:34:01 stiffy kernel:  [pg0+553595222/1069659136] translate_table+0x95f/0xbcb [ip_tables]
Nov 23 18:34:01 stiffy kernel:  [map_vm_area+109/149] map_vm_area+0x6d/0x95
Nov 23 18:34:01 stiffy kernel:  [__vmalloc_area_node+246/362] __vmalloc_area_node+0xf6/0x16a
Nov 23 18:34:01 stiffy kernel:  [__vmalloc_node+79/110] __vmalloc_node+0x4f/0x6e
Nov 23 18:34:01 stiffy kernel:  [__vmalloc+39/43] __vmalloc+0x27/0x2b
Nov 23 18:34:01 stiffy kernel:  [pg0+553597367/1069659136] do_replace+0x145/0x6d6 [ip_tables]
Nov 23 18:34:03 stiffy kernel:  [pg0+553596209/1069659136] copy_entries_to_user+0xaf/0x1e3 [ip_tables]
Nov 23 18:34:04 stiffy kernel:  [pg0+553599347/1069659136] do_ipt_set_ctl+0x1e/0x62 [ip_tables]
Nov 23 18:34:04 stiffy kernel:  [nf_sockopt+198/277] nf_sockopt+0xc6/0x115
Nov 23 18:34:04 stiffy kernel:  [nf_setsockopt+55/59] nf_setsockopt+0x37/0x3b
Nov 23 18:34:04 stiffy kernel:  [ip_setsockopt+219/3448] ip_setsockopt+0xdb/0xd78
Nov 23 18:34:04 stiffy kernel:  [nf_sockopt+136/277] nf_sockopt+0x88/0x115
Nov 23 18:34:04 stiffy kernel:  [nf_getsockopt+55/59] nf_getsockopt+0x37/0x3b
Nov 23 18:34:04 stiffy kernel:  [ip_getsockopt+254/1764] ip_getsockopt+0xfe/0x6e4
Nov 23 18:34:04 stiffy kernel:  [prio_tree_remove+150/191] prio_tree_remove+0x96/0xbf
Nov 23 18:34:04 stiffy kernel:  [free_pgtables+59/167] free_pgtables+0x3b/0xa7
Nov 23 18:34:04 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
Nov 23 18:34:04 stiffy kernel:  [get_page_from_freelist+136/162] get_page_from_freelist+0x88/0xa2
Nov 23 18:34:04 stiffy irattach: executing: 'echo stiffy > /proc/sys/net/irda/devname'
Nov 23 18:34:04 stiffy kernel:  [__alloc_pages+88/816] __alloc_pages+0x58/0x330
Nov 23 18:34:04 stiffy kernel:  [do_no_page+424/681] do_no_page+0x1a8/0x2a9
Nov 23 18:34:04 stiffy kernel:  [do_anonymous_page+340/388] do_anonymous_page+0x154/0x184
Nov 23 18:34:04 stiffy irattach: executing: 'echo 1 > /proc/sys/net/irda/discovery'
Nov 23 18:34:05 stiffy kernel:  [sys_setsockopt+96/158] sys_setsockopt+0x60/0x9e
Nov 23 18:34:05 stiffy irattach: Starting device irda0
Nov 23 18:34:05 stiffy kernel:  [sys_socketcall+571/675] sys_socketcall+0x23b/0x2a3
Nov 23 18:34:05 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 23 18:34:08 stiffy kernel:  [schedule+1453/1679] schedule+0x5ad/0x68f
Nov 23 18:34:08 stiffy kernel:  [__wake_up_common+60/94] __wake_up_common+0x3c/0x5e
Nov 23 18:34:08 stiffy kernel:  [wait_for_completion+134/242] wait_for_completion+0x86/0xf2
Nov 23 18:34:08 stiffy kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
Nov 23 18:34:08 stiffy kernel:  [call_usermodehelper_keys+175/186] call_usermodehelper_keys+0xaf/0xba
Nov 23 18:34:08 stiffy kernel:  [__call_usermodehelper+0/110] __call_usermodehelper+0x0/0x6e
Nov 23 18:34:08 stiffy kernel:  [request_module+175/240] request_module+0xaf/0xf0
Nov 23 18:34:08 stiffy kernel:  [get_page_from_freelist+136/162] get_page_from_freelist+0x88/0xa2
Nov 23 18:34:08 stiffy kernel:  [pg0+553595222/1069659136] translate_table+0x95f/0xbcb [ip_tables]
Nov 23 18:34:08 stiffy kernel:  [map_vm_area+109/149] map_vm_area+0x6d/0x95
Nov 23 18:34:08 stiffy kernel:  [__vmalloc_area_node+246/362] __vmalloc_area_node+0xf6/0x16a
Nov 23 18:34:08 stiffy kernel:  [__vmalloc_node+79/110] __vmalloc_node+0x4f/0x6e
Nov 23 18:34:08 stiffy kernel:  [__vmalloc+39/43] __vmalloc+0x27/0x2b
Nov 23 18:34:08 stiffy kernel:  [pg0+553597367/1069659136] do_replace+0x145/0x6d6 [ip_tables]
Nov 23 18:34:08 stiffy kernel:  [pg0+553596209/1069659136] copy_entries_to_user+0xaf/0x1e3 [ip_tables]
Nov 23 18:34:08 stiffy kernel:  [pg0+553599347/1069659136] do_ipt_set_ctl+0x1e/0x62 [ip_tables]
Nov 23 18:34:08 stiffy kernel:  [nf_sockopt+198/277] nf_sockopt+0xc6/0x115
Nov 23 18:34:08 stiffy kernel:  [nf_setsockopt+55/59] nf_setsockopt+0x37/0x3b
Nov 23 18:34:08 stiffy kernel:  [ip_setsockopt+219/3448] ip_setsockopt+0xdb/0xd78
Nov 23 18:34:08 stiffy kernel:  [nf_sockopt+136/277] nf_sockopt+0x88/0x115
Nov 23 18:34:09 stiffy kernel:  [nf_getsockopt+55/59] nf_getsockopt+0x37/0x3b
Nov 23 18:34:09 stiffy kernel:  [ip_getsockopt+254/1764] ip_getsockopt+0xfe/0x6e4
Nov 23 18:34:09 stiffy kernel:  [prio_tree_remove+150/191] prio_tree_remove+0x96/0xbf
Nov 23 18:34:09 stiffy kernel:  [free_pgtables+59/167] free_pgtables+0x3b/0xa7
Nov 23 18:34:09 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
Nov 23 18:34:10 stiffy kernel:  [find_get_page+39/95] find_get_page+0x27/0x5f
Nov 23 18:34:11 stiffy kernel:  [filemap_nopage+389/1013] filemap_nopage+0x185/0x3f5
Nov 23 18:34:12 stiffy kernel:  [page_add_file_rmap+66/78] page_add_file_rmap+0x42/0x4e
Nov 23 18:34:12 stiffy kernel:  [do_no_page+424/681] do_no_page+0x1a8/0x2a9
Nov 23 18:34:12 stiffy kernel:  [sys_setsockopt+96/158] sys_setsockopt+0x60/0x9e
Nov 23 18:34:12 stiffy kernel:  [sys_socketcall+571/675] sys_socketcall+0x23b/0x2a3
Nov 23 18:34:12 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 23 18:34:13 stiffy kernel:  [schedule+1453/1679] schedule+0x5ad/0x68f
Nov 23 18:34:13 stiffy kernel:  [__wake_up_common+60/94] __wake_up_common+0x3c/0x5e
Nov 23 18:34:13 stiffy kernel:  [wait_for_completion+134/242] wait_for_completion+0x86/0xf2
Nov 23 18:34:13 stiffy kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
Nov 23 18:34:13 stiffy irattach: Stopping device /dev/ttyS1
Nov 23 18:34:13 stiffy kernel:  [call_usermodehelper_keys+175/186] call_usermodehelper_keys+0xaf/0xba
Nov 23 18:34:13 stiffy irattach: ioctl(SIOCGIFFLAGS): No such device
Nov 23 18:34:13 stiffy kernel:  [__call_usermodehelper+0/110] __call_usermodehelper+0x0/0x6e
Nov 23 18:34:13 stiffy kernel:  [request_module+175/240] request_module+0xaf/0xf0
Nov 23 18:34:13 stiffy irattach: exiting ... 
Nov 23 18:34:13 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
Nov 23 18:34:13 stiffy kernel:  [get_page_from_freelist+136/162] get_page_from_freelist+0x88/0xa2
Nov 23 18:34:13 stiffy kernel:  [pg0+553594963/1069659136] translate_table+0x85c/0xbcb [ip_tables]
Nov 23 18:34:13 stiffy kernel:  [__vmalloc_node+79/110] __vmalloc_node+0x4f/0x6e
Nov 23 18:34:13 stiffy kernel:  [__vmalloc+39/43] __vmalloc+0x27/0x2b
Nov 23 18:34:13 stiffy kernel:  [pg0+553597367/1069659136] do_replace+0x145/0x6d6 [ip_tables]
Nov 23 18:34:13 stiffy kernel:  [pg0+553596209/1069659136] copy_entries_to_user+0xaf/0x1e3 [ip_tables]
Nov 23 18:34:13 stiffy kernel:  [pg0+553599347/1069659136] do_ipt_set_ctl+0x1e/0x62 [ip_tables]
Nov 23 18:34:13 stiffy kernel:  [nf_sockopt+198/277] nf_sockopt+0xc6/0x115
Nov 23 18:34:14 stiffy kernel:  [nf_setsockopt+55/59] nf_setsockopt+0x37/0x3b
Nov 23 18:34:14 stiffy kernel:  [ip_setsockopt+219/3448] ip_setsockopt+0xdb/0xd78
Nov 23 18:34:14 stiffy kernel:  [nf_sockopt+136/277] nf_sockopt+0x88/0x115
Nov 23 18:34:14 stiffy kernel:  [nf_getsockopt+55/59] nf_getsockopt+0x37/0x3b
Nov 23 18:34:14 stiffy kernel:  [ip_getsockopt+254/1764] ip_getsockopt+0xfe/0x6e4
Nov 23 18:34:14 stiffy kernel:  [prio_tree_remove+150/191] prio_tree_remove+0x96/0xbf
Nov 23 18:34:14 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
Nov 23 18:34:14 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
Nov 23 18:34:14 stiffy kernel:  [get_page_from_freelist+136/162] get_page_from_freelist+0x88/0xa2
Nov 23 18:34:14 stiffy kernel:  [__alloc_pages+88/816] __alloc_pages+0x58/0x330
Nov 23 18:34:14 stiffy kernel:  [do_no_page+424/681] do_no_page+0x1a8/0x2a9
Nov 23 18:34:14 stiffy kernel:  [do_anonymous_page+340/388] do_anonymous_page+0x154/0x184
Nov 23 18:34:14 stiffy kernel:  [sys_setsockopt+96/158] sys_setsockopt+0x60/0x9e
Nov 23 18:34:14 stiffy kernel:  [sys_socketcall+571/675] sys_socketcall+0x23b/0x2a3
Nov 23 18:34:14 stiffy kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 23 18:34:14 stiffy kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Nov 23 18:34:14 stiffy kernel: microcode: CPU0 updated from revision 0x9 to 0x20, date = 06052003 
Nov 23 18:34:14 stiffy kernel: IA-32 Microcode Update Driver v1.14 unregistered
Nov 23 18:34:14 stiffy kernel: NET: Registered protocol family 10
Nov 23 18:34:15 stiffy kernel: Disabled Privacy Extensions on device c0341f20(lo)
Nov 23 18:34:16 stiffy kernel: IPv6 over IPv4 tunneling driver
Nov 23 18:34:17 stiffy kernel: ACPI: Battery Slot [BAT0] (battery present)
Nov 23 18:34:17 stiffy kernel: ACPI: Battery Slot [BAT1] (battery present)
Nov 23 18:34:17 stiffy kernel: ACPI: AC Adapter [AC] (on-line)
Nov 23 18:34:17 stiffy kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Nov 23 18:34:17 stiffy kernel: ACPI: Processor [CPU0] (supports 8 throttling states)
Nov 23 18:34:17 stiffy kernel: ACPI: Lid Switch [LID]
Nov 23 18:34:17 stiffy kernel: ACPI: Power Button (CM) [PBTN]
Nov 23 18:34:17 stiffy kernel: ACPI: Sleep Button (CM) [SBTN]
Nov 23 18:34:17 stiffy kernel: ACPI: Thermal Zone [THM] (58 C)
Nov 23 18:34:21 stiffy kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
Nov 23 18:35:38 stiffy gconfd (marc-6570): (Version 2.12.1) wird gestartet, Prozesskennung 6570, Benutzer »marc«
Nov 23 18:35:38 stiffy gconfd (marc-6570): Die Adresse »xml:readonly:/etc/gconf/gconf.xml.mandatory« wurde an der Position 0 zu einer nur lesbaren Konfigurationsquelle aufgelöst
Nov 23 18:35:38 stiffy gconfd (marc-6570): Die Adresse »xml:readwrite:/home/marc/.gconf« wurde an der Position 1 zu einer schreibbaren Konfigurationsquelle aufgelöst
Nov 23 18:35:38 stiffy gconfd (marc-6570): Die Adresse »xml:readonly:/etc/gconf/gconf.xml.defaults« wurde an der Position 2 zu einer nur lesbaren Konfigurationsquelle aufgelöst
Nov 23 18:35:38 stiffy gconfd (marc-6570): Die Adresse »xml:readonly:/var/lib/gconf/debian.defaults« wurde an der Position 3 zu einer nur lesbaren Konfigurationsquelle aufgelöst
Nov 23 18:35:38 stiffy gconfd (marc-6570): Die Adresse »xml:readonly:/var/lib/gconf/defaults« wurde an der Position 4 zu einer nur lesbaren Konfigurationsquelle aufgelöst
Nov 23 18:36:10 stiffy kernel: psmouse.c: resync failed, issuing reconnect request
Nov 23 18:36:13 stiffy gconfd (marc-6570): Die Adresse »xml:readwrite:/home/marc/.gconf« wurde an der Position 0 zu einer schreibbaren Konfigurationsquelle aufgelöst
Nov 23 18:36:21 stiffy kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
Nov 23 18:36:39 stiffy gconfd (marc-6570): Beenden
Nov 23 18:36:41 stiffy shutdown[5698]: shutting down for system reboot
Nov 23 18:36:49 stiffy kernel: Kernel logging (proc) stopped.
Nov 23 18:36:49 stiffy kernel: Kernel log daemon terminating.
Nov 23 18:36:49 stiffy exiting on signal 15
