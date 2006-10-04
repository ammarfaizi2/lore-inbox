Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWJDOYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWJDOYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWJDOYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:24:12 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:31953 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1161140AbWJDOYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:24:09 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: [discuss] Re: Please report all left over "DWARF2 unwinder
	stucks"
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
In-Reply-To: <1159830741.4432.11.camel@localhost.portugal>
References: <200610012201.20544.ak@suse.de> <adazmcev8qy.fsf@cisco.com>
	 <200610022150.48346.ak@suse.de>
	 <1159830741.4432.11.camel@localhost.portugal>
Content-Type: multipart/mixed; boundary="=-pUlZ5MfU96jyqp63XV77"
Date: Wed, 04 Oct 2006 15:23:57 +0100
Message-Id: <1159971837.26175.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pUlZ5MfU96jyqp63XV77
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi, I am resending the message. Only yesterday, I notice that I send my
emails via localhost with sendmail, which gave some problems.

On Tue, 2006-10-03 at 00:12 +0100, Sergio Monteiro Basto wrote:
> 
> Hi got one DWARF2 when eth1 is going down (usbnet, cdc_ether).

(I mean when I do service network stop )

> I got it with git6, 7 or 8 ( I don't remember well), with git 10 no and
> with git 18 I got it again.
> 
> Option report_lost_tickets, now send a lot of messages 
> 
> Last note I strip all RedHat patches, now is just linux-2.6.18 with gits
> and strip also  .config

I dont know if it help (with git20), I made a test and boot up without
Option notsc , I got other DWARF2 ...

Let me know if you need some more information or test.

Thanks, 
-- 
Sérgio M.B.

--=-pUlZ5MfU96jyqp63XV77
Content-Disposition: attachment; filename=dmesg27
Content-Type: text/plain; name=dmesg27; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.18-3_git20_FC5 (root@monteirov) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Tue Oct 3 23:17:44 WEST 2006
Command line: ro root=LABEL=/1 report_lost_ticks initcall_debug
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffc0000 (ACPI data)
 BIOS-e820: 000000003ffc0000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 262064) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f7ca0
ACPI: RSDT (v001 A M I  OEMRSDT  0x06000616 MSFT 0x00000097) @ 0x000000003ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x06000616 MSFT 0x00000097) @ 0x000000003ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x06000616 MSFT 0x00000097) @ 0x000000003ffb0390
ACPI: MCFG (v001 A M I  OEMMCFG  0x06000616 MSFT 0x00000097) @ 0x000000003ffb0410
ACPI: OEMB (v001 A M I  AMI_OEM  0x06000616 MSFT 0x00000097) @ 0x000000003ffc0040
ACPI: DSDT (v001  75D8P 75D8P004 0x00000004 INTL 0x02002026) @ 0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-000000003ffb0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 262064) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003ffb0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   262064
On node 0 totalpages: 261967
  DMA zone: 88 pages used for memmap
  DMA zone: 2261 pages reserved
  DMA zone: 1650 pages, LIFO batch:0
  DMA32 zone: 5542 pages used for memmap
  DMA32 zone: 252426 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfecc0000] gsi_base[24])
