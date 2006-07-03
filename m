Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWGCLmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWGCLmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWGCLmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:42:19 -0400
Received: from tornado.reub.net ([202.89.145.182]:12188 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751132AbWGCLmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:42:18 -0400
Message-ID: <44A90276.4050108@reub.net>
Date: Mon, 03 Jul 2006 23:41:42 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060701)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, greg@kroah.com, brice@myri.com
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<44A8F8D2.1030101@reub.net> <20060703043954.0807c3f2.akpm@osdl.org>
In-Reply-To: <20060703043954.0807c3f2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/07/2006 11:39 p.m., Andrew Morton wrote:
> On Mon, 03 Jul 2006 23:00:34 +1200
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>> Allocate Port Service[0000:00:1c.0:pcie0]
>> Allocate Port Service[0000:00:1c.0:pcie0]
> 
> Could we have the full dmesg please?

Sure:

Bootdata ok (command line is ro root=/dev/md0 panic=60 console=ttyS0,57600)
Linux version 2.6.17-mm6 (root@tornado.reub.net) (gcc version 4.1.1 20060629 
(Red Hat 4.1.1-6)) #1 SMP Mon Jul 3 22:47:46 NZST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003f670000 (usable)
  BIOS-e820: 000000003f670000 - 000000003f6e9000 (ACPI NVS)
  BIOS-e820: 000000003f6e9000 - 000000003f6ec000 (usable)
  BIOS-e820: 000000003f6ec000 - 000000003f6ff000 (ACPI data)
  BIOS-e820: 000000003f6ff000 - 000000003f700000 (usable)
