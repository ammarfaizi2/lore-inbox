Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWJBPKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWJBPKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWJBPKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:10:51 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:18659
	"EHLO saville.com") by vger.kernel.org with ESMTP id S932511AbWJBPKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:10:50 -0400
Message-ID: <45212BFB.3080708@saville.com>
Date: Mon, 02 Oct 2006 08:10:51 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with
 2.6.18 kernel
References: <45206777.7020405@saville.com> <p733ba7hwlh.fsf@verdi.suse.de>
In-Reply-To: <p733ba7hwlh.fsf@verdi.suse.de>
Content-Type: multipart/mixed;
 boundary="------------060108090305000903040405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060108090305000903040405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andi,

Attached is the log file captured via a serial port with initcall_debug 
enabled and loglevel=7. BTW, if I didn't have a serial port what other 
mechanisms are available to capture the logs if the kernel won't boot?

Cheers,

Wink


--------------060108090305000903040405
Content-Type: text/plain;
 name="winkc2d1-log-1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="winkc2d1-log-1.txt"

[    0.000000] Linux version 2.6.18-w3 (wink@winkc2d1) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP PREEMPT Sun Oct 1 12:23:45 PDT 2006
[    0.000000] Command line: root=/dev/sda2 ro quiet splash initcall_debug console=ttyS0,115200n8 loglevel=7
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
[    0.000000]  BIOS-e820: 000000007ff80000 - 000000007ff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff8e000 - 000000007ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   524160
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7fb00000)
[    0.000000] PERCPU: Allocating 31616 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 515219
[    0.000000] Kernel command line: root=/dev/sda2 ro quiet splash initcall_debug console=ttyS0,115200n8 loglevel=7
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   84.420383] Console: colour VGA+ 80x25
[   84.674982] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   84.683050] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   84.690219] Checking aperture...
[   84.714386] Memory: 2057540k/2096640k available (4269k kernel code, 38684k reserved, 1554k data, 260k init)
[   84.783517] Calibrating delay using timer specific routine.. 4810.18 BogoMIPS (lpj=2405092)
[   84.791908] Mount-cache hash table entries: 256
[   84.796532] CPU: L1 I cache: 32K, L1 D cache: 32K
[   84.801248] CPU: L2 cache: 4096K
[   84.804474] using mwait in idle threads.
[   84.808392] CPU: Physical Processor ID: 0
[   84.812395] CPU: Processor Core ID: 0
[   84.816057] CPU0: Thermal monitoring enabled (TM2)
[   84.820844] Freeing SMP alternatives: 36k freed
[   84.825382] ACPI: Core revision 20060707
[   84.855783] Using local APIC timer interrupts.
[   84.901726] result 16695787
[   84.904513] Detected 16.695 MHz APIC timer.
[   84.909286] Booting processor 1/2 APIC 0x1
[   84.923894] Initializing CPU#1
[   85.000999] Calibrating delay using timer specific routine.. 6517.75 BogoMIPS (lpj=3258877)
[   85.001005] CPU: L1 I cache: 32K, L1 D cache: 32K
[   85.001006] CPU: L2 cache: 4096K
[   85.001008] CPU: Physical Processor ID: 0
[   85.001009] CPU: Processor Core ID: 1
[   85.001014] CPU1: Thermal monitoring enabled (TM2)
[   85.001424] Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[   85.002012] Brought up 2 CPUs
[   85.043275] testing NMI watchdog ... OK.
[   85.057199] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   85.063364] time.c: Detected 2404.196 MHz processor.
[   85.201853] migration_cost=21
[   85.205085] Calling initcall 0xffffffff807cfe40: cpufreq_tsc+0x0/0x70()
[   85.211721] Calling initcall 0xffffffff807d4980: init_smp_flush+0x0/0x70()
[   85.219063] Calling initcall 0xffffffff807dc760: init_elf32_binfmt+0x0/0x10()
[   85.226230] Calling initcall 0xffffffff807de210: helper_init+0x0/0x40()
[   85.232869] Calling initcall 0xffffffff807de5c0: pm_init+0x0/0x40()
[   85.239162] Calling initcall 0xffffffff807de690: ksysfs_init+0x0/0x40()
[   85.245804] Calling initcall 0xffffffff807e10b0: filelock_init+0x0/0x40()
[   85.252621] Calling initcall 0xffffffff807e1d30: init_misc_binfmt+0x0/0x40()
[   85.259689] Calling initcall 0xffffffff807e1d70: init_script_binfmt+0x0/0x10()
[   85.266935] Calling initcall 0xffffffff807e1d80: init_elf_binfmt+0x0/0x10()
[   85.273913] Calling initcall 0xffffffff807e35e0: debugfs_init+0x0/0x50()
[   85.280643] Calling initcall 0xffffffff807ef670: sock_init+0x0/0x70()<7>Losing some ticks... checking if CPU frequency changed.
[   85.292121] 
[   85.293630] Calling initcall 0xffffffff807f01d0: netlink_proto_init+0x0/0x190()
[   85.300958] NET: Registered protocol family 16
[   85.305397] Calling initcall 0xffffffff807e4380: kobject_uevent_init+0x0/0x40()
[   85.312724] Calling initcall 0xffffffff807e4500: pcibus_class_init+0x0/0x10()
[   85.319886] Calling initcall 0xffffffff807e4e50: pci_driver_init+0x0/0x10()
[   85.326878] Calling initcall 0xffffffff807e5990: lcd_class_init+0x0/0x10()
[   85.333773] Calling initcall 0xffffffff807e59a0: backlight_class_init+0x0/0x10()
[   85.341194] Calling initcall 0xffffffff807e7861: dock_init+0x0/0x46()
[   85.347715] Calling initcall 0xffffffff807e89a0: tty_class_init+0x0/0x30()
[   85.354623] Calling initcall 0xffffffff807e91c0: vtconsole_class_init+0x0/0xd0()
[   85.362081] Calling initcall 0xffffffff807d37f0: mtrr_if_init+0x0/0x80()
[   85.368805] Calling initcall 0xffffffff807e54b0: acpi_pci_init+0x0/0x40()
[   85.375628] ACPI: bus type pci registered
[   85.379631] Calling initcall 0xffffffff807e710d: init_acpi_device_notify+0x0/0x48()
[   85.387310] Calling initcall 0xffffffff807ee6e0: pci_access_init+0x0/0x30()
[   85.394294] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   85.400714] PCI: Not using MMCONFIG.
[   85.404277] PCI: Using configuration type 1
[   85.408456] Calling initcall 0xffffffff807d3640: mtrr_init_finialize+0x0/0x40()
[   85.415786] Calling initcall 0xffffffff807daaf0: topology_init+0x0/0x40()
[   85.422625] Calling initcall 0xffffffff807ddf70: param_sysfs_init+0x0/0x210()
[   85.430776] Calling initcall 0xffffffff807e18d0: init_bio+0x0/0x110()
[   85.437285] Calling initcall 0xffffffff807e4200: genhd_device_init+0x0/0x60()
[   85.444485] Calling initcall 0xffffffff807e54f0: fbmem_init+0x0/0xa0()
[   85.451043] Calling initcall 0xffffffff807e6f25: acpi_init+0x0/0x1e8()
[   85.464257] ACPI: Interpreter enabled
[   85.467917] ACPI: Using IOAPIC for interrupt routing
[   85.473282] Calling initcall 0xffffffff807e7236: acpi_ec_init+0x0/0x5e()
[   85.480007] Calling initcall 0xffffffff807e7b1e: acpi_pci_root_init+0x0/0x27()
[   85.487251] Calling initcall 0xffffffff807e7c0a: acpi_pci_link_init+0x0/0x46()
[   85.494489] Calling initcall 0xffffffff807e7cea: acpi_power_init+0x0/0x76()
[   85.501475] Calling initcall 0xffffffff807e7e3c: acpi_system_init+0x0/0xc3()
[   85.508542] Calling initcall 0xffffffff807e7eff: acpi_event_init+0x0/0x3e()
[   85.515529] Calling initcall 0xffffffff807e7f3d: acpi_scan_init+0x0/0x1a4()
[   85.523211] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   85.529604] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   85.536141] PCI: Transparent bridge - 0000:00:1e.0
[   85.547106] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   85.554558] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   85.561985] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   85.569429] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   85.576859] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   85.584304] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   85.591750] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   85.600344] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12 14 15)
[   85.607687] Calling initcall 0xffffffff807e8254: acpi_cm_sbs_init+0x0/0xc()
[   85.614682] Calling initcall 0xffffffff807e8260: pnp_init+0x0/0x30()
[   85.621063] Linux Plug and Play Support v0.97 (c) Adam Belay
[   85.626706] Calling initcall 0xffffffff807e8420: pnpacpi_init+0x0/0x70()
[   85.633421] pnp: PnP ACPI init
[   85.638555] pnp: PnP ACPI: found 13 devices
[   85.642727] Calling initcall 0xffffffff807e8e80: misc_init+0x0/0x90()
[   85.649207] Calling initcall 0xffffffff807e9720: mod_init+0x0/0x280()
[   85.657054] intel_rng: FWH not detected
[   85.660894] Calling initcall 0xffffffff807e99a0: mod_init+0x0/0xc0()
[   85.667283] Calling initcall 0xffffffff807e9a60: mod_init+0x0/0xc0()
[   85.673663] Calling initcall 0xffffffff804bdda0: cn_init+0x0/0xe0()
[   85.679992] Calling initcall 0xffffffff807ec270: init_scsi+0x0/0x90()
[   85.686569] SCSI subsystem initialized
[   85.690306] Calling initcall 0xffffffff807ec9c0: init_pcmcia_cs+0x0/0x50()
[   85.697208] Calling initcall 0xffffffff807ecb00: usb_init+0x0/0x110()
[   85.703725] usbcore: registered new interface driver usbfs
[   85.709216] usbcore: registered new interface driver hub
[   85.714538] usbcore: registered new device driver usb
[   85.719579] Calling initcall 0xffffffff807eced0: serio_init+0x0/0xf0()
[   85.726579] Calling initcall 0xffffffff807ed350: gameport_init+0x0/0xe0()
[   85.733403] Calling initcall 0xffffffff807ed430: input_init+0x0/0x120()
[   85.740050] Calling initcall 0xffffffff807ed850: rtc_init+0x0/0x50()
[   85.746438] Calling initcall 0xffffffff807ed8a0: i2c_init+0x0/0x40()
[   85.752850] Calling initcall 0xffffffff807ee710: pci_acpi_init+0x0/0xb0()
[   85.759659] PCI: Using ACPI for IRQ routing
[   85.763828] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   85.772070] Calling initcall 0xffffffff807ee7c0: pci_legacy_init+0x0/0x130()
[   85.779141] Calling initcall 0xffffffff807eed80: pcibios_irq_init+0x0/0x540()
[   85.786295] Calling initcall 0xffffffff807ef2c0: pcibios_init+0x0/0x70()
[   85.793075] Calling initcall 0xffffffff807ef740: proto_init+0x0/0x40()
[   85.799627] Calling initcall 0xffffffff807ef8e0: net_dev_init+0x0/0x210()
[   85.806448] Calling initcall 0xffffffff807f01c0: fib_rules_init+0x0/0x10()
[   85.813335] Calling initcall 0xffffffff807f0360: genl_init+0x0/0xb0()
[   85.819808] Calling initcall 0xffffffff807cff40: late_hpet_init+0x0/0xb0()
[   85.826703] Calling initcall 0xffffffff807d3070: pci_iommu_init+0x0/0x20()
[   85.833603] PCI-GART: No AMD northbridge found.
[   85.838118] Calling initcall 0xffffffff807e1030: init_pipe_fs+0x0/0x50()
[   85.844849] Calling initcall 0xffffffff807e8121: acpi_motherboard_init+0x0/0x133()
[   85.852979] Calling initcall 0xffffffff807e8390: pnp_system_init+0x0/0x10()
[   85.859987] pnp: 00:06: ioport range 0x290-0x297 has been reserved
[   85.866162] Calling initcall 0xffffffff807e8880: chr_dev_init+0x0/0x90()
[   85.873036] Calling initcall 0xffffffff807eacd0: firmware_class_init+0x0/0x80()
[   85.880364] Calling initcall 0xffffffff807eca10: init_pcmcia_bus+0x0/0x50()
[   85.887346] Calling initcall 0xffffffff807eda00: cpufreq_gov_performance_init+0x0/0x10()
[   85.895453] Calling initcall 0xffffffff807eda20: cpufreq_gov_userspace_init+0x0/0x30()
[   85.903391] Calling initcall 0xffffffff807ee0f0: pcibios_assign_resources+0x0/0x90()
[   85.911172] PCI: Bridge: 0000:00:01.0
[   85.914824]   IO window: c000-cfff
[   85.918224]   MEM window: faa00000-feafffff
[   85.922400]   PREFETCH window: cff00000-efefffff
[   85.927009] PCI: Bridge: 0000:00:1c.0
[   85.930666]   IO window: disabled.
[   85.934066]   MEM window: disabled.
[   85.937551]   PREFETCH window: cfe00000-cfefffff
[   85.942161] PCI: Bridge: 0000:00:1c.3
[   85.945818]   IO window: b000-bfff
[   85.949217]   MEM window: fa900000-fa9fffff
[   85.953393]   PREFETCH window: disabled.
[   85.957310] PCI: Bridge: 0000:00:1c.4
[   85.960969]   IO window: a000-afff
[   85.964367]   MEM window: fa800000-fa8fffff
[   85.968543]   PREFETCH window: disabled.
[   85.972463] PCI: Bridge: 0000:00:1e.0
[   85.976118]   IO window: disabled.
[   85.979969]   MEM window: fa700000-fa7fffff
[   85.984144]   PREFETCH window: disabled.
[   85.988073] GSI 16 sharing vector 0xA9 and IRQ 16
[   85.992766] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
[   86.000268] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
[   86.007767] GSI 17 sharing vector 0xB1 and IRQ 17
[   86.012455] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 177
[   86.019951] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 169
[   86.027436] Calling initcall 0xffffffff807f0eb0: inet_init+0x0/0x3e0()
[   86.034001] NET: Registered protocol family 2
[   86.046931] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   86.054152] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   86.063143] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   86.070376] TCP: Hash tables configured (established 262144 bind 65536)
[   86.076975] TCP reno registered
[   86.080154] Calling initcall 0xffffffff8020e040: time_init_device+0x0/0x30()
[   86.087287] Calling initcall 0xffffffff807d04b0: add_pcspkr+0x0/0x60()
[   86.093868] Calling initcall 0xffffffff807d1390: init_timer_sysfs+0x0/0x30()
[   86.100956] Calling initcall 0xffffffff807d1360: i8259A_init_sysfs+0x0/0x30()
[   86.108141] Calling initcall 0xffffffff807d18c0: vsyscall_init+0x0/0xb0()
[   86.114960] Calling initcall 0xffffffff807d1fd0: sbf_init+0x0/0xe0()
[   86.121336] Calling initcall 0xffffffff807d2e00: i8237A_init_sysfs+0x0/0x30()
[   86.128522] Calling initcall 0xffffffff807d32c0: mce_init_device+0x0/0x1b0()
[   86.135661] Calling initcall 0xffffffff807d31c0: periodic_mcheck_init+0x0/0x30()
[   86.143077] Calling initcall 0xffffffff807d34e0: thermal_throttle_init_device+0x0/0x60()
[   86.151194] Calling initcall 0xffffffff807d4680: msr_init+0x0/0x130()
[   86.157696] Calling initcall 0xffffffff807d47b0: microcode_init+0x0/0xa0()
[  106.118228] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
[  106.124743] Calling initcall 0xffffffff807d4850: cpuid_init+0x0/0x130()
[  106.131417] Calling initcall 0xffffffff807d5c70: init_lapic_sysfs+0x0/0x40()
[  106.138516] Calling initcall 0xffffffff807d6b30: ioapic_init_sysfs+0x0/0xf0()
[  106.145694] Calling initcall 0xffffffff807db670: cache_sysfs_init+0x0/0x60()
[  106.152913] Calling initcall 0xffffffff807db990: x8664_sysctl_init+0x0/0x20()
[  106.160456] Calling initcall 0xffffffff807dc430: aes_init+0x0/0x330()
[  106.166942] Calling initcall 0xffffffff807dc770: ia32_binfmt_init+0x0/0x20()
[  106.174017] Calling initcall 0xffffffff807dc790: init_syscall32+0x0/0x80()
[  106.180928] Calling initcall 0xffffffff807dc810: init_aout_binfmt+0x0/0x10()
[  106.188008] Calling initcall 0xffffffff807dd300: create_proc_profile+0x0/0x2c0()
[  106.195427] Calling initcall 0xffffffff807dd770: ioresources_init+0x0/0x50()
[  106.202501] Calling initcall 0xffffffff807dd8e0: timekeeping_init_device+0x0/0x30()
[  106.210206] Calling initcall 0xffffffff807ddb60: uid_cache_init+0x0/0x90()
[  106.217115] Calling initcall 0xffffffff807de180: init_posix_timers+0x0/0x90()
[  106.224279] Calling initcall 0xffffffff807de250: init_posix_cpu_timers+0x0/0x80()
[  106.231790] Calling initcall 0xffffffff807de360: latency_init+0x0/0x30()
[  106.238510] Calling initcall 0xffffffff807de3a0: init_clocksource_sysfs+0x0/0x60()
[  106.246127] Calling initcall 0xffffffff807de4b0: init_jiffies_clocksource+0x0/0x10()
[  106.253885] Calling initcall 0xffffffff807de4c0: init+0x0/0x90()
[  106.259931] Calling initcall 0xffffffff807de550: proc_dma_init+0x0/0x30()
[  106.266753] Calling initcall 0xffffffff8024ff30: percpu_modinit+0x0/0x80()
[  106.273653] Calling initcall 0xffffffff807de590: kallsyms_init+0x0/0x30()
[  106.280459] Calling initcall 0xffffffff807de600: crash_notes_memory_init+0x0/0x50()
[  106.288138] Calling initcall 0xffffffff807de650: ikconfig_init+0x0/0x40()
[  106.294953] Calling initcall 0xffffffff807dfc40: init_per_zone_pages_min+0x0/0x50()
[  106.302642] Calling initcall 0xffffffff807e0710: pdflush_init+0x0/0x20()
[  106.309386] Calling initcall 0xffffffff807e0750: kswapd_init+0x0/0x20()
[  106.316042] Calling initcall 0xffffffff807e0770: setup_vmstat+0x0/0x20()
[  106.322763] Calling initcall 0xffffffff807e0810: procswaps_init+0x0/0x30()
[  106.329664] Calling initcall 0xffffffff807e0840: init_tmpfs+0x0/0xd0()
[  106.336236] Calling initcall 0xffffffff807e0910: cpucache_init+0x0/0x40()
[  106.343051] Calling initcall 0xffffffff807e1080: fasync_init+0x0/0x30()
[  106.349696] Calling initcall 0xffffffff807e1800: aio_setup+0x0/0x70()
[  106.356188] Calling initcall 0xffffffff807e1a70: inotify_setup+0x0/0x10()
[  106.363000] Calling initcall 0xffffffff807e1a80: inotify_user_setup+0x0/0xc0()
[  106.370257] Calling initcall 0xffffffff807e1b40: eventpoll_init+0x0/0xf0()
[  106.377164] Calling initcall 0xffffffff807e1c30: init_sys32_ioctl+0x0/0x100()
[  106.384330] Calling initcall 0xffffffff807e1d90: init_mbcache+0x0/0x30()
[  106.391053] Calling initcall 0xffffffff807e1dc0: dnotify_init+0x0/0x30()
[  106.397783] Calling initcall 0xffffffff807e2260: configfs_init+0x0/0xa0()
[  106.404602] Calling initcall 0xffffffff807e2300: init_devpts_fs+0x0/0x40()
[  106.411510] Calling initcall 0xffffffff807e2340: init_reiserfs_fs+0x0/0xa0()
[  106.419041] Calling initcall 0xffffffff807e2510: init_ext3_fs+0x0/0x70()
[  106.425782] Calling initcall 0xffffffff807e2640: journal_init+0x0/0xd0()
[  106.432514] Calling initcall 0xffffffff807e2710: init_ext2_fs+0x0/0x70()
[  106.439253] Calling initcall 0xffffffff807e27c0: init_cramfs_fs+0x0/0x30()
[  106.446161] Calling initcall 0xffffffff807e27f0: init_ramfs_fs+0x0/0x10()
[  106.452961] Calling initcall 0xffffffff807e2810: init_minix_fs+0x0/0x60()
[  106.459769] Calling initcall 0xffffffff807e28b0: init_fat_fs+0x0/0x50()
[  106.466415] Calling initcall 0xffffffff807e2900: init_msdos_fs+0x0/0x10()
[  106.473232] Calling initcall 0xffffffff807e2910: init_vfat_fs+0x0/0x10()
[  106.479959] Calling initcall 0xffffffff807e2920: init_iso9660_fs+0x0/0x70()
[  106.486950] Calling initcall 0xffffffff807e2ae0: init_nfs_fs+0x0/0xd0()
[  106.493628] Calling initcall 0xffffffff807e2da0: init_nfsd+0x0/0xb0()
[  106.500090] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  106.506545] Calling initcall 0xffffffff807e2e50: init_nlm+0x0/0x30()
[  106.512935] Calling initcall 0xffffffff807e2e80: init_nls_ascii+0x0/0x10()
[  106.519843] Calling initcall 0xffffffff807e2e90: init_nls_iso8859_1+0x0/0x10()
[  106.527088] Calling initcall 0xffffffff807e2ea0: init_smb_fs+0x0/0x70()
[  106.533728] Calling initcall 0xffffffff807e2f10: init_ntfs_fs+0x0/0x1e0()
[  106.540536] NTFS driver 2.1.27 [Flags: R/W].
[  106.544813] Calling initcall 0xffffffff807e30f0: init_romfs_fs+0x0/0x60()
[  106.551625] Calling initcall 0xffffffff807e3150: init_autofs_fs+0x0/0x10()
[  106.558523] Calling initcall 0xffffffff807e3160: init_autofs4_fs+0x0/0x10()
[  106.565501] initcall at 0xffffffff807e3160: init_autofs4_fs+0x0/0x10(): returned with error code -16
[  106.574650] Calling initcall 0xffffffff807e31c0: fuse_init+0x0/0x120()
[  106.581213] fuse init (API version 7.7)
[  106.585067] Calling initcall 0xffffffff807e32f0: init_udf_fs+0x0/0x60()
[  106.591716] Calling initcall 0xffffffff807e3350: init_jfs_fs+0x0/0x210()
[  106.598459] JFS: nTxBlock = 8192, nTxLock = 65536
[  106.606349] Calling initcall 0xffffffff807e3630: ipc_init+0x0/0x20()
[  106.612759] Calling initcall 0xffffffff807e3890: init_mqueue_fs+0x0/0xf0()
[  106.619700] Calling initcall 0xffffffff807e3980: crypto_algapi_init+0x0/0x10()
[  106.626952] Calling initcall 0xffffffff807e39c0: cryptomgr_init+0x0/0x10()
[  106.633852] Calling initcall 0xffffffff807e39d0: hmac_module_init+0x0/0x10()
[  106.640927] Calling initcall 0xffffffff807e39e0: init+0x0/0x60()
[  106.646973] Calling initcall 0xffffffff807e3a40: init+0x0/0x10()
[  106.652998] Calling initcall 0xffffffff807e3a50: init+0x0/0x10()
[  106.659035] Calling initcall 0xffffffff807e3a60: init+0x0/0x10()
[  106.665079] Calling initcall 0xffffffff807e3a70: init+0x0/0x10()
[  106.671590] Calling initcall 0xffffffff807e3a80: init+0x0/0x40()
[  106.677618] Calling initcall 0xffffffff807e3ac0: init+0x0/0x70()
[  106.683655] Calling initcall 0xffffffff807e3b30: init+0x0/0x70()
[  106.689700] Calling initcall 0xffffffff807e3ba0: crypto_ecb_module_init+0x0/0x10()
[  106.697300] Calling initcall 0xffffffff807e3bb0: crypto_cbc_module_init+0x0/0x10()
[  106.704891] Calling initcall 0xffffffff807e3bc0: init+0x0/0x40()
[  106.710921] Calling initcall 0xffffffff807e3c00: init+0x0/0x10()
[  106.716965] Calling initcall 0xffffffff807e3c10: init+0x0/0x10()
[  106.723009] Calling initcall 0xffffffff807e3c20: init+0x0/0x40()
[  106.729046] Calling initcall 0xffffffff807e3c60: aes_init+0x0/0x330()
[  106.735537] Calling initcall 0xffffffff807e3f90: init+0x0/0x10()
[  106.741576] Calling initcall 0xffffffff807e3fa0: init+0x0/0x10()
[  106.747620] Calling initcall 0xffffffff807e3fb0: arc4_init+0x0/0x10()
[  106.754088] Calling initcall 0xffffffff807e3fc0: init+0x0/0x70()
[  106.760117] Calling initcall 0xffffffff807e4030: init+0x0/0x10()
[  106.766161] Calling initcall 0xffffffff807e4040: init+0x0/0x10()
[  106.772197] Calling initcall 0xffffffff807e4050: init+0x0/0x10()
[  106.778233] Calling initcall 0xffffffff807e4060: michael_mic_init+0x0/0x10()
[  106.785306] Calling initcall 0xffffffff807e4070: init+0x0/0x10()
[  106.791334] Calling initcall 0xffffffff807e4260: noop_init+0x0/0x10()
[  106.797803] io scheduler noop registered
[  106.801746] Calling initcall 0xffffffff807e4270: as_init+0x0/0x10()
[  106.808049] io scheduler anticipatory registered (default)
[  106.813557] Calling initcall 0xffffffff807e4280: deadline_init+0x0/0x10()
[  106.820363] io scheduler deadline registered
[  106.824644] Calling initcall 0xffffffff807e4290: cfq_init+0x0/0xb0()
[  106.831024] io scheduler cfq registered
[  106.834864] Calling initcall 0xffffffff807e4340: blk_trace_init+0x0/0x40()
[  106.841777] Calling initcall 0xffffffff80433370: pci_init+0x0/0x30()
[  106.850046] Calling initcall 0xffffffff807e4e60: pci_sysfs_init+0x0/0x40()
[  106.856997] Calling initcall 0xffffffff807e4ea0: pci_proc_init+0x0/0x70()
[  106.863827] Calling initcall 0xffffffff807e4f10: pcie_portdrv_init+0x0/0x50()
[  106.871079] assign_interrupt_mode Found MSI capability
[  106.876331] assign_interrupt_mode Found MSI capability
[  106.881615] assign_interrupt_mode Found MSI capability
[  106.886870] assign_interrupt_mode Found MSI capability
[  106.892090] Calling initcall 0xffffffff807e4f60: aer_service_init+0x0/0x10()
[  106.899178] Calling initcall 0xffffffff807e4f70: pci_hotplug_init+0x0/0x50()
[  106.906252] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  106.911811] Calling initcall 0xffffffff807e4fc0: dummyphp_init+0x0/0x60()
[  106.918626] fakephp: Fake PCI Hot Plug Controller Driver
[  106.924228] Calling initcall 0xffffffff807e5020: acpiphp_init+0x0/0x50()
[  106.930958] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[  106.938716] Calling initcall 0xffffffff807e5290: ibm_acpiphp_init+0x0/0x1a0()
[  106.946009] acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[  106.971992] Calling initcall 0xffffffff807e58b0: fb_console_init+0x0/0xe0()
[  106.979005] Calling initcall 0xffffffff80457f60: rivafb_init+0x0/0x160()
[  106.985759] Calling initcall 0xffffffff80460a30: nvidiafb_init+0x0/0x240()
[  106.992698] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[  107.000200] nvidiafb: Device ID: 10de0391 
[  107.008307] nvidiafb: CRTC0 analog found
[  107.016390] nvidiafb: CRTC1 analog not found
[  107.042392] nvidiafb: EDID found from BUS1
[  107.200423] nvidiafb: EDID found from BUS2
[  107.204509] nvidiafb: CRTC 0 appears to have a CRT attached
[  107.210067] nvidiafb: Using CRT on CRTC 0
[  107.214820] nvidiafb: MTRR set to ON

--------------060108090305000903040405--
