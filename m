Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWACKzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWACKzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 05:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWACKzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 05:55:18 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:57810 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751364AbWACKzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 05:55:16 -0500
From: =?iso-8859-15?q?Jo=E3o_Esteves?= <joao.m.esteves@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: Via VT 6410 Raid Controller
Date: Tue, 3 Jan 2006 10:55:02 +0000
User-Agent: KMail/1.8.2
References: <200601021253.10738.joao.m.esteves@netcabo.pt> <200601021647.27453.joao.m.esteves@netcabo.pt> <43B95D20.3060401@gentoo.org>
In-Reply-To: <43B95D20.3060401@gentoo.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GgluDZ7nnPSiLQd"
Message-Id: <200601031055.02257.joao.m.esteves@netcabo.pt>
X-OriginalArrivalTime: 03 Jan 2006 10:55:13.0038 (UTC) FILETIME=[2C224AE0:01C61054]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GgluDZ7nnPSiLQd
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thank you, Daniel.
> >
>
> Can you explain what you mean by you don't "see" it? Where are you lookin=
g?
>
> You could also post the output of:
> 	dmesg
> 	lspci
> 	lspci -n

I'm looking in the "Devices" Desktop shortcut (Mandriva2006). It appears sd=
a1,=20
hda (DVD), hdb (DVD-Recorder) and floppy, but no reference to the Pata HDD.=
=20
This is the same as "device:/" in konqueror.
The output of the commands are attached.

Best regards.

Jo=E3o


--Boundary-00=_GgluDZ7nnPSiLQd
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=1 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=8 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=2 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=9 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=3 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=4 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=10 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=5 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=6 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=7 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=8 DF PROTO=UDP SPT=631 DPT=631 LEN=118
[root@localhost ~]# dmsg
bash: dmsg: command not found
[root@localhost ~]# dmesg
Linux version 2.6.12-12mdkcustom (root@localhost) (gcc version 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0)) #3 Mon Jan 2 21:27:02 WET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
 BIOS-e820: 000000001ffc0000 - 000000001ffce000 (ACPI data)
 BIOS-e820: 000000001ffce000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 131008
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126912 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f8a60
ACPI: RSDT (v001 A M I  OEMRSDT  0x08000524 MSFT 0x00000097) @ 0x1ffc0000
ACPI: FADT (v002 A M I  OEMFACP  0x08000524 MSFT 0x00000097) @ 0x1ffc0200
ACPI: MADT (v001 A M I  OEMAPIC  0x08000524 MSFT 0x00000097) @ 0x1ffc0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x08000524 MSFT 0x00000097) @ 0x1ffce040
ACPI: MCFG (v001 A M I  OEMMCFG  0x08000524 MSFT 0x00000097) @ 0x1ffc4300
ACPI: DSDT (v001  0AAAA 0AAAA000 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dfb80000)
Built 1 zonelists
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2612-12custom root=806 pci=nosort resume=/dev/sda5 splash=silent
bootsplash: silent mode.
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 3401.657 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514596k/524032k available (2358k kernel code, 8940k reserved, 719k data, 264k init, 0k highmem, 0k BadRAM)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6733.82 BogoMIPS (lpj=3366912)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000441d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000441d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: Looking for DSDT in initrd... not found.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 273k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using MMCONFIG
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 17 devices
PnPBIOS: Disabled
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x295-0x296 has been reserved
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1136283494.095:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
vesafb: framebuffer at 0xf0000000, mapped to 0xe0880000, using 3750k, total 16384k
vesafb: mode is 800x600x16, linelength=1600, pages=16
vesafb: protected mode interface info at c000:5926
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
bootsplash 3.1.6-2004/03/31: looking for picture...<6> silentjpeg size 34430 bytes,<6>...found (800x600, 34382 bytes, v3).
Console: switching to colour frame buffer device 93x30
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: TSSTcorpCD/DVDW TS-H552U, ATAPI CD/DVD-ROM drive
hdb: SAMSUNG DVD-ROM SD-612S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
ACPI wakeup devices:
P0P2 P0P1 USB1 USB2 USB3 USB4 EUSB MC97 P0P4 P0P5 P0P6 P0P7 PWRB
ACPI: (supports S0 S1 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
devfs_mk_dev: could not append to parent for md/0
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
libata version 1.11 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xB400 ctl 0xB082 bmdma 0xA880 irq 19
ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xAC02 bmdma 0xA888 irq 19
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0xB007
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 264k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000bc00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000b880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000b800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000b480
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 2-2: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfbdffc00
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-2: can't set config #1, error -71
usb 2-2: new low speed USB device using uhci_hcd and address 4
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
ACPI: Processor [CPU1] (supports 8 throttling states)
input: Logitech USB Receiver on usb-0000:00:1d.1-2
usbcore: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
EXT3 FS on sda6, internal journal
Adding 1028120k swap on /dev/sda5.  Priority:-1 extents:1
hw_random: RNG not detected
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915G Chipset.
agpgart: AGP aperture is 256M @ 0x0
Supermount version 2.0.4 for kernel 2.6
ntfs: Ignoring new-style parameters in presence of obsolete ones
NTFS driver 2.1.22 [Flags: R/O DEBUG MODULE].
NTFS volume version 3.1.
loop: loaded (max 8 devices)
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 40X DVD-ROM drive, 512kB Cache, DMA
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 260 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET: Registered protocol family 17
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
sk98lin: Network Device Driver v8.23.1.3
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:03:00.0 to 64
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 260 bytes per conntrack
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
netfilter PSD loaded - (c) astaro AG
IFWLOG: register target
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ppdev: user-space parallel port driver
ppdev0: registered pardevice
ppdev0: unregistered pardevice
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=631 DPT=631 LEN=118
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03c8e60(lo)
IPv6 over IPv4 tunneling driver
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=77 TOS=0x00 PREC=0x00 TTL=255 ID=0 DF PROTO=UDP SPT=5353 DPT=5353 LEN=57
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=77 TOS=0x00 PREC=0x00 TTL=255 ID=1 DF PROTO=UDP SPT=5353 DPT=5353 LEN=57
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=77 TOS=0x00 PREC=0x00 TTL=255 ID=2 DF PROTO=UDP SPT=5353 DPT=5353 LEN=57
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=3 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
[drm] Initialized drm 1.0.0 20040925
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 10117 bytes, v3).
bootsplash: status on console 0 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 10117 bytes, v3).
bootsplash: status on console 1 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 10117 bytes, v3).
bootsplash: status on console 2 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 10117 bytes, v3).
bootsplash: status on console 3 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 10117 bytes, v3).
bootsplash: status on console 4 changed to on
bootsplash 3.1.6-2004/03/31: looking for picture...<6>...found (800x600, 10117 bytes, v3).
bootsplash: status on console 5 changed to on
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=4 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=44 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=32769 DPT=7741 LEN=24
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.0 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=ICMP TYPE=8 CODE=0 ID=3606 SEQ=0
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=255 DF PROTO=ICMP TYPE=8 CODE=0 ID=3606 SEQ=0
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=5 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=6 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
eth0: no IPv6 routers present
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=7 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=1 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=8 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=2 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=9 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=3 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=4 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=224.0.0.251 LEN=111 TOS=0x00 PREC=0x00 TTL=255 ID=10 DF PROTO=UDP SPT=5353 DPT=5353 LEN=91
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=5 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=6 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=7 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=8 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=9 DF PROTO=UDP SPT=631 DPT=631 LEN=118
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=44 TOS=0x00 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=32769 DPT=7741 LEN=24
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.0 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=256 DF PROTO=ICMP TYPE=8 CODE=0 ID=5399 SEQ=0
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=28 TOS=0x00 PREC=0x00 TTL=64 ID=511 DF PROTO=ICMP TYPE=8 CODE=0 ID=5399 SEQ=0
Shorewall:net2all:DROP:IN=eth0 OUT= MAC= SRC=192.168.1.100 DST=192.168.1.255 LEN=138 TOS=0x00 PREC=0x00 TTL=64 ID=10 DF PROTO=UDP SPT=631 DPT=631 LEN=118

