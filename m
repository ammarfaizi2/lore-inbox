Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUHYKJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUHYKJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 06:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUHYKJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 06:09:11 -0400
Received: from lug.demon.co.uk ([80.177.165.112]:579 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S266643AbUHYKEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 06:04:25 -0400
From: David Johnson <dj@david-web.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Oops in vt_ioctl with 2.6.7
Date: Wed, 25 Aug 2004 11:04:11 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bQGLBfPfRLvM4pk"
Message-Id: <200408251104.11356.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_bQGLBfPfRLvM4pk
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I've had an oops in vt_ioctl with 2.6.7. All I did was select shutdown from my 
gdm menu. There was nothing unusual in the logs prior to the oops, it just 
happened out of the blue. It has not happened since and I have been unable to 
reproduce it...

The machine is a Dell Inspiron laptop "with broken BIOS".

I've attached my messages which contains the oops, my .config and my dmesg.

Regards,
David.

-- 
David Johnson
http://www.david-web.co.uk/
http://www.penguincomputing.co.uk/

--Boundary-00=_bQGLBfPfRLvM4pk
Content-Type: text/plain;
  charset="iso-8859-15";
  name="messages.oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="messages.oops"

Aug 12 22:37:09 localhost syslogd 1.4.1#15: restart.
Aug 12 22:37:09 localhost kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Aug 12 22:37:09 localhost kernel: Inspecting /boot/System.map-2.6.7
Aug 12 22:37:09 localhost kernel: Loaded 21902 symbols from /boot/System.map-2.6.7.
Aug 12 22:37:09 localhost kernel: Symbols match kernel version 2.6.7.
Aug 12 22:37:09 localhost kernel: No module symbols loaded - kernel modules not enabled. 
Aug 12 22:37:09 localhost kernel: Linux version 2.6.7 (root@laptop) (gcc version 3.3.4 (Debian)) #2 SMP Sat Jul 3 21:40:45 BST 2004
Aug 12 22:37:09 localhost kernel: BIOS-provided physical RAM map:
Aug 12 22:37:09 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
Aug 12 22:37:09 localhost kernel:  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
Aug 12 22:37:09 localhost kernel:  BIOS-e820: 0000000000100000 - 000000003ffcf800 (usable)
Aug 12 22:37:09 localhost kernel:  BIOS-e820: 000000003ffcf800 - 0000000040000000 (reserved)
Aug 12 22:37:09 localhost kernel:  BIOS-e820: 00000000fec00000 - 00000000fec20000 (reserved)
Aug 12 22:37:09 localhost kernel:  BIOS-e820: 00000000feda0000 - 00000000fee10000 (reserved)
Aug 12 22:37:09 localhost kernel:  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Aug 12 22:37:09 localhost kernel: 127MB HIGHMEM available.
Aug 12 22:37:09 localhost kernel: 896MB LOWMEM available.
Aug 12 22:37:09 localhost kernel: On node 0 totalpages: 262095
Aug 12 22:37:09 localhost kernel:   DMA zone: 4096 pages, LIFO batch:1
Aug 12 22:37:09 localhost kernel:   Normal zone: 225280 pages, LIFO batch:16
Aug 12 22:37:09 localhost kernel:   HighMem zone: 32719 pages, LIFO batch:7
Aug 12 22:37:09 localhost kernel: DMI 2.3 present.
Aug 12 22:37:09 localhost kernel: Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
Aug 12 22:37:09 localhost kernel: ACPI: RSDP (v000 DELL                                      ) @ 0x000fdea0
Aug 12 22:37:09 localhost kernel: ACPI: RSDT (v001 DELL    CPi R   0x27d4051a ASL  0x00000061) @ 0x3fff0000
Aug 12 22:37:09 localhost kernel: ACPI: FADT (v001 DELL    CPi R   0x27d4051a ASL  0x00000061) @ 0x3fff0400
Aug 12 22:37:09 localhost kernel: ACPI: MADT (v001 DELL    CPi R   0x27d4051a ASL  0x00000047) @ 0x3fff0c00
Aug 12 22:37:09 localhost kernel: ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
Aug 12 22:37:09 localhost kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Aug 12 22:37:09 localhost kernel: Processor #0 15:2 APIC version 20
Aug 12 22:37:09 localhost kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Aug 12 22:37:09 localhost kernel: Processor #1 15:2 APIC version 20
Aug 12 22:37:09 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Aug 12 22:37:09 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Aug 12 22:37:09 localhost kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Aug 12 22:37:09 localhost kernel: IOAPIC[0]: Assigned apic_id 2
Aug 12 22:37:09 localhost kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Aug 12 22:37:09 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug 12 22:37:09 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Aug 12 22:37:09 localhost kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Aug 12 22:37:10 localhost kernel: Using ACPI (MADT) for SMP configuration information
Aug 12 22:37:10 localhost kernel: Built 1 zonelists
Aug 12 22:37:10 localhost kernel: Kernel command line: root=/dev/hdc2 ro
Aug 12 22:37:10 localhost kernel: Initializing CPU#0
Aug 12 22:37:10 localhost kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Aug 12 22:37:10 localhost kernel: Detected 3057.001 MHz processor.
Aug 12 22:37:10 localhost kernel: Using tsc for high-res timesource
Aug 12 22:37:10 localhost kernel: Console: colour VGA+ 80x25
Aug 12 22:37:10 localhost kernel: Memory: 1034612k/1048380k available (1441k kernel code, 12852k reserved, 661k data, 232k init, 130876k highmem)
Aug 12 22:37:10 localhost kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Aug 12 22:37:10 localhost kernel: Calibrating delay loop... 6045.69 BogoMIPS
Aug 12 22:37:10 localhost kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 12 22:37:10 localhost kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 12 22:37:10 localhost kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 12 22:37:10 localhost kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Aug 12 22:37:10 localhost kernel: CPU: L2 cache: 512K
Aug 12 22:37:10 localhost kernel: CPU: Physical Processor ID: 0
Aug 12 22:37:10 localhost kernel: Enabling fast FPU save and restore... done.
Aug 12 22:37:10 localhost kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 12 22:37:10 localhost kernel: Checking 'hlt' instruction... OK.
Aug 12 22:37:10 localhost kernel: CPU0: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
Aug 12 22:37:10 localhost kernel: per-CPU timeslice cutoff: 1462.68 usecs.
Aug 12 22:37:10 localhost kernel: task migration cache decay timeout: 2 msecs.
Aug 12 22:37:10 localhost kernel: enabled ExtINT on CPU#0
Aug 12 22:37:10 localhost kernel: ESR value before enabling vector: 00000000
Aug 12 22:37:10 localhost kernel: ESR value after enabling vector: 00000000
Aug 12 22:37:10 localhost kernel: Booting processor 1/1 eip 3000
Aug 12 22:37:10 localhost kernel: Initializing CPU#1
Aug 12 22:37:10 localhost kernel: masked ExtINT on CPU#1
Aug 12 22:37:10 localhost kernel: ESR value before enabling vector: 00000000
Aug 12 22:37:10 localhost kernel: ESR value after enabling vector: 00000000
Aug 12 22:37:10 localhost kernel: Calibrating delay loop... 6094.84 BogoMIPS
Aug 12 22:37:10 localhost kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Aug 12 22:37:10 localhost kernel: CPU: L2 cache: 512K
Aug 12 22:37:10 localhost kernel: CPU: Physical Processor ID: 0
Aug 12 22:37:10 localhost kernel: CPU1: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
Aug 12 22:37:10 localhost kernel: Total of 2 processors activated (12140.54 BogoMIPS).
Aug 12 22:37:10 localhost kernel: ENABLING IO-APIC IRQs
Aug 12 22:37:10 localhost kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug 12 22:37:10 localhost kernel: Using local APIC timer interrupts.
Aug 12 22:37:10 localhost kernel: calibrating APIC timer ...
Aug 12 22:37:10 localhost kernel: ..... CPU clock speed is 3056.0072 MHz.
Aug 12 22:37:10 localhost kernel: ..... host bus clock speed is 132.0872 MHz.
Aug 12 22:37:10 localhost kernel: checking TSC synchronization across 2 CPUs: 
Aug 12 22:37:10 localhost kernel: BIOS BUG: CPU#0 improperly initialized, has -4939 usecs TSC skew! FIXED.
Aug 12 22:37:10 localhost kernel: BIOS BUG: CPU#1 improperly initialized, has 4939 usecs TSC skew! FIXED.
Aug 12 22:37:10 localhost kernel: Brought up 2 CPUs
Aug 12 22:37:10 localhost kernel: checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Aug 12 22:37:10 localhost kernel: Freeing initrd memory: 1824k freed
Aug 12 22:37:10 localhost kernel: NET: Registered protocol family 16
Aug 12 22:37:10 localhost kernel: EISA bus registered
Aug 12 22:37:10 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xfcf1e, last bus=2
Aug 12 22:37:10 localhost kernel: PCI: Using configuration type 1
Aug 12 22:37:10 localhost kernel: mtrr: v2.0 (20020519)
Aug 12 22:37:10 localhost kernel: ACPI: Subsystem revision 20040326
Aug 12 22:37:10 localhost kernel: ACPI: Interpreter enabled
Aug 12 22:37:10 localhost kernel: ACPI: Using IOAPIC for interrupt routing
Aug 12 22:37:10 localhost kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 12 22:37:10 localhost kernel: PCI: Probing PCI hardware (bus 00)
Aug 12 22:37:10 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Aug 12 22:37:10 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Aug 12 22:37:10 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
Aug 12 22:37:10 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
Aug 12 22:37:10 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
Aug 12 22:37:10 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
Aug 12 22:37:10 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Aug 12 22:37:10 localhost kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Aug 12 22:37:10 localhost kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 12 22:37:10 localhost kernel: testing the IO APIC.......................
Aug 12 22:37:10 localhost kernel: .................................... done.
Aug 12 22:37:10 localhost kernel: PCI: Using ACPI for IRQ routing
Aug 12 22:37:10 localhost kernel: Starting balanced_irq
Aug 12 22:37:10 localhost kernel: highmem bounce pool size: 64 pages
Aug 12 22:37:10 localhost kernel: Initializing Cryptographic API
Aug 12 22:37:10 localhost kernel: ACPI: AC Adapter [AC] (on-line)
Aug 12 22:37:10 localhost kernel: ACPI: Battery Slot [BAT0] (battery present)
Aug 12 22:37:10 localhost kernel: ACPI: Lid Switch [LID]
Aug 12 22:37:10 localhost kernel: ACPI: Power Button (CM) [PBTN]
Aug 12 22:37:10 localhost kernel: ACPI: Sleep Button (CM) [SBTN]
Aug 12 22:37:10 localhost kernel: ACPI: Processor [CPU0] (supports C1, 8 throttling states)
Aug 12 22:37:10 localhost kernel: ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Aug 12 22:37:10 localhost kernel: ACPI: Thermal Zone [THM] (28 C)
Aug 12 22:37:10 localhost kernel: Real Time Clock Driver v1.12
Aug 12 22:37:10 localhost kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Aug 12 22:37:10 localhost kernel: mice: PS/2 mouse device common for all mice
Aug 12 22:37:10 localhost kernel: i8042.c: Warning: Keylock active.
Aug 12 22:37:10 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 12 22:37:10 localhost kernel: Synaptics Touchpad, model: 1
Aug 12 22:37:10 localhost kernel:  Firmware: 5.9
Aug 12 22:37:10 localhost kernel:  Sensor: 37
Aug 12 22:37:10 localhost kernel:  new absolute packet format
Aug 12 22:37:10 localhost kernel:  Touchpad has extended capability bits
Aug 12 22:37:10 localhost kernel:  -> multifinger detection
Aug 12 22:37:10 localhost kernel:  -> palm detection
Aug 12 22:37:10 localhost kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Aug 12 22:37:10 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 12 22:37:10 localhost kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 12 22:37:10 localhost kernel: EISA: Probing bus 0 at eisa0
Aug 12 22:37:10 localhost kernel: NET: Registered protocol family 2
Aug 12 22:37:10 localhost kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Aug 12 22:37:10 localhost kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug 12 22:37:10 localhost kernel: ACPI: (supports S0 S1 S3 S4 S4bios S5)
Aug 12 22:37:10 localhost kernel: RAMDISK: cramfs filesystem found at block 0
Aug 12 22:37:10 localhost kernel: RAMDISK: Loading 1824 blocks [1 disk] into ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^Hdone.
Aug 12 22:37:10 localhost kernel: VFS: Mounted root (cramfs filesystem) readonly.
Aug 12 22:37:10 localhost kernel: Freeing unused kernel memory: 232k freed
Aug 12 22:37:10 localhost kernel: NET: Registered protocol family 1
Aug 12 22:37:10 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 12 22:37:10 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 12 22:37:10 localhost kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Aug 12 22:37:10 localhost kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Aug 12 22:37:10 localhost kernel: ICH4: chipset revision 1
Aug 12 22:37:10 localhost kernel: ICH4: not 100%% native mode: will probe irqs later
Aug 12 22:37:10 localhost kernel:     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
Aug 12 22:37:10 localhost kernel:     ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
Aug 12 22:37:10 localhost kernel: hda: SONY CD-RW/DVD-ROM CRX830E, ATAPI CD/DVD-ROM drive
Aug 12 22:37:10 localhost kernel: Using anticipatory io scheduler
Aug 12 22:37:10 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 12 22:37:10 localhost kernel: hdc: IC25N060ATMR04-0, ATA DISK drive
Aug 12 22:37:10 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 12 22:37:10 localhost kernel: hdc: max request size: 1024KiB
Aug 12 22:37:10 localhost kernel: hdc: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
Aug 12 22:37:10 localhost kernel:  hdc: hdc1 hdc2 hdc3
Aug 12 22:37:10 localhost kernel: SGI XFS with no debug enabled
Aug 12 22:37:10 localhost kernel: SGI XFS Quota Management subsystem
Aug 12 22:37:10 localhost kernel: VFS: Can't find ext2 filesystem on dev hdc2.
Aug 12 22:37:10 localhost kernel: Unable to identify CD-ROM format.
Aug 12 22:37:10 localhost kernel: VFS: Can't find a valid FAT filesystem on dev hdc2.
Aug 12 22:37:10 localhost kernel: XFS mounting filesystem hdc2
Aug 12 22:37:10 localhost kernel: Adding 1967952k swap on /dev/hdc3.  Priority:-1 extents:1
Aug 12 22:37:10 localhost kernel: hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Aug 12 22:37:10 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Aug 12 22:37:10 localhost kernel: kjournald starting.  Commit interval 5 seconds
Aug 12 22:37:10 localhost kernel: EXT3 FS on hdc1, internal journal
Aug 12 22:37:10 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 12 22:37:10 localhost kernel: Linux Kernel Card Services
Aug 12 22:37:10 localhost kernel:   options:  [pci] [cardbus] [pm]
Aug 12 22:37:10 localhost kernel: PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Aug 12 22:37:10 localhost kernel: Yenta: CardBus bridge found at 0000:02:04.0 [1028:015f]
Aug 12 22:37:10 localhost kernel: Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Aug 12 22:37:10 localhost kernel: Socket status: 30000006
Aug 12 22:37:10 localhost kernel: b44.c:v0.94 (May 4, 2004)
Aug 12 22:37:10 localhost kernel: eth0: Broadcom 4400 10/100BaseT Ethernet 00:0f:1f:19:00:bb
Aug 12 22:37:10 localhost kernel: usbcore: registered new driver usbfs
Aug 12 22:37:10 localhost kernel: usbcore: registered new driver hub
Aug 12 22:37:10 localhost kernel: ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
Aug 12 22:37:10 localhost kernel: ehci_hcd 0000:00:1d.7: irq 23, pci mem f882bc00
Aug 12 22:37:10 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Aug 12 22:37:10 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Aug 12 22:37:10 localhost kernel: hub 1-0:1.0: USB hub found
Aug 12 22:37:10 localhost kernel: hub 1-0:1.0: 6 ports detected
Aug 12 22:37:10 localhost kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 12 22:37:10 localhost kernel: agpgart: Detected an Intel 855GM Chipset.
Aug 12 22:37:10 localhost kernel: agpgart: Maximum main memory to use for agp memory: 941M
Aug 12 22:37:10 localhost kernel: agpgart: AGP aperture is 128M @ 0xe0000000
Aug 12 22:37:10 localhost kernel: USB Universal Host Controller Interface driver v2.2
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.0: irq 16, io base 0000bf80
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Aug 12 22:37:10 localhost kernel: hub 2-0:1.0: USB hub found
Aug 12 22:37:10 localhost kernel: hub 2-0:1.0: 2 ports detected
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.1: irq 19, io base 0000bf40
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Aug 12 22:37:10 localhost kernel: hub 3-0:1.0: USB hub found
Aug 12 22:37:10 localhost kernel: hub 3-0:1.0: 2 ports detected
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0000bf20
Aug 12 22:37:10 localhost kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Aug 12 22:37:10 localhost kernel: hub 4-0:1.0: USB hub found
Aug 12 22:37:10 localhost kernel: hub 4-0:1.0: 2 ports detected
Aug 12 22:37:10 localhost kernel: usb 2-1: new low speed USB device using address 2
Aug 12 22:37:10 localhost kernel: usbcore: registered new driver hiddev
Aug 12 22:37:10 localhost kernel: input: USB HID v1.10 Keyboard [Composite USB PS2 Converter USB to PS2 Adaptor  v1.12] on usb-0000:00:1d.0-1
Aug 12 22:37:10 localhost kernel: input: USB HID v1.10 Mouse [Composite USB PS2 Converter USB to PS2 Adaptor  v1.12] on usb-0000:00:1d.0-1
Aug 12 22:37:10 localhost kernel: usbcore: registered new driver usbhid
Aug 12 22:37:10 localhost kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Aug 12 22:37:10 localhost kernel: intel8x0_measure_ac97_clock: measured 49441 usecs
Aug 12 22:37:10 localhost kernel: intel8x0: clocking to 48000
Aug 12 22:37:10 localhost kernel: slamr: module license 'Smart Link Ltd.' taints kernel.
Aug 12 22:37:10 localhost kernel: slamr: SmartLink AMRMO modem.
Aug 12 22:37:10 localhost kernel: slamr: probe 8086:24c6 ICH4 card...
Aug 12 22:37:10 localhost kernel: slamr: mc97 codec is BCM64
Aug 12 22:37:10 localhost kernel: slamr: slamr0 is ICH4 card.
Aug 12 22:37:10 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Aug 12 22:37:10 localhost kernel: b44: eth0: Link is down.
Aug 12 22:37:10 localhost kernel: NET: Registered protocol family 17
Aug 12 22:37:12 localhost kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
Aug 12 22:37:12 localhost kernel: cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x807
Aug 12 22:37:12 localhost kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug 12 22:37:12 localhost kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug 12 22:37:14 localhost kernel: NET: Registered protocol family 10
Aug 12 22:37:14 localhost kernel: Disabled Privacy Extensions on device c02dd7c0(lo)
Aug 12 22:37:14 localhost kernel: IPv6 over IPv4 tunneling driver
Aug 12 22:37:18 localhost kernel: bridge-eth0: already up
Aug 12 22:37:21 localhost kernel: NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27 07:55:38 PDT 2004
Aug 12 22:37:21 localhost kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug 12 22:37:21 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Aug 12 22:37:21 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Aug 12 22:37:23 localhost kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug 12 22:37:23 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Aug 12 22:37:23 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Aug 12 22:37:23 localhost kernel: drivers/usb/input/hid-input.c: event field not found
Aug 12 22:37:23 localhost kernel: drivers/usb/input/hid-input.c: event field not found
Aug 12 22:38:01 localhost gconfd (dj-2787): starting (version 2.6.2), pid 2787 user 'dj'
Aug 12 22:38:01 localhost gconfd (dj-2787): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at position 0
Aug 12 22:38:01 localhost gconfd (dj-2787): Resolved address "xml:readwrite:/home/dj/.gconf" to a writable config source at position 1
Aug 12 22:38:01 localhost gconfd (dj-2787): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at position 2
Aug 12 22:57:09 localhost -- MARK --
Aug 12 23:17:09 localhost -- MARK --
Aug 12 23:37:09 localhost -- MARK --
Aug 12 23:37:21 localhost gconfd (dj-2787): Received signal 15, shutting down cleanly
Aug 12 23:37:21 localhost kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug 12 23:37:21 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
Aug 12 23:37:21 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
Aug 12 23:37:21 localhost gconfd (dj-2787): Exiting
Aug 12 23:37:31 localhost shutdown[2395]: shutting down for system halt
Aug 12 23:37:33 localhost kernel: c01df932
Aug 12 23:37:33 localhost kernel: PREEMPT SMP 
Aug 12 23:37:33 localhost kernel: Modules linked in: nvidia vmnet vmmon md5 ipv6 ds af_packet snd_intel8x0m 8250_pci 8250 serial_core slamr snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore usbhid uhci_hcd intel_agp agpgart evdev ehci_hcd usbcore b44 mii yenta_socket pcmcia_core ide_cd cdrom xfs vfat fat isofs ext3 jbd ide_disk ide_generic piix generic ide_core unix
Aug 12 23:37:33 localhost kernel: CPU:    0
Aug 12 23:37:33 localhost kernel: EIP:    0060:[vt_ioctl+30/7199]    Tainted: P  
Aug 12 23:37:33 localhost kernel: EFLAGS: 00010296   (2.6.7) 
Aug 12 23:37:33 localhost kernel: EIP is at vt_ioctl+0x1e/0x1c1f
Aug 12 23:37:33 localhost kernel: eax: 00000000   ebx: 00005401   ecx: 00005401   edx: bffff660
Aug 12 23:37:33 localhost kernel: esi: c01df914   edi: f78fd000   ebp: f719bc80   esp: f0d3fe9c
Aug 12 23:37:33 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug 12 23:37:33 localhost kernel: Process rc (pid: 3723, threadinfo=f0d3e000 task=e681a640)
Aug 12 23:37:33 localhost kernel: Stack: c17fa340 4013d000 f0d3fec8 00000001 f7252400 f7253d00 f7253d00 c0148b86 
Aug 12 23:37:33 localhost kernel:        c16e2f00 00000000 f7990ec4 00000001 00000206 f7252400 f7253d00 4013dea0 
Aug 12 23:37:33 localhost kernel:        c014b190 f7253d00 f732e468 4013dea0 00000000 f71784f4 f7252400 88020006 
Aug 12 23:37:33 localhost kernel: Call Trace:
Aug 12 23:37:33 localhost kernel:  [pte_alloc_map+166/231] pte_alloc_map+0xa6/0xe7
Aug 12 23:37:33 localhost kernel:  [handle_mm_fault+254/431] handle_mm_fault+0xfe/0x1af
Aug 12 23:37:33 localhost kernel:  [do_page_fault+805/1293] do_page_fault+0x325/0x50d
Aug 12 23:37:33 localhost kernel:  [dentry_open+461/557] dentry_open+0x1cd/0x22d
Aug 12 23:37:33 localhost kernel:  [vt_ioctl+0/7199] vt_ioctl+0x0/0x1c1f
Aug 12 23:37:33 localhost kernel:  [tty_ioctl+1140/1383] tty_ioctl+0x474/0x567
Aug 12 23:37:33 localhost kernel:  [sys_ioctl+275/641] sys_ioctl+0x113/0x281
Aug 12 23:37:33 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 12 23:37:33 localhost kernel: 
Aug 12 23:37:33 localhost kernel: Code: 8b 30 8b 04 b5 e0 4a 37 c0 89 34 24 89 44 24 54 e8 d2 65 00 
Aug 12 23:37:33 localhost kernel:  <3>vt: argh, driver_data is NULL !
--Boundary-00=_bQGLBfPfRLvM4pk
Content-Type: text/plain;
  charset="iso-8859-15";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config"

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
CONFIG_STANDALONE=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
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
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
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
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_I82092=m
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_CARMEL is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=m
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
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
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

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
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
# CONFIG_I2O_CONFIG is not set
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
# CONFIG_IP_VS_PROTO_UDP is not set
# CONFIG_IP_VS_PROTO_ESP is not set
# CONFIG_IP_VS_PROTO_AH is not set

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
# CONFIG_IP_NF_MATCH_IPRANGE is not set
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
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
# CONFIG_IP_NF_TARGET_NETMAP is not set
# CONFIG_IP_NF_TARGET_SAME is not set
CONFIG_IP_NF_NAT_LOCAL=y
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
# CONFIG_IP_NF_TARGET_CLASSIFY is not set
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_COMPAT_IPFWADM=m
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
# CONFIG_IP6_NF_RAW is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
CONFIG_B44=m
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
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
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

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
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
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
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=m
CONFIG_AGP_INTEL_MCH=m
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set

#
# Other I2C Chip support
#
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

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
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_EHCI_SPLIT_ISO is not set
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
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
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=m
# CONFIG_QUOTA is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_4KSTACKS is not set
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
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=m
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_X86_STD_RESOURCES=y
CONFIG_PC=y

--Boundary-00=_bQGLBfPfRLvM4pk
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.7 (root@laptop) (gcc version 3.3.4 (Debian)) #2 SMP Sat Jul 3 21:40:45 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffcf800 (usable)
 BIOS-e820: 000000003ffcf800 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262095
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32719 pages, LIFO batch:7
DMI 2.3 present.
Dell Inspiron with broken BIOS detected. Refusing to enable the local APIC.
ACPI: RSDP (v000 DELL                                      ) @ 0x000fdea0
ACPI: RSDT (v001 DELL    CPi R   0x27d4051a ASL  0x00000061) @ 0x3fff0000
ACPI: FADT (v001 DELL    CPi R   0x27d4051a ASL  0x00000061) @ 0x3fff0400
ACPI: MADT (v001 DELL    CPi R   0x27d4051a ASL  0x00000047) @ 0x3fff0c00
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hdc2 ro
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 3056.961 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1034612k/1048380k available (1441k kernel code, 12852k reserved, 661k data, 232k init, 130876k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6045.69 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
per-CPU timeslice cutoff: 1463.16 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 6094.84 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
CPU1: Intel Mobile Intel(R) Pentium(R) 4     CPU 3.06GHz stepping 09
Total of 2 processors activated (12140.54 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3056.0040 MHz.
..... host bus clock speed is 132.0871 MHz.
checking TSC synchronization across 2 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has -4805 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 4805 usecs TSC skew! FIXED.
Brought up 2 CPUs
CPU0:  online
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:  online
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 1824k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfcf1e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 7) *11
ACPI: PCI Interrupt Link [LNKC] (IRQs 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIE._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
00:00:1f[A] -> 2-16 -> IRQ 16 level low
00:00:1f[B] -> 2-17 -> IRQ 17 level low
00:00:1f[C] -> 2-18 -> IRQ 18 level low
00:00:1f[D] -> 2-19 -> IRQ 19 level low
00:00:1d[D] -> 2-23 -> IRQ 23 level low
00:01:00[A] -> 2-20 -> IRQ 20 level low
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 003 03  1    1    0   1   0    1    1    D1
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 003 03  1    1    0   1   0    1    1    C9
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
Starting balanced_irq
highmem bounce pool size: 64 pages
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU0] (supports C1, 8 throttling states)
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Thermal Zone [THM] (53 C)
Real Time Clock Driver v1.12
hw_random: RNG not detected
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
mice: PS/2 mouse device common for all mice
i8042.c: Warning: Keylock active.
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 37
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ACPI: (supports S0 S1 S3 S4 S4bios S5)
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 1824 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 232k freed
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
hda: SONY CD-RW/DVD-ROM CRX830E, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC25N060ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 1024KiB
hdc: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
 hdc: hdc1 hdc2 hdc3
SGI XFS with no debug enabled
SGI XFS Quota Management subsystem
VFS: Can't find ext3 filesystem on dev hdc2.
VFS: Can't find ext2 filesystem on dev hdc2.
Unable to identify CD-ROM format.
FAT: bogus number of FAT structure
VFS: Can't find a valid FAT filesystem on dev hdc2.
XFS mounting filesystem hdc2
Ending clean XFS mount for filesystem: hdc2
Adding 1967952k swap on /dev/hdc3.  Priority:-1 extents:1
hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:02:04.0 [1028:015f]
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
b44.c:v0.94 (May 4, 2004)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:0f:1f:19:00:bb
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f882bc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855GM Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xe0000000
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0000bf80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0000bf40
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0000bf20
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.10 Keyboard [Composite USB PS2 Converter USB to PS2 Adaptor  v1.12] on usb-0000:00:1d.1-1
input: USB HID v1.10 Mouse [Composite USB PS2 Converter USB to PS2 Adaptor  v1.12] on usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49440 usecs
intel8x0: clocking to 48000
slamr: module license 'Smart Link Ltd.' taints kernel.
slamr: SmartLink AMRMO modem.
slamr: probe 8086:24c6 ICH4 card...
PCI: Setting latency timer of device 0000:00:1f.6 to 64
slamr: mc97 codec is BCM64
slamr: slamr0 is ICH4 card.
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
b44: eth0: Link is down.
NET: Registered protocol family 17
b44: eth0: Link is up at 100 Mbps, full duplex.
b44: eth0: Flow control is on for TX and on for RX.
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02dd7c0(lo)
IPv6 over IPv4 tunneling driver
cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x807
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
eth0: no IPv6 routers present
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 2612 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
/dev/vmnet: open called by PID 2620 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2790 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 2808 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
vmnet8: no IPv6 routers present

--Boundary-00=_bQGLBfPfRLvM4pk--