IOAPIC[1]: apic_id 3, address 0xfecc0000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e6000
Nosave address range: 00000000000e6000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:bee00000)
SMP: Allowing 4 CPUs, 2 hotplug CPUs
PERCPU: Allocating 34944 bytes of per cpu data
Built 1 zonelists.  Total pages: 254076
Kernel command line: ro root=LABEL=/1 report_lost_ticks initcall_debug
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
time.c: Lost 2 timer tick(s)! rip release_console_sem+0x1bd/0x238)
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 1328 kB
 per task-struct memory footprint: 1680 bytes
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1013316k/1048256k available (2429k kernel code, 34552k reserved, 2007k data, 308k init)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
Calibrating delay using timer specific routine.. 5595.18 BogoMIPS (lpj=11190369)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irq+0x2e/0x31)
time.c: Lost 1 timer tick(s)! rip kmem_cache_alloc+0xf5/0x115)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip __mutex_lock_slowpath+0x242/0x258)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 3 timer tick(s)! rip __mutex_lock_slowpath+0x242/0x258)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip __mutex_lock_slowpath+0x242/0x258)
time.c: Lost 1 timer tick(s)! rip __mutex_lock_slowpath+0x242/0x258)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip cache_grow+0xb4/0x5ab)
time.c: Lost 1 timer tick(s)! rip __mutex_lock_slowpath+0x242/0x258)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip __mutex_lock_slowpath+0x242/0x258)
time.c: Lost 1 timer tick(s)! rip __mutex_lock_slowpath+0x242/0x258)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
lockdep: not fixing up alternatives.
ACPI: Core revision 20060707
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
Using local APIC timer interrupts.
result 12468931
Detected 12.468 MHz APIC timer.
time.c: Lost 9 timer tick(s)! rip setup_boot_APIC_clock+0x12c/0x12f)
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5586.54 BogoMIPS (lpj=11173089)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) D CPU 2.80GHz stepping 04
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2793.051 MHz processor.
migration_cost=543
checking if image is initramfs... it is
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
Freeing initrd memory: 1103k freed
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:platform
Calling initcall 0xffffffff8069657a: cpufreq_tsc+0x0/0x6d()
Calling initcall 0xffffffff8022253c: init_smp_flush+0x0/0x61()
Calling initcall 0xffffffff806a0499: init_elf32_binfmt+0x0/0x12()
Calling initcall 0xffffffff806a19f7: helper_init+0x0/0x2f()
Calling initcall 0xffffffff806a1eb0: pm_init+0x0/0x29()
Calling initcall 0xffffffff806a1f16: pm_disk_init+0x0/0x19()
Calling initcall 0xffffffff806a2356: ksysfs_init+0x0/0x29()
Calling initcall 0xffffffff806a4db7: filelock_init+0x0/0x31()
Calling initcall 0xffffffff806a5820: init_misc_binfmt+0x0/0x3f()
Calling initcall 0xffffffff806a585f: init_script_binfmt+0x0/0x12()
Calling initcall 0xffffffff806a5871: init_elf_binfmt+0x0/0x12()
Calling initcall 0xffffffff806a60d4: debugfs_init+0x0/0x4a()
Calling initcall 0xffffffff806a6681: securityfs_init+0x0/0x4a()
Calling initcall 0xffffffff806aeb22: sock_init+0x0/0x5f()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806af445: netlink_proto_init+0x0/0x171()
NET: Registered protocol family 16
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806a6ef8: kobject_uevent_init+0x0/0x3a()
Calling initcall 0xffffffff806a704f: pcibus_class_init+0x0/0x12()
Calling initcall 0xffffffff806a75ad: pci_driver_init+0x0/0x12()
Calling initcall 0xffffffff806aa9b1: tty_class_init+0x0/0x2a()
Calling initcall 0xffffffff806ab165: vtconsole_class_init+0x0/0xbb()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806ab849: register_node_type+0x0/0x12()
Calling initcall 0xffffffff80698c52: mtrr_if_init+0x0/0x6c()
Calling initcall 0xffffffff806a777d: acpi_pci_init+0x0/0x2e()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
ACPI: bus type pci registered
Calling initcall 0xffffffff806a9253: init_acpi_device_notify+0x0/0x4b()
Calling initcall 0xffffffff806adc83: pci_access_init+0x0/0x2e()
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
Calling initcall 0xffffffff80698acd: mtrr_init_finialize+0x0/0x34()
Calling initcall 0xffffffff8069e584: topology_init+0x0/0x8c()
Calling initcall 0xffffffff806a17bb: param_sysfs_init+0x0/0x186()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff802b4697: pm_sysrq_init+0x0/0x19()
Calling initcall 0xffffffff806a5486: init_bio+0x0/0xf8()
Calling initcall 0xffffffff806a6cfd: genhd_device_init+0x0/0x57()
Calling initcall 0xffffffff806a782e: fbmem_init+0x0/0x95()
Calling initcall 0xffffffff806a9064: acpi_init+0x0/0x1ef()
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
Calling initcall 0xffffffff806a94c2: acpi_ec_init+0x0/0x61()
Calling initcall 0xffffffff806a98d3: acpi_pci_root_init+0x0/0x28()
Calling initcall 0xffffffff806a9925: acpi_pci_link_init+0x0/0x48()
Calling initcall 0xffffffff806a9ad0: acpi_power_init+0x0/0x77()
Calling initcall 0xffffffff806a9c8f: acpi_system_init+0x0/0xc6()
Calling initcall 0xffffffff806a9d55: acpi_event_init+0x0/0x3f()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806a9ec7: acpi_scan_init+0x0/0x1a4()
PM: Adding info for acpi:acpi
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
ACPI: PCI Root Bridge [PCI0] (0000:00)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PCI: Probing PCI hardware (bus 00)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 5 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 9 timer tick(s)! rip __do_softirq+0x53/0xe3)
Losing some ticks... checking if CPU frequency changed.
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:pci0000:00
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:00.1
PM: Adding info for pci:0000:00:00.2
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for pci:0000:00:00.3
PM: Adding info for pci:0000:00:00.4
PM: Adding info for pci:0000:00:00.5
PM: Adding info for pci:0000:00:00.7
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:02.0
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for pci:0000:00:0f.0
PM: Adding info for pci:0000:00:0f.1
PM: Adding info for pci:0000:00:10.0
PM: Adding info for pci:0000:00:10.1
PM: Adding info for pci:0000:00:10.2
PM: Adding info for pci:0000:00:10.3
PM: Adding info for pci:0000:00:10.4
PM: Adding info for pci:0000:00:11.0
PM: Adding info for pci:0000:00:11.5
PM: Adding info for pci:0000:00:12.0
PM: Adding info for pci:0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NBPG._PRT]
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Calling initcall 0xffffffff806aa1da: acpi_cm_sbs_init+0x0/0x8()
Calling initcall 0xffffffff806aa1e2: pnp_init+0x0/0x20()
Linux Plug and Play Support v0.97 (c) Adam Belay
Calling initcall 0xffffffff806aa3fe: pnpacpi_init+0x0/0x6a()
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
pnp: PnP ACPI: found 15 devices
Calling initcall 0xffffffff806aac5e: misc_init+0x0/0x86()
Calling initcall 0xffffffff803ad431: cn_init+0x0/0xcc()
Calling initcall 0xffffffff806ac49d: init_pcmcia_cs+0x0/0x38()
Calling initcall 0xffffffff806ac5b6: usb_init+0x0/0x10d()
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Calling initcall 0xffffffff806ac95b: serio_init+0x0/0xc0()
Calling initcall 0xffffffff806acd55: input_init+0x0/0x120()
Calling initcall 0xffffffff806ad0b2: leds_init+0x0/0x2a()
Calling initcall 0xffffffff806ad69e: dma_bus_init+0x0/0x2c()
Calling initcall 0xffffffff806adcb1: pci_acpi_init+0x0/0xae()
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Calling initcall 0xffffffff806add5f: pci_legacy_init+0x0/0x126()
Calling initcall 0xffffffff806ae213: pcibios_irq_init+0x0/0x4c8()
Calling initcall 0xffffffff806ae6db: pcibios_init+0x0/0x66()
Calling initcall 0xffffffff806aebdc: proto_init+0x0/0x34()
Calling initcall 0xffffffff806aed29: net_dev_init+0x0/0x276()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806af286: wireless_nlevent_init+0x0/0x41()
Calling initcall 0xffffffff806af2fb: fib_rules_init+0x0/0x12()
Calling initcall 0xffffffff806af30d: pktsched_init+0x0/0xa6()
Calling initcall 0xffffffff806af3c5: tc_filter_init+0x0/0x40()
Calling initcall 0xffffffff806af405: tc_action_init+0x0/0x40()
Calling initcall 0xffffffff806af5b6: genl_init+0x0/0xb0()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806968d4: late_hpet_init+0x0/0xd0()
Calling initcall 0xffffffff80698461: pci_iommu_init+0x0/0x17()
PCI-GART: No AMD northbridge found.
Calling initcall 0xffffffff806a4d40: init_pipe_fs+0x0/0x4a()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806aa0aa: acpi_motherboard_init+0x0/0x130()
Calling initcall 0xffffffff806aa2ee: pnp_system_init+0x0/0x12()
Calling initcall 0xffffffff806aa722: chr_dev_init+0x0/0x87()
Calling initcall 0xffffffff806ab7d7: firmware_class_init+0x0/0x72()
Calling initcall 0xffffffff806ac4d5: init_pcmcia_bus+0x0/0x3f()
Calling initcall 0xffffffff806ad080: cpufreq_gov_performance_init+0x0/0x12()
Calling initcall 0xffffffff806ad092: cpufreq_gov_userspace_init+0x0/0x20()
Calling initcall 0xffffffff806ad6ca: pcibios_assign_resources+0x0/0x87()
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: f3e00000-f7efffff
  PREFETCH window: bff00000-dfefffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 27 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