--Boundary-00=_GgluDZ7nnPSiLQd
Content-Type: text/plain;
  charset="iso-8859-15";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O Controller (rev 04)
00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express Root Port (rev 04)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B62 [Radeon X600 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc Radeon X600(RV380)
02:00.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
02:00.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
02:04.0 RAID bus controller: VIA Technologies, Inc. VT6410 ATA133 RAID controller (rev 06)
03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit Ethernet Controller (rev 15)

--Boundary-00=_GgluDZ7nnPSiLQd
Content-Type: text/plain;
  charset="iso-8859-15";
  name="lspci-n"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci-n"

00:00.0 Class 0600: 8086:2580 (rev 04)
00:01.0 Class 0604: 8086:2581 (rev 04)
00:1c.0 Class 0604: 8086:2660 (rev 03)
00:1d.0 Class 0c03: 8086:2658 (rev 03)
00:1d.1 Class 0c03: 8086:2659 (rev 03)
00:1d.2 Class 0c03: 8086:265a (rev 03)
00:1d.3 Class 0c03: 8086:265b (rev 03)
00:1d.7 Class 0c03: 8086:265c (rev 03)
00:1e.0 Class 0604: 8086:244e (rev d3)
00:1f.0 Class 0601: 8086:2640 (rev 03)
00:1f.1 Class 0101: 8086:266f (rev 03)
00:1f.2 Class 0101: 8086:2651 (rev 03)
00:1f.3 Class 0c05: 8086:266a (rev 03)
01:00.0 Class 0300: 1002:5b62
01:00.1 Class 0380: 1002:5b72
02:00.0 Class 0401: 1102:0002 (rev 0a)
02:00.1 Class 0980: 1102:7002 (rev 0a)
02:04.0 Class 0104: 1106:3164 (rev 06)
03:00.0 Class 0200: 11ab:4362 (rev 15)

--Boundary-00=_GgluDZ7nnPSiLQd--
