Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbVHSUli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbVHSUli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVHSUli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:41:38 -0400
Received: from iron.pdx.net ([207.149.241.18]:29899 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S932715AbVHSUlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:41:37 -0400
Subject: 2.6.13-rc6-git10 test report [x86_64]
From: Sean Bruno <sean.bruno@dsl-only.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-DsECYJLvNPXjCeRdaebv"
Date: Fri, 19 Aug 2005 13:41:23 -0700
Message-Id: <1124484084.14825.45.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DsECYJLvNPXjCeRdaebv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Saw the new git today and thought I would test it out.

Still running with pci=noacpi for my mobo, but compiles ok and runs
well.

Sean

--=-DsECYJLvNPXjCeRdaebv
Content-Disposition: attachment; filename=dmesg.2.6.13-rc6-git11-noacpi-clean.txt
Content-Type: text/plain; name=dmesg.2.6.13-rc6-git11-noacpi-clean.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 rhgb pci=noacpi iommu=memaper=3)
Linux version 2.6.13-rc6-git11 (root@home-desk) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 SMP Fri Aug 19 13:15:31 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e400 (usable)
 BIOS-e820: 000000000009e400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001c0000000 (usable)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7650
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x00000000bfff9680
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x00000000bfff9880
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff99c0
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x00000000bfff9580
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> CPU 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> CPU 1 -> Node 1
SRAT: Node 0 PXM 0 0-9ffff
SRAT: Node 0 PXM 0 0-bfffffff
SRAT: Node 0 PXM 0 0-13fffffff
SRAT: Node 1 PXM 1 140000000-1bfffffff
Using 25 for the hash shift. Max adder is 1bfffffff 
Bootmem setup node 0 0000000000000000-000000013fffffff
Bootmem setup node 1 0000000140000000-00000001bfffffff
On node 0 totalpages: 1310719
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1306623 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 <6>Product ID: PROD00000000 <6>APIC at: 0xFEE00000
I/O APIC #4 Version 17 at 0xFEC00000.
Setting APIC routing to flat
Processors: 2
Allocating PCI resources starting at c0000000 (gap: c0000000:20000000)
Checking aperture...
CPU 0: aperture @ 10000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 256 MB of RAM
Mapping aperture over 262144 KB of RAM @ 10000000
Built 2 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb pci=noacpi iommu=memaper=3
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2010.343 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 5908456k/7340032k available (2448k kernel code, 0k reserved, 1304k data, 224k init)
Calibrating delay using timer specific routine.. 4024.90 BogoMIPS (lpj=8049809)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
ACPI: setting ELCR to 1a28 (from 1828)
Using IO-APIC 4
..MP-BIOS bug: 8254 timer not connected to IO-APIC
works.
Using local APIC timer interrupts.
Detected 12.564 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 2010.47 BogoMIPS (lpj=4020947)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 246 stepping 0a
CPU 1: Syncing TSC to CPU 0.
Brought up 2 CPUs
CPU 1: synchronized TSC with CPU 0 (last diff -72877 cycles, maxerr 654 cycles)
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... CPU#1: NMI appears to be stuck (9->14)!
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
    ACPI-0362: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace, AE_NOT_FOUND
search_node ffff8101428572c0 start_node ffff8101428572c0 return_node 0000000000000000
    ACPI-0362: *** Error: Looking up [\_SB_.PCI0.APC0] in namespace, AE_NOT_FOUND