Calling initcall 0xffffffff806aea4d: fill_mp_bus_to_cpumask+0x0/0xd5()
Calling initcall 0xffffffff806b0063: inet_init+0x0/0x3da()
NET: Registered protocol family 2
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
TCP reno registered
Calling initcall 0xffffffff80270481: time_init_device+0x0/0x22()
Calling initcall 0xffffffff806969c6: add_pcspkr+0x0/0x43()
PM: Adding info for platform:pcspkr
Calling initcall 0xffffffff806970c3: i8259A_init_sysfs+0x0/0x22()
Calling initcall 0xffffffff806970a1: init_timer_sysfs+0x0/0x22()
Calling initcall 0xffffffff80697528: vsyscall_init+0x0/0x9b()
Calling initcall 0xffffffff806977cd: sbf_init+0x0/0xd5()
Calling initcall 0xffffffff8069843f: i8237A_init_sysfs+0x0/0x22()
Calling initcall 0xffffffff806988c5: periodic_mcheck_init+0x0/0x27()
Calling initcall 0xffffffff806988ec: mce_init_device+0x0/0x78()
Calling initcall 0xffffffff80698a11: thermal_throttle_init_device+0x0/0x71()
Calling initcall 0xffffffff80698a82: threshold_init_device+0x0/0x4b()
Calling initcall 0xffffffff80699a87: msr_init+0x0/0x100()
Calling initcall 0xffffffff80699b87: cpuid_init+0x0/0x100()
Calling initcall 0xffffffff8069a667: init_lapic_sysfs+0x0/0x35()
Calling initcall 0xffffffff8069b182: ioapic_init_sysfs+0x0/0xc8()
Calling initcall 0xffffffff8069e436: audit_classes_init+0x0/0x8d()
Calling initcall 0xffffffff80282631: cache_sysfs_init+0x0/0x5e()
Calling initcall 0xffffffff8069e6be: x8664_sysctl_init+0x0/0x19()
Calling initcall 0xffffffff806a0480: ia32_binfmt_init+0x0/0x19()
Calling initcall 0xffffffff806a04ab: init_syscall32+0x0/0x58()
Calling initcall 0xffffffff806a0d80: create_proc_profile+0x0/0x34f()
Calling initcall 0xffffffff806a128b: ioresources_init+0x0/0x42()
Calling initcall 0xffffffff806a13cc: timekeeping_init_device+0x0/0x22()
Calling initcall 0xffffffff806a14ec: uid_cache_init+0x0/0x8b()
Calling initcall 0xffffffff806a1941: init_posix_timers+0x0/0xb6()
Calling initcall 0xffffffff806a1a26: init_posix_cpu_timers+0x0/0xd4()
Calling initcall 0xffffffff806a1b28: latency_init+0x0/0x23()
Calling initcall 0xffffffff806a1bf3: init_clocksource_sysfs+0x0/0x50()
Calling initcall 0xffffffff806a1c43: init_jiffies_clocksource+0x0/0x12()
Calling initcall 0xffffffff806a1d61: lockdep_proc_init+0x0/0x48()
Calling initcall 0xffffffff806a1da9: init+0x0/0x75()
Calling initcall 0xffffffff806a1e1e: proc_dma_init+0x0/0x25()
Calling initcall 0xffffffff802ab711: percpu_modinit+0x0/0x76()
Calling initcall 0xffffffff806a1e43: kallsyms_init+0x0/0x28()
Calling initcall 0xffffffff806a1f2f: snapshot_device_init+0x0/0x12()
Calling initcall 0xffffffff806a1f41: crash_notes_memory_init+0x0/0x3d()
Calling initcall 0xffffffff806a2163: audit_init+0x0/0x126()
audit: initializing netlink socket (disabled)
audit(1159933284.812:1): initialized
Calling initcall 0xffffffff806a230e: init_kprobes+0x0/0x48()
Calling initcall 0xffffffff806a3335: init_per_zone_pages_min+0x0/0x53()
Calling initcall 0xffffffff806a430d: pdflush_init+0x0/0x1d()
Calling initcall 0xffffffff806a4356: kswapd_init+0x0/0x71()
Calling initcall 0xffffffff806a43c7: setup_vmstat+0x0/0x19()
Calling initcall 0xffffffff806a4424: procswaps_init+0x0/0x25()
Calling initcall 0xffffffff806a447c: hugetlb_init+0x0/0x68()
Total HugeTLB memory allocated, 0
Calling initcall 0xffffffff806a45da: init_tmpfs+0x0/0xcc()
Calling initcall 0xffffffff806a46a6: cpucache_init+0x0/0x3c()
Calling initcall 0xffffffff806a4d8a: fasync_init+0x0/0x2d()
Calling initcall 0xffffffff806a53c5: aio_setup+0x0/0x67()
Calling initcall 0xffffffff806a55f8: inotify_setup+0x0/0x12()
Calling initcall 0xffffffff806a560a: inotify_user_setup+0x0/0xbc()
Calling initcall 0xffffffff806a56c6: eventpoll_init+0x0/0xd5()
Calling initcall 0xffffffff806a579b: init_sys32_ioctl+0x0/0x85()
Calling initcall 0xffffffff806a5883: init_mbcache+0x0/0x20()
Calling initcall 0xffffffff806a58a3: dquot_init+0x0/0xea()
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Calling initcall 0xffffffff806a598d: init_v2_quota_format+0x0/0x12()
Calling initcall 0xffffffff806a599f: dnotify_init+0x0/0x2d()
Calling initcall 0xffffffff806a5e54: init_devpts_fs+0x0/0x3d()
Calling initcall 0xffffffff806a5e91: init_ext2_fs+0x0/0x6d()
Calling initcall 0xffffffff806a5f44: init_ramfs_fs+0x0/0x12()
Calling initcall 0xffffffff806a5f56: init_hugetlbfs_fs+0x0/0x80()
Calling initcall 0xffffffff806a5fd6: init_iso9660_fs+0x0/0x6f()
Calling initcall 0xffffffff806a60b0: init_nls_cp437+0x0/0x12()
Calling initcall 0xffffffff806a60c2: init_nls_ascii+0x0/0x12()
Calling initcall 0xffffffff806a611e: ipc_init+0x0/0x17()
Calling initcall 0xffffffff806a63a4: init_mqueue_fs+0x0/0xd9()
Calling initcall 0xffffffff806a65e0: key_proc_init+0x0/0x55()
Calling initcall 0xffffffff806a6774: selinux_nf_ip_init+0x0/0x56()
SELinux:  Registering netfilter hooks
Calling initcall 0xffffffff806a6928: init_sel_fs+0x0/0x66()
Calling initcall 0xffffffff806a69d4: selnl_init+0x0/0x42()
Calling initcall 0xffffffff806a6a16: sel_netif_init+0x0/0x66()
Calling initcall 0xffffffff806a6a7c: aurule_init+0x0/0x37()
Calling initcall 0xffffffff806a6b41: crypto_algapi_init+0x0/0xd()
Calling initcall 0xffffffff806a6b71: hmac_module_init+0x0/0x12()
Calling initcall 0xffffffff806a6b83: init+0x0/0x12()
Calling initcall 0xffffffff806a6d54: noop_init+0x0/0x12()
io scheduler noop registered
Calling initcall 0xffffffff806a6d66: as_init+0x0/0x12()
io scheduler anticipatory registered
Calling initcall 0xffffffff806a6d78: deadline_init+0x0/0x12()
io scheduler deadline registered
Calling initcall 0xffffffff806a6d8a: cfq_init+0x0/0xaf()
io scheduler cfq registered (default)
Calling initcall 0xffffffff806a6e39: blk_trace_init+0x0/0xbf()
Calling initcall 0xffffffff8034e80d: pci_init+0x0/0x35()
PCI: Bypassing VIA 8237 APIC De-Assert Message
Calling initcall 0xffffffff806a75bf: pci_sysfs_init+0x0/0x3f()
Calling initcall 0xffffffff806a75fe: pci_proc_init+0x0/0x72()
Calling initcall 0xffffffff806a7670: pcie_portdrv_init+0x0/0x46()
PCI: Setting latency timer of device 0000:00:02.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
PM: Adding info for pci_express:0000:00:02.0:pcie00
Allocate Port Service[0000:00:02.0:pcie02]
PM: Adding info for pci_express:0000:00:02.0:pcie02
Calling initcall 0xffffffff806a76b6: aer_service_init+0x0/0x12()
Calling initcall 0xffffffff806a76c8: pci_hotplug_init+0x0/0x5a()
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Calling initcall 0xffffffff806a78dc: fb_console_init+0x0/0x12b()
Calling initcall 0xffffffff806a8303: vesafb_init+0x0/0x235()
PM: Adding info for platform:vesafb.0
Calling initcall 0xffffffff806a9875: acpi_fan_init+0x0/0x5e()
Calling initcall 0xffffffff806a996d: irqrouter_init_sysfs+0x0/0x38()
Calling initcall 0xffffffff806a9b47: acpi_processor_init+0x0/0xa8()
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] (Node ffff8100027fd810), AE_BAD_HEADER
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] (Node ffff8100027fd650), AE_BAD_HEADER
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x3
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x4
Calling initcall 0xffffffff806a9bef: acpi_container_init+0x0/0x42()
Calling initcall 0xffffffff806a9c31: acpi_thermal_init+0x0/0x5e()
Calling initcall 0xffffffff806aa7b8: rand_initialize+0x0/0x2c()
Calling initcall 0xffffffff806aa7e4: tty_init+0x0/0x1cd()
Calling initcall 0xffffffff806aaa13: pty_init+0x0/0x24b()
Calling initcall 0xffffffff806ab220: rtc_init+0x0/0x1c8()
Real Time Clock Driver v1.12ac
Calling initcall 0xffffffff806ab3e8: hpet_init+0x0/0x6c()
Calling initcall 0xffffffff806ab454: nvram_init+0x0/0x8a()
Non-volatile memory driver v1.2
Calling initcall 0xffffffff806ab4de: agp_init+0x0/0x26()
Linux agpgart interface v0.101 (c) Dave Jones
Calling initcall 0xffffffff806ab60b: agp_intel_init+0x0/0x22()
Calling initcall 0xffffffff806ab62d: agp_sis_init+0x0/0x22()
Calling initcall 0xffffffff806ab64f: agp_via_init+0x0/0x22()
agpgart: Detected VIA PT880 Ultra chipset
agpgart: AGP aperture is 64M @ 0xf8000000
Calling initcall 0xffffffff806ab671: cn_proc_init+0x0/0x3d()
Calling initcall 0xffffffff803b5b5f: topology_sysfs_init+0x0/0x54()
Calling initcall 0xffffffff806ab89a: rd_init+0x0/0x1c1()
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Calling initcall 0xffffffff806abab0: net_olddevs_init+0x0/0xb7()
Calling initcall 0xffffffff803b687e: amd74xx_ide_init+0x0/0x14()
Calling initcall 0xffffffff803b7ea0: atiixp_ide_init+0x0/0x14()
Calling initcall 0xffffffff803b846c: via_ide_init+0x0/0x14()
Calling initcall 0xffffffff803b8e07: generic_ide_init+0x0/0x14()
Calling initcall 0xffffffff806abbe1: ide_init+0x0/0x91()
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
GSI 17 sharing vector 0xC1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
Calling initcall 0xffffffff806ac459: ide_generic_init+0x0/0x12()
Probing IDE interface ide0...
Calling initcall 0xffffffff806ac46b: idedisk_init+0x0/0x12()
Calling initcall 0xffffffff806ac47d: idefloppy_init+0x0/0x20()
ide-floppy driver 0.99.newide
Calling initcall 0xffffffff806ac590: nonstatic_sysfs_init+0x0/0x12()
Calling initcall 0xffffffff806ac5a2: yenta_socket_init+0x0/0x14()
Calling initcall 0xffffffff806ac807: mon_init+0x0/0xcd()
Calling initcall 0xffffffff806ac8d4: usb_usual_init+0x0/0x29()
usbcore: registered new interface driver libusual
Calling initcall 0xffffffff806ac8fd: hid_init+0x0/0x4a()
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Calling initcall 0xffffffff806aca1b: i8042_init+0x0/0x306()
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
serio: i8042 KBD port at 0x60,0x64 irq 1
time.c: Lost 5 timer tick(s)! rip __do_softirq+0x53/0xe3)
serio: i8042 AUX port at 0x60,0x64 irq 12
Calling initcall 0xffffffff806acd21: serport_init+0x0/0x34()
Calling initcall 0xffffffff806ace75: mousedev_init+0x0/0xc2()
mice: PS/2 mouse device common for all mice
Calling initcall 0xffffffff806acf37: evdev_init+0x0/0x12()
Calling initcall 0xffffffff806acf49: atkbd_init+0x0/0x16()
Calling initcall 0xffffffff806acf5f: psmouse_init+0x0/0x46()
Calling initcall 0xffffffff806acfa5: md_init+0x0/0xdb()
Calling initcall 0xffffffff806ad0dc: ledtrig_ide_init+0x0/0x1b()
PM: Adding info for serio:serio0
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806af0df: flow_cache_init+0x0/0x1a7()
Calling initcall 0xffffffff806af3b3: blackhole_module_init+0x0/0x12()
Calling initcall 0xffffffff806b06e6: init_syncookies+0x0/0x19()
Calling initcall 0xffffffff8044e0a6: ipv4_netfilter_init+0x0/0x12()
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff806b06ff: cubictcp_register+0x0/0x7f()
TCP cubic registered
Calling initcall 0xffffffff806b0976: xfrm_user_init+0x0/0x4d()
Initializing XFRM netlink socket
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
Calling initcall 0xffffffff806b09c3: af_unix_init+0x0/0x70()
NET: Registered protocol family 1
Calling initcall 0xffffffff806b0a33: packet_init+0x0/0x5e()
NET: Registered protocol family 17
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
Calling initcall 0xffffffff8069a93e: init_lapic_nmi_sysfs+0x0/0x39()
Calling initcall 0xffffffff8027dcda: powernowk8_init+0x0/0x88()
PM: Adding info for serio:serio1
Calling initcall 0xffffffff8069caf7: centrino_init+0x0/0xc8()
Calling initcall 0xffffffff806a1b4b: clocksource_done_booting+0x0/0x12()
Calling initcall 0xffffffff802b0ed7: software_resume+0x0/0x193()
initcall at 0xffffffff802b0ed7: software_resume+0x0/0x193(): returned with error code -2
Calling initcall 0xffffffff806a2489: taskstats_init+0x0/0x55()
Calling initcall 0xffffffff80384247: acpi_poweroff_init+0x0/0x58()
Calling initcall 0xffffffff806a8dc8: acpi_wakeup_device_init+0x0/0xb1()
Calling initcall 0xffffffff806a8e9d: acpi_sleep_init+0x0/0xad()
ACPI: (supports S0 S1 S3 S4 S5)
Calling initcall 0xffffffff80384820: acpi_sleep_proc_init+0x0/0x6e()
Calling initcall 0xffffffff806aa7a9: seqgen_init+0x0/0xf()
Calling initcall 0xffffffff80417552: net_random_reseed+0x0/0x6b()
Calling initcall 0xffffffff806b048f: tcp_congestion_default+0x0/0x12()
Freeing unused kernel memory: 308k freed
Write protecting the kernel read-only data: 469k
time.c: Lost 5 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 8 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 12 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 5 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
input: AT Translated Set 2 keyboard as /class/input/input0
time.c: Lost 8 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 8 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irq+0x2e/0x31)
SCSI subsystem initialized
libata version 2.00 loaded.
sata_via 0000:00:0f.0: version 2.0
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193
sata_via 0000:00:0f.0: routed to hard irq line 3
ata1: SATA max UDMA/133 cmd 0xD880 ctl 0xD802 bmdma 0xD080 irq 193
ata2: SATA max UDMA/133 cmd 0xD480 ctl 0xD402 bmdma 0xD088 irq 193
scsi0 : sata_via
PM: Adding info for No Bus:host0
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/100, 390721968 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : sata_via
PM: Adding info for No Bus:host1
ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xD487
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:target0:0:0
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6L200M0   BANC PQ: 0 ANSI: 5
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for scsi:0:0:0:0
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 5 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 7 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:<4>time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
 sda1 sda2 sda3 <<4>time.c: Lost 9 timer tick(s)! rip __do_softirq+0x53/0xe3)
 sda5 sda6 sda7 sda8 >
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
sd 0:0:0:0: Attached scsi disk sda
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
kjournald starting.  Commit interval 5 seconds
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
EXT3-fs: mounted filesystem with ordered data mode.
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1159933290.972:2): selinux=0 auid=4294967295
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
warning: process `date' used the removed sysctl system call
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
warning: process `touch' used the removed sysctl system call
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
input: PC Speaker as /class/input/input2
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:i2c-0
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
GSI 18 sharing vector 0xC9 and IRQ 18
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 201
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
eth0: VIA Rhine II at 0xf7fffc00, 00:13:8f:6e:8f:c5, IRQ 201.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 0021.
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Floppy drive(s): fd0 is 1.44M
GSI 19 sharing vector 0xD1 and IRQ 19
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 209
ehci_hcd 0000:00:10.4: EHCI Host Controller
time.c: Lost 5 timer tick(s)! rip __do_softirq+0x53/0xe3)
USB Universal Host Controller Interface driver v3.0
FDC 0 is a post-1991 82077
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for platform:floppy.0
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 209, io mem 0xf7fff800
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
time.c: Lost 13 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 6 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:usbdev1.1_ep81
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.0: UHCI Host Controller
sd 0:0:0:0: Attached scsi generic sg0 type 0
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 209, io base 0x0000ec00
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:usbdev2.1_ep81
time.c: Lost 6 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 5 timer tick(s)! rip __do_softirq+0x53/0xe3)
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 209, io base 0x0000e080
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:usbdev3.1_ep81
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 209, io base 0x0000e000
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:usbdev4.1_ep81
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 209, io base 0x0000dc00
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 1-6: new high speed USB device using ehci_hcd and address 3
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:usbdev5.1_ep81
GSI 20 sharing vector 0xD9 and IRQ 20
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:11.5 to 64
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for usb:1-6
PM: Adding info for No Bus:usbdev1.3_ep00
usb 1-6: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-6:1.0
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:usbdev1.3_ep81
PM: Adding info for No Bus:usbdev1.3_ep02
PM: Adding info for No Bus:usbdev1.3_ep83
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for ac97:0-0:ALC850
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
usb 3-2: new full speed USB device using uhci_hcd and address 2
Initializing USB Mass Storage driver...
PM: Adding info for usb:3-2
PM: Adding info for No Bus:usbdev3.2_ep00
usb 3-2: configuration #1 chosen from 1 choice
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for usb:3-2:1.0
PM: Adding info for No Bus:usbdev3.2_ep85
PM: Adding info for usb:3-2:1.1
warning: process `salsa' used the removed sysctl system call
warning: process `salsa' used the removed sysctl system call
warning: process `salsa' used the removed sysctl system call
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
scsi2 : SCSI emulation for USB Mass Storage devices
PM: Adding info for No Bus:host2
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PM: Adding info for No Bus:usbdev3.2_ep81
PM: Adding info for No Bus:usbdev3.2_ep02
eth1: register 'cdc_ether' at usb-0000:00:10.1-2, CDC Ethernet Device, 00:90:64:fc:ce:2b
usbcore: registered new interface driver cdc_ether
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
parport: PnPBIOS parport detected.
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
EXT3 FS on sda6, internal journal
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
Adding 1220900k swap on /dev/sda8.  Priority:-1 extents:1 across:1220900k
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:target2:0:0
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 7 timer tick(s)! rip __do_softirq+0x53/0xe3)
scsi 2:0:0:0: Direct-Access     OTi      CF CARD Reader   2.00 PQ: 0 ANSI: 0 CCS
PM: Adding info for scsi:2:0:0:0
sd 2:0:0:0: Attached scsi removable disk sdb
sd 2:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:1: Direct-Access     OTi      SM CARD Reader   2.00 PQ: 0 ANSI: 0 CCS
PM: Adding info for scsi:2:0:0:1
sd 2:0:0:1: Attached scsi removable disk sdc
sd 2:0:0:1: Attached scsi generic sg2 type 0
scsi 2:0:0:2: Direct-Access     OTi      SD CARD Reader   2.00 PQ: 0 ANSI: 0 CCS
PM: Adding info for scsi:2:0:0:2
sd 2:0:0:2: Attached scsi removable disk sdd
sd 2:0:0:2: Attached scsi generic sg3 type 0
scsi 2:0:0:3: Direct-Access     OTi      MS CARD Reader   2.00 PQ: 0 ANSI: 0 CCS
PM: Adding info for scsi:2:0:0:3
sd 2:0:0:3: Attached scsi removable disk sde
sd 2:0:0:3: Attached scsi generic sg4 type 0
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:target2:0:1
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Removing info for No Bus:target2:0:1
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
PM: Adding info for No Bus:target2:0:2
PM: Removing info for No Bus:target2:0:2
PM: Adding info for No Bus:target2:0:3
PM: Removing info for No Bus:target2:0:3
PM: Adding info for No Bus:target2:0:4
PM: Removing info for No Bus:target2:0:4
PM: Adding info for No Bus:target2:0:5
PM: Removing info for No Bus:target2:0:5
PM: Adding info for No Bus:target2:0:6
PM: Removing info for No Bus:target2:0:6
PM: Adding info for No Bus:target2:0:7
PM: Removing info for No Bus:target2:0:7
usb-storage: device scan complete
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 6 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 6 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 7 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 6 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 3 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 4 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 5 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
eth0: link up, 10Mbps, half-duplex, lpa 0x0021
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
audit(1159929713.931:3): audit_pid=2029 old=0 by auid=4294967295
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 4 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
IPv6 over IPv4 tunneling driver
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip kmem_cache_alloc+0xf5/0x115)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 3 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 3 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
eth0: no IPv6 routers present
eth1: no IPv6 routers present
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 8 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 11 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 3 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfc0f05)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 2 timer tick(s)! rip kmem_cache_alloc+0xf5/0x115)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
eth0: link down
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip kmem_cache_alloc+0xf5/0x115)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 1 timer tick(s)! rip lock_acquire+0x60/0x6a)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x53/0xe3)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 300 timer tick(s)! rip release_pages+0x77/0x1a9)
time.c: Lost 300 timer tick(s)! rip 0x2b62ac803fe2)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfdf00e)
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip do_page_fault+0x35a/0x83c)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip get_page_from_freelist+0x255/0x44b)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)

=================================
[ INFO: inconsistent lock state ]
2.6.18-3_git20_FC5 #1
---------------------------------
inconsistent {in-softirq-W} -> {softirq-on-W} usage.
ionice/12420 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&q->__queue_lock){-+..}, at: [<ffffffff8021d588>] cfq_set_request+0x21c/0x39f
{in-softirq-W} state was registered at:
  [<ffffffff802a61f7>] mark_lock+0x75/0x3e1
  [<ffffffff802a6ec8>] __lock_acquire+0x41b/0xa06
  [<ffffffff802a7a1f>] lock_acquire+0x4b/0x6a
  [<ffffffff8026785b>] _spin_lock+0x25/0x31
  [<ffffffff8800756a>] scsi_device_unbusy+0x76/0x98 [scsi_mod]
  [<ffffffff880024a8>] scsi_finish_command+0x1f/0xa1 [scsi_mod]
  [<ffffffff8800773f>] scsi_softirq_done+0xf4/0xfd [scsi_mod]
  [<ffffffff80239de9>] blk_done_softirq+0x6d/0x7c
  [<ffffffff80212866>] __do_softirq+0x5f/0xe3
  [<ffffffff802612bc>] call_softirq+0x1c/0x30
  [<ffffffff8026fd7f>] do_softirq+0x39/0xa0
  [<ffffffff802952e3>] irq_exit+0x4e/0x50
  [<ffffffff8027a47e>] smp_apic_timer_interrupt+0x54/0x59
  [<ffffffff80260d6b>] apic_timer_interrupt+0x6b/0x70
  [<ffffffffffffffff>] 0xffffffffffffffff
irq event stamp: 3421
hardirqs last  enabled at (3421): [<ffffffff8020a9ed>] kmem_cache_alloc+0xf2/0x115
hardirqs last disabled at (3420): [<ffffffff8020a946>] kmem_cache_alloc+0x4b/0x115
softirqs last  enabled at (146): [<ffffffff802128e1>] __do_softirq+0xda/0xe3
softirqs last disabled at (103): [<ffffffff802612bc>] call_softirq+0x1c/0x30

other info that might help us debug this:
no locks held by ionice/12420.

stack backtrace:

Call Trace:
 [<ffffffff8026e8df>] dump_trace+0xaa/0x3ed
 [<ffffffff8026ec5e>] show_trace+0x3c/0x52
 [<ffffffff8026ec89>] dump_stack+0x15/0x17
 [<ffffffff802a5b8f>] print_usage_bug+0x264/0x275
 [<ffffffff802a641e>] mark_lock+0x29c/0x3e1
 [<ffffffff802a6f47>] __lock_acquire+0x49a/0xa06
 [<ffffffff802a7a1f>] lock_acquire+0x4b/0x6a
 [<ffffffff8026785b>] _spin_lock+0x25/0x31
 [<ffffffff8021d588>] cfq_set_request+0x21c/0x39f
 [<ffffffff8025148b>] elv_set_request+0x16/0x27
 [<ffffffff8021394b>] get_request+0x1a5/0x2ab
 [<ffffffff8022ab8e>] get_request_wait+0x24/0x153
 [<ffffffff8020bed8>] __make_request+0x376/0x43d
 [<ffffffff8021d045>] generic_make_request+0x21a/0x235
 [<ffffffff802355f3>] submit_bio+0xca/0xd3
 [<ffffffff802f2b4b>] mpage_bio_submit+0x22/0x26
 [<ffffffff8023b115>] mpage_readpages+0x138/0x149
 [<ffffffff8809446b>] :ext3:ext3_readpages+0x1a/0x1c
 [<ffffffff80213446>] __do_page_cache_readahead+0x12a/0x229
 [<ffffffff80234693>] blockable_page_cache_readahead+0x5f/0xc1
 [<ffffffff802145fc>] page_cache_readahead+0xdf/0x1bb
 [<ffffffff8020c0f7>] do_generic_mapping_read+0x158/0x47a
 [<ffffffff80217543>] generic_file_aio_read+0x157/0x1a8
 [<ffffffff8020ce33>] do_sync_read+0xe2/0x126
 [<ffffffff8020b557>] vfs_read+0xcc/0x172
 [<ffffffff80246a91>] kernel_read+0x3a/0x51
 [<ffffffff802403a0>] prepare_binprm+0xeb/0xf0
 [<ffffffff80241a7a>] do_execve+0x12c/0x253
 [<ffffffff80256356>] sys_execve+0x36/0x8b
 [<ffffffff80260527>] stub_execve+0x67/0xb0
DWARF2 unwinder stuck at stub_execve+0x67/0xb0

Leftover inexact backtrace:


time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip error_exit+0x10/0x96)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfdf00e)
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
time.c: Lost 300 timer tick(s)! rip check_poison_obj+0x44/0x1dc)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip _spin_unlock_irq+0x2e/0x31)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip _spin_unlock_irqrestore+0x42/0x47)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfe2c2b)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfe2c2b)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfe2c2b)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfe2c2b)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfe2c2b)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip 0x2b62adfc0f05)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)

--=-pUlZ5MfU96jyqp63XV77--