DMI 2.3 present.
ACPI: RSDP (v000 INTEL                                 ) @ 0x00000000000fe020
ACPI: RSDT (v001 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x000000003f6fde48
ACPI: FADT (v001 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x000000003f6fcf10
ACPI: MADT (v001 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x000000003f6fce10
ACPI: WDDT (v001 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x000000003f6f6f90
ACPI: MCFG (v001 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x000000003f6f6f10
ACPI: ASF! (v032 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x000000003f6fcd10
ACPI: HPET (v001 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x000000003f6f6e90
ACPI: SSDT (v001 INTEL     CpuPm 0x00000f5a MSFT 0x01000013) @ 0x000000003f6fdc10
ACPI: SSDT (v001 INTEL   Cpu0Ist 0x00000f5a MSFT 0x01000013) @ 0x000000003f6fda10
ACPI: SSDT (v001 INTEL   Cpu1Ist 0x00000f5a MSFT 0x01000013) @ 0x000000003f6fd810
ACPI: SSDT (v001 INTEL   Cpu2Ist 0x00000f5a MSFT 0x01000013) @ 0x000000003f6fd610
ACPI: SSDT (v001 INTEL   Cpu3Ist 0x00000f5a MSFT 0x01000013) @ 0x000000003f6fd410
ACPI: TCPA (v001 INTEL  TIANO    0x00000002 MSFT 0x01000013) @ 0x000000003f670010
ACPI: DSDT (v001 INTEL  D945GNT  0x00000f5a MSFT 0x01000013) @ 0x0000000000000000
On node 0 totalpages: 254541
   DMA zone: 2433 pages, LIFO batch:0
   DMA32 zone: 252108 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f700000:c0900000)
Built 1 zonelists.  Total pages: 254541
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1015020k/1039360k available (2582k kernel code, 22812k reserved, 1666k 
data, 216k init)
Calibrating delay using timer specific routine.. 6006.43 BogoMIPS (lpj=12012875)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
Freeing SMP alternatives: 28k freed
ACPI: Core revision 20060623
Using local APIC timer interrupts.
result 12500448
Detected 12.500 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.21 BogoMIPS (lpj=12000420)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
               Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3000.123 MHz processor.
migration_cost=5
checking if image is initramfs... it is
Freeing initrd memory: 877k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-GART: No AMD northbridge found.
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
   IO window: 2000-2fff
   MEM window: 48000000-480fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: 1000-1fff
   MEM window: disabled.
   PREFETCH window: disabled.
Device `[PEX0]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.0[A] -> 
GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
Device `[PEX2]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.2[C] -> 
GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
Device `[PEX3]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.3[D] -> 
GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
Device `[PEX4]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.4[A] -> 
GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
Device `[PEX5]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1c.5[B] -> 
GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1151924044.008:1): initialized
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie0]
Allocate Port Service[0000:00:1c.0:pcie0]
kobject_add failed for 0000:00:1c.0:pcie0 with -EEXIST, don't try to register 
things with the same name in the same directory.

Call Trace:
  [<ffffffff80358298>] kobject_put+0x19/0x21
  [<ffffffff80358741>] kobject_add+0x181/0x1ac
  [<ffffffff803aa378>] device_add+0x88/0x4b9
  [<ffffffff803aa7c2>] device_register+0x19/0x27
  [<ffffffff80363e90>] pcie_port_device_register+0x3a0/0x3de
  [<ffffffff8042fa10>] pcibios_set_master+0x7f/0x86
  [<ffffffff80364004>] pcie_portdrv_probe+0x64/0x80
  [<ffffffff803612ac>] pci_device_probe+0x4d/0x78
  [<ffffffff803ac08f>] driver_probe_device+0x5c/0xb4
  [<ffffffff803ac1c9>] __driver_attach+0x67/0xb9
  [<ffffffff803ac162>] __driver_attach+0x0/0xb9
  [<ffffffff803aba4f>] bus_for_each_dev+0x4f/0x79
  [<ffffffff803abfbc>] driver_attach+0x1c/0x1e
  [<ffffffff803ab61a>] bus_add_driver+0x7a/0x143
  [<ffffffff803ac463>] driver_register+0x9f/0xa6
  [<ffffffff80361497>] __pci_register_driver+0x59/0x7e
  [<ffffffff806b7a57>] pcie_portdrv_init+0x1c/0x30
  [<ffffffff80267f3e>] init+0x14e/0x2d0
  [<ffffffff80260a12>] child_rip+0x8/0x12
  [<ffffffff80267df0>] init+0x0/0x2d0
  [<ffffffff80260a0a>] child_rip+0x0/0x12

PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie0]
Allocate Port Service[0000:00:1c.2:pcie0]
kobject_add failed for 0000:00:1c.2:pcie0 with -EEXIST, don't try to register 
things with the same name in the same directory.

Call Trace:
  [<ffffffff80358298>] kobject_put+0x19/0x21
  [<ffffffff80358741>] kobject_add+0x181/0x1ac
  [<ffffffff803aa378>] device_add+0x88/0x4b9
  [<ffffffff803aa7c2>] device_register+0x19/0x27
  [<ffffffff80363e90>] pcie_port_device_register+0x3a0/0x3de
  [<ffffffff8042fa10>] pcibios_set_master+0x7f/0x86
  [<ffffffff80364004>] pcie_portdrv_probe+0x64/0x80
  [<ffffffff803612ac>] pci_device_probe+0x4d/0x78
  [<ffffffff803ac08f>] driver_probe_device+0x5c/0xb4
  [<ffffffff803ac1c9>] __driver_attach+0x67/0xb9
  [<ffffffff803ac162>] __driver_attach+0x0/0xb9
  [<ffffffff803aba4f>] bus_for_each_dev+0x4f/0x79
  [<ffffffff803abfbc>] driver_attach+0x1c/0x1e
  [<ffffffff803ab61a>] bus_add_driver+0x7a/0x143
  [<ffffffff803ac463>] driver_register+0x9f/0xa6
  [<ffffffff80361497>] __pci_register_driver+0x59/0x7e
  [<ffffffff806b7a57>] pcie_portdrv_init+0x1c/0x30
  [<ffffffff80267f3e>] init+0x14e/0x2d0
  [<ffffffff80260a12>] child_rip+0x8/0x12
  [<ffffffff80267df0>] init+0x0/0x2d0
  [<ffffffff80260a0a>] child_rip+0x0/0x12

PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie0]
Allocate Port Service[0000:00:1c.3:pcie0]
kobject_add failed for 0000:00:1c.3:pcie0 with -EEXIST, don't try to register 
things with the same name in the same directory.

Call Trace:
  [<ffffffff80358298>] kobject_put+0x19/0x21
  [<ffffffff80358741>] kobject_add+0x181/0x1ac
  [<ffffffff803aa378>] device_add+0x88/0x4b9
  [<ffffffff803aa7c2>] device_register+0x19/0x27
  [<ffffffff80363e90>] pcie_port_device_register+0x3a0/0x3de
  [<ffffffff8042fa10>] pcibios_set_master+0x7f/0x86
  [<ffffffff80364004>] pcie_portdrv_probe+0x64/0x80
  [<ffffffff803612ac>] pci_device_probe+0x4d/0x78
  [<ffffffff803ac08f>] driver_probe_device+0x5c/0xb4
  [<ffffffff803ac1c9>] __driver_attach+0x67/0xb9
  [<ffffffff803ac162>] __driver_attach+0x0/0xb9
  [<ffffffff803aba4f>] bus_for_each_dev+0x4f/0x79
  [<ffffffff803abfbc>] driver_attach+0x1c/0x1e
  [<ffffffff803ab61a>] bus_add_driver+0x7a/0x143
  [<ffffffff803ac463>] driver_register+0x9f/0xa6
  [<ffffffff80361497>] __pci_register_driver+0x59/0x7e
  [<ffffffff806b7a57>] pcie_portdrv_init+0x1c/0x30
  [<ffffffff80267f3e>] init+0x14e/0x2d0
  [<ffffffff80260a12>] child_rip+0x8/0x12
  [<ffffffff80267df0>] init+0x0/0x2d0
  [<ffffffff80260a0a>] child_rip+0x0/0x12

PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie0]
Allocate Port Service[0000:00:1c.4:pcie0]
kobject_add failed for 0000:00:1c.4:pcie0 with -EEXIST, don't try to register 
things with the same name in the same directory.

Call Trace:
  [<ffffffff80358298>] kobject_put+0x19/0x21
  [<ffffffff80358741>] kobject_add+0x181/0x1ac
  [<ffffffff803aa378>] device_add+0x88/0x4b9
  [<ffffffff803aa7c2>] device_register+0x19/0x27
  [<ffffffff80363e90>] pcie_port_device_register+0x3a0/0x3de
  [<ffffffff8042fa10>] pcibios_set_master+0x7f/0x86
  [<ffffffff80364004>] pcie_portdrv_probe+0x64/0x80
  [<ffffffff803612ac>] pci_device_probe+0x4d/0x78
  [<ffffffff803ac08f>] driver_probe_device+0x5c/0xb4
  [<ffffffff803ac1c9>] __driver_attach+0x67/0xb9
  [<ffffffff803ac162>] __driver_attach+0x0/0xb9
  [<ffffffff803aba4f>] bus_for_each_dev+0x4f/0x79
  [<ffffffff803abfbc>] driver_attach+0x1c/0x1e
  [<ffffffff803ab61a>] bus_add_driver+0x7a/0x143
  [<ffffffff803ac463>] driver_register+0x9f/0xa6
  [<ffffffff80361497>] __pci_register_driver+0x59/0x7e
  [<ffffffff806b7a57>] pcie_portdrv_init+0x1c/0x30
  [<ffffffff80267f3e>] init+0x14e/0x2d0
  [<ffffffff80260a12>] child_rip+0x8/0x12
  [<ffffffff80267df0>] init+0x0/0x2d0
  [<ffffffff80260a0a>] child_rip+0x0/0x12

PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie0]
Allocate Port Service[0000:00:1c.5:pcie0]
kobject_add failed for 0000:00:1c.5:pcie0 with -EEXIST, don't try to register 
things with the same name in the same directory.

Call Trace:
  [<ffffffff80358298>] kobject_put+0x19/0x21
  [<ffffffff80358741>] kobject_add+0x181/0x1ac
  [<ffffffff803aa378>] device_add+0x88/0x4b9
  [<ffffffff803aa7c2>] device_register+0x19/0x27
  [<ffffffff80363e90>] pcie_port_device_register+0x3a0/0x3de
  [<ffffffff8042fa10>] pcibios_set_master+0x7f/0x86
  [<ffffffff80364004>] pcie_portdrv_probe+0x64/0x80
  [<ffffffff803612ac>] pci_device_probe+0x4d/0x78
  [<ffffffff803ac08f>] driver_probe_device+0x5c/0xb4
  [<ffffffff803ac1c9>] __driver_attach+0x67/0xb9
  [<ffffffff803ac162>] __driver_attach+0x0/0xb9
  [<ffffffff803aba4f>] bus_for_each_dev+0x4f/0x79
  [<ffffffff803abfbc>] driver_attach+0x1c/0x1e
  [<ffffffff803ab61a>] bus_add_driver+0x7a/0x143
  [<ffffffff803ac463>] driver_register+0x9f/0xa6
  [<ffffffff80361497>] __pci_register_driver+0x59/0x7e
  [<ffffffff806b7a57>] pcie_portdrv_init+0x1c/0x30
  [<ffffffff80267f3e>] init+0x14e/0x2d0
  [<ffffffff80260a12>] child_rip+0x8/0x12
  [<ffffffff80267df0>] init+0x0/0x2d0
  [<ffffffff80260a0a>] child_rip+0x0/0x12

ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 19 (level, low) -> IRQ 19
0000:06:03.0: ttyS1 at I/O 0x1000 (irq = 19) is a 16550A
0000:06:03.0: ttyS2 at I/O 0x1008 (irq = 19) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 4 RAM disks of 16384K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.1.9-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:13:20:60:b4:23
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
Device `[IDES]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> 
GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC20000016100 ctl 0x0 bmdma 0x0 irq 314
ata2: SATA max UDMA/133 cmd 0xFFFFC20000016180 ctl 0x0 bmdma 0x0 irq 314
ata3: SATA max UDMA/133 cmd 0xFFFFC20000016200 ctl 0x0 bmdma 0x0 irq 314
ata4: SATA max UDMA/133 cmd 0xFFFFC20000016280 ctl 0x0 bmdma 0x0 irq 314
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
Losing some ticks... checking if CPU frequency changed.
scsi2 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
  sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 >
sd 2:0:0:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
Device `[EHCI]' is not power manageable<6>ACPI: PCI Interrupt 0000:00:1d.7[A] -> 
GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 23, io mem 0x481a0400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.17-mm6 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003080
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.17-mm6 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.17-mm6 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.17-mm6 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
usb 2-1: new full speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003020
usb usb5: new device found, idVendor=0000, idProduct=0000
usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.17-mm6 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new device found, idVendor=0451, idProduct=2046
usb 2-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 3-2: new full speed USB device using uhci_hcd and address 2
usb 3-2: new device found, idVendor=046d, idProduct=08b0
usb 3-2: new device strings: Mfr=0, Product=0, SerialNumber=1
usb 3-2: SerialNumber: 01402100A5000000
usb 3-2: configuration #1 chosen from 1 choice
usb 2-1.1: new low speed USB device using uhci_hcd and address 3
usb 2-1.1: new device found, idVendor=050d, idProduct=0105
usb 2-1.1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1.1: Product: Belkin OmniView KVM Switch
usb 2-1.1: Manufacturer: Belkin Components
usb 2-1.1: configuration #1 chosen from 1 choice
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input0
input: USB HID v1.00 Keyboard [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.0-1.1
input: Belkin Components Belkin OmniView KVM Switch as /class/input/input1
input: USB HID v1.00 Mouse [Belkin Components Belkin OmniView KVM Switch] on 
usb-0000:00:1d.0-1.1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: raid1 personality registered for level 1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
EDAC MC: Ver: 2.0.1 Jul  3 2006
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
Freeing unused kernel memory: 216k freed
md: Autodetecting RAID arrays.
md: invalid raid superblock magic on sda10
md: sda10 has invalid sb, not importing!
md: invalid raid superblock magic on sdc10
md: sdc10 has invalid sb, not importing!
md: autorun ...
md: considering sdc11 ...
md:  adding sdc11 ...
md: sdc7 has different UUID to sdc11
md: sdc6 has different UUID to sdc11
md: sdc5 has different UUID to sdc11
md: sdc3 has different UUID to sdc11
md: sdc2 has different UUID to sdc11
md:  adding sda11 ...
md: sda7 has different UUID to sdc11
md: sda6 has different UUID to sdc11
md: sda5 has different UUID to sdc11
md: sda3 has different UUID to sdc11
md: sda2 has different UUID to sdc11
md: created md5
md: bind<sda11>
md: bind<sdc11>
md: running: <sdc11><sda11>
raid1: raid set md5 active with 2 out of 2 mirrors
md5: bitmap initialized from disk: read 10/10 pages, set 7 bits, status: 0
created bitmap (153 pages) for device md5
md: considering sdc7 ...
md:  adding sdc7 ...
md: sdc6 has different UUID to sdc7
md: sdc5 has different UUID to sdc7
md: sdc3 has different UUID to sdc7
md: sdc2 has different UUID to sdc7
md:  adding sda7 ...
md: sda6 has different UUID to sdc7
md: sda5 has different UUID to sdc7
md: sda3 has different UUID to sdc7
md: sda2 has different UUID to sdc7
md: created md4
md: bind<sda7>
md: bind<sdc7>
md: running: <sdc7><sda7>
raid1: raid set md4 active with 2 out of 2 mirrors
md4: bitmap initialized from disk: read 4/4 pages, set 9 bits, status: 0
created bitmap (61 pages) for device md4
md: considering sdc6 ...
md:  adding sdc6 ...
md: sdc5 has different UUID to sdc6
md: sdc3 has different UUID to sdc6
md: sdc2 has different UUID to sdc6
md:  adding sda6 ...
md: sda5 has different UUID to sdc6
md: sda3 has different UUID to sdc6
md: sda2 has different UUID to sdc6
md: created md3
md: bind<sda6>
md: bind<sdc6>
md: running: <sdc6><sda6>
raid1: raid set md3 active with 2 out of 2 mirrors
md3: bitmap initialized from disk: read 1/1 pages, set 1 bits, status: 0
created bitmap (13 pages) for device md3
md: considering sdc5 ...
md:  adding sdc5 ...
md: sdc3 has different UUID to sdc5
md: sdc2 has different UUID to sdc5
md:  adding sda5 ...
md: sda3 has different UUID to sdc5
md: sda2 has different UUID to sdc5
md: created md2
md: bind<sda5>
md: bind<sdc5>
md: running: <sdc5><sda5>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 10/10 pages, set 54 bits, status: 0
created bitmap (150 pages) for device md2
md: considering sdc3 ...
md:  adding sdc3 ...
md: sdc2 has different UUID to sdc3
md:  adding sda3 ...
md: sda2 has different UUID to sdc3
md: created md1
md: bind<sda3>
md: bind<sdc3>
md: running: <sdc3><sda3>
raid1: raid set md1 active with 2 out of 2 mirrors
md1: bitmap initialized from disk: read 10/10 pages, set 50 bits, status: 0
created bitmap (150 pages) for device md1
md: considering sdc2 ...
md:  adding sdc2 ...
md:  adding sda2 ...
md: created md0
md: bind<sda2>
md: bind<sdc2>
md: running: <sdc2><sda2>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 12/12 pages, set 41 bits, status: 0
created bitmap (187 pages) for device md0
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1151924056.656:2): selinux=0 auid=4294967295
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (18-Jun-2006)
iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x0460)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: mounting fs with errors, running e2fsck is recommended
EXT3 FS on md5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda8: found reiserfs format "3.6" with standard journal
ReiserFS: sda8: using ordered data mode
ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda8: checking transaction log (sda8)
ReiserFS: sda8: Using r5 hash to sort names
ReiserFS: sdc8: found reiserfs format "3.6" with standard journal
ReiserFS: sdc8: using ordered data mode
ReiserFS: sdc8: journal params: device sdc8, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdc8: checking transaction log (sdc8)
ReiserFS: sdc8: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 248968k swap on /dev/sda9.  Priority:-1 extents:1 across:248968k
Adding 248968k swap on /dev/sdc9.  Priority:-2 extents:1 across:248968k
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (4060 buckets, 32480 max) - 288 bytes per conntrack
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
GRE over IPv4 tunneling driver
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.7
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
eth0: no IPv6 routers present
[root@tornado linux]#

reuben