search_node ffff8101428571c0 start_node ffff8101428571c0 return_node 0000000000000000
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:04:00.0
PCI->APIC IRQ transform: 0000:00:01.1[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:00:02.0[A] -> IRQ 3
PCI->APIC IRQ transform: 0000:00:02.1[B] -> IRQ 5
PCI->APIC IRQ transform: 0000:00:04.0[A] -> IRQ 12
PCI->APIC IRQ transform: 0000:00:07.0[A] -> IRQ 12
PCI->APIC IRQ transform: 0000:00:08.0[A] -> IRQ 11
PCI->APIC IRQ transform: 0000:01:08.0[A] -> IRQ 3
PCI->APIC IRQ transform: 0000:01:09.0[A] -> IRQ 5
PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 3
PCI->APIC IRQ transform: 0000:04:00.0[A] -> IRQ 11
PCI: Bridge: 0000:00:09.0
  IO window: d000-dfff
  MEM window: fe800000-fe8fffff
  PREFETCH window: fe900000-fe9fffff
PCI: Bridge: 0000:00:0c.0
  IO window: c000-cfff
  MEM window: fe700000-fe7fffff
  PREFETCH window: fe600000-fe6fffff
PCI: Bridge: 0000:00:0d.0
  IO window: b000-bfff
  MEM window: fe500000-fe5fffff
  PREFETCH window: fe400000-fe4fffff
PCI: Bridge: 0000:00:0e.0
  IO window: a000-afff
  MEM window: fb000000-fdffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 10000000 size 262144 KB
PCI-DMA: Reserving 256MB of IOMMU area in the AGP aperture
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4800-0x487f has been reserved
pnp: 00:00: ioport range 0x4880-0x48ff has been reserved
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1124483662.536:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0xfa00-0xfa07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfa08-0xfa0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
hdd: Polaroid BurnMAX48, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide0...
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.3)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0xc, vid 0x2
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0xe (1200 mV)
cpu_init done, current fid 0x2, vid 0xe
Freeing unused kernel memory: 224k freed
scsi_mod: no version for "struct_module" found: kernel tainted.
SCSI subsystem initialized
libata version 1.11 loaded.
sata_sil version 0.9
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004080 ctl 0xFFFFC2000000408A bmdma 0xFFFFC20000004000 irq 5
ata2: SATA max UDMA/100 cmd 0xFFFFC200000040C0 ctl 0xFFFFC200000040CA bmdma 0xFFFFC20000004008 irq 5
ata3: SATA max UDMA/100 cmd 0xFFFFC20000004280 ctl 0xFFFFC2000000428A bmdma 0xFFFFC20000004200 irq 5
ata4: SATA max UDMA/100 cmd 0xFFFFC200000042C0 ctl 0xFFFFC200000042CA bmdma 0xFFFFC20000004208 irq 5
input: AT Translated Set 2 keyboard on isa0060/serio0
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c68 86:3c01 87:4003 88:20ff
ata1: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3e01 87:4003 88:20ff
ata2: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
sata_nv version 0.6
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata5: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xF500 irq 12
ata6: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xF508 irq 12
ata5: no device found (phy stat 00000000)
scsi4 : sata_nv
ata6: no device found (phy stat 00000000)
scsi5 : sata_nv
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata7: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xF000 irq 11
ata8: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xF008 irq 11
ata7: no device found (phy stat 00000000)
scsi6 : sata_nv
ata8: no device found (phy stat 00000000)
scsi7 : sata_nv
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
tg3.c:v3.35 (August 6, 2005)
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751) rev 4101 PHY(5750)] (PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:11:d8:d3:08:05
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000]
PCI: Setting latency timer of device 0000:00:04.0 to 64
intel8x0_measure_ac97_clock: measured 58676 usecs
intel8x0: clocking to 46940
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Address64 -------- Resource unparsed
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 5, io mem 0xfeb00000
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: park 0
ehci_hcd 0000:00:02.1: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 3, io mem 0xfeaff000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
usb 2-3: new low speed USB device using ohci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:02.0-3
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[3]  MMIO=[fe8ff000-fe8ff7ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000277ca6]
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff8045c4a0(lo)
IPv6 over IPv4 tunneling driver
audit(1124483676.993:2): user pid=1546 uid=0 auid=4294967295 msg='hwclock: op=changing system time id=0 res=success'
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
w83627hf 2-0290: GPIO5 disabled, no VID function
w83627hf 2-0290: Enabling temp2, readings might not make sense
w83627hf 2-0290: Enabling temp3, readings might not make sense
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth0: no IPv6 routers present

--=-DsECYJLvNPXjCeRdaebv--

