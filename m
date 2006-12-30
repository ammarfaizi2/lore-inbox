Return-Path: <linux-kernel-owner+w=401wt.eu-S1030326AbWL3Wz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWL3Wz0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 17:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWL3Wz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 17:55:26 -0500
Received: from main.gmane.org ([80.91.229.2]:60772 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030326AbWL3WzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 17:55:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Nagel <feuerschwanz76@web.de>
Subject: new harddrive with media error
Date: Sat, 30 Dec 2006 23:44:01 +0100
Message-ID: <en6q3j$2jk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-87-78-107-42.netcologne.de
User-Agent: IceDove 1.5.0.9 (X11/20061220)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

i installed a new drive (WDC WD5000KS-00M) in my computer and installed 
WinXP on it. Afterwards i installed Debian etch on the second one 
(HDS722512VLSA80). Everything works fine so far, but during every boot i 
get following messages in dmesg [1]
Kernel [2] is 2.6.18 as default kernel in etch.
the board is a asusboard with via chipset [3]
The problem is that the boottime is very long, for every "media error" ~ 
3 sec. :-(
After successfull boot, the desktop and everything else works fine.

What cause these errors and how can i get rid of them? And can someone 
"translate" them? I dont know what they mean.
Is this a known kernel bug?
If you need more info, ask :-)

greets

Alex

[3]
lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host 
Bridge (rev 01)
         Subsystem: ASUSTeK Computer Inc. K8V Deluxe/K8V-X motherboard
         Flags: bus master, 66MHz, medium devsel, latency 64
         Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: <access denied>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800/K8T890 South] (prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: f9700000-fd8fffff
         Prefetchable memory behind bridge: b9600000-d95fffff
         Capabilities: <access denied>

00:0a.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
         Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit 
Ethernet Controller (Asus)
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 169
         Memory at fda00000 (32-bit, non-prefetchable) [size=16K]
         I/O ports at c800 [size=256]
         Expansion ROM at fd900000 [disabled] [size=128K]
         Capabilities: <access denied>

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe/K8V-X/A8V 
Deluxe motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 177
         I/O ports at e800 [size=8]
         I/O ports at e400 [size=4]
         I/O ports at e000 [size=8]
         I/O ports at d800 [size=4]
         I/O ports at d400 [size=16]
         I/O ports at d000 [size=256]
         Capabilities: <access denied>

00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe 
motherboard
         Flags: bus master, medium devsel, latency 32, IRQ 177
         I/O ports at fc00 [size=16]
         Capabilities: <access denied>

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe 
motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 185
         I/O ports at dc00 [size=32]
         Capabilities: <access denied>

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe 
motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 185
         I/O ports at ec00 [size=32]
         Capabilities: <access denied>

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe 
motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 185
         I/O ports at c000 [size=32]
         Capabilities: <access denied>

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe 
motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 185
         I/O ports at c400 [size=32]
         Capabilities: <access denied>

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 
20 [EHCI])
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe 
motherboard
         Flags: bus master, medium devsel, latency 64, IRQ 185
         Memory at fdc00000 (32-bit, non-prefetchable) [size=256]
         Capabilities: <access denied>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[KT600/K8T800/K8T890 South]
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe 
motherboard
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: <access denied>

00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
         Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe motherboard 
(ADI AD1980 codec [SoundMAX])
         Flags: medium devsel, IRQ 193
         I/O ports at cc00 [size=256]
         Capabilities: <access denied>

00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem 
Controller (rev 80)
         Flags: medium devsel, IRQ 193
         I/O ports at 1000 [disabled] [size=256]
         Capabilities: <access denied>

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
         Flags: fast devsel
         Capabilities: <access denied>

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
         Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
         Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
         Flags: fast devsel

01:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce 7800 
GS] (rev a2) (prog-if 00 [VGA])
         Subsystem: CardExpert Technology Unknown device 0801
         Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 201
         Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
         Memory at c0000000 (32-bit, prefetchable) [size=256M]
         Memory at fb000000 (32-bit, non-prefetchable) [size=16M]
         [virtual] Expansion ROM at fd800000 [disabled] [size=128K]
         Capabilities: <access denied>


[2]
uname -a
Linux petticoatpussy 2.6.18-3-amd64 #1 SMP Mon Dec 4 17:04:37 CET 2006 
x86_64 GNU/Linux


