Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758094AbWK0MSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094AbWK0MSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758097AbWK0MSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:18:40 -0500
Received: from fw3.q-free.com ([62.92.116.8]:52241 "HELO fw3.q-free.com")
	by vger.kernel.org with SMTP id S1758094AbWK0MSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:18:38 -0500
From: Oyvind Kristiansen <oyvindk@q-free.com>
Organization: Q-Free
To: linux-kernel@vger.kernel.org
Subject: Bug? Needed to use pci=assign-busses
Date: Mon, 27 Nov 2006 13:18:30 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WetaF/xnNKp+pDf"
Message-Id: <200611271318.30365.oyvindk@q-free.com>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.168.2.22 (failed)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WetaF/xnNKp+pDf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!
I've had to use the kernel parameter pci=3Dassign-busses to enable a Realte=
k=20
ethernet chip.

The chip does not show up in lspci without this kernel option.

Attached are 4 files:
=2Dklog.txt & lspci.txt for the case that pci=3Dassign-busses are enabled
=2Dklog2.txt & lspci2.txt for the case that this option is not enabled

The kernel that is running is 2.6.17-10-generic and the distribution is=20
Kubuntu Edgy without any patches.

Best regards,
=D8yvind Kristiansen

=2D-=20
Oyvind Kristiansen
R&D Engineer
Q-Free ASA

--Boundary-00=_WetaF/xnNKp+pDf
Content-Type: text/plain;
  charset="iso-8859-1";
  name="klog2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="klog2.txt"

