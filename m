Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVBXRPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVBXRPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 12:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVBXRPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 12:15:38 -0500
Received: from news.suse.de ([195.135.220.2]:37764 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262424AbVBXROP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 12:14:15 -0500
Date: Thu, 24 Feb 2005 18:14:09 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
Message-ID: <20050224171409.GA6932@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050224145049.GA21313@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Feb 24, Olaf Hering wrote:

>  On Wed, Feb 23, Linus Torvalds wrote:
> 
> > This time it's really supposed to be a quickie, so people who can, please 
> > check it out, and we'll make the real 2.6.11 asap.
> 
> radeonfb oopses on intel.
> Havent checked yet when it started with it.

2.6.10 works at least.



0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8378 [KM400/A] Chipset Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
0000:00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61)
0000:00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 62)
0000:00:0a.3 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]

Linux version 2.6.10-200502230204-usbtest (olaf@weissichgradnich) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #2 Thu Feb 24 17:56:06 CET 2005
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
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 KM400                                 ) @ 0x000f6cd0
ACPI: RSDT (v001 KM400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 KM400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 KM400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7a40
ACPI: DSDT (v001 KM400  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Built 1 zonelists
Kernel command line: vga=normal selinux=0 panic=180
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1328.010 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513340k/524224k available (2149k kernel code, 10296k reserved, 1155k data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2621.44 BogoMIPS (lpj=1310720)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: After vendor identify, caps:  0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Sempron(tm) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e28)
checking if image is initramfs... it is
Freeing initrd memory: 1100k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb5e0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 10 11 12) *5
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x5000-0x500f has been reserved
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1109264817.884:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: VIA Rhine II at 0xc400, 00:11:5b:83:1e:76, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI interrupt 0000:00:11.1[A] -> GSI 11 (level, low) -> IRQ 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1203N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: Host Protected Area detected.
	current capacity is 66055248 sectors (33820 MB)
	native  capacity is 234493056 sectors (120060 MB)
hda: Host Protected Area disabled.
hda: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PC Speaker
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
ACPI wakeup devices: 
PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 LAN0 MC97 UAR1 ECP1 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 204k freed
ide_core: disagrees about version of symbol struct_module
via82cxxx: disagrees about version of symbol struct_module
jbd: disagrees about version of symbol struct_module
ext3: disagrees about version of symbol struct_module
ide_disk: disagrees about version of symbol struct_module
ide_floppy: disagrees about version of symbol struct_module
cdrom: disagrees about version of symbol struct_module
ide_cd: disagrees about version of symbol struct_module
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
EXT3 FS on hda8, internal journal
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
Linux agpgart interface v0.100 (c) Dave Jones
cpci_hotplug: CompactPCI Hot Plug Core version: 0.2
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:0a.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
shpchp: acpi_shpchprm:\_SB_.PCI0 evaluate _BBN fail=0x5
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x5
uhci_hcd 0000:00:0a.0: irq 10, io base 0xa000
uhci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0a.1[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Via IRQ fixup for 0000:00:0a.1, from 5 to 11
uhci_hcd 0000:00:0a.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:0a.1: irq 11, io base 0xa400
uhci_hcd 0000:00:0a.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.0: irq 11, io base 0xac00
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI interrupt 0000:00:10.1[B] -> GSI 3 (level, low) -> IRQ 3
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.1: irq 3, io base 0xb000
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#5)
uhci_hcd 0000:00:10.2: irq 10, io base 0xb400
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
agpgart: Detected VIA KM400/KM400A chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
ACPI: PCI interrupt 0000:00:0a.2[C] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:0a.2: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:0a.2: irq 11, pci mem 0xe2000000
ehci_hcd 0000:00:0a.2: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:0a.2: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 4 ports detected
ACPI: PCI interrupt 0000:00:10.3[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0 (#2)
ehci_hcd 0000:00:10.3: irq 11, pci mem 0xe2002000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:0a.3[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e2001000-e20017ff]  Max Packet=[2048]
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:11.5 to 64
NET: Registered protocol family 23
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=133.00 Mhz, System=133.00 MHz
radeonfb: PLL min 12000 max 35000
usb 5-1: new low speed USB device using uhci_hcd and address 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006685]
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
EDID checksum failed, aborting
EDID checksum failed, aborting
EDID checksum failed, aborting
radeonfb: Assuming panel size 8x1
radeonfb: Can't find mode for panel size, going back to CRT
Console: switching to colour frame buffer device 80x30
radeonfb: ATI Radeon QY  DDR SGRAM 64 MB
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0000:00:10.2-1
usbcore: registered new driver usbhid
/home/olaf/linux-2.6.10/drivers/usb/input/hid-core.c: v2.0:USB HID core driver
SCSI subsystem initialized
st: Version 20041025, fixed bufsize 32768, s/g segs 256
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
NET: Registered protocol family 17
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (39 C)
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03c0940(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device daf4d400(sit0)
powernow-k8: Processor cpuid 681 not supported