[1]
Bootdata ok (command line is root=/dev/sdb1 ro bootkbd=de )
Linux version 2.6.18-3-amd64 (Debian 2.6.18-7) (waldi@debian.org) (gcc 
version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #1 SMP Mon Dec 4 
17:04:37 CET 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 
0x00000000000fa850
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000517 MSFT 0x00000097) @ 
0x000000003ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x06000517 MSFT 0x00000097) @ 
0x000000003ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000517 MSFT 0x00000097) @ 
0x000000003ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000517 MSFT 0x00000097) @ 
0x000000003ff40040
ACPI: DSDT (v001  A0058 A0058002 0x00000002 MSFT 0x0100000d) @ 
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000003ff30000
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000003ff30000
On node 0 totalpages: 257374
   DMA zone: 3059 pages, LIFO batch:0
   DMA32 zone: 254315 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bff80000)
SMP: Allowing 1 CPUs, 0 hotplug CPUs
Built 1 zonelists.  Total pages: 257374
Kernel command line: root=/dev/sdb1 ro bootkbd=de
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2002.653 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
CPU 0: aperture @ e0000000 size 256 MB
Memory: 1022944k/1047744k available (1929k kernel code, 24412k reserved, 
864k data, 176k init)
Calibrating delay using timer specific routine.. 4009.99 BogoMIPS 
(lpj=8019989)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
SMP alternatives: switching to UP code
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12516600
Detected 12.516 MHz APIC timer.
Brought up 1 CPUs
testing NMI watchdog ... OK.
migration_cost=0
checking if image is initramfs... it is
Freeing initrd memory: 4887k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: enabled onboard AC97/MC97 devices
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0A03
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0F03
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C01
pnp: PnP ACPI: found 11 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 256M @ 0xe0000000
PCI-DMA: Disabling IOMMU.
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:08' and the driver 'system'
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:0a' and the driver 'system'
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: f9700000-fd8fffff
   PREFETCH window: b9600000-d95fffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1167490003.628:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
pnp: the driver 'serial' has been registered
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
usbmon: debugfs is not available
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:03' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:04' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 176k freed
input: AT Translated Set 2 keyboard as /class/input/input0
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 169
skge 1.6 addr 0xfda00000 irq 169 chip Yukon-Lite rev 7
skge eth0: addr 00:0e:a6:70:20:84
SCSI subsystem initialized
libata version 2.00 loaded.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 177
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
USB Universal Host Controller Interface driver v3.0
hda: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
sata_via 0000:00:0f.0: version 2.0
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 177
sata_via 0000:00:0f.0: routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 177
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 177
scsi0 : sata_via
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_via
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-6, max UDMA/100, 241254720 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/100
   Vendor: ATA       Model: WDC WD5000KS-00M  Rev: 07.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: HDS722512VLSA80   Rev: V33O
   Type:   Direct-Access                      ANSI SCSI revision: 05
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 185
PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 9
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 185, io base 0x0000dc00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 241254720 512-byte hdwr sectors (123522 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 241254720 512-byte hdwr sectors (123522 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi disk sdb
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 185
PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 9
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 185, io base 0x0000ec00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 185
PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 9
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 185, io base 0x0000c000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 185
PCI: VIA IRQ fixup for 0000:00:10.3, from 10 to 9
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 185, io base 0x0000c400
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 185
PCI: VIA IRQ fixup for 0000:00:10.4, from 5 to 9
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 185, io mem 0xfdc00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
input: PC Speaker as /class/input/input1
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
PCI: Enabling device 0000:00:11.6 (0000 -> 0001)
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:11.6[C] -> GSI 22 (level, low) -> IRQ 193
input: PS2++ Logitech MX Mouse as /class/input/input2
ts: Compaq touchscreen protocol output
PCI: Setting latency timer of device 0000:00:11.6 to 64
ACPI: PCI interrupt for device 0000:00:11.6 disabled
VIA 82xx Modem: probe of 0000:00:11.6 failed with error -13
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:11.5 to 64
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
Adding 1140604k swap on /dev/sdb3.  Priority:-1 extents:1 across:1140604k
EXT3 FS on sdb1, internal journal
loop: loaded (max 8 devices)
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+ processors 
(version 2.00.00)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x2
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0xa
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
skge eth0: enabling interface
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
skge eth0: Link is up at 100 Mbps, full duplex, flow control tx and rx
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
nvidia: module license 'NVIDIA' taints kernel.
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 201
NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-8774  Tue Aug  1 
21:42:17 PDT 2006
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
ata1: EH complete
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: (BMDMA stat 0x0)
ata1.00: tag 0 cmd 0x25 Emask 0x9 stat 0x51 err 0x40 (media error)
sd 0:0:0:0: SCSI error: return code = 0x08000002
sda: Current: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 976751999
Buffer I/O error on device sda1, logical block 976751936
ata1: EH complete
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
eth0: no IPv6 routers present

