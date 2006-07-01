Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbWGALIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWGALIm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbWGALIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:08:42 -0400
Received: from tornado.reub.net ([202.89.145.182]:19933 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932723AbWGALIl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:08:41 -0400
Message-ID: <44A657B8.7040702@reub.net>
Date: Sat, 01 Jul 2006 23:08:40 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060627)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5
References: <20060701033524.3c478698.akpm@osdl.org>
In-Reply-To: <20060701033524.3c478698.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/07/2006 10:35 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm5/
> 
> 
> Nothing very exciting here - a few buggy patches were fixed or dropped.

Ouch:

Bootdata ok (command line is ro root=/dev/md0 panic=60 console=ttyS0,57600 single)
Linux version 2.6.17-mm5 (root@tornado.reub.net) (gcc version 4.1.1 20060629 
(Red Hat 4.1.1-6)) #1 SMP Sat Jul 1 22:59:00 NZST 2006
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
ACPI: PM-Timer IO Port: 0x408
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
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f700000:c0900000)
Built 1 zonelists.  Total pages: 254547
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600 single
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1015044k/1039360k available (2569k kernel code, 22788k reserved, 1660k 
data, 216k init)
Calibrating delay using timer specific routine.. 6006.40 BogoMIPS (lpj=12012800)
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
result 12500450
Detected 12.500 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5999.87 BogoMIPS (lpj=11999755)
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
migration_cost=4
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
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
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
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1151751831.012:1): initialized
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Getting cpuindex for acpiid 0x4
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 19 (level, low) -> IRQ 19
0000:06:03.0: ttyS1 at I/O 0x1000 (irq = 19) is a 16550A
0000:06:03.0: ttyS2 at I/O 0x1008 (irq = 19) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 4 RAM disks of 16384K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.0.38-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:13:20:60:b4:23
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
hda: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Unable to handle kernel NULL pointer dereference at 00000000000000ce RIP:
  [<ffffffff80363a96>] pci_msi_supported+0x37/0x4b
PGD 0
Oops: 0000 [1] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.17-mm5 #1
RIP: 0010:[<ffffffff80363a96>]  [<ffffffff80363a96>] pci_msi_supported+0x37/0x4b
RSP: 0000:ffff81003f601b88  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff81003ec659c8 RCX: 00000000481a0000
RDX: 00000000481a03ff RSI: ffff810037f9aa80 RDI: ffff81003ec65800
RBP: ffff81003f601b88 R08: 0000000000000000 R09: 0000000000000000
R10: ffff810037f9aa80 R11: 0000000000000040 R12: ffff81003ec65800
R13: 0000000000000000 R14: ffffffff805a0620 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80685000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000000000ce CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 1, threadinfo ffff81003f600000, task ffff810001fb8740)
Stack:  ffff81003f601bf8 ffffffff80364909 ffff81003f601bc8 ffffffff8035dbee
  0000000000000000 0000000000000005 ffffffff804c8166 ffff81003ec65800
  ffff81003f601bf8 ffff81003ec659c8 ffff81003ec65800 0000000000000000
Call Trace:
  [<ffffffff80364909>] pci_enable_msi+0x19/0x2f2
  [<ffffffff8035dbee>] pci_request_region+0xce/0x180
  [<ffffffff803e8867>] ahci_init_one+0x88/0x93a
  [<ffffffff8026311d>] wait_for_completion+0xb2/0x112
  [<ffffffff80280b4f>] default_wake_function+0x0/0xf
  [<ffffffff80290dcc>] call_usermodehelper_keys+0xd4/0xe8
  [<ffffffff80290de0>] __call_usermodehelper+0x0/0x64
  [<ffffffff8025affa>] kobject_get+0x1a/0x24
  [<ffffffff8035ff1c>] pci_device_probe+0x4d/0x78
  [<ffffffff803aaa8f>] driver_probe_device+0x5c/0xb4
  [<ffffffff803aabc9>] __driver_attach+0x67/0xb9
  [<ffffffff803aab62>] __driver_attach+0x0/0xb9
  [<ffffffff803aa44f>] bus_for_each_dev+0x4f/0x79
  [<ffffffff803aa9bc>] driver_attach+0x1c/0x1e
  [<ffffffff803aa01a>] bus_add_driver+0x7a/0x143
  [<ffffffff803aae63>] driver_register+0x9f/0xa6
  [<ffffffff80280b6e>] wake_up_process+0x10/0x12
  [<ffffffff80360107>] __pci_register_driver+0x59/0x7e
  [<ffffffff806b7799>] ahci_init+0x12/0x14
  [<ffffffff80267ece>] init+0x14e/0x2c2
  [<ffffffff80227b67>] schedule_tail+0x37/0x9e
  [<ffffffff80260972>] child_rip+0x8/0x12
  [<ffffffff80267d80>] init+0x0/0x2c2
  [<ffffffff8026096a>] child_rip+0x0/0x12


Code: f6 80 ce 00 00 00 01 75 04 31 c0 eb 05 b8 ff ff ff ff 5d c3
RIP  [<ffffffff80363a96>] pci_msi_supported+0x37/0x4b
  RSP <ffff81003f601b88>
CR2: 00000000000000ce
  <0>Kernel panic - not syncing: Attempted to kill init!
  <0>Rebooting in 60 seconds..

Hardware is listed at http://www.reub.net/files/kernel/system-hardware

Reuben

