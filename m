Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbULZELz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbULZELz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 23:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbULZELz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 23:11:55 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:1908 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261609AbULZEK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 23:10:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=AcLL1RpxNap8R6dPO+CLARfm8nswBzqA+ct9qzNZ24O+g3BIvLB/nVxOq96j62ojv/nLQe2PIoE0s04eTfNGxPY5viPoFOoyhuRHfwjUdVtw09MuRvSne4IXUp+Zo7Zm7ou8HPL0chnscoVo2fI9aMUt0H7N3dvSO7ghNXFKXGU=
Message-ID: <9dda349204122520106f3b2f46@mail.gmail.com>
Date: Sat, 25 Dec 2004 23:10:27 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Ho ho ho - Linux v2.6.10
Cc: LKML <linux-kernel@vger.kernel.org>, Diffie <diffie@blazebox.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_429_3490466.1104034227606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_429_3490466.1104034227606
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ho ho ho, my NFS is no go!

NFS needs some symbols here  and SCSI prints DV failed to configure device.

Merry Christmas

Linux version 2.6.10 (root@blaze) (gcc version 3.3.4) #1 Sat Dec 25
01:00:12 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f53c0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f6df0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7640
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=Slackware ro root=801
video=vesafb:ywrap,mtrr,vram:128 console=ttyS0,57600n8 console=tty0
rootflags=quota
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0435000 soft=c0434000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2204.891 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035260k/1048512k available (2252k kernel code, 12664k
reserved, 804k data, 196k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4358.14 BogoMIPS (lpj=2179072)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 3200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=0 pin2=-1
checking if image is initramfs...it isn't (bad gzip magic numbers);
looks like an initrd
Freeing initrd memory: 56k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfaf40, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 7680k,
total 16384k
vesafb: mode is 1280x1024x24, linelength=3840, pages=3
vesafb: protected mode interface info at c000:581c
vesafb: pmi: set display start = c00c58b0, set palette = c00c58fc
vesafb: pmi: ports = c010 c016 c054 c038 c03c c05c c000 c004 c0b0 c0b2 c0b4
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=2048
vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD300BB-00AUA1, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
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
hda: Host Protected Area detected.
        current capacity is 58631231 sectors (30019 MB)
        native  capacity is 58633344 sectors (30020 MB)
hda: Host Protected Area disabled.
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 18 (level, high) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
(scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
scsi0:A:6:0: DV failed to configure device.  Please file a bug report
against this driver.
  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 17 (level, high) -> IRQ 17
Found Controller: IT8212 UDMA/ATA133 RAID Controller
FindDevices: device 0 is IDE
Channel[0] BM-DMA at 0x9800-0x9807
Channel[1] BM-DMA at 0x9808-0x980F
scsi1 : ITE RAIDExpress133
  Vendor: ITE       Model: IT8212F           Rev: 1.45
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sdb: 468883200 512-byte hdwr sectors (240068 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
SCSI device sdb: 468883200 512-byte hdwr sectors (240068 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
RAMDISK: Couldn't find valid RAM disk image starting at 0.
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding 248968k swap on /dev/sda7.  Priority:-1 extents:1
XFS mounting filesystem sda2
Ending clean XFS mount for filesystem: sda2
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
XFS mounting filesystem sda6
Ending clean XFS mount for filesystem: sda6
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 16 (level, high) -> IRQ 16
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[22] 
MMIO=[e6084000-e60847ff]  Max Packet=[2048]
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49646 usecs
intel8x0: clocking to 47502
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.30.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 20 (level, high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:04.0 to 64
ohci1394: fw-host0: SelfID received outside of bus reset sequence
eth1: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:04.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 22 (level, high) -> IRQ 22
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 22, pci mem 0xe6083000
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 21 (level, high) -> IRQ 21
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 21, pci mem 0xe6087000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 20 (level, high) -> IRQ 20
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 20, pci mem 0xe6082000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
ohci_hcd 0000:00:02.1: wakeup
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 256M @ 0xb0000000
usb 2-1: new low speed USB device using ohci_hcd and address 2
usb 2-2: new full speed USB device using ohci_hcd and address 3
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 3 ports detected
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(TM)] on usb-0000:00:02.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 3-1: new full speed USB device using ohci_hcd and address 2
usb 2-2.1: new low speed USB device using ohci_hcd and address 4
input: USB HID v1.10 Keyboard [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-2.1
input: USB HID v1.10 Device [Microsoft Natural Keyboard Pro] on
usb-0000:00:02.0-2.1
USB Universal Host Controller Interface driver v2.2
lockd: Unknown symbol svc_wake_up
lockd: Unknown symbol xdr_decode_string_inplace
lockd: Unknown symbol svc_recv
lockd: Unknown symbol svc_exit_thread
lockd: Unknown symbol xdr_encode_netobj
lockd: Unknown symbol svc_process
lockd: Unknown symbol xprt_set_timeout
lockd: Unknown symbol nlm_debug
lockd: Unknown symbol svc_destroy
lockd: Unknown symbol svc_create
lockd: Unknown symbol rpc_call_sync
lockd: Unknown symbol rpc_delay
lockd: Unknown symbol svc_makesock
lockd: Unknown symbol svc_create_thread
lockd: Unknown symbol rpciod_up
lockd: Unknown symbol xprt_destroy
lockd: Unknown symbol rpciod_down
lockd: Unknown symbol xprt_create_proto
lockd: Unknown symbol rpc_restart_call
lockd: Unknown symbol xdr_encode_string
lockd: Unknown symbol xdr_decode_netobj
lockd: Unknown symbol rpc_call_async
lockd: Unknown symbol rpc_destroy_client
lockd: Unknown symbol rpc_create_client
nfs: Unknown symbol nlmclnt_proc
nfs: Unknown symbol rpc_proc_register
nfs: Unknown symbol rpc_wake_up_task
nfs: Unknown symbol xdr_write_pages
nfs: Unknown symbol rpc_shutdown_client
nfs: Unknown symbol svc_recv
nfs: Unknown symbol xdr_inline_decode
nfs: Unknown symbol rpc_mkpipe
nfs: Unknown symbol lockd_down
nfs: Unknown symbol rpc_wake_up
nfs: Unknown symbol lockd_up
nfs: Unknown symbol xdr_encode_opaque
nfs: Unknown symbol xdr_read_pages
nfs: Unknown symbol xdr_encode_opaque_fixed
nfs: Unknown symbol rpc_sleep_on
nfs: Unknown symbol rpc_init_task
nfs: Unknown symbol xdr_encode_pages
nfs: Unknown symbol rpc_setbufsize
nfs: Unknown symbol rpc_clnt_sigmask
nfs: Unknown symbol rpc_clone_client
nfs: Unknown symbol svc_process
nfs: Unknown symbol xdr_init_decode
nfs: Unknown symbol rpc_proc_unregister
nfs: Unknown symbol svc_destroy
nfs: Unknown symbol svc_create
nfs: Unknown symbol rpc_call_sync
nfs: Unknown symbol rpc_queue_upcall
nfs: Unknown symbol rpc_delay
nfs: Unknown symbol svc_makesock
nfs: Unknown symbol svc_create_thread
nfs: Unknown symbol rpc_execute
nfs: Unknown symbol rpc_killall_tasks
nfs: Unknown symbol rpciod_up
nfs: Unknown symbol xdr_reserve_space
nfs: Unknown symbol xprt_destroy
nfs: Unknown symbol rpc_clnt_sigunmask
nfs: Unknown symbol rpcauth_lookupcred
nfs: Unknown symbol rpciod_down
nfs: Unknown symbol xprt_create_proto
nfs: Unknown symbol rpc_restart_call
nfs: Unknown symbol xdr_inline_pages
nfs: Unknown symbol rpc_call_setup
nfs: Unknown symbol rpc_init_wait_queue
nfs: Unknown symbol put_rpccred
nfs: Unknown symbol rpc_unlink
nfs: Unknown symbol rpc_call_async
nfs: Unknown symbol rpcauth_create
nfs: Unknown symbol xdr_init_encode
nfs: Unknown symbol nfs_debug
nfs: Unknown symbol rpc_create_client
nfs: Unknown symbol xdr_shift_buf
lockd: Unknown symbol svc_wake_up
lockd: Unknown symbol xdr_decode_string_inplace
lockd: Unknown symbol svc_recv
lockd: Unknown symbol svc_exit_thread
lockd: Unknown symbol xdr_encode_netobj
lockd: Unknown symbol svc_process
lockd: Unknown symbol xprt_set_timeout
lockd: Unknown symbol nlm_debug
lockd: Unknown symbol svc_destroy
lockd: Unknown symbol svc_create
lockd: Unknown symbol rpc_call_sync
lockd: Unknown symbol rpc_delay
lockd: Unknown symbol svc_makesock
lockd: Unknown symbol svc_create_thread
lockd: Unknown symbol rpciod_up
lockd: Unknown symbol xprt_destroy
lockd: Unknown symbol rpciod_down
lockd: Unknown symbol xprt_create_proto
lockd: Unknown symbol rpc_restart_call
lockd: Unknown symbol xdr_encode_string
lockd: Unknown symbol xdr_decode_netobj
lockd: Unknown symbol rpc_call_async
lockd: Unknown symbol rpc_destroy_client
lockd: Unknown symbol rpc_create_client
nfs: Unknown symbol nlmclnt_proc
nfs: Unknown symbol rpc_proc_register
nfs: Unknown symbol rpc_wake_up_task
nfs: Unknown symbol xdr_write_pages
nfs: Unknown symbol rpc_shutdown_client
nfs: Unknown symbol svc_recv
nfs: Unknown symbol xdr_inline_decode
nfs: Unknown symbol rpc_mkpipe
nfs: Unknown symbol lockd_down
nfs: Unknown symbol rpc_wake_up
nfs: Unknown symbol lockd_up
nfs: Unknown symbol xdr_encode_opaque
nfs: Unknown symbol xdr_read_pages
nfs: Unknown symbol xdr_encode_opaque_fixed
nfs: Unknown symbol rpc_sleep_on
nfs: Unknown symbol rpc_init_task
nfs: Unknown symbol xdr_encode_pages
nfs: Unknown symbol rpc_setbufsize
nfs: Unknown symbol rpc_clnt_sigmask
nfs: Unknown symbol rpc_clone_client
nfs: Unknown symbol svc_process
nfs: Unknown symbol xdr_init_decode
nfs: Unknown symbol rpc_proc_unregister
nfs: Unknown symbol svc_destroy
nfs: Unknown symbol svc_create
nfs: Unknown symbol rpc_call_sync
nfs: Unknown symbol rpc_queue_upcall
nfs: Unknown symbol rpc_delay
nfs: Unknown symbol svc_makesock
nfs: Unknown symbol svc_create_thread
nfs: Unknown symbol rpc_execute
nfs: Unknown symbol rpc_killall_tasks
nfs: Unknown symbol rpciod_up
nfs: Unknown symbol xdr_reserve_space
nfs: Unknown symbol xprt_destroy
nfs: Unknown symbol rpc_clnt_sigunmask
nfs: Unknown symbol rpcauth_lookupcred
nfs: Unknown symbol rpciod_down
nfs: Unknown symbol xprt_create_proto
nfs: Unknown symbol rpc_restart_call
nfs: Unknown symbol xdr_inline_pages
nfs: Unknown symbol rpc_call_setup
nfs: Unknown symbol rpc_init_wait_queue
nfs: Unknown symbol put_rpccred
nfs: Unknown symbol rpc_unlink
nfs: Unknown symbol rpc_call_async
nfs: Unknown symbol rpcauth_create
nfs: Unknown symbol xdr_init_encode
nfs: Unknown symbol nfs_debug
nfs: Unknown symbol rpc_create_client
nfs: Unknown symbol xdr_shift_buf
-- 
FreeBSD the Power to Serve!

------=_Part_429_3490466.1104034227606
Content-Type: application/octet-stream; name=".config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=".config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4xMAojIFNhdCBEZWMgMjUgMDA6NDg6MTcgMjAwNAojCkNP
TkZJR19YODY9eQpDT05GSUdfTU1VPXkKQ09ORklHX1VJRDE2PXkKQ09ORklHX0dFTkVSSUNfSVNB
X0RNQT15CkNPTkZJR19HRU5FUklDX0lPTUFQPXkKCiMKIyBDb2RlIG1hdHVyaXR5IGxldmVsIG9w
dGlvbnMKIwpDT05GSUdfRVhQRVJJTUVOVEFMPXkKQ09ORklHX0NMRUFOX0NPTVBJTEU9eQpDT05G
SUdfQlJPS0VOX09OX1NNUD15CkNPTkZJR19MT0NLX0tFUk5FTD15CgojCiMgR2VuZXJhbCBzZXR1
cAojCkNPTkZJR19MT0NBTFZFUlNJT049IiIKQ09ORklHX1NXQVA9eQpDT05GSUdfU1lTVklQQz15
CiMgQ09ORklHX1BPU0lYX01RVUVVRSBpcyBub3Qgc2V0CkNPTkZJR19CU0RfUFJPQ0VTU19BQ0NU
PXkKIyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVF9WMyBpcyBub3Qgc2V0CkNPTkZJR19TWVNDVEw9
eQojIENPTkZJR19BVURJVCBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE2CkNPTkZJ
R19IT1RQTFVHPXkKIyBDT05GSUdfS09CSkVDVF9VRVZFTlQgaXMgbm90IHNldApDT05GSUdfSUtD
T05GSUc9eQpDT05GSUdfSUtDT05GSUdfUFJPQz15CiMgQ09ORklHX0VNQkVEREVEIGlzIG5vdCBz
ZXQKQ09ORklHX0tBTExTWU1TPXkKIyBDT05GSUdfS0FMTFNZTVNfQUxMIGlzIG5vdCBzZXQKIyBD
T05GSUdfS0FMTFNZTVNfRVhUUkFfUEFTUyBpcyBub3Qgc2V0CkNPTkZJR19GVVRFWD15CkNPTkZJ
R19FUE9MTD15CiMgQ09ORklHX0NDX09QVElNSVpFX0ZPUl9TSVpFIGlzIG5vdCBzZXQKQ09ORklH
X1NITUVNPXkKQ09ORklHX0NDX0FMSUdOX0ZVTkNUSU9OUz0wCkNPTkZJR19DQ19BTElHTl9MQUJF
TFM9MApDT05GSUdfQ0NfQUxJR05fTE9PUFM9MApDT05GSUdfQ0NfQUxJR05fSlVNUFM9MAojIENP
TkZJR19USU5ZX1NITUVNIGlzIG5vdCBzZXQKCiMKIyBMb2FkYWJsZSBtb2R1bGUgc3VwcG9ydAoj
CkNPTkZJR19NT0RVTEVTPXkKQ09ORklHX01PRFVMRV9VTkxPQUQ9eQpDT05GSUdfTU9EVUxFX0ZP
UkNFX1VOTE9BRD15CkNPTkZJR19PQlNPTEVURV9NT0RQQVJNPXkKIyBDT05GSUdfTU9EVkVSU0lP
TlMgaXMgbm90IHNldApDT05GSUdfTU9EVUxFX1NSQ1ZFUlNJT05fQUxMPXkKQ09ORklHX0tNT0Q9
eQoKIwojIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19YODZfUEM9eQojIENP
TkZJR19YODZfRUxBTiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9WT1lBR0VSIGlzIG5vdCBzZXQK
IyBDT05GSUdfWDg2X05VTUFRIGlzIG5vdCBzZXQKIyBDT05GSUdfWDg2X1NVTU1JVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1g4Nl9CSUdTTVAgaXMgbm90IHNldAojIENPTkZJR19YODZfVklTV1MgaXMg
bm90IHNldAojIENPTkZJR19YODZfR0VORVJJQ0FSQ0ggaXMgbm90IHNldAojIENPTkZJR19YODZf
RVM3MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfTTM4NiBpcyBub3Qgc2V0CiMgQ09ORklHX000ODYg
aXMgbm90IHNldAojIENPTkZJR19NNTg2IGlzIG5vdCBzZXQKIyBDT05GSUdfTTU4NlRTQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX001ODZNTVggaXMgbm90IHNldAojIENPTkZJR19NNjg2IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTVBFTlRJVU1JSSBpcyBub3Qgc2V0CiMgQ09ORklHX01QRU5USVVNSUlJIGlz
IG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU1NIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBFTlRJVU00
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUs2IGlzIG5vdCBzZXQKQ09ORklHX01LNz15CiMgQ09ORklH
X01LOCBpcyBub3Qgc2V0CiMgQ09ORklHX01DUlVTT0UgaXMgbm90IHNldAojIENPTkZJR19NRUZG
SUNFT04gaXMgbm90IHNldAojIENPTkZJR19NV0lOQ0hJUEM2IGlzIG5vdCBzZXQKIyBDT05GSUdf
TVdJTkNISVAyIGlzIG5vdCBzZXQKIyBDT05GSUdfTVdJTkNISVAzRCBpcyBub3Qgc2V0CiMgQ09O
RklHX01DWVJJWElJSSBpcyBub3Qgc2V0CiMgQ09ORklHX01WSUFDM18yIGlzIG5vdCBzZXQKIyBD
T05GSUdfWDg2X0dFTkVSSUMgaXMgbm90IHNldApDT05GSUdfWDg2X0NNUFhDSEc9eQpDT05GSUdf
WDg2X1hBREQ9eQpDT05GSUdfWDg2X0wxX0NBQ0hFX1NISUZUPTYKQ09ORklHX1JXU0VNX1hDSEdB
RERfQUxHT1JJVEhNPXkKQ09ORklHX1g4Nl9XUF9XT1JLU19PSz15CkNPTkZJR19YODZfSU5WTFBH
PXkKQ09ORklHX1g4Nl9CU1dBUD15CkNPTkZJR19YODZfUE9QQURfT0s9eQpDT05GSUdfWDg2X0dP
T0RfQVBJQz15CkNPTkZJR19YODZfSU5URUxfVVNFUkNPUFk9eQpDT05GSUdfWDg2X1VTRV9QUFJP
X0NIRUNLU1VNPXkKQ09ORklHX1g4Nl9VU0VfM0ROT1c9eQpDT05GSUdfSFBFVF9USU1FUj15CiMg
Q09ORklHX1NNUCBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUPXkKQ09ORklHX1g4Nl9VUF9BUElD
PXkKQ09ORklHX1g4Nl9VUF9JT0FQSUM9eQpDT05GSUdfWDg2X0xPQ0FMX0FQSUM9eQpDT05GSUdf
WDg2X0lPX0FQSUM9eQpDT05GSUdfWDg2X1RTQz15CkNPTkZJR19YODZfTUNFPXkKQ09ORklHX1g4
Nl9NQ0VfTk9ORkFUQUw9eQpDT05GSUdfWDg2X01DRV9QNFRIRVJNQUw9eQojIENPTkZJR19UT1NI
SUJBIGlzIG5vdCBzZXQKIyBDT05GSUdfSThLIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlDUk9DT0RF
IGlzIG5vdCBzZXQKQ09ORklHX1g4Nl9NU1I9bQpDT05GSUdfWDg2X0NQVUlEPW0KCiMKIyBGaXJt
d2FyZSBEcml2ZXJzCiMKQ09ORklHX0VERD15CiMgQ09ORklHX05PSElHSE1FTSBpcyBub3Qgc2V0
CkNPTkZJR19ISUdITUVNNEc9eQojIENPTkZJR19ISUdITUVNNjRHIGlzIG5vdCBzZXQKQ09ORklH
X0hJR0hNRU09eQpDT05GSUdfSElHSFBURT15CiMgQ09ORklHX01BVEhfRU1VTEFUSU9OIGlzIG5v
dCBzZXQKQ09ORklHX01UUlI9eQojIENPTkZJR19FRkkgaXMgbm90IHNldApDT05GSUdfSEFWRV9E
RUNfTE9DSz15CiMgQ09ORklHX1JFR1BBUk0gaXMgbm90IHNldAoKIwojIFBvd2VyIG1hbmFnZW1l
bnQgb3B0aW9ucyAoQUNQSSwgQVBNKQojCkNPTkZJR19QTT15CiMgQ09ORklHX1BNX0RFQlVHIGlz
IG5vdCBzZXQKQ09ORklHX1NPRlRXQVJFX1NVU1BFTkQ9eQpDT05GSUdfUE1fU1REX1BBUlRJVElP
Tj0iL2Rldi9zZGE3IgoKIwojIEFDUEkgKEFkdmFuY2VkIENvbmZpZ3VyYXRpb24gYW5kIFBvd2Vy
IEludGVyZmFjZSkgU3VwcG9ydAojCkNPTkZJR19BQ1BJPXkKQ09ORklHX0FDUElfQk9PVD15CkNP
TkZJR19BQ1BJX0lOVEVSUFJFVEVSPXkKQ09ORklHX0FDUElfU0xFRVA9eQpDT05GSUdfQUNQSV9T
TEVFUF9QUk9DX0ZTPXkKIyBDT05GSUdfQUNQSV9BQyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElf
QkFUVEVSWSBpcyBub3Qgc2V0CkNPTkZJR19BQ1BJX0JVVFRPTj15CiMgQ09ORklHX0FDUElfVklE
RU8gaXMgbm90IHNldApDT05GSUdfQUNQSV9GQU49eQpDT05GSUdfQUNQSV9QUk9DRVNTT1I9eQpD
T05GSUdfQUNQSV9USEVSTUFMPXkKIyBDT05GSUdfQUNQSV9BU1VTIGlzIG5vdCBzZXQKIyBDT05G
SUdfQUNQSV9JQk0gaXMgbm90IHNldAojIENPTkZJR19BQ1BJX1RPU0hJQkEgaXMgbm90IHNldApD
T05GSUdfQUNQSV9CTEFDS0xJU1RfWUVBUj0wCiMgQ09ORklHX0FDUElfREVCVUcgaXMgbm90IHNl
dApDT05GSUdfQUNQSV9CVVM9eQpDT05GSUdfQUNQSV9FQz15CkNPTkZJR19BQ1BJX1BPV0VSPXkK
Q09ORklHX0FDUElfUENJPXkKQ09ORklHX0FDUElfU1lTVEVNPXkKIyBDT05GSUdfWDg2X1BNX1RJ
TUVSIGlzIG5vdCBzZXQKCiMKIyBBUE0gKEFkdmFuY2VkIFBvd2VyIE1hbmFnZW1lbnQpIEJJT1Mg
U3VwcG9ydAojCiMgQ09ORklHX0FQTSBpcyBub3Qgc2V0CgojCiMgQ1BVIEZyZXF1ZW5jeSBzY2Fs
aW5nCiMKIyBDT05GSUdfQ1BVX0ZSRVEgaXMgbm90IHNldAoKIwojIEJ1cyBvcHRpb25zIChQQ0ks
IFBDTUNJQSwgRUlTQSwgTUNBLCBJU0EpCiMKQ09ORklHX1BDST15CiMgQ09ORklHX1BDSV9HT0JJ
T1MgaXMgbm90IHNldAojIENPTkZJR19QQ0lfR09NTUNPTkZJRyBpcyBub3Qgc2V0CiMgQ09ORklH
X1BDSV9HT0RJUkVDVCBpcyBub3Qgc2V0CkNPTkZJR19QQ0lfR09BTlk9eQpDT05GSUdfUENJX0JJ
T1M9eQpDT05GSUdfUENJX0RJUkVDVD15CkNPTkZJR19QQ0lfTU1DT05GSUc9eQojIENPTkZJR19Q
Q0lfTVNJIGlzIG5vdCBzZXQKQ09ORklHX1BDSV9MRUdBQ1lfUFJPQz15CkNPTkZJR19QQ0lfTkFN
RVM9eQojIENPTkZJR19JU0EgaXMgbm90IHNldAojIENPTkZJR19NQ0EgaXMgbm90IHNldAojIENP
TkZJR19TQ3gyMDAgaXMgbm90IHNldAoKIwojIFBDQ0FSRCAoUENNQ0lBL0NhcmRCdXMpIHN1cHBv
cnQKIwojIENPTkZJR19QQ0NBUkQgaXMgbm90IHNldAoKIwojIFBDLWNhcmQgYnJpZGdlcwojCgoj
CiMgUENJIEhvdHBsdWcgU3VwcG9ydAojCiMgQ09ORklHX0hPVFBMVUdfUENJIGlzIG5vdCBzZXQK
CiMKIyBFeGVjdXRhYmxlIGZpbGUgZm9ybWF0cwojCkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklH
X0JJTkZNVF9BT1VUPXkKQ09ORklHX0JJTkZNVF9NSVNDPXkKCiMKIyBEZXZpY2UgRHJpdmVycwoj
CgojCiMgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJR19TVEFOREFMT05FPXkKQ09ORklH
X1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQojIENPTkZJR19GV19MT0FERVIgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19EUklWRVIgaXMgbm90IHNldAoKIwojIE1lbW9yeSBUZWNobm9sb2d5IERl
dmljZXMgKE1URCkKIwojIENPTkZJR19NVEQgaXMgbm90IHNldAoKIwojIFBhcmFsbGVsIHBvcnQg
c3VwcG9ydAojCkNPTkZJR19QQVJQT1JUPW0KQ09ORklHX1BBUlBPUlRfUEM9bQpDT05GSUdfUEFS
UE9SVF9QQ19DTUwxPW0KIyBDT05GSUdfUEFSUE9SVF9TRVJJQUwgaXMgbm90IHNldApDT05GSUdf
UEFSUE9SVF9QQ19GSUZPPXkKQ09ORklHX1BBUlBPUlRfUENfU1VQRVJJTz15CiMgQ09ORklHX1BB
UlBPUlRfT1RIRVIgaXMgbm90IHNldApDT05GSUdfUEFSUE9SVF8xMjg0PXkKCiMKIyBQbHVnIGFu
ZCBQbGF5IHN1cHBvcnQKIwojIENPTkZJR19QTlAgaXMgbm90IHNldAoKIwojIEJsb2NrIGRldmlj
ZXMKIwpDT05GSUdfQkxLX0RFVl9GRD1tCiMgQ09ORklHX1BBUklERSBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19DUFFfREEgaXMgbm90IHNldAojIENPTkZJR19CTEtfQ1BRX0NJU1NfREEgaXMgbm90
IHNldAojIENPTkZJR19CTEtfREVWX0RBQzk2MCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
VU1FTSBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0xPT1A9bQpDT05GSUdfQkxLX0RFVl9DUllQ
VE9MT09QPW0KQ09ORklHX0JMS19ERVZfTkJEPW0KIyBDT05GSUdfQkxLX0RFVl9TWDggaXMgbm90
IHNldAojIENPTkZJR19CTEtfREVWX1VCIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfUkFNPXkK
Q09ORklHX0JMS19ERVZfUkFNX0NPVU5UPTE2CkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTgxOTIK
Q09ORklHX0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX0lOSVRSQU1GU19TT1VSQ0U9IiIKQ09ORklH
X0xCRD15CkNPTkZJR19DRFJPTV9QS1RDRFZEPW0KQ09ORklHX0NEUk9NX1BLVENEVkRfQlVGRkVS
Uz04CkNPTkZJR19DRFJPTV9QS1RDRFZEX1dDQUNIRT15CgojCiMgSU8gU2NoZWR1bGVycwojCkNP
TkZJR19JT1NDSEVEX05PT1A9eQpDT05GSUdfSU9TQ0hFRF9BUz15CkNPTkZJR19JT1NDSEVEX0RF
QURMSU5FPXkKQ09ORklHX0lPU0NIRURfQ0ZRPXkKCiMKIyBBVEEvQVRBUEkvTUZNL1JMTCBzdXBw
b3J0CiMKQ09ORklHX0lERT15CkNPTkZJR19CTEtfREVWX0lERT15CgojCiMgUGxlYXNlIHNlZSBE
b2N1bWVudGF0aW9uL2lkZS50eHQgZm9yIGhlbHAvaW5mbyBvbiBJREUgZHJpdmVzCiMKIyBDT05G
SUdfQkxLX0RFVl9JREVfU0FUQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSERfSURFIGlz
IG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURFRElTSz15CkNPTkZJR19JREVESVNLX01VTFRJX01P
REU9eQpDT05GSUdfQkxLX0RFVl9JREVDRD1tCiMgQ09ORklHX0JMS19ERVZfSURFVEFQRSBpcyBu
b3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERUZMT1BQWT1tCiMgQ09ORklHX0JMS19ERVZfSURFU0NT
SSBpcyBub3Qgc2V0CiMgQ09ORklHX0lERV9UQVNLX0lPQ1RMIGlzIG5vdCBzZXQKCiMKIyBJREUg
Y2hpcHNldCBzdXBwb3J0L2J1Z2ZpeGVzCiMKQ09ORklHX0lERV9HRU5FUklDPXkKIyBDT05GSUdf
QkxLX0RFVl9DTUQ2NDAgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVQQ0k9eQpDT05GSUdf
SURFUENJX1NIQVJFX0lSUT15CiMgQ09ORklHX0JMS19ERVZfT0ZGQk9BUkQgaXMgbm90IHNldApD
T05GSUdfQkxLX0RFVl9HRU5FUklDPXkKIyBDT05GSUdfQkxLX0RFVl9PUFRJNjIxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9SWjEwMDAgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVE
TUFfUENJPXkKIyBDT05GSUdfQkxLX0RFVl9JREVETUFfRk9SQ0VEIGlzIG5vdCBzZXQKQ09ORklH
X0lERURNQV9QQ0lfQVVUTz15CiMgQ09ORklHX0lERURNQV9PTkxZRElTSyBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfQUVDNjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQUxJMTVY
MyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0FNRDc0WFg9eQojIENPTkZJR19CTEtfREVWX0FU
SUlYUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ01ENjRYIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9UUklGTEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DWTgyQzY5MyBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQ1M1NTIwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9DUzU1MzAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0hQVDM0WCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfSFBUMzY2IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TQzEy
MDAgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1BJSVggaXMgbm90IHNldAojIENPTkZJR19C
TEtfREVWX05TODc0MTUgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1BEQzIwMlhYX09MRCBp
cyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfUERDMjAyWFhfTkVXIGlzIG5vdCBzZXQKIyBDT05G
SUdfQkxLX0RFVl9TVldLUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU0lJTUFHRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfU0lTNTUxMyBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfU0xDOTBFNjYgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1RSTTI5MCBpcyBub3Qgc2V0
CiMgQ09ORklHX0JMS19ERVZfVklBODJDWFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfSURFX0FSTSBp
cyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERURNQT15CiMgQ09ORklHX0lERURNQV9JVkIgaXMg
bm90IHNldApDT05GSUdfSURFRE1BX0FVVE89eQojIENPTkZJR19CTEtfREVWX0hEIGlzIG5vdCBz
ZXQKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX1NDU0k9eQpDT05GSUdfU0NTSV9Q
Uk9DX0ZTPXkKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNP
TkZJR19CTEtfREVWX1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9TVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NIUl9ERVZfT1NTVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1NSPW0KIyBDT05GSUdfQkxL
X0RFVl9TUl9WRU5ET1IgaXMgbm90IHNldApDT05GSUdfQ0hSX0RFVl9TRz1tCgojCiMgU29tZSBT
Q1NJIGRldmljZXMgKGUuZy4gQ0QganVrZWJveCkgc3VwcG9ydCBtdWx0aXBsZSBMVU5zCiMKIyBD
T05GSUdfU0NTSV9NVUxUSV9MVU4gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NPTlNUQU5UUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfTE9HR0lORyBpcyBub3Qgc2V0CgojCiMgU0NTSSBUcmFu
c3BvcnQgQXR0cmlidXRlcwojCiMgQ09ORklHX1NDU0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CgojCiMgU0NTSSBsb3ctbGV2ZWwgZHJpdmVy
cwojCiMgQ09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NT
SV8zV185WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQ0FSRCBpcyBub3Qgc2V0CkNPTkZJ
R19TQ1NJX0lURVJBSUQ9eQojIENPTkZJR19TQ1NJX0FBQ1JBSUQgaXMgbm90IHNldApDT05GSUdf
U0NTSV9BSUM3WFhYPXkKQ09ORklHX0FJQzdYWFhfQ01EU19QRVJfREVWSUNFPTMyCkNPTkZJR19B
SUM3WFhYX1JFU0VUX0RFTEFZX01TPTE1MDAwCiMgQ09ORklHX0FJQzdYWFhfREVCVUdfRU5BQkxF
IGlzIG5vdCBzZXQKQ09ORklHX0FJQzdYWFhfREVCVUdfTUFTSz0wCiMgQ09ORklHX0FJQzdYWFhf
UkVHX1BSRVRUWV9QUklOVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfQUlDN1hYWF9PTEQgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX0FJQzc5WFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RQ
VF9JMk8gaXMgbm90IHNldAojIENPTkZJR19NRUdBUkFJRF9ORVdHRU4gaXMgbm90IHNldAojIENP
TkZJR19NRUdBUkFJRF9MRUdBQ1kgaXMgbm90IHNldApDT05GSUdfU0NTSV9TQVRBPXkKIyBDT05G
SUdfU0NTSV9TQVRBX0FIQ0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfU1ZXIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0NTSV9BVEFfUElJWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FU
QV9OViBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9QUk9NSVNFIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0NTSV9TQVRBX1NYNCBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1NBVEFfU0lMPW0KIyBD
T05GSUdfU0NTSV9TQVRBX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9VTEkgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfVklBIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9T
QVRBX1ZJVEVTU0UgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0JVU0xPR0lDIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9ETVgzMTkxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRUFUQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfRUFUQV9QSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0ZV
VFVSRV9ET01BSU4gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0dEVEggaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX0lQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSU5JVElPIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9JTklBMTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QUEEgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX0lNTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU1lNNTNDOFhY
XzIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lQUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
UUxPR0lDX0lTUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUUxPR0lDX0ZDIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0NTSV9RTE9HSUNfMTI4MCBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX1FMQTJYWFg9
eQojIENPTkZJR19TQ1NJX1FMQTIxWFggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMQTIyWFgg
aXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMQTIzMDAgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1FMQTIzMjIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1FMQTYzMTIgaXMgbm90IHNldAojIENP
TkZJR19TQ1NJX1FMQTYzMjIgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzk1eCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NDU0lfREMzOTBUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9OU1AzMiBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfREVCVUcgaXMgbm90IHNldAoKIwojIE11bHRpLWRldmlj
ZSBzdXBwb3J0IChSQUlEIGFuZCBMVk0pCiMKQ09ORklHX01EPXkKIyBDT05GSUdfQkxLX0RFVl9N
RCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0RNPXkKQ09ORklHX0RNX0NSWVBUPXkKIyBDT05G
SUdfRE1fU05BUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19ETV9NSVJST1IgaXMgbm90IHNldAoj
IENPTkZJR19ETV9aRVJPIGlzIG5vdCBzZXQKCiMKIyBGdXNpb24gTVBUIGRldmljZSBzdXBwb3J0
CiMKIyBDT05GSUdfRlVTSU9OIGlzIG5vdCBzZXQKCiMKIyBJRUVFIDEzOTQgKEZpcmVXaXJlKSBz
dXBwb3J0CiMKQ09ORklHX0lFRUUxMzk0PW0KCiMKIyBTdWJzeXN0ZW0gT3B0aW9ucwojCiMgQ09O
RklHX0lFRUUxMzk0X1ZFUkJPU0VERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0lFRUUxMzk0X09V
SV9EQiBpcyBub3Qgc2V0CkNPTkZJR19JRUVFMTM5NF9FWFRSQV9DT05GSUdfUk9NUz15CkNPTkZJ
R19JRUVFMTM5NF9DT05GSUdfUk9NX0lQMTM5ND15CgojCiMgRGV2aWNlIERyaXZlcnMKIwojIENP
TkZJR19JRUVFMTM5NF9QQ0lMWU5YIGlzIG5vdCBzZXQKQ09ORklHX0lFRUUxMzk0X09IQ0kxMzk0
PW0KCiMKIyBQcm90b2NvbCBEcml2ZXJzCiMKQ09ORklHX0lFRUUxMzk0X1ZJREVPMTM5ND1tCkNP
TkZJR19JRUVFMTM5NF9TQlAyPW0KIyBDT05GSUdfSUVFRTEzOTRfU0JQMl9QSFlTX0RNQSBpcyBu
b3Qgc2V0CkNPTkZJR19JRUVFMTM5NF9FVEgxMzk0PW0KQ09ORklHX0lFRUUxMzk0X0RWMTM5ND1t
CkNPTkZJR19JRUVFMTM5NF9SQVdJTz1tCkNPTkZJR19JRUVFMTM5NF9DTVA9bQpDT05GSUdfSUVF
RTEzOTRfQU1EVFA9bQoKIwojIEkyTyBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19JMk89bQojIENP
TkZJR19JMk9fQ09ORklHIGlzIG5vdCBzZXQKQ09ORklHX0kyT19CTE9DSz1tCkNPTkZJR19JMk9f
U0NTST1tCkNPTkZJR19JMk9fUFJPQz1tCgojCiMgTmV0d29ya2luZyBzdXBwb3J0CiMKQ09ORklH
X05FVD15CgojCiMgTmV0d29ya2luZyBvcHRpb25zCiMKQ09ORklHX1BBQ0tFVD15CiMgQ09ORklH
X1BBQ0tFVF9NTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUTElOS19ERVYgaXMgbm90IHNldApD
T05GSUdfVU5JWD15CiMgQ09ORklHX05FVF9LRVkgaXMgbm90IHNldApDT05GSUdfSU5FVD15CkNP
TkZJR19JUF9NVUxUSUNBU1Q9eQojIENPTkZJR19JUF9BRFZBTkNFRF9ST1VURVIgaXMgbm90IHNl
dAojIENPTkZJR19JUF9QTlAgaXMgbm90IHNldAojIENPTkZJR19ORVRfSVBJUCBpcyBub3Qgc2V0
CiMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX01ST1VURSBpcyBub3Qg
c2V0CiMgQ09ORklHX0FSUEQgaXMgbm90IHNldApDT05GSUdfU1lOX0NPT0tJRVM9eQojIENPTkZJ
R19JTkVUX0FIIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9FU1AgaXMgbm90IHNldAojIENPTkZJ
R19JTkVUX0lQQ09NUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfVFVOTkVMIGlzIG5vdCBzZXQK
Q09ORklHX0lQX1RDUERJQUc9eQojIENPTkZJR19JUF9UQ1BESUFHX0lQVjYgaXMgbm90IHNldApD
T05GSUdfSVBWNj1tCiMgQ09ORklHX0lQVjZfUFJJVkFDWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
RVQ2X0FIIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfRVNQIGlzIG5vdCBzZXQKIyBDT05GSUdf
SU5FVDZfSVBDT01QIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVDZfVFVOTkVMIGlzIG5vdCBzZXQK
IyBDT05GSUdfSVBWNl9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19ORVRGSUxURVIgaXMgbm90
IHNldAoKIwojIFNDVFAgQ29uZmlndXJhdGlvbiAoRVhQRVJJTUVOVEFMKQojCkNPTkZJR19JUF9T
Q1RQPW0KIyBDT05GSUdfU0NUUF9EQkdfTVNHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NUUF9EQkdf
T0JKQ05UIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NUUF9ITUFDX05PTkUgaXMgbm90IHNldAojIENP
TkZJR19TQ1RQX0hNQUNfU0hBMSBpcyBub3Qgc2V0CkNPTkZJR19TQ1RQX0hNQUNfTUQ1PXkKIyBD
T05GSUdfQVRNIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJREdFIGlzIG5vdCBzZXQKIyBDT05GSUdf
VkxBTl84MDIxUSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQ05FVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0xMQzIgaXMgbm90IHNldAojIENPTkZJR19JUFggaXMgbm90IHNldAojIENPTkZJR19BVEFMSyBp
cyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09ORklHX0xBUEIgaXMgbm90IHNl
dAojIENPTkZJR19ORVRfRElWRVJUIGlzIG5vdCBzZXQKIyBDT05GSUdfRUNPTkVUIGlzIG5vdCBz
ZXQKIyBDT05GSUdfV0FOX1JPVVRFUiBpcyBub3Qgc2V0CgojCiMgUW9TIGFuZC9vciBmYWlyIHF1
ZXVlaW5nCiMKIyBDT05GSUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0NMU19S
T1VURSBpcyBub3Qgc2V0CgojCiMgTmV0d29yayB0ZXN0aW5nCiMKIyBDT05GSUdfTkVUX1BLVEdF
TiBpcyBub3Qgc2V0CkNPTkZJR19ORVRQT0xMPXkKIyBDT05GSUdfTkVUUE9MTF9SWCBpcyBub3Qg
c2V0CiMgQ09ORklHX05FVFBPTExfVFJBUCBpcyBub3Qgc2V0CkNPTkZJR19ORVRfUE9MTF9DT05U
Uk9MTEVSPXkKIyBDT05GSUdfSEFNUkFESU8gaXMgbm90IHNldAojIENPTkZJR19JUkRBIGlzIG5v
dCBzZXQKIyBDT05GSUdfQlQgaXMgbm90IHNldApDT05GSUdfTkVUREVWSUNFUz15CkNPTkZJR19E
VU1NWT1tCiMgQ09ORklHX0JPTkRJTkcgaXMgbm90IHNldAojIENPTkZJR19FUVVBTElaRVIgaXMg
bm90IHNldAojIENPTkZJR19UVU4gaXMgbm90IHNldAoKIwojIEFSQ25ldCBkZXZpY2VzCiMKIyBD
T05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAgb3IgMTAwTWJpdCkKIwpD
T05GSUdfTkVUX0VUSEVSTkVUPXkKQ09ORklHX01JST15CiMgQ09ORklHX0hBUFBZTUVBTCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NVTkdFTSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9WRU5ET1JfM0NP
TSBpcyBub3Qgc2V0CgojCiMgVHVsaXAgZmFtaWx5IG5ldHdvcmsgZGV2aWNlIHN1cHBvcnQKIwoj
IENPTkZJR19ORVRfVFVMSVAgaXMgbm90IHNldAojIENPTkZJR19IUDEwMCBpcyBub3Qgc2V0CkNP
TkZJR19ORVRfUENJPXkKIyBDT05GSUdfUENORVQzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0FNRDgx
MTFfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfQURBUFRFQ19TVEFSRklSRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0I0NCBpcyBub3Qgc2V0CkNPTkZJR19GT1JDRURFVEg9bQojIENPTkZJR19ER1JTIGlz
IG5vdCBzZXQKIyBDT05GSUdfRUVQUk8xMDAgaXMgbm90IHNldAojIENPTkZJR19FMTAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkVBTE5YIGlzIG5vdCBzZXQKIyBDT05GSUdfTkFUU0VNSSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FMktfUENJIGlzIG5vdCBzZXQKIyBDT05GSUdfODEzOUNQIGlzIG5vdCBz
ZXQKIyBDT05GSUdfODEzOVRPTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NJUzkwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0VQSUMxMDAgaXMgbm90IHNldAojIENPTkZJR19TVU5EQU5DRSBpcyBub3Qgc2V0
CiMgQ09ORklHX1RMQU4gaXMgbm90IHNldAojIENPTkZJR19WSUFfUkhJTkUgaXMgbm90IHNldAoK
IwojIEV0aGVybmV0ICgxMDAwIE1iaXQpCiMKIyBDT05GSUdfQUNFTklDIGlzIG5vdCBzZXQKIyBD
T05GSUdfREwySyBpcyBub3Qgc2V0CkNPTkZJR19FMTAwMD1tCkNPTkZJR19FMTAwMF9OQVBJPXkK
IyBDT05GSUdfTlM4MzgyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTUFDSEkgaXMgbm90IHNldAoj
IENPTkZJR19ZRUxMT1dGSU4gaXMgbm90IHNldAojIENPTkZJR19SODE2OSBpcyBub3Qgc2V0CiMg
Q09ORklHX1NLOThMSU4gaXMgbm90IHNldAojIENPTkZJR19WSUFfVkVMT0NJVFkgaXMgbm90IHNl
dAojIENPTkZJR19USUdPTjMgaXMgbm90IHNldAoKIwojIEV0aGVybmV0ICgxMDAwMCBNYml0KQoj
CiMgQ09ORklHX0lYR0IgaXMgbm90IHNldAojIENPTkZJR19TMklPIGlzIG5vdCBzZXQKCiMKIyBU
b2tlbiBSaW5nIGRldmljZXMKIwojIENPTkZJR19UUiBpcyBub3Qgc2V0CgojCiMgV2lyZWxlc3Mg
TEFOIChub24taGFtcmFkaW8pCiMKIyBDT05GSUdfTkVUX1JBRElPIGlzIG5vdCBzZXQKCiMKIyBX
YW4gaW50ZXJmYWNlcwojCiMgQ09ORklHX1dBTiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZEREkgaXMg
bm90IHNldAojIENPTkZJR19ISVBQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1BMSVAgaXMgbm90IHNl
dAojIENPTkZJR19QUFAgaXMgbm90IHNldAojIENPTkZJR19TTElQIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX0ZDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0hBUEVSIGlzIG5vdCBzZXQKQ09ORklHX05F
VENPTlNPTEU9bQoKIwojIElTRE4gc3Vic3lzdGVtCiMKIyBDT05GSUdfSVNETiBpcyBub3Qgc2V0
CgojCiMgVGVsZXBob255IFN1cHBvcnQKIwojIENPTkZJR19QSE9ORSBpcyBub3Qgc2V0CgojCiMg
SW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfSU5QVVQ9eQoKIwojIFVzZXJsYW5kIGludGVy
ZmFjZXMKIwpDT05GSUdfSU5QVVRfTU9VU0VERVY9eQpDT05GSUdfSU5QVVRfTU9VU0VERVZfUFNB
VVg9eQpDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NSRUVOX1g9MTAyNApDT05GSUdfSU5QVVRfTU9V
U0VERVZfU0NSRUVOX1k9NzY4CkNPTkZJR19JTlBVVF9KT1lERVY9bQojIENPTkZJR19JTlBVVF9U
U0RFViBpcyBub3Qgc2V0CkNPTkZJR19JTlBVVF9FVkRFVj1tCiMgQ09ORklHX0lOUFVUX0VWQlVH
IGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBJL08gZHJpdmVycwojCkNPTkZJR19HQU1FUE9SVD1tCkNP
TkZJR19TT1VORF9HQU1FUE9SVD1tCkNPTkZJR19HQU1FUE9SVF9OUzU1OD1tCiMgQ09ORklHX0dB
TUVQT1JUX0w0IGlzIG5vdCBzZXQKQ09ORklHX0dBTUVQT1JUX0VNVTEwSzE9bQojIENPTkZJR19H
QU1FUE9SVF9WT1JURVggaXMgbm90IHNldAojIENPTkZJR19HQU1FUE9SVF9GTTgwMSBpcyBub3Qg
c2V0CiMgQ09ORklHX0dBTUVQT1JUX0NTNDYxeCBpcyBub3Qgc2V0CkNPTkZJR19TRVJJTz15CkNP
TkZJR19TRVJJT19JODA0Mj15CiMgQ09ORklHX1NFUklPX1NFUlBPUlQgaXMgbm90IHNldAojIENP
TkZJR19TRVJJT19DVDgyQzcxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1BBUktCRCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFUklPX1BDSVBTMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX1JB
VyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERyaXZlcnMKIwpDT05GSUdfSU5QVVRfS0VZ
Qk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQojIENPTkZJR19LRVlCT0FSRF9TVU5LQkQg
aXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MS0tCRCBpcyBub3Qgc2V0CiMgQ09ORklHX0tF
WUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfS0VZQk9BUkRfTkVXVE9OIGlzIG5vdCBz
ZXQKQ09ORklHX0lOUFVUX01PVVNFPXkKQ09ORklHX01PVVNFX1BTMj15CiMgQ09ORklHX01PVVNF
X1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNFX1ZTWFhYQUEgaXMgbm90IHNldApDT05G
SUdfSU5QVVRfSk9ZU1RJQ0s9eQpDT05GSUdfSk9ZU1RJQ0tfQU5BTE9HPW0KIyBDT05GSUdfSk9Z
U1RJQ0tfQTNEIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfQURJIGlzIG5vdCBzZXQKIyBD
T05GSUdfSk9ZU1RJQ0tfQ09CUkEgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HRjJLIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfR1JJUCBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNU
SUNLX0dSSVBfTVAgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19HVUlMTEVNT1QgaXMgbm90
IHNldAojIENPTkZJR19KT1lTVElDS19JTlRFUkFDVCBpcyBub3Qgc2V0CkNPTkZJR19KT1lTVElD
S19TSURFV0lOREVSPW0KIyBDT05GSUdfSk9ZU1RJQ0tfVE1EQyBpcyBub3Qgc2V0CkNPTkZJR19K
T1lTVElDS19JRk9SQ0U9bQpDT05GSUdfSk9ZU1RJQ0tfSUZPUkNFX1VTQj15CiMgQ09ORklHX0pP
WVNUSUNLX0lGT1JDRV8yMzIgaXMgbm90IHNldAojIENPTkZJR19KT1lTVElDS19XQVJSSU9SIGlz
IG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfTUFHRUxMQU4gaXMgbm90IHNldAojIENPTkZJR19K
T1lTVElDS19TUEFDRU9SQiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NQQUNFQkFMTCBp
cyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX1NUSU5HRVIgaXMgbm90IHNldAojIENPTkZJR19K
T1lTVElDS19UV0lERExFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0pPWVNUSUNLX0RCOSBpcyBub3Qg
c2V0CiMgQ09ORklHX0pPWVNUSUNLX0dBTUVDT04gaXMgbm90IHNldAojIENPTkZJR19KT1lTVElD
S19UVVJCT0dSQUZYIGlzIG5vdCBzZXQKIyBDT05GSUdfSk9ZU1RJQ0tfSk9ZRFVNUCBpcyBub3Qg
c2V0CiMgQ09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRf
TUlTQyBpcyBub3Qgc2V0CgojCiMgQ2hhcmFjdGVyIGRldmljZXMKIwpDT05GSUdfVlQ9eQpDT05G
SUdfVlRfQ09OU09MRT15CkNPTkZJR19IV19DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMX05PTlNU
QU5EQVJEIGlzIG5vdCBzZXQKCiMKIyBTZXJpYWwgZHJpdmVycwojCkNPTkZJR19TRVJJQUxfODI1
MD15CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfQUNQ
SSBpcyBub3Qgc2V0CkNPTkZJR19TRVJJQUxfODI1MF9OUl9VQVJUUz00CkNPTkZJR19TRVJJQUxf
ODI1MF9FWFRFTkRFRD15CiMgQ09ORklHX1NFUklBTF84MjUwX01BTllfUE9SVFMgaXMgbm90IHNl
dApDT05GSUdfU0VSSUFMXzgyNTBfU0hBUkVfSVJRPXkKIyBDT05GSUdfU0VSSUFMXzgyNTBfREVU
RUNUX0lSUSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX01VTFRJUE9SVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFUklBTF84MjUwX1JTQSBpcyBub3Qgc2V0CgojCiMgTm9uLTgyNTAgc2Vy
aWFsIHBvcnQgc3VwcG9ydAojCkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJR19TRVJJQUxfQ09S
RV9DT05TT0xFPXkKQ09ORklHX1VOSVg5OF9QVFlTPXkKIyBDT05GSUdfTEVHQUNZX1BUWVMgaXMg
bm90IHNldApDT05GSUdfUFJJTlRFUj1tCkNPTkZJR19MUF9DT05TT0xFPXkKQ09ORklHX1BQREVW
PW0KIyBDT05GSUdfVElQQVIgaXMgbm90IHNldAoKIwojIElQTUkKIwojIENPTkZJR19JUE1JX0hB
TkRMRVIgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRzCiMKIyBDT05GSUdfV0FUQ0hET0cg
aXMgbm90IHNldAojIENPTkZJR19IV19SQU5ET00gaXMgbm90IHNldApDT05GSUdfTlZSQU09bQpD
T05GSUdfUlRDPW0KIyBDT05GSUdfR0VOX1JUQyBpcyBub3Qgc2V0CiMgQ09ORklHX0RUTEsgaXMg
bm90IHNldAojIENPTkZJR19SMzk2NCBpcyBub3Qgc2V0CiMgQ09ORklHX0FQUExJQ09NIGlzIG5v
dCBzZXQKIyBDT05GSUdfU09OWVBJIGlzIG5vdCBzZXQKCiMKIyBGdGFwZSwgdGhlIGZsb3BweSB0
YXBlIGRldmljZSBkcml2ZXIKIwojIENPTkZJR19GVEFQRSBpcyBub3Qgc2V0CkNPTkZJR19BR1A9
bQojIENPTkZJR19BR1BfQUxJIGlzIG5vdCBzZXQKIyBDT05GSUdfQUdQX0FUSSBpcyBub3Qgc2V0
CiMgQ09ORklHX0FHUF9BTUQgaXMgbm90IHNldAojIENPTkZJR19BR1BfQU1ENjQgaXMgbm90IHNl
dAojIENPTkZJR19BR1BfSU5URUwgaXMgbm90IHNldAojIENPTkZJR19BR1BfSU5URUxfTUNIIGlz
IG5vdCBzZXQKQ09ORklHX0FHUF9OVklESUE9bQojIENPTkZJR19BR1BfU0lTIGlzIG5vdCBzZXQK
IyBDT05GSUdfQUdQX1NXT1JLUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9WSUEgaXMgbm90IHNl
dAojIENPTkZJR19BR1BfRUZGSUNFT04gaXMgbm90IHNldAojIENPTkZJR19EUk0gaXMgbm90IHNl
dAojIENPTkZJR19NV0FWRSBpcyBub3Qgc2V0CiMgQ09ORklHX1JBV19EUklWRVIgaXMgbm90IHNl
dAojIENPTkZJR19IUEVUIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFOR0NIRUNLX1RJTUVSIGlzIG5v
dCBzZXQKCiMKIyBJMkMgc3VwcG9ydAojCkNPTkZJR19JMkM9bQpDT05GSUdfSTJDX0NIQVJERVY9
bQoKIwojIEkyQyBBbGdvcml0aG1zCiMKQ09ORklHX0kyQ19BTEdPQklUPW0KIyBDT05GSUdfSTJD
X0FMR09QQ0YgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxHT1BDQSBpcyBub3Qgc2V0CgojCiMg
STJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CiMKIyBDT05GSUdfSTJDX0FMSTE1MzUgaXMgbm90IHNl
dAojIENPTkZJR19JMkNfQUxJMTU2MyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTEkxNVgzIGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX0FNRDc1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19BTUQ4
MTExIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0k4MDEgaXMgbm90IHNldAojIENPTkZJR19JMkNf
STgxMCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19JU0EgaXMgbm90IHNldApDT05GSUdfSTJDX05G
T1JDRTI9bQojIENPTkZJR19JMkNfUEFSUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQVJQ
T1JUX0xJR0hUIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BJSVg0IGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX1BST1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TQVZBR0U0IGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0N4MjAwX0FDQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM1NTk1IGlz
IG5vdCBzZXQKIyBDT05GSUdfSTJDX1NJUzYzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM5
NlggaXMgbm90IHNldAojIENPTkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19W
SUEgaXMgbm90IHNldAojIENPTkZJR19JMkNfVklBUFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X1ZPT0RPTzMgaXMgbm90IHNldAojIENPTkZJR19JMkNfUENBX0lTQSBpcyBub3Qgc2V0CgojCiMg
SGFyZHdhcmUgU2Vuc29ycyBDaGlwIHN1cHBvcnQKIwpDT05GSUdfSTJDX1NFTlNPUj1tCiMgQ09O
RklHX1NFTlNPUlNfQURNMTAyMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNSBp
cyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQURNMTAyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfQURNMTAzMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfQVNCMTAwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19EUzE2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZT
Q0hFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfR0w1MThTTSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfSVQ4NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE02MyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NFTlNPUlNfTE03NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03
NyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE03OCBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
TlNPUlNfTE04MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04MyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfTE04NSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE04NyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfTE05MCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNf
TUFYMTYxOSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfUEM4NzM2MCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NFTlNPUlNfU01TQzQ3TTEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1ZJQTY4
NkEgaXMgbm90IHNldApDT05GSUdfU0VOU09SU19XODM3ODFEPW0KQ09ORklHX1NFTlNPUlNfVzgz
TDc4NVRTPW0KQ09ORklHX1NFTlNPUlNfVzgzNjI3SEY9bQoKIwojIE90aGVyIEkyQyBDaGlwIHN1
cHBvcnQKIwpDT05GSUdfU0VOU09SU19FRVBST009bQojIENPTkZJR19TRU5TT1JTX1BDRjg1NzQg
aXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDRjg1OTEgaXMgbm90IHNldAojIENPTkZJR19T
RU5TT1JTX1JUQzg1NjQgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQ09SRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0kyQ19ERUJVR19BTEdPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVH
X0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DSElQIGlzIG5vdCBzZXQKCiMKIyBE
YWxsYXMncyAxLXdpcmUgYnVzCiMKIyBDT05GSUdfVzEgaXMgbm90IHNldAoKIwojIE1pc2MgZGV2
aWNlcwojCiMgQ09ORklHX0lCTV9BU00gaXMgbm90IHNldAoKIwojIE11bHRpbWVkaWEgZGV2aWNl
cwojCiMgQ09ORklHX1ZJREVPX0RFViBpcyBub3Qgc2V0CgojCiMgRGlnaXRhbCBWaWRlbyBCcm9h
ZGNhc3RpbmcgRGV2aWNlcwojCiMgQ09ORklHX0RWQiBpcyBub3Qgc2V0CgojCiMgR3JhcGhpY3Mg
c3VwcG9ydAojCkNPTkZJR19GQj15CkNPTkZJR19GQl9NT0RFX0hFTFBFUlM9eQojIENPTkZJR19G
Ql9USUxFQkxJVFRJTkcgaXMgbm90IHNldAojIENPTkZJR19GQl9DSVJSVVMgaXMgbm90IHNldAoj
IENPTkZJR19GQl9QTTIgaXMgbm90IHNldAojIENPTkZJR19GQl9DWUJFUjIwMDAgaXMgbm90IHNl
dAojIENPTkZJR19GQl9BU0lMSUFOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0lNU1RUIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfVkdBMTYgaXMgbm90IHNldApDT05GSUdfRkJfVkVTQT15CkNPTkZJ
R19WSURFT19TRUxFQ1Q9eQojIENPTkZJR19GQl9IR0EgaXMgbm90IHNldAojIENPTkZJR19GQl9S
SVZBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSTgxMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0lO
VEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUFUUk9YIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
UkFERU9OX09MRCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1JBREVPTiBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX0FUWTEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FUWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX1NBVkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1NJUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX05FT01BR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfS1lSTyBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZCXzNERlggaXMgbm90IHNldAojIENPTkZJR19GQl9WT09ET08xIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfVFJJREVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1ZJUlRVQUwgaXMgbm90
IHNldAoKIwojIENvbnNvbGUgZGlzcGxheSBkcml2ZXIgc3VwcG9ydAojCkNPTkZJR19WR0FfQ09O
U09MRT15CkNPTkZJR19EVU1NWV9DT05TT0xFPXkKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEU9
eQojIENPTkZJR19GT05UUyBpcyBub3Qgc2V0CkNPTkZJR19GT05UXzh4OD15CkNPTkZJR19GT05U
Xzh4MTY9eQoKIwojIExvZ28gY29uZmlndXJhdGlvbgojCkNPTkZJR19MT0dPPXkKQ09ORklHX0xP
R09fTElOVVhfTU9OTz15CkNPTkZJR19MT0dPX0xJTlVYX1ZHQTE2PXkKQ09ORklHX0xPR09fTElO
VVhfQ0xVVDIyND15CgojCiMgU291bmQKIwpDT05GSUdfU09VTkQ9bQoKIwojIEFkdmFuY2VkIExp
bnV4IFNvdW5kIEFyY2hpdGVjdHVyZQojCkNPTkZJR19TTkQ9bQpDT05GSUdfU05EX1RJTUVSPW0K
Q09ORklHX1NORF9QQ009bQpDT05GSUdfU05EX0hXREVQPW0KQ09ORklHX1NORF9SQVdNSURJPW0K
Q09ORklHX1NORF9TRVFVRU5DRVI9bQojIENPTkZJR19TTkRfU0VRX0RVTU1ZIGlzIG5vdCBzZXQK
Q09ORklHX1NORF9PU1NFTVVMPXkKQ09ORklHX1NORF9NSVhFUl9PU1M9bQpDT05GSUdfU05EX1BD
TV9PU1M9bQpDT05GSUdfU05EX1NFUVVFTkNFUl9PU1M9eQpDT05GSUdfU05EX1JUQ1RJTUVSPW0K
IyBDT05GSUdfU05EX1ZFUkJPU0VfUFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RFQlVH
IGlzIG5vdCBzZXQKCiMKIyBHZW5lcmljIGRldmljZXMKIwojIENPTkZJR19TTkRfRFVNTVkgaXMg
bm90IHNldAojIENPTkZJR19TTkRfVklSTUlESSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NVFBB
ViBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TRVJJQUxfVTE2NTUwIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX01QVTQwMSBpcyBub3Qgc2V0CgojCiMgUENJIGRldmljZXMKIwpDT05GSUdfU05EX0FD
OTdfQ09ERUM9bQojIENPTkZJR19TTkRfQUxJNTQ1MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9B
VElJWFAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVRJSVhQX01PREVNIGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX0FVODgxMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BVTg4MjAgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfQVU4ODMwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FaVDMzMjggaXMg
bm90IHNldAojIENPTkZJR19TTkRfQlQ4N1ggaXMgbm90IHNldAojIENPTkZJR19TTkRfQ1M0NlhY
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNDI4MSBpcyBub3Qgc2V0CkNPTkZJR19TTkRfRU1V
MTBLMT1tCiMgQ09ORklHX1NORF9LT1JHMTIxMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NSVhB
UlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfTk0yNTYgaXMgbm90IHNldAojIENPTkZJR19TTkRf
Uk1FMzIgaXMgbm90IHNldAojIENPTkZJR19TTkRfUk1FOTYgaXMgbm90IHNldAojIENPTkZJR19T
TkRfUk1FOTY1MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9IRFNQIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1RSSURFTlQgaXMgbm90IHNldAojIENPTkZJR19TTkRfWU1GUENJIGlzIG5vdCBzZXQK
IyBDT05GSUdfU05EX0FMUzQwMDAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQ01JUENJIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzAgaXMgbm90IHNldAojIENPTkZJR19TTkRfRU5TMTM3
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE5MzggaXMgbm90IHNldAojIENPTkZJR19TTkRf
RVMxOTY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01BRVNUUk8zIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX0ZNODAxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0lDRTE3MTIgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfSUNFMTcyNCBpcyBub3Qgc2V0CkNPTkZJR19TTkRfSU5URUw4WDA9bQojIENP
TkZJR19TTkRfSU5URUw4WDBNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1NPTklDVklCRVMgaXMg
bm90IHNldAojIENPTkZJR19TTkRfVklBODJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9WWDIy
MiBpcyBub3Qgc2V0CgojCiMgVVNCIGRldmljZXMKIwojIENPTkZJR19TTkRfVVNCX0FVRElPIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX1VTQl9VU1gyWSBpcyBub3Qgc2V0CgojCiMgT3BlbiBTb3Vu
ZCBTeXN0ZW0KIwojIENPTkZJR19TT1VORF9QUklNRSBpcyBub3Qgc2V0CgojCiMgVVNCIHN1cHBv
cnQKIwpDT05GSUdfVVNCPW0KIyBDT05GSUdfVVNCX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBNaXNj
ZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09ORklHX1VTQl9ERVZJQ0VGUz15CkNPTkZJR19VU0Jf
QkFORFdJRFRIPXkKQ09ORklHX1VTQl9EWU5BTUlDX01JTk9SUz15CkNPTkZJR19VU0JfU1VTUEVO
RD15CiMgQ09ORklHX1VTQl9PVEcgaXMgbm90IHNldApDT05GSUdfVVNCX0FSQ0hfSEFTX0hDRD15
CkNPTkZJR19VU0JfQVJDSF9IQVNfT0hDST15CgojCiMgVVNCIEhvc3QgQ29udHJvbGxlciBEcml2
ZXJzCiMKQ09ORklHX1VTQl9FSENJX0hDRD1tCkNPTkZJR19VU0JfRUhDSV9TUExJVF9JU089eQpD
T05GSUdfVVNCX0VIQ0lfUk9PVF9IVUJfVFQ9eQpDT05GSUdfVVNCX09IQ0lfSENEPW0KQ09ORklH
X1VTQl9VSENJX0hDRD1tCiMgQ09ORklHX1VTQl9TTDgxMV9IQ0QgaXMgbm90IHNldAoKIwojIFVT
QiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCkNPTkZJR19VU0JfQVVESU89bQojIENPTkZJR19VU0Jf
QkxVRVRPT1RIX1RUWSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NSURJIGlzIG5vdCBzZXQKQ09O
RklHX1VTQl9BQ009bQpDT05GSUdfVVNCX1BSSU5URVI9bQoKIwojIE5PVEU6IFVTQl9TVE9SQUdF
IGVuYWJsZXMgU0NTSSwgYW5kICdTQ1NJIGRpc2sgc3VwcG9ydCcgbWF5IGFsc28gYmUgbmVlZGVk
OyBzZWUgVVNCX1NUT1JBR0UgSGVscCBmb3IgbW9yZSBpbmZvcm1hdGlvbgojCkNPTkZJR19VU0Jf
U1RPUkFHRT1tCiMgQ09ORklHX1VTQl9TVE9SQUdFX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1VT
Ql9TVE9SQUdFX1JXX0RFVEVDVD15CiMgQ09ORklHX1VTQl9TVE9SQUdFX0RBVEFGQUIgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9GUkVFQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X1NUT1JBR0VfSVNEMjAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfRFBDTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdFX0hQODIwMGUgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU1RPUkFHRV9TRERSMDkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9TRERSNTUg
aXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9KVU1QU0hPVCBpcyBub3Qgc2V0CgojCiMg
VVNCIElucHV0IERldmljZXMKIwpDT05GSUdfVVNCX0hJRD1tCkNPTkZJR19VU0JfSElESU5QVVQ9
eQpDT05GSUdfSElEX0ZGPXkKQ09ORklHX0hJRF9QSUQ9eQpDT05GSUdfTE9HSVRFQ0hfRkY9eQpD
T05GSUdfVEhSVVNUTUFTVEVSX0ZGPXkKQ09ORklHX1VTQl9ISURERVY9eQoKIwojIFVTQiBISUQg
Qm9vdCBQcm90b2NvbCBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX0tCRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9NT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BSVBURUsgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfV0FDT00gaXMgbm90IHNldAojIENPTkZJR19VU0JfS0JUQUIgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfUE9XRVJNQVRFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01UT1VDSCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FR0FMQVggaXMgbm90IHNldAojIENPTkZJR19VU0JfWFBB
RCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BVElfUkVNT1RFIGlzIG5vdCBzZXQKCiMKIyBVU0Ig
SW1hZ2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9IUFVTQlNDU0kgaXMgbm90IHNl
dAoKIwojIFVTQiBNdWx0aW1lZGlhIGRldmljZXMKIwojIENPTkZJR19VU0JfREFCVVNCIGlzIG5v
dCBzZXQKCiMKIyBWaWRlbzRMaW51eCBzdXBwb3J0IGlzIG5lZWRlZCBmb3IgVVNCIE11bHRpbWVk
aWEgZGV2aWNlIHN1cHBvcnQKIwoKIwojIFVTQiBOZXR3b3JrIEFkYXB0ZXJzCiMKIyBDT05GSUdf
VVNCX0NBVEMgaXMgbm90IHNldAojIENPTkZJR19VU0JfS0FXRVRIIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1BFR0FTVVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfUlRMODE1MCBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9VU0JORVQgaXMgbm90IHNldAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwoj
IENPTkZJR19VU0JfVVNTNzIwIGlzIG5vdCBzZXQKCiMKIyBVU0IgU2VyaWFsIENvbnZlcnRlciBz
dXBwb3J0CiMKIyBDT05GSUdfVVNCX1NFUklBTCBpcyBub3Qgc2V0CgojCiMgVVNCIE1pc2NlbGxh
bmVvdXMgZHJpdmVycwojCiMgQ09ORklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9FTUkyNiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9USUdMIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0FVRVJTV0FMRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9SSU81MDAgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfTEVHT1RPV0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xDRCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9MRUQgaXMgbm90IHNldAojIENPTkZJR19VU0JfQ1lUSEVSTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9QSElER0VUS0lUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BI
SURHRVRTRVJWTyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9URVNUIGlzIG5vdCBzZXQKCiMKIyBV
U0IgQVRNL0RTTCBkcml2ZXJzCiMKCiMKIyBVU0IgR2FkZ2V0IFN1cHBvcnQKIwojIENPTkZJR19V
U0JfR0FER0VUIGlzIG5vdCBzZXQKCiMKIyBNTUMvU0QgQ2FyZCBzdXBwb3J0CiMKQ09ORklHX01N
Qz1tCiMgQ09ORklHX01NQ19ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19NTUNfQkxPQ0s9bQojIENP
TkZJR19NTUNfV0JTRCBpcyBub3Qgc2V0CgojCiMgRmlsZSBzeXN0ZW1zCiMKQ09ORklHX0VYVDJf
RlM9bQpDT05GSUdfRVhUMl9GU19YQVRUUj15CkNPTkZJR19FWFQyX0ZTX1BPU0lYX0FDTD15CiMg
Q09ORklHX0VYVDJfRlNfU0VDVVJJVFkgaXMgbm90IHNldAojIENPTkZJR19FWFQzX0ZTIGlzIG5v
dCBzZXQKIyBDT05GSUdfSkJEIGlzIG5vdCBzZXQKQ09ORklHX0ZTX01CQ0FDSEU9bQojIENPTkZJ
R19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CkNPTkZJR19KRlNfRlM9bQpDT05GSUdfSkZTX1BPU0lY
X0FDTD15CiMgQ09ORklHX0pGU19ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19TVEFUSVNU
SUNTIGlzIG5vdCBzZXQKQ09ORklHX0ZTX1BPU0lYX0FDTD15CkNPTkZJR19YRlNfRlM9eQpDT05G
SUdfWEZTX1JUPXkKQ09ORklHX1hGU19RVU9UQT15CiMgQ09ORklHX1hGU19TRUNVUklUWSBpcyBu
b3Qgc2V0CkNPTkZJR19YRlNfUE9TSVhfQUNMPXkKQ09ORklHX01JTklYX0ZTPW0KQ09ORklHX1JP
TUZTX0ZTPW0KQ09ORklHX1FVT1RBPXkKQ09ORklHX1FGTVRfVjE9bQpDT05GSUdfUUZNVF9WMj1t
CkNPTkZJR19RVU9UQUNUTD15CkNPTkZJR19ETk9USUZZPXkKIyBDT05GSUdfQVVUT0ZTX0ZTIGlz
IG5vdCBzZXQKQ09ORklHX0FVVE9GUzRfRlM9eQoKIwojIENELVJPTS9EVkQgRmlsZXN5c3RlbXMK
IwpDT05GSUdfSVNPOTY2MF9GUz1tCkNPTkZJR19KT0xJRVQ9eQpDT05GSUdfWklTT0ZTPXkKQ09O
RklHX1pJU09GU19GUz1tCkNPTkZJR19VREZfRlM9bQpDT05GSUdfVURGX05MUz15CgojCiMgRE9T
L0ZBVC9OVCBGaWxlc3lzdGVtcwojCkNPTkZJR19GQVRfRlM9bQpDT05GSUdfTVNET1NfRlM9bQpD
T05GSUdfVkZBVF9GUz1tCkNPTkZJR19GQVRfREVGQVVMVF9DT0RFUEFHRT00MzcKQ09ORklHX0ZB
VF9ERUZBVUxUX0lPQ0hBUlNFVD0iaXNvODg1OS0xIgpDT05GSUdfTlRGU19GUz1tCiMgQ09ORklH
X05URlNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19OVEZTX1JXIGlzIG5vdCBzZXQKCiMKIyBQ
c2V1ZG8gZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJPQ19GUz15CkNPTkZJR19QUk9DX0tDT1JFPXkK
Q09ORklHX1NZU0ZTPXkKIyBDT05GSUdfREVWRlNfRlMgaXMgbm90IHNldApDT05GSUdfREVWUFRT
X0ZTX1hBVFRSPXkKIyBDT05GSUdfREVWUFRTX0ZTX1NFQ1VSSVRZIGlzIG5vdCBzZXQKQ09ORklH
X1RNUEZTPXkKIyBDT05GSUdfVE1QRlNfWEFUVFIgaXMgbm90IHNldApDT05GSUdfSFVHRVRMQkZT
PXkKQ09ORklHX0hVR0VUTEJfUEFHRT15CkNPTkZJR19SQU1GUz15CgojCiMgTWlzY2VsbGFuZW91
cyBmaWxlc3lzdGVtcwojCiMgQ09ORklHX0FERlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BRkZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfSEZTUExV
U19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JFRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRlNf
RlMgaXMgbm90IHNldAojIENPTkZJR19FRlNfRlMgaXMgbm90IHNldApDT05GSUdfQ1JBTUZTPW0K
IyBDT05GSUdfVlhGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19TWVNWX0ZTIGlzIG5vdCBzZXQK
Q09ORklHX1VGU19GUz1tCiMgQ09ORklHX1VGU19GU19XUklURSBpcyBub3Qgc2V0CgojCiMgTmV0
d29yayBGaWxlIFN5c3RlbXMKIwpDT05GSUdfTkZTX0ZTPW0KQ09ORklHX05GU19WMz15CkNPTkZJ
R19ORlNfVjQ9eQpDT05GSUdfTkZTX0RJUkVDVElPPXkKQ09ORklHX05GU0Q9bQpDT05GSUdfTkZT
RF9WMz15CkNPTkZJR19ORlNEX1Y0PXkKQ09ORklHX05GU0RfVENQPXkKQ09ORklHX0xPQ0tEPW0K
Q09ORklHX0xPQ0tEX1Y0PXkKQ09ORklHX0VYUE9SVEZTPW0KQ09ORklHX1NVTlJQQz1tCkNPTkZJ
R19TVU5SUENfR1NTPW0KQ09ORklHX1JQQ1NFQ19HU1NfS1JCNT1tCiMgQ09ORklHX1JQQ1NFQ19H
U1NfU1BLTTMgaXMgbm90IHNldApDT05GSUdfU01CX0ZTPW0KQ09ORklHX1NNQl9OTFNfREVGQVVM
VD15CkNPTkZJR19TTUJfTkxTX1JFTU9URT0iY3A0MzciCkNPTkZJR19DSUZTPW0KIyBDT05GSUdf
Q0lGU19TVEFUUyBpcyBub3Qgc2V0CkNPTkZJR19DSUZTX1hBVFRSPXkKQ09ORklHX0NJRlNfUE9T
SVg9eQojIENPTkZJR19DSUZTX0VYUEVSSU1FTlRBTCBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFfRlMgaXMgbm90IHNldAojIENPTkZJR19BRlNfRlMg
aXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwojCiMgQ09ORklHX1BBUlRJVElPTl9BRFZB
TkNFRCBpcyBub3Qgc2V0CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQoKIwojIE5hdGl2ZSBMYW5n
dWFnZSBTdXBwb3J0CiMKQ09ORklHX05MUz15CkNPTkZJR19OTFNfREVGQVVMVD0iaXNvODg1OS0x
IgpDT05GSUdfTkxTX0NPREVQQUdFXzQzNz1tCiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKQ09ORklHX05MU19D
T0RFUEFHRV84NTA9bQpDT05GSUdfTkxTX0NPREVQQUdFXzg1Mj1tCiMgQ09ORklHX05MU19DT0RF
UEFHRV84NTUgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU3IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjEgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYyIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2MyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjQgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY1IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzg2NiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84Njkg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTM2IGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzk1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85MzIgaXMg
bm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTQ5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0NPREVQQUdFXzg3NCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzggaXMgbm90IHNl
dApDT05GSUdfTkxTX0NPREVQQUdFXzEyNTA9bQojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MSBp
cyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9bQpDT05GSUdfTkxTX0lTTzg4NTlfMT1tCkNPTkZJ
R19OTFNfSVNPODg1OV8yPW0KIyBDT05GSUdfTkxTX0lTTzg4NTlfMyBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19JU084ODU5XzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV81IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084
ODU5XzcgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV85IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0lTTzg4NTlfMTMgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzE1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tP
SThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1UgaXMgbm90IHNldApDT05GSUdfTkxT
X1VURjg9bQoKIwojIFByb2ZpbGluZyBzdXBwb3J0CiMKIyBDT05GSUdfUFJPRklMSU5HIGlzIG5v
dCBzZXQKCiMKIyBLZXJuZWwgaGFja2luZwojCkNPTkZJR19ERUJVR19LRVJORUw9eQpDT05GSUdf
TUFHSUNfU1lTUlE9eQojIENPTkZJR19TQ0hFRFNUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVC
VUdfU0xBQiBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NQSU5MT0NLIGlzIG5vdCBzZXQKIyBD
T05GSUdfREVCVUdfU1BJTkxPQ0tfU0xFRVAgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19LT0JK
RUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfSElHSE1FTSBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX0lORk8gaXMgbm90IHNldAojIENPTkZJR19GUkFNRV9QT0lOVEVSIGlzIG5vdCBzZXQK
Q09ORklHX0VBUkxZX1BSSU5USz15CiMgQ09ORklHX0RFQlVHX1NUQUNLT1ZFUkZMT1cgaXMgbm90
IHNldAojIENPTkZJR19LUFJPQkVTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU1RBQ0tfVVNB
R0UgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19QQUdFQUxMT0MgaXMgbm90IHNldApDT05GSUdf
NEtTVEFDS1M9eQpDT05GSUdfWDg2X0ZJTkRfU01QX0NPTkZJRz15CkNPTkZJR19YODZfTVBQQVJT
RT15CgojCiMgU2VjdXJpdHkgb3B0aW9ucwojCiMgQ09ORklHX0tFWVMgaXMgbm90IHNldAojIENP
TkZJR19TRUNVUklUWSBpcyBub3Qgc2V0CgojCiMgQ3J5cHRvZ3JhcGhpYyBvcHRpb25zCiMKQ09O
RklHX0NSWVBUTz15CkNPTkZJR19DUllQVE9fSE1BQz15CiMgQ09ORklHX0NSWVBUT19OVUxMIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX01ENCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fTUQ1
PW0KIyBDT05GSUdfQ1JZUFRPX1NIQTEgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0hBMjU2
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTUxMiBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19XUDUxMiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fREVTPW0KIyBDT05GSUdfQ1JZUFRP
X0JMT1dGSVNIIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RXT0ZJU0ggaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fU0VSUEVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BRVNfNTg2
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0NBU1Q1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZ
UFRPX0NBU1Q2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1RFQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0NSWVBUT19BUkM0IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0tIQVpBRCBpcyBub3Qg
c2V0CiMgQ09ORklHX0NSWVBUT19BTlVCSVMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fREVG
TEFURSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19NSUNIQUVMX01JQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19DUkMzMkMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVEVTVCBpcyBu
b3Qgc2V0CgojCiMgTGlicmFyeSByb3V0aW5lcwojCiMgQ09ORklHX0NSQ19DQ0lUVCBpcyBub3Qg
c2V0CkNPTkZJR19DUkMzMj15CiMgQ09ORklHX0xJQkNSQzMyQyBpcyBub3Qgc2V0CkNPTkZJR19a
TElCX0lORkxBVEU9bQpDT05GSUdfR0VORVJJQ19IQVJESVJRUz15CkNPTkZJR19HRU5FUklDX0lS
UV9QUk9CRT15CkNPTkZJR19YODZfQklPU19SRUJPT1Q9eQpDT05GSUdfUEM9eQo=
------=_Part_429_3490466.1104034227606--