[17179569.184000] Linux version 2.6.17-10-generic (root@vernadsky) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #2 SMP Fri Oct 13 18:45:35 UTC 2006 (Ubuntu 2.6.17-10.33-generic)
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[17179569.184000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003dff0000 (usable)
[17179569.184000]  BIOS-e820: 000000003dff0000 - 000000003dff3000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000003dff3000 - 000000003e000000 (ACPI data)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[17179569.184000] 95MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] found SMP MP-table at 000f5100
[17179569.184000] On node 0 totalpages: 253936
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 24560 pages, LIFO batch:3
[17179569.184000] DMI 2.2 present.
[17179569.184000] ACPI: RSDP (v000 IntelR                                ) @ 0x000f8c00
[17179569.184000] ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff3040
[17179569.184000] ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff30c0
[17179569.184000] ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff7380
[17179569.184000] ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x4008
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:13 APIC version 20
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
[17179569.184000] IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 2 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 40000000 (gap: 3e000000:c0c00000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/hda1 ro quiet splash
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] mapped IOAPIC to ffffb000 (fec10000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[17179569.184000] Detected 1400.288 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179570.036000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179570.036000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179570.072000] Memory: 997092k/1015744k available (1910k kernel code, 18036k reserved, 1070k data, 308k init, 98240k highmem)
[17179570.072000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179570.152000] Calibrating delay using timer specific routine.. 2802.64 BogoMIPS (lpj=5605291)
[17179570.152000] Security Framework v1.0.0 initialized
[17179570.152000] SELinux:  Disabled at boot.
[17179570.152000] Mount-cache hash table entries: 512
[17179570.152000] CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[17179570.152000] CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[17179570.152000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179570.152000] CPU: L2 cache: 2048K
[17179570.152000] CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040 00000180 00000000 00000000
[17179570.152000] Checking 'hlt' instruction... OK.
[17179570.168000] SMP alternatives: switching to UP code
[17179570.168000] Freeing SMP alternatives: 16k freed
[17179570.168000] checking if image is initramfs... it is
[17179570.816000] Freeing initrd memory: 5523k freed
[17179570.816000] ACPI: Core revision 20060707
[17179570.820000] ACPI: Looking for DSDT ... not found!
[17179570.892000] CPU0: Intel(R) Pentium(R) M processor 1.40GHz stepping 06
[17179570.892000] Total of 1 processors activated (2802.64 BogoMIPS).
[17179570.892000] ENABLING IO-APIC IRQs
[17179570.892000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179571.036000] Brought up 1 CPUs
[17179571.036000] migration_cost=0
[17179571.036000] NET: Registered protocol family 16
[17179571.036000] EISA bus registered
[17179571.036000] ACPI: bus type pci registered
[17179571.048000] PCI: PCI BIOS revision 2.10 entry at 0xfac00, last bus=2
[17179571.048000] PCI: Using configuration type 1
[17179571.048000] Setting up standard PCI resources
[17179571.064000] ACPI: Interpreter enabled
[17179571.064000] ACPI: Using IOAPIC for interrupt routing
[17179571.064000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179571.064000] PCI: Probing PCI hardware (bus 00)
[17179571.068000] Boot video device is 0000:00:02.0
[17179571.068000] PCI quirk: region 4000-407f claimed by ICH4 ACPI/GPIO/TCO
[17179571.068000] PCI quirk: region 4080-40bf claimed by ICH4 GPIO
[17179571.068000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[17179571.068000] PCI: Bus #02 (-#05) is hidden behind  bridge #01 (-#01) (try 'pci=assign-busses')
[17179571.068000] Please report the result to linux-kernel to fix this permanently
[17179571.068000] PCI: Bus 0000:02 already known
[17179571.068000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179571.080000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[17179571.080000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HRB_._PRT]
[17179571.084000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
[17179571.084000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
[17179571.084000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 *12 14 15)
[17179571.084000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
[17179571.084000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[17179571.084000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[17179571.084000] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[17179571.084000] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[17179571.084000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179571.084000] pnp: PnP ACPI init
[17179571.092000] pnp: PnP ACPI: found 16 devices
[17179571.092000] PnPBIOS: Disabled by ACPI PNP
[17179571.092000] PCI: Using ACPI for IRQ routing
[17179571.092000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179571.112000] pnp: 00:0d: ioport range 0x4000-0x40bf could not be reserved
[17179571.112000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179571.112000] PCI: Failed to allocate mem resource #9:2000000@ea000000 for 0000:01:0c.0
[17179571.112000] PCI: Failed to allocate mem resource #10:2000000@ea000000 for 0000:01:0c.0
[17179571.112000] PCI: Bus 2, cardbus bridge: 0000:01:0c.0
[17179571.112000]   IO window: 0000d400-0000d4ff
[17179571.112000]   IO window: 0000d800-0000d8ff
[17179571.112000] PCI: Bridge: 0000:00:1c.0
[17179571.112000]   IO window: d000-dfff
[17179571.112000]   MEM window: e8000000-e80fffff
[17179571.112000]   PREFETCH window: e8100000-e81fffff
[17179571.112000] ACPI: PCI Interrupt 0000:01:0c.0[A] -> GSI 24 (level, low) -> IRQ 169
[17179571.112000] NET: Registered protocol family 2
[17179571.152000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179571.152000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[17179571.152000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[17179571.152000] TCP: Hash tables configured (established 131072 bind 65536)
[17179571.152000] TCP reno registered
[17179571.152000] audit: initializing netlink socket (disabled)
[17179571.152000] audit(1164632309.152:1): initialized
[17179571.152000] highmem bounce pool size: 64 pages
[17179571.152000] VFS: Disk quotas dquot_6.5.1
[17179571.152000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179571.152000] Initializing Cryptographic API
[17179571.152000] io scheduler noop registered
[17179571.152000] io scheduler anticipatory registered
[17179571.152000] io scheduler deadline registered
[17179571.152000] io scheduler cfq registered (default)
[17179571.152000] isapnp: Scanning for PnP cards...
[17179571.508000] isapnp: No Plug & Play device found
[17179571.532000] Real Time Clock Driver v1.12ac
[17179571.532000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[17179571.532000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[17179571.532000] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[17179571.532000] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[17179571.532000] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[17179571.532000] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[17179571.532000] 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[17179571.532000] 00:0b: ttyS2 at I/O 0x3e8 (irq = 10) is a 16550A
[17179571.532000] 00:0c: ttyS3 at I/O 0x2e8 (irq = 11) is a 16550A
[17179571.532000] mice: PS/2 mouse device common for all mice
[17179571.532000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[17179571.536000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179571.536000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179571.536000] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[17179571.536000] PNP: PS/2 controller doesn't have AUX irq; using default 12
[17179571.548000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179571.548000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.552000] EISA: Probing bus 0 at eisa.0
[17179571.552000] Cannot allocate resource for EISA slot 4
[17179571.552000] Cannot allocate resource for EISA slot 5
[17179571.552000] EISA: Detected 0 cards.
[17179571.552000] TCP bic registered
[17179571.552000] NET: Registered protocol family 1
[17179571.552000] NET: Registered protocol family 8
[17179571.552000] NET: Registered protocol family 20
[17179571.552000] Using IPI No-Shortcut mode
[17179571.552000] ACPI: (supports S0 S1 S4 S5)
[17179571.552000] Freeing unused kernel memory: 308k freed
[17179571.780000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179572.688000] Capability LSM initialized
[17179572.720000] ACPI: Fan [FAN] (on)
[17179572.720000] ACPI: Processor [CPU0] (supports 2 throttling states)
[17179572.724000] ACPI: Thermal Zone [THRM] (47 C)
[17179573.056000] ICH5: IDE controller at PCI slot 0000:00:1f.1
[17179573.056000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
[17179573.056000] ICH5: chipset revision 2
[17179573.056000] ICH5: not 100% native mode: will probe irqs later
[17179573.056000]     ide0: BM-DMA at 0xf300-0xf307, BIOS settings: hda:pio, hdb:pio
[17179573.056000]     ide1: BM-DMA at 0xf308-0xf30f, BIOS settings: hdc:pio, hdd:pio
[17179573.056000] Probing IDE interface ide0...
[17179573.348000] hda: ST940814AM, ATA DISK drive
[17179574.024000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[17179574.088000] Probing IDE interface ide1...
[17179574.672000] hda: max request size: 512KiB
[17179574.672000] hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(33)
[17179574.672000] hda: cache flushes supported
[17179574.672000]  hda: hda1 hda2 < hda5 >
[17179574.928000] SCSI subsystem initialized
[17179574.932000] libata version 1.20 loaded.
[17179574.932000] ata_piix 0000:00:1f.2: version 1.05
[17179574.932000] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
[17179574.932000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[17179574.932000] ata1: SATA max UDMA/133 cmd 0xF400 ctl 0xF502 bmdma 0xF800 irq 177
[17179574.932000] ata2: SATA max UDMA/133 cmd 0xF600 ctl 0xF702 bmdma 0xF808 irq 177
[17179575.100000] scsi0 : ata_piix
[17179575.268000] scsi1 : ata_piix
[17179575.312000] Probing IDE interface ide1...
[17179575.348000] usbcore: registered new driver usbfs
[17179575.348000] usbcore: registered new driver hub
[17179575.352000] USB Universal Host Controller Interface driver v3.0
[17179575.352000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 185
[17179575.352000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179575.352000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179575.352000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179575.352000] uhci_hcd 0000:00:1d.0: irq 185, io base 0x0000f000
[17179575.356000] usb usb1: configuration #1 chosen from 1 choice
[17179575.356000] hub 1-0:1.0: USB hub found
[17179575.356000] hub 1-0:1.0: 2 ports detected
[17179575.416000] ieee1394: Initialized config rom entry `ip1394'
[17179575.464000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
[17179575.464000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179575.464000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179575.464000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179575.464000] uhci_hcd 0000:00:1d.1: irq 193, io base 0x0000f100
[17179575.464000] usb usb2: configuration #1 chosen from 1 choice
[17179575.464000] hub 2-0:1.0: USB hub found
[17179575.464000] hub 2-0:1.0: 2 ports detected
[17179575.572000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
[17179575.572000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179575.572000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179575.572000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
[17179575.572000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179575.572000] ehci_hcd 0000:00:1d.7: irq 201, io mem 0xe8501000
[17179575.576000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179575.576000] usb usb3: configuration #1 chosen from 1 choice
[17179575.576000] hub 3-0:1.0: USB hub found
[17179575.576000] hub 3-0:1.0: 4 ports detected
[17179575.684000] ACPI: PCI Interrupt 0000:01:0d.0[A] -> GSI 25 (level, low) -> IRQ 209
[17179575.684000] PCI: Via IRQ fixup for 0000:01:0d.0, from 9 to 1
[17179575.736000] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[209]  MMIO=[e8000000-e80007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[17179575.980000] Attempting manual resume
[17179576.080000] kjournald starting.  Commit interval 5 seconds
[17179576.080000] EXT3-fs: mounted filesystem with ordered data mode.
[17179576.140000] usb 3-3: new high speed USB device using ehci_hcd and address 2
[17179576.288000] usb 3-3: configuration #1 chosen from 1 choice
[17179576.820000] usb 2-2: new low speed USB device using uhci_hcd and address 2
[17179577.004000] usb 2-2: configuration #1 chosen from 1 choice
[17179577.024000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[20000000030008cf]
[17179587.736000] FDC 0 is a post-1991 82077
[17179587.760000] input: PC Speaker as /class/input/input1
[17179587.764000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179587.772000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179588.072000] Linux agpgart interface v0.101 (c) Dave Jones
[17179588.076000] agpgart: Detected an Intel 855 Chipset.
[17179588.076000] agpgart: Detected 32636K stolen memory.
[17179588.084000] agpgart: AGP aperture is 128M @ 0xd8000000
[17179588.112000] hw_random: RNG not detected
[17179588.228000] parport: PnPBIOS parport detected.
[17179588.228000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[17179588.364000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 217
[17179588.364000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[17179588.684000] intel8x0_measure_ac97_clock: measured 4294373566 usecs
[17179588.684000] intel8x0: measured clock 0 rejected
[17179588.684000] intel8x0: clocking to 48000
[17179588.708000] ACPI: PCI Interrupt 0000:01:0c.0[A] -> GSI 24 (level, low) -> IRQ 169
[17179588.708000] Yenta: CardBus bridge found at 0000:01:0c.0 [0000:0000]
[17179588.708000] PCI: Bus 2, cardbus bridge: 0000:01:0c.0
[17179588.708000]   IO window: 0000d400-0000d4ff
[17179588.708000]   IO window: 0000d800-0000d8ff
[17179588.708000]   PREFETCH window: e8100000-e811ffff
[17179588.708000]   MEM window: e8020000-e803ffff
[17179588.780000] usbcore: registered new driver hiddev
[17179588.796000] input: Logitech Optical USB Mouse as /class/input/input2
[17179588.796000] input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.1-2
[17179588.796000] usbcore: registered new driver usbhid
[17179588.796000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[17179588.828000] usbcore: registered new driver libusual
[17179588.848000] Yenta: ISA IRQ mask 0x0000, PCI irq 169
[17179588.848000] Socket status: 30000006
[17179588.848000] Yenta: Raising subordinate bus# of parent bus (#01) from #01 to #05
[17179588.848000] pcmcia: parent PCI bridge I/O window: 0xd000 - 0xdfff
[17179588.848000] cs: IO port probe 0xd000-0xdfff: clean.
[17179588.848000] pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xe80fffff
[17179588.848000] pcmcia: parent PCI bridge Memory window: 0xe8100000 - 0xe81fffff
[17179588.904000] Initializing USB Mass Storage driver...
[17179588.928000] scsi2 : SCSI emulation for USB Mass Storage devices
[17179588.928000] usbcore: registered new driver usb-storage
[17179588.928000] USB Mass Storage support registered.
[17179588.928000] usb-storage: device found at 2
[17179588.928000] usb-storage: waiting for device to settle before scanning
[17179588.944000] ts: Compaq touchscreen protocol output
[17179589.240000] cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x290-0x297 0x370-0x37f
[17179589.240000] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[17179589.240000] cs: IO port probe 0x820-0x8ff: clean.
[17179589.244000] cs: IO port probe 0xc00-0xcf7: clean.
[17179589.244000] cs: IO port probe 0xa00-0xaff: clean.
[17179589.344000] lp0: using parport0 (interrupt-driven).
[17179589.372000] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[17179589.372000] ieee1394: sbp2: Try serialize_io=0 for better performance
[17179589.392000] Adding 1622524k swap on /dev/disk/by-uuid/ef1fee3b-ccfc-468f-b6e5-95a75ede08e7.  Priority:-1 extents:1 across:1622524k
[17179589.452000] EXT3 FS on hda1, internal journal
[17179590.932000] NET: Registered protocol family 17
[17179593.928000] usb-storage: device scan complete
[17179593.932000]   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.02
[17179593.932000]   Type:   CD-ROM                             ANSI SCSI revision: 00
[17179594.052000] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
[17179594.052000] Uniform CD-ROM driver Revision: 3.20
[17179594.052000] sr 2:0:0:0: Attached scsi CD-ROM sr0
[17179594.068000] sr 2:0:0:0: Attached scsi generic sg0 type 5
[17179596.540000] ACPI: Power Button (FF) [PWRF]
[17179596.540000] ACPI: Power Button (CM) [PWRB]
[17179596.696000] ibm_acpi: ec object not found
[17179596.732000] pcc_acpi: loading...
[17179599.296000] [drm] Initialized drm 1.0.1 20051102
[17179599.296000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 185
[17179599.300000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[17179599.300000] PCI: Enabling device 0000:00:02.1 (0000 -> 0002)
[17179599.300000] [drm] Initialized i915 1.5.0 20060119 on minor 1
[17179600.268000] apm: BIOS not found.
[17179605.160000] Bluetooth: Core ver 2.8
[17179605.160000] NET: Registered protocol family 31
[17179605.160000] Bluetooth: HCI device and connection manager initialized
[17179605.160000] Bluetooth: HCI socket layer initialized
[17179605.484000] Bluetooth: L2CAP ver 2.8
[17179605.484000] Bluetooth: L2CAP socket layer initialized
[17179605.656000] Bluetooth: RFCOMM socket layer initialized
[17179605.656000] Bluetooth: RFCOMM TTY layer initialized
[17179605.656000] Bluetooth: RFCOMM ver 1.7

--Boundary-00=_WetaF/xnNKp+pDf
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02)
00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02)
00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a)
00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 6300ESB SATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 6300ESB AC'97 Audio Controller (rev 02)
01:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
01:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
06:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

--Boundary-00=_WetaF/xnNKp+pDf
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci2.txt"

00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV Processor to I/O Controller (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
00:02.1 Display controller: Intel Corporation 82852/855GM Integrated Graphics Device (rev 02)
00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02)
00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host Controller (rev 02)
00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable Interrupt Controller (rev 02)
00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a)
00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 6300ESB SATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 6300ESB AC'97 Audio Controller (rev 02)
01:0c.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 81)
01:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)

--Boundary-00=_WetaF/xnNKp+pDf
Content-Type: text/plain;
  charset="iso-8859-1";
  name="klog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="klog.txt"

[17179569.184000] Linux version 2.6.17-10-generic (root@vernadsky) (gcc version 4.1.2 20060928 (prerelease) (Ubuntu 4.1.1-13ubuntu5)) #2 SMP Fri Oct 13 18:45:35 UTC 2006 (Ubuntu 2.6.17-10.33-generic)
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[17179569.184000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003dff0000 (usable)
[17179569.184000]  BIOS-e820: 000000003dff0000 - 000000003dff3000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000003dff3000 - 000000003e000000 (ACPI data)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[17179569.184000] 95MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] found SMP MP-table at 000f5100
[17179569.184000] On node 0 totalpages: 253936
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 24560 pages, LIFO batch:3
[17179569.184000] DMI 2.2 present.
[17179569.184000] ACPI: RSDP (v000 IntelR                                ) @ 0x000f8c00
[17179569.184000] ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff3040
[17179569.184000] ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff30c0
[17179569.184000] ACPI: MADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3dff7380
[17179569.184000] ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x4008
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:13 APIC version 20
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
[17179569.184000] IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 2 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 40000000 (gap: 3e000000:c0c00000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/hda1 ro quiet splash pci=assign-busses
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] mapped IOAPIC to ffffb000 (fec10000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[17179569.184000] Detected 1400.294 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179571.760000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179571.760000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179571.796000] Memory: 997092k/1015744k available (1910k kernel code, 18036k reserved, 1070k data, 308k init, 98240k highmem)
[17179571.796000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179571.876000] Calibrating delay using timer specific routine.. 2802.64 BogoMIPS (lpj=5605282)
[17179571.876000] Security Framework v1.0.0 initialized
[17179571.876000] SELinux:  Disabled at boot.
[17179571.876000] Mount-cache hash table entries: 512
[17179571.876000] CPU: After generic identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[17179571.876000] CPU: After vendor identify, caps: afe9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
[17179571.876000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179571.876000] CPU: L2 cache: 2048K
[17179571.876000] CPU: After all inits, caps: afe9fbbf 00000000 00000000 00000040 00000180 00000000 00000000
[17179571.876000] Checking 'hlt' instruction... OK.
[17179571.892000] SMP alternatives: switching to UP code
[17179571.892000] Freeing SMP alternatives: 16k freed
[17179571.892000] checking if image is initramfs... it is
[17179572.540000] Freeing initrd memory: 5523k freed
[17179572.540000] ACPI: Core revision 20060707
[17179572.544000] ACPI: Looking for DSDT ... not found!
[17179572.616000] CPU0: Intel(R) Pentium(R) M processor 1.40GHz stepping 06
[17179572.616000] Total of 1 processors activated (2802.64 BogoMIPS).
[17179572.616000] ENABLING IO-APIC IRQs
[17179572.616000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179572.760000] Brought up 1 CPUs
[17179572.760000] migration_cost=0
[17179572.760000] NET: Registered protocol family 16
[17179572.760000] EISA bus registered
[17179572.760000] ACPI: bus type pci registered
[17179572.772000] PCI: PCI BIOS revision 2.10 entry at 0xfac00, last bus=2
[17179572.772000] PCI: Using configuration type 1
[17179572.772000] Setting up standard PCI resources
[17179572.788000] ACPI: Interpreter enabled
[17179572.788000] ACPI: Using IOAPIC for interrupt routing
[17179572.788000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[17179572.788000] PCI: Probing PCI hardware (bus 00)
[17179572.792000] Boot video device is 0000:00:02.0
[17179572.792000] PCI quirk: region 4000-407f claimed by ICH4 ACPI/GPIO/TCO
[17179572.792000] PCI quirk: region 4080-40bf claimed by ICH4 GPIO
[17179572.792000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[17179572.792000] PCI: Transparent bridge - 0000:00:1e.0
[17179572.792000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179572.804000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[17179572.804000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HRB_._PRT]
[17179572.808000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *9 10 11 12 14 15)
[17179572.808000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 *12 14 15)
[17179572.808000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 11 *12 14 15)
[17179572.808000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12 14 15)
[17179572.808000] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[17179572.808000] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[17179572.808000] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[17179572.808000] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[17179572.808000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179572.808000] pnp: PnP ACPI init
[17179572.816000] pnp: PnP ACPI: found 16 devices
[17179572.816000] PnPBIOS: Disabled by ACPI PNP
[17179572.816000] PCI: Using ACPI for IRQ routing
[17179572.816000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179572.840000] PCI: Device 0000:06:06.0 not found by BIOS
[17179572.840000] pnp: 00:0d: ioport range 0x4000-0x40bf could not be reserved
[17179572.840000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179572.840000] PCI: Failed to allocate mem resource #9:2000000@ea000000 for 0000:01:0c.0
[17179572.840000] PCI: Failed to allocate mem resource #10:2000000@ea000000 for 0000:01:0c.0
[17179572.840000] PCI: Bus 2, cardbus bridge: 0000:01:0c.0
[17179572.840000]   IO window: 0000d400-0000d4ff
[17179572.840000]   IO window: 0000d800-0000d8ff
[17179572.840000] PCI: Bridge: 0000:00:1c.0
[17179572.840000]   IO window: d000-dfff
[17179572.840000]   MEM window: e8000000-e80fffff
[17179572.840000]   PREFETCH window: e8100000-e81fffff
[17179572.840000] PCI: Bridge: 0000:00:1e.0
[17179572.840000]   IO window: e000-efff
[17179572.840000]   MEM window: e8200000-e82fffff
[17179572.840000]   PREFETCH window: e8300000-e83fffff
[17179572.840000] ACPI: PCI Interrupt 0000:01:0c.0[A] -> GSI 24 (level, low) -> IRQ 169
[17179572.840000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179572.840000] NET: Registered protocol family 2
[17179572.880000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179572.880000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[17179572.880000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[17179572.880000] TCP: Hash tables configured (established 131072 bind 65536)
[17179572.880000] TCP reno registered
[17179572.880000] audit: initializing netlink socket (disabled)
[17179572.880000] audit(1164630991.880:1): initialized
[17179572.880000] highmem bounce pool size: 64 pages
[17179572.880000] VFS: Disk quotas dquot_6.5.1
[17179572.880000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179572.880000] Initializing Cryptographic API
[17179572.880000] io scheduler noop registered
[17179572.880000] io scheduler anticipatory registered
[17179572.880000] io scheduler deadline registered
[17179572.880000] io scheduler cfq registered (default)
[17179572.880000] isapnp: Scanning for PnP cards...
[17179573.236000] isapnp: No Plug & Play device found
[17179573.260000] Real Time Clock Driver v1.12ac
[17179573.260000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[17179573.260000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[17179573.260000] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[17179573.260000] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[17179573.260000] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[17179573.260000] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[17179573.260000] 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[17179573.260000] 00:0b: ttyS2 at I/O 0x3e8 (irq = 10) is a 16550A
[17179573.260000] 00:0c: ttyS3 at I/O 0x2e8 (irq = 11) is a 16550A
[17179573.260000] mice: PS/2 mouse device common for all mice
[17179573.260000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[17179573.260000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179573.260000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179573.260000] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[17179573.260000] PNP: PS/2 controller doesn't have AUX irq; using default 12
[17179573.276000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179573.276000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179573.280000] EISA: Probing bus 0 at eisa.0
[17179573.280000] Cannot allocate resource for EISA slot 4
[17179573.280000] Cannot allocate resource for EISA slot 5
[17179573.280000] EISA: Detected 0 cards.
[17179573.280000] TCP bic registered
[17179573.280000] NET: Registered protocol family 1
[17179573.280000] NET: Registered protocol family 8
[17179573.280000] NET: Registered protocol family 20
[17179573.280000] Using IPI No-Shortcut mode
[17179573.280000] ACPI: (supports S0 S1 S4 S5)
[17179573.280000] Freeing unused kernel memory: 308k freed
[17179573.520000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179574.416000] Capability LSM initialized
[17179574.448000] ACPI: Fan [FAN] (on)
[17179574.452000] ACPI: Processor [CPU0] (supports 2 throttling states)
[17179574.452000] ACPI: Thermal Zone [THRM] (47 C)
[17179574.788000] ICH5: IDE controller at PCI slot 0000:00:1f.1
[17179574.788000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
[17179574.788000] ICH5: chipset revision 2
[17179574.788000] ICH5: not 100% native mode: will probe irqs later
[17179574.788000]     ide0: BM-DMA at 0xf300-0xf307, BIOS settings: hda:pio, hdb:pio
[17179574.788000]     ide1: BM-DMA at 0xf308-0xf30f, BIOS settings: hdc:pio, hdd:pio
[17179574.788000] Probing IDE interface ide0...
[17179575.080000] hda: ST940814AM, ATA DISK drive
[17179575.756000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[17179575.828000] Probing IDE interface ide1...
[17179576.404000] hda: max request size: 512KiB
[17179576.404000] hda: 78140160 sectors (40007 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(33)
[17179576.404000] hda: cache flushes supported
[17179576.404000]  hda: hda1 hda2 < hda5 >
[17179576.660000] SCSI subsystem initialized
[17179576.664000] libata version 1.20 loaded.
[17179576.664000] ata_piix 0000:00:1f.2: version 1.05
[17179576.664000] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
[17179576.664000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[17179576.664000] ata1: SATA max UDMA/133 cmd 0xF400 ctl 0xF502 bmdma 0xF800 irq 177
[17179576.664000] ata2: SATA max UDMA/133 cmd 0xF600 ctl 0xF702 bmdma 0xF808 irq 177
[17179576.832000] scsi0 : ata_piix
[17179577.000000] scsi1 : ata_piix
[17179577.044000] Probing IDE interface ide1...
[17179577.080000] usbcore: registered new driver usbfs
[17179577.080000] usbcore: registered new driver hub
[17179577.084000] USB Universal Host Controller Interface driver v3.0
[17179577.084000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 185
[17179577.084000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179577.084000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179577.084000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[17179577.084000] uhci_hcd 0000:00:1d.0: irq 185, io base 0x0000f000
[17179577.088000] usb usb1: configuration #1 chosen from 1 choice
[17179577.088000] hub 1-0:1.0: USB hub found
[17179577.088000] hub 1-0:1.0: 2 ports detected
[17179577.148000] ieee1394: Initialized config rom entry `ip1394'
[17179577.196000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
[17179577.196000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179577.196000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179577.196000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[17179577.196000] uhci_hcd 0000:00:1d.1: irq 193, io base 0x0000f100
[17179577.196000] usb usb2: configuration #1 chosen from 1 choice
[17179577.196000] hub 2-0:1.0: USB hub found
[17179577.196000] hub 2-0:1.0: 2 ports detected
[17179577.304000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 201
[17179577.304000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179577.304000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179577.304000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 3
[17179577.304000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179577.304000] ehci_hcd 0000:00:1d.7: irq 201, io mem 0xe8501000
[17179577.308000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179577.308000] usb usb3: configuration #1 chosen from 1 choice
[17179577.308000] hub 3-0:1.0: USB hub found
[17179577.308000] hub 3-0:1.0: 4 ports detected
[17179577.416000] ACPI: PCI Interrupt 0000:01:0d.0[A] -> GSI 25 (level, low) -> IRQ 209
[17179577.416000] PCI: Via IRQ fixup for 0000:01:0d.0, from 9 to 1
[17179577.468000] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[209]  MMIO=[e8000000-e80007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[17179577.800000] Attempting manual resume
[17179577.868000] usb 3-3: new high speed USB device using ehci_hcd and address 2
[17179577.884000] kjournald starting.  Commit interval 5 seconds
[17179577.884000] EXT3-fs: mounted filesystem with ordered data mode.
[17179578.016000] usb 3-3: configuration #1 chosen from 1 choice
[17179578.552000] usb 2-2: new low speed USB device using uhci_hcd and address 2
[17179578.736000] usb 2-2: configuration #1 chosen from 1 choice
[17179578.756000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[20000000030008cf]
[17179589.168000] Linux agpgart interface v0.101 (c) Dave Jones
[17179589.196000] agpgart: Detected an Intel 855 Chipset.
[17179589.196000] agpgart: Detected 32636K stolen memory.
[17179589.216000] input: PC Speaker as /class/input/input1
[17179589.312000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179589.416000] agpgart: AGP aperture is 128M @ 0xd8000000
[17179589.416000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179589.548000] FDC 0 is a post-1991 82077
[17179589.556000] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 217
[17179589.556000] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[17179589.608000] hw_random: RNG not detected
[17179589.632000] parport: PnPBIOS parport detected.
[17179589.632000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[17179589.876000] intel8x0_measure_ac97_clock: measured 59234 usecs
[17179589.876000] intel8x0: clocking to 48000
[17179590.280000] ACPI: PCI Interrupt 0000:01:0c.0[A] -> GSI 24 (level, low) -> IRQ 169
[17179590.280000] Yenta: CardBus bridge found at 0000:01:0c.0 [0000:0000]
[17179590.280000] PCI: Bus 2, cardbus bridge: 0000:01:0c.0
[17179590.280000]   IO window: 0000d400-0000d4ff
[17179590.280000]   IO window: 0000d800-0000d8ff
[17179590.280000]   PREFETCH window: e8100000-e811ffff
[17179590.280000]   MEM window: e8020000-e803ffff
[17179590.428000] Yenta: ISA IRQ mask 0x0000, PCI irq 169
[17179590.428000] Socket status: 30000006
[17179590.428000] pcmcia: parent PCI bridge I/O window: 0xd000 - 0xdfff
[17179590.428000] cs: IO port probe 0xd000-0xdfff: clean.
[17179590.428000] pcmcia: parent PCI bridge Memory window: 0xe8000000 - 0xe80fffff
[17179590.428000] pcmcia: parent PCI bridge Memory window: 0xe8100000 - 0xe81fffff
[17179590.524000] usbcore: registered new driver libusual
[17179590.528000] usbcore: registered new driver hiddev
[17179590.556000] 8139too Fast Ethernet driver 0.9.27
[17179590.556000] ACPI: PCI Interrupt 0000:06:06.0[A] -> GSI 22 (level, low) -> IRQ 225
[17179590.556000] eth0: RealTek RTL8139 at 0xf8ac4000, 00:60:e0:e1:12:f9, IRQ 225
[17179590.556000] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[17179590.576000] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[17179590.584000] input: Logitech Optical USB Mouse as /class/input/input2
[17179590.584000] input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:1d.1-2
[17179590.584000] usbcore: registered new driver usbhid
[17179590.584000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[17179590.644000] Initializing USB Mass Storage driver...
[17179590.656000] scsi2 : SCSI emulation for USB Mass Storage devices
[17179590.656000] usbcore: registered new driver usb-storage
[17179590.656000] USB Mass Storage support registered.
[17179590.656000] usb-storage: device found at 2
[17179590.656000] usb-storage: waiting for device to settle before scanning
[17179590.672000] ts: Compaq touchscreen protocol output
[17179590.712000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[17179591.076000] cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x290-0x297 0x370-0x37f
[17179591.076000] cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
[17179591.080000] cs: IO port probe 0x820-0x8ff: clean.
[17179591.080000] cs: IO port probe 0xc00-0xcf7: clean.
[17179591.080000] cs: IO port probe 0xa00-0xaff: clean.
[17179591.192000] lp0: using parport0 (interrupt-driven).
[17179591.220000] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[17179591.220000] ieee1394: sbp2: Try serialize_io=0 for better performance
[17179591.240000] Adding 1622524k swap on /dev/disk/by-uuid/ef1fee3b-ccfc-468f-b6e5-95a75ede08e7.  Priority:-1 extents:1 across:1622524k
[17179591.300000] EXT3 FS on hda1, internal journal
[17179591.816000] NET: Registered protocol family 17
[17179595.500000] NET: Registered protocol family 10
[17179595.500000] lo: Disabled Privacy Extensions
[17179595.500000] IPv6 over IPv4 tunneling driver
[17179595.656000] usb-storage: device scan complete
[17179595.660000]   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.02
[17179595.660000]   Type:   CD-ROM                             ANSI SCSI revision: 00
[17179595.700000] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
[17179595.700000] Uniform CD-ROM driver Revision: 3.20
[17179595.700000] sr 2:0:0:0: Attached scsi CD-ROM sr0
[17179595.716000] sr 2:0:0:0: Attached scsi generic sg0 type 5
[17179597.112000] ACPI: Power Button (FF) [PWRF]
[17179597.112000] ACPI: Power Button (CM) [PWRB]
[17179597.264000] ibm_acpi: ec object not found
[17179597.296000] pcc_acpi: loading...
[17179599.704000] [drm] Initialized drm 1.0.1 20051102
[17179599.708000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 185
[17179599.708000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[17179599.708000] PCI: Enabling device 0000:00:02.1 (0000 -> 0002)
[17179599.708000] [drm] Initialized i915 1.5.0 20060119 on minor 1
[17179600.492000] apm: BIOS not found.
[17179605.560000] Bluetooth: Core ver 2.8
[17179605.560000] NET: Registered protocol family 31
[17179605.560000] Bluetooth: HCI device and connection manager initialized
[17179605.560000] Bluetooth: HCI socket layer initialized
[17179605.620000] eth0: no IPv6 routers present
[17179605.816000] Bluetooth: L2CAP ver 2.8
[17179605.816000] Bluetooth: L2CAP socket layer initialized
[17179605.900000] Bluetooth: RFCOMM socket layer initialized
[17179605.900000] Bluetooth: RFCOMM TTY layer initialized
[17179605.900000] Bluetooth: RFCOMM ver 1.7

--Boundary-00=_WetaF/xnNKp+pDf--
