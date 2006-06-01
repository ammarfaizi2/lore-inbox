Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWFABW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWFABW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 21:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWFABW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 21:22:27 -0400
Received: from xenotime.net ([66.160.160.81]:16586 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964883AbWFABW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 21:22:26 -0400
Date: Wed, 31 May 2006 18:25:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060531182507.aaf1f9fd.rdunlap@xenotime.net>
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
References: <20060530022925.8a67b613.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__31_May_2006_18_25_07_-0700_S_CO=W_vjh+WtOj_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__31_May_2006_18_25_07_-0700_S_CO=W_vjh+WtOj_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 May 2006 02:29:25 -0700 Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/


Some odd panic, reproducible.  .config attached.
Machine is Pentium-D with 2 GB RAM and SATA drives.


[    0.000000] Bootdata ok (command line is root=/dev/sda7 vga=0x31a psmouse.proto=imps selinux=0  resume=/dev/sda2 splash=silent debug console=ttyS0,57600n8 netconsole=6665@192.168.0.101/eth0,6666@192.168.0.104/00:14:22:d9:67:60 console=ttyUSB0,57600n8r console=tty1  initcall_debug)
[    0.000000] Linux version 2.6.17-rc5-mm1 (rddunlap@midway) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #1 SMP Wed May 31 15:14:19 PDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007f664000 (usable)
[    0.000000]  BIOS-e820: 000000007f664000 - 000000007f6e9000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007f6e9000 - 000000007f6ed000 (usable)
[    0.000000]  BIOS-e820: 000000007f6ed000 - 000000007f6ff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007f6ff000 - 000000007f700000 (usable)
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 INTEL                                 ) @ 0x00000000000fe020
[    0.000000] ACPI: RSDT (v001 INTEL  D945GNT  0x000009b7 MSFT 0x01000013) @ 0x000000007f6fde48
[    0.000000] ACPI: FADT (v001 INTEL  D945GNT  0x000009b7 MSFT 0x01000013) @ 0x000000007f6fcf10
[    0.000000] ACPI: MADT (v001 INTEL  D945GNT  0x000009b7 MSFT 0x01000013) @ 0x000000007f6fce10
[    0.000000] ACPI: WDDT (v001 INTEL  D945GNT  0x000009b7 MSFT 0x01000013) @ 0x000000007f6f7f90
[    0.000000] ACPI: MCFG (v001 INTEL  D945GNT  0x000009b7 MSFT 0x01000013) @ 0x000000007f6f7f10
[    0.000000] ACPI: ASF! (v032 INTEL  D945GNT  0x000009b7 MSFT 0x01000013) @ 0x000000007f6fcd10
[    0.000000] ACPI: SSDT (v001 INTEL     CpuPm 0x000009b7 MSFT 0x01000013) @ 0x000000007f6fdc10
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu0Ist 0x000009b7 MSFT 0x01000013) @ 0x000000007f6fda10
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu1Ist 0x000009b7 MSFT 0x01000013) @ 0x000000007f6fd810
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu2Ist 0x000009b7 MSFT 0x01000013) @ 0x000000007f6fd610
[    0.000000] ACPI: SSDT (v001 INTEL   Cpu3Ist 0x000009b7 MSFT 0x01000013) @ 0x000000007f6fd410
[    0.000000] ACPI: TCPA (v001 INTEL  TIANO    0x00000002 MSFT 0x01000013) @ 0x000000007f6e6d90
[    0.000000] ACPI: DSDT (v001 INTEL  D945GNT  0x000009b7 MSFT 0x01000013) @ 0x0000000000000000
[    0.000000] On node 0 totalpages: 512398
[    0.000000]   DMA zone: 2753 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 509645 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:4 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 80000000 (gap: 7f700000:80900000)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=/dev/sda7 vga=0x31a psmouse.proto=imps selinux=0  resume=/dev/sda2 splash=silent debug console=ttyS0,57600n8 netconsole=6665@192.168.0.101/eth0,6666@192.168.0.104/00:14:22:d9:67:60 console=ttyUSB0,57600n8r console=tty1  initcall_debug
[    0.000000] netconsole: local port 6665
[    0.000000] netconsole: local IP 192.168.0.101
[    0.000000] netconsole: interface eth0
[    0.000000] netconsole: remote port 6666
[    0.000000] netconsole: remote IP 192.168.0.104
[    0.000000] netconsole: remote ethernet address 00:14:22:d9:67:60
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   25.380581] Console: colour dummy device 80x25
[   26.188250] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   26.204064] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   26.218420] Checking aperture...
[   26.247610] Memory: 2045964k/2087936k available (2767k kernel code, 40628k reserved, 1240k data, 224k init)
[   26.409571] Calibrating delay using timer specific routine.. 6004.26 BogoMIPS (lpj=30021346)
[   26.426565] Mount-cache hash table entries: 256
[   26.435858] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   26.446262] CPU: L2 cache: 1024K
[   26.452679] using mwait in idle threads.
[   26.460479] CPU: Physical Processor ID: 0
[   26.469735] CPU: Processor Core ID: 0
[   26.477018] CPU0: Thermal monitoring enabled (TM1)
[   26.486560] Freeing SMP alternatives: 24k freed
[   26.497278]  tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
[   26.519875] Parsing all Control Methods:
[   26.527484] Table [DSDT](id 000A) - 528 Objects with 54 Devices 147 Methods 30 Regions
[   26.543798] Parsing all Control Methods:
[   26.551371] Table [SSDT](id 0004) - 10 Objects with 0 Devices 4 Methods 0 Regions
[   26.566731] Parsing all Control Methods:
[   26.574303] Table [SSDT](id 0005) - 5 Objects with 0 Devices 3 Methods 0 Regions
[   26.589490] Parsing all Control Methods:
[   26.597054] Table [SSDT](id 0006) - 5 Objects with 0 Devices 3 Methods 0 Regions
[   26.612238] Parsing all Control Methods:
[   26.619811] Table [SSDT](id 0007) - 5 Objects with 0 Devices 3 Methods 0 Regions
[   26.634990] Parsing all Control Methods:
[   26.642565] Table [SSDT](id 0008) - 5 Objects with 0 Devices 3 Methods 0 Regions
[   26.657639] ACPI Namespace successfully loaded at root ffffffff80529b20
[   26.671579] evxfevnt-0089 [02] enable                : Transition to ACPI mode successful
[   26.788186] Using local APIC timer interrupts.
[   26.830321] result 12500143
[   26.835866] Detected 12.500 MHz APIC timer.
[   26.849668] Booting processor 1/2 APIC 0x1
[   26.868194] Initializing CPU#1
[   27.018978] Calibrating delay using timer specific routine.. 6000.09 BogoMIPS (lpj=30000493)
[   27.018990] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   27.018993] CPU: L2 cache: 1024K
[   27.018996] CPU: Physical Processor ID: 0
[   27.018997] CPU: Processor Core ID: 1
[   27.019007] CPU1: Thermal monitoring enabled (TM1)
[   27.019245]               Intel(R) Pentium(R) D CPU 3.00GHz stepping 04
[   27.028976] APIC error on CPU1: 00(40)
[   27.028993] Brought up 2 CPUs
[   27.119902] testing NMI watchdog ... OK.
[   27.227673] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   27.239966] time.c: Detected 3000.048 MHz processor.
[   27.439186] migration_cost=399
[   27.448014] Calling initcall 0xffffffff80559ef0: cpufreq_tsc+0x0/0x6d()
[   27.461208] Calling initcall 0xffffffff8055e129: init_smp_flush+0x0/0x58()
[   27.474906] Calling initcall 0xffffffff80564a7a: init_elf32_binfmt+0x0/0x12()
[   27.490550] Calling initcall 0xffffffff8056619b: helper_init+0x0/0x2f()
[   27.503750] Calling initcall 0xffffffff80566423: pm_init+0x0/0x29()
[   27.516247] Calling initcall 0xffffffff805665f7: ksysfs_init+0x0/0x29()
[   27.529439] Calling initcall 0xffffffff8056854c: filelock_init+0x0/0x31()
[   27.542986] Calling initcall 0xffffffff80568dd6: init_misc_binfmt+0x0/0x3c()
[   27.557030] Calling initcall 0xffffffff80568e12: init_script_binfmt+0x0/0x12()
[   27.571420] Calling initcall 0xffffffff80568e24: init_elf_binfmt+0x0/0x12()
[   27.585287] Calling initcall 0xffffffff805698b1: debugfs_init+0x0/0x49()
[   27.598643] Calling initcall 0xffffffff80575ff8: sock_init+0x0/0x5a()
[   27.611538] Calling initcall 0xffffffff80576518: netlink_proto_init+0x0/0x17e()
[   27.626124] NET: Registered protocol family 16
[   27.634977] Calling initcall 0xffffffff80569edc: kobject_uevent_init+0x0/0x3c()
[   27.649550] Calling initcall 0xffffffff8056a01a: pcibus_class_init+0x0/0x12()
[   27.663774] Calling initcall 0xffffffff8056a84c: pci_driver_init+0x0/0x12()
[   27.677662] Calling initcall 0xffffffff8056e08f: tty_class_init+0x0/0x2a()
[   27.691371] Calling initcall 0xffffffff8055d4dc: mtrr_if_init+0x0/0x74()
[   27.704724] Calling initcall 0xffffffff8056a9de: pci_acpi_init+0x0/0x2e()
[   27.718244] ACPI: bus type pci registered
[   27.726214] Calling initcall 0xffffffff8056c7e2: init_acpi_device_notify+0x0/0x4b()
[   27.741470] Calling initcall 0xffffffff80575356: pci_access_init+0x0/0x1c()
[   27.755338] PCI: BIOS Bug: MCFG area is not E820-reserved
[   27.766073] PCI: Not using MMCONFIG.
[   27.773181] PCI: Using configuration type 1
[   27.781496] Calling initcall 0xffffffff8055d355: mtrr_init_finialize+0x0/0x34()
[   27.796057] Calling initcall 0xffffffff805636ef: topology_init+0x0/0x36()
[   27.809839] Calling initcall 0xffffffff80147401: pm_sysrq_init+0x0/0x1b()
[   27.823367] Calling initcall 0xffffffff80568325: init_bio+0x0/0x105()
[   27.836657] Calling initcall 0xffffffff80569d1b: genhd_device_init+0x0/0x33()
[   27.851014] Calling initcall 0xffffffff8056affd: fbmem_init+0x0/0x95()
[   27.864039] Calling initcall 0xffffffff8056c604: acpi_init+0x0/0x1de()
[   27.877042] ACPI: Subsystem revision 20060310
[   27.886383] evgpeblk-0951 [04] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
[   27.905663] evgpeblk-1048 [03] ev_initialize_gpe_bloc: Found 8 Wake, Enabled 1 Runtime GPEs in this block
[   27.926803] Completing Region/Field/Buffer/Package initialization:...........................................................................
[   27.956263] Initialized 29/30 Regions 0/0 Fields 22/22 Buffers 24/40 Packages (567 nodes)
[   27.972888] Executing all Device _STA and_INI methods:............................................................
[   27.993929] 60 Devices found - executed 0 _STA, 1 _INI methods
[   28.007242] ACPI: Interpreter enabled
[   28.014520] ACPI: Using IOAPIC for interrupt routing
[   28.024484] Calling initcall 0xffffffff8056c94d: acpi_ec_init+0x0/0x63()
[   28.037838] Calling initcall 0xffffffff8056d20b: acpi_pci_root_init+0x0/0x28()
[   28.052229] Calling initcall 0xffffffff8056d320: acpi_pci_link_init+0x0/0x48()
[   28.066616] Calling initcall 0xffffffff8056d41b: acpi_power_init+0x0/0x77()
[   28.080488] Calling initcall 0xffffffff8056d5b2: acpi_system_init+0x0/0xc0()
[   28.094532] Calling initcall 0xffffffff8056d672: acpi_event_init+0x0/0x3d()
[   28.108402] Calling initcall 0xffffffff8056d6af: acpi_debug_init+0x0/0xa8()
[   28.122278] Calling initcall 0xffffffff8056d757: acpi_scan_init+0x0/0x18e()
[   28.137642] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   28.147173] PCI: Probing PCI hardware (bus 00)
[   28.156068] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[   28.174188] Boot video device is 0000:00:02.0
[   28.183647] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   28.196982] PCI: Transparent bridge - 0000:00:1e.0
[   28.206591] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   28.232605] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[   28.248331] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[   28.262146] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12)
[   28.275964] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
[   28.289783] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[   28.303588] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[   28.319674] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11 12)
[   28.333481] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
[   28.347286] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
[   28.365226] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[   28.379046] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[   28.392591] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[   28.406129] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[   28.419669] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
[   28.436624] Calling initcall 0xffffffff8056da5a: pnp_init+0x0/0x20()
[   28.449290] Linux Plug and Play Support v0.97 (c) Adam Belay
[   28.460568] Calling initcall 0xffffffff8056dbc9: pnpacpi_init+0x0/0x6a()
[   28.473918] pnp: PnP ACPI init
[   28.490943] pnp: PnP ACPI: found 13 devices
[   28.499259] Calling initcall 0xffffffff8056e6c3: misc_init+0x0/0x80()
[   28.513336] Calling initcall 0xffffffff80571b62: phy_init+0x0/0x2f()
[   28.526123] Generic PHY: Registered new driver
[   28.534959] Calling initcall 0xffffffff8057293b: init_scsi+0x0/0xd9()
[   28.548867] SCSI subsystem initialized
[   28.556319] Calling initcall 0xffffffff80572e4c: usb_init+0x0/0xd5()
[   28.569122] usbcore: registered new driver usbfs
[   28.578421] usbcore: registered new driver hub
[   28.587388] Calling initcall 0xffffffff805735d1: serio_init+0x0/0x9f()
[   28.600451] Calling initcall 0xffffffff80573969: gameport_init+0x0/0x89()
[   28.614028] Calling initcall 0xffffffff805739f2: input_init+0x0/0x122()
[   28.627228] Calling initcall 0xffffffff80573c66: i2c_init+0x0/0x32()
[   28.640018] Calling initcall 0xffffffff80575372: pci_acpi_init+0x0/0xab()
[   28.653543] PCI: Using ACPI for IRQ routing
[   28.661860] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   28.678305] Calling initcall 0xffffffff8057541d: pci_legacy_init+0x0/0x124()
[   28.692348] Calling initcall 0xffffffff805758ef: pcibios_irq_init+0x0/0x4a4()
[   28.706562] Calling initcall 0xffffffff80575d93: pcibios_init+0x0/0x69()
[   28.720004] Calling initcall 0xffffffff805760ad: proto_init+0x0/0x34()
[   28.733010] Calling initcall 0xffffffff80576210: net_dev_init+0x0/0x1cb()
[   28.746555] Calling initcall 0xffffffff80576696: genl_init+0x0/0xaf()
[   28.759407] Calling initcall 0xffffffff80559fef: late_hpet_init+0x0/0xd1()
[   28.773105] Calling initcall 0xffffffff8055ce79: pci_iommu_init+0x0/0x12()
[   28.786812] PCI-GART: No AMD northbridge found.
[   28.795820] Calling initcall 0xffffffff805684d6: init_pipe_fs+0x0/0x49()
[   28.809189] Calling initcall 0xffffffff8056d924: acpi_motherboard_init+0x0/0x136()
[   28.824329] Calling initcall 0xffffffff8056db5e: pnp_system_init+0x0/0x12()
[   28.838314] pnp: 00:06: ioport range 0x500-0x53f has been reserved
[   28.850610] pnp: 00:06: ioport range 0x400-0x47f could not be reserved
[   28.863596] pnp: 00:06: ioport range 0x680-0x6ff has been reserved
[   28.875901] Calling initcall 0xffffffff8056df93: chr_dev_init+0x0/0x8a()
[   28.890130] Calling initcall 0xffffffff80573e16: cpufreq_gov_performance_init+0x0/0x12()
[   28.906250] Calling initcall 0xffffffff80573e3a: cpufreq_gov_userspace_init+0x0/0x20()
[   28.922027] Calling initcall 0xffffffff80574e1a: pcibios_assign_resources+0x0/0x8b()
[   28.937476] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[   28.949081] PCI: Bridge: 0000:00:1c.0
[   28.956357]   IO window: 1000-1fff
[   28.963118]   MEM window: 90100000-901fffff
[   28.971435]   PREFETCH window: disabled.
[   28.979236] PCI: Bridge: 0000:00:1c.2
[   28.986509]   IO window: disabled.
[   28.993271]   MEM window: 90300000-903fffff
[   29.001587]   PREFETCH window: disabled.
[   29.009385] PCI: Bridge: 0000:00:1c.3
[   29.016658]   IO window: disabled.
[   29.024810]   MEM window: 90400000-904fffff
[   29.033127]   PREFETCH window: disabled.
[   29.040926] PCI: Bridge: 0000:00:1c.4
[   29.048202]   IO window: disabled.
[   29.054961]   MEM window: 90500000-905fffff
[   29.063277]   PREFETCH window: disabled.
[   29.071074] PCI: Bridge: 0000:00:1c.5
[   29.078350]   IO window: disabled.
[   29.085109]   MEM window: 90600000-906fffff
[   29.093424]   PREFETCH window: disabled.
[   29.101223] PCI: Bridge: 0000:00:1e.0
[   29.108498]   IO window: disabled.
[   29.115258]   MEM window: 90000000-900fffff
[   29.123573]   PREFETCH window: disabled.
[   29.131388] ACPI (acpi_bus-0192): Device `PEX0]is not power manageable [20060310]
[   29.146298] GSI 16 sharing vector 0xA9 and IRQ 16
[   29.155653] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[   29.170556] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   29.183037] ACPI (acpi_bus-0192): Device `PEX2]is not power manageable [20060310]
[   29.197947] GSI 17 sharing vector 0xB1 and IRQ 17
[   29.207300] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 177
[   29.222200] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   29.234681] ACPI (acpi_bus-0192): Device `PEX3]is not power manageable [20060310]
[   29.249591] GSI 18 sharing vector 0xB9 and IRQ 18
[   29.258942] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 185
[   29.273841] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   29.286320] ACPI (acpi_bus-0192): Device `PEX4]is not power manageable [20060310]
[   29.301230] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
[   29.316128] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   29.328607] ACPI (acpi_bus-0192): Device `PEX5]is not power manageable [20060310]
[   29.343515] GSI 19 sharing vector 0xC1 and IRQ 19
[   29.352868] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 193
[   29.367767] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[   29.380241] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   29.392709] Calling initcall 0xffffffff80577008: inet_init+0x0/0x331()
[   29.405796] NET: Registered protocol family 2
[   29.508841] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   29.523569] TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
[   29.541890] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
[   29.556348] TCP: Hash tables configured (established 131072 bind 65536)
[   29.569519] TCP reno registered
[   29.575845] Calling initcall 0xffffffff8010c770: time_init_device+0x0/0x22()
[   29.590030] Calling initcall 0xffffffff8055a51c: add_pcspkr+0x0/0x43()
[   29.603165] Calling initcall 0xffffffff8055b67e: init_timer_sysfs+0x0/0x22()
[   29.617310] Calling initcall 0xffffffff8055b65c: i8259A_init_sysfs+0x0/0x22()
[   29.631632] Calling initcall 0xffffffff8055bb4d: vsyscall_init+0x0/0x9b()
[   29.645166] Calling initcall 0xffffffff8055c093: sbf_init+0x0/0xd7()
[   29.657824] Calling initcall 0xffffffff8055cc54: i8237A_init_sysfs+0x0/0x22()
[   29.672142] Calling initcall 0xffffffff8055d18b: mce_init_device+0x0/0x76()
[   29.686332] Calling initcall 0xffffffff8055cfb1: periodic_mcheck_init+0x0/0x24()
[   29.701075] Calling initcall 0xffffffff8055df35: msr_init+0x0/0xfa()
[   29.713951] Calling initcall 0xffffffff8055e02f: cpuid_init+0x0/0xfa()
[   29.727167] Calling initcall 0xffffffff8055f302: init_lapic_sysfs+0x0/0x33()
[   29.741313] Calling initcall 0xffffffff80560109: ioapic_init_sysfs+0x0/0xb6()
[   29.755635] Calling initcall 0xffffffff80563d56: cache_sysfs_init+0x0/0x5a()
[   29.770281] Calling initcall 0xffffffff805642d2: x8664_sysctl_init+0x0/0x19()
[   29.784514] Calling initcall 0xffffffff80564a8c: ia32_binfmt_init+0x0/0x19()
[   29.798562] Calling initcall 0xffffffff80564aa5: init_syscall32+0x0/0x5a()
[   29.812258] Calling initcall 0xffffffff80564aff: init_aout_binfmt+0x0/0x12()
[   29.826298] Calling initcall 0xffffffff805657b9: create_proc_profile+0x0/0x246()
[   29.841033] Calling initcall 0xffffffff80565a7c: ioresources_init+0x0/0x42()
[   29.855077] Calling initcall 0xffffffff80565bb7: timekeeping_init_device+0x0/0x22()
[   29.870427] Calling initcall 0xffffffff80565cca: uid_cache_init+0x0/0x8c()
[   29.884154] Calling initcall 0xffffffff80565faa: param_sysfs_init+0x0/0x15d()
[   29.903349] Calling initcall 0xffffffff80566107: init_posix_timers+0x0/0x94()
[   29.917604] Calling initcall 0xffffffff805661ca: init_posix_cpu_timers+0x0/0x69()
[   29.932512] Calling initcall 0xffffffff80566273: init_clocksource_sysfs+0x0/0x50()
[   29.947688] Calling initcall 0xffffffff80566358: init_jiffies_clocksource+0x0/0x12()
[   29.963115] Calling initcall 0xffffffff8056636a: init+0x0/0x6c()
[   29.975147] Calling initcall 0xffffffff805663d6: proc_dma_init+0x0/0x25()
[   29.988769] Calling initcall 0xffffffff8014362e: percpu_modinit+0x0/0x73()
[   30.002473] Calling initcall 0xffffffff805663fb: kallsyms_init+0x0/0x28()
[   30.015996] Calling initcall 0xffffffff8056644c: ikconfig_init+0x0/0x3c()
[   30.029523] Calling initcall 0xffffffff805664fa: audit_init+0x0/0xab()
[   30.042524] audit: initializing netlink socket (disabled)
[   30.054554] audit(1149099139.660:1): initialized
[   30.063734] Calling initcall 0xffffffff805665a5: init_kprobes+0x0/0x52()
[   30.077094] Calling initcall 0xffffffff805672ee: init_per_zone_pages_min+0x0/0x41()
[   30.092353] Calling initcall 0xffffffff80567a74: pdflush_init+0x0/0x1a()
[   30.105803] Calling initcall 0xffffffff80567a8e: readahead_init+0x0/0xa6()
[   30.119552] Calling initcall 0xffffffff80567b59: kswapd_init+0x0/0x2b()
[   30.132792] Calling initcall 0xffffffff80567bc8: procswaps_init+0x0/0x25()
[   30.146490] Calling initcall 0xffffffff80567ca7: kprefetchd_init+0x0/0x3d()
[   30.160397] Calling initcall 0xffffffff80567d17: hugetlb_init+0x0/0x63()
[   30.173746] Total HugeTLB memory allocated, 0
[   30.182405] Calling initcall 0xffffffff80567d7a: init_tmpfs+0x0/0xe1()
[   30.195445] Calling initcall 0xffffffff80567e5b: cpucache_init+0x0/0x37()
[   30.208972] Calling initcall 0xffffffff8056851f: fasync_init+0x0/0x2d()
[   30.222173] Calling initcall 0xffffffff80568b3c: aio_setup+0x0/0x67()
[   30.235121] Calling initcall 0xffffffff80568ba3: inotify_setup+0x0/0x12()
[   30.248646] Calling initcall 0xffffffff80568bb5: inotify_user_setup+0x0/0xbc()
[   30.263092] Calling initcall 0xffffffff80568c71: eventpoll_init+0x0/0xd0()
[   30.276840] Calling initcall 0xffffffff80568d41: init_sys32_ioctl+0x0/0x95()
[   30.290910] Calling initcall 0xffffffff80568e36: dnotify_init+0x0/0x2d()
[   30.304287] Calling initcall 0xffffffff805692d2: configfs_init+0x0/0x98()
[   30.317839] Calling initcall 0xffffffff8056936a: init_devpts_fs+0x0/0x3a()
[   30.331549] Calling initcall 0xffffffff805693a4: init_ext3_fs+0x0/0x5b()
[   30.344917] Calling initcall 0xffffffff8056947d: journal_init+0x0/0xc2()
[   30.358361] Calling initcall 0xffffffff8056953f: init_ext2_fs+0x0/0x5a()
[   30.371732] Calling initcall 0xffffffff80569599: init_cramfs_fs+0x0/0x17()
[   30.385432] Calling initcall 0xffffffff805695b0: init_ramfs_fs+0x0/0x12()
[   30.398956] Calling initcall 0xffffffff805695d4: init_hugetlbfs_fs+0x0/0x7f()
[   30.413201] Calling initcall 0xffffffff8056968b: init_fat_fs+0x0/0x50()
[   30.426425] Calling initcall 0xffffffff805696db: init_msdos_fs+0x0/0x12()
[   30.439948] Calling initcall 0xffffffff805696ed: init_vfat_fs+0x0/0x12()
[   30.453294] Calling initcall 0xffffffff805696ff: init_iso9660_fs+0x0/0x6e()
[   30.467187] Calling initcall 0xffffffff805697d8: init_nls_cp437+0x0/0x12()
[   30.480881] Calling initcall 0xffffffff805697ea: init_nls_cp850+0x0/0x12()
[   30.494572] Calling initcall 0xffffffff805697fc: init_nls_ascii+0x0/0x12()
[   30.508267] Calling initcall 0xffffffff8056980e: init_nls_iso8859_1+0x0/0x12()
[   30.522652] Calling initcall 0xffffffff80569820: init_nls_iso8859_15+0x0/0x12()
[   30.537213] Calling initcall 0xffffffff80569832: init_nls_utf8+0x0/0x25()
[   30.550733] Calling initcall 0xffffffff80569857: init_romfs_fs+0x0/0x5a()
[   30.565557] Calling initcall 0xffffffff805698fa: ipc_init+0x0/0x17()
[   30.578240] Calling initcall 0xffffffff80569adb: init_mqueue_fs+0x0/0xe9()
[   30.591984] Calling initcall 0xffffffff80569d4e: noop_init+0x0/0x12()
[   30.604813] io scheduler noop registered
[   30.612616] Calling initcall 0xffffffff80569d60: as_init+0x0/0x57()
[   30.625118] io scheduler anticipatory registered
[   30.634306] Calling initcall 0xffffffff80569db7: deadline_init+0x0/0x58()
[   30.647855] io scheduler deadline registered
[   30.656349] Calling initcall 0xffffffff80569e0f: cfq_init+0x0/0xcd()
[   30.669074] io scheduler cfq registered (default)
[   30.678444] Calling initcall 0xffffffff802015a8: pci_init+0x0/0x32()
[   30.691114]  0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x0f10
[   30.703578]  0000:00:1d.0: Performing full reset
[   30.712770]  0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x0010
[   30.725234]  0000:00:1d.1: Performing full reset
[   30.734424]  0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x0010
[   30.746887]  0000:00:1d.2: Performing full reset
[   30.756076]  0000:00:1d.3: uhci_check_and_reset_hc: legsup = 0x0010
[   30.768541]  0000:00:1d.3: Performing full reset
[   30.777984] Calling initcall 0xffffffff8056a85e: pci_sysfs_init+0x0/0x37()
[   30.791791] Calling initcall 0xffffffff8056a895: pci_proc_init+0x0/0x6f()
[   30.805367] Calling initcall 0xffffffff8056a904: pcie_portdrv_init+0x0/0x2b()
[   30.819758] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
[   30.834658] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   30.847164] assign_interrupt_mode Found MSI capability
[   30.857475] Allocate Port Service[0000:00:1c.0:pcie00]
[   30.867816] Allocate Port Service[0000:00:1c.0:pcie02]
[   30.878165] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 177
[   30.893064] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[   30.905569] assign_interrupt_mode Found MSI capability
[   30.915860] Allocate Port Service[0000:00:1c.2:pcie00]
[   30.926191] Allocate Port Service[0000:00:1c.2:pcie02]
[   30.936534] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 185
[   30.951433] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   30.963938] assign_interrupt_mode Found MSI capability
[   30.974228] Allocate Port Service[0000:00:1c.3:pcie00]
[   30.984554] Allocate Port Service[0000:00:1c.3:pcie02]
[   30.994897] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
[   31.009804] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[   31.022308] assign_interrupt_mode Found MSI capability
[   31.032598] Allocate Port Service[0000:00:1c.4:pcie00]
[   31.042932] Allocate Port Service[0000:00:1c.4:pcie02]
[   31.053272] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 193
[   31.068174] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[   31.080679] assign_interrupt_mode Found MSI capability
[   31.090969] Allocate Port Service[0000:00:1c.5:pcie00]
[   31.101302] Allocate Port Service[0000:00:1c.5:pcie02]
[   31.111650] Calling initcall 0xffffffff8056a92f: pci_hotplug_init+0x0/0x57()
[   31.125702] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   31.136783] Calling initcall 0xffffffff8056af93: fb_console_init+0x0/0x6a()
[   31.150652] Calling initcall 0xffffffff8056b7c4: vesafb_init+0x0/0x235()
[   31.164237] vesafb: framebuffer at 0x80000000, mapped to 0xffffc20000080000, using 5120k, total 7872k
[   31.182585] vesafb: mode is 1280x1024x16, linelength=2560, pages=2
[   31.194877] vesafb: scrolling: redraw
[   31.202154] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   31.260457] Console: switching to colour frame buffer device 160x64
[   31.320013] fb0: VESA VGA frame buffer device
[   31.328916] Calling initcall 0xffffffff8056bbab: vga16fb_init+0x0/0xb1()
[   31.342853] vga16fb: initializing
[   31.349618] vga16fb: mapped to 0xffff8100000a0000
[   31.359368] fb1: VGA16 VGA frame buffer device
[   31.368445] Calling initcall 0xffffffff8056c82d: acpi_ac_init+0x0/0x60()
[   31.382190] Calling initcall 0xffffffff8056c88d: acpi_battery_init+0x0/0x60()
[   31.396816] Calling initcall 0xffffffff8056c8ed: acpi_button_init+0x0/0x60()
[   31.411273] ACPI: Power Button (FF) [PWRF]
[   31.419655] ACPI: Sleep Button (CM) [SLPB]
[   31.428026] Calling initcall 0xffffffff8056cf2e: acpi_fan_init+0x0/0x60()
[   31.441935] Calling initcall 0xffffffff8056cf8e: acpi_video_init+0x0/0x60()
[   31.456455] Calling initcall 0xffffffff8056cfee: hotkey_init+0x0/0x21d()
[   31.470178] Using specific hotkey driver
[   31.478180] Calling initcall 0xffffffff8056d2e8: irqrouter_init_sysfs+0x0/0x38()
[   31.493427] Calling initcall 0xffffffff8056d492: acpi_processor_init+0x0/0x80()
[   31.509012] ACPI Error (acpi_processor-0474): Getting cpuindex for acpiid 0x3 [20060310]
[   31.525593] ACPI Error (acpi_processor-0474): Getting cpuindex for acpiid 0x4 [20060310]
[   31.542165] Calling initcall 0xffffffff8056d512: acpi_container_init+0x0/0x40()
[   31.561015] Calling initcall 0xffffffff8056d552: acpi_thermal_init+0x0/0x60()
[   31.575651] Calling initcall 0xffffffff8056e02c: rand_initialize+0x0/0x2c()
[   31.589929] Calling initcall 0xffffffff8056e0b9: tty_init+0x0/0x1cd()
[   31.609984] Calling initcall 0xffffffff8056e286: pty_init+0x0/0x43d()
[   31.683014] Calling initcall 0xffffffff8056ec8d: lp_init_module+0x0/0x253()
[   31.697397] lp: driver loaded but no devices found
[   31.707184] Calling initcall 0xffffffff8056eee0: hpet_init+0x0/0x6b()
[   31.720507] Calling initcall 0xffffffff8056ef4b: rtc_generic_init+0x0/0x65()
[   31.734949] Generic RTC Driver v1.07
[   31.742347] Calling initcall 0xffffffff8056efb0: nvram_init+0x0/0x89()
[   31.755821] Non-volatile memory driver v1.2
[   31.764359] Calling initcall 0xffffffff8056f039: ppdev_init+0x0/0xcb()
[   31.777826] ppdev: user-space parallel port driver
[   31.787615] Calling initcall 0xffffffff8056f104: watchdog_init+0x0/0xb4()
[   31.801616] Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
[   31.820456] Calling initcall 0xffffffff8056f1b8: agp_init+0x0/0x26()
[   31.833472] Linux agpgart interface v0.101 (c) Dave Jones
[   31.844491] Calling initcall 0xffffffff8056f2e1: drm_core_init+0x0/0x140()
[   31.858588] [drm] Initialized drm 1.0.1 20051102
[   31.868011] Calling initcall 0xffffffff8056f4d5: hangcheck_init+0x0/0x7e()
[   31.891941] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   31.920508] Hangcheck: Using monotonic_clock().
[   31.940326] Calling initcall 0xffffffff8056f553: cn_init+0x0/0xc4()
[   31.964092] Calling initcall 0xffffffff8056f617: cn_proc_init+0x0/0x3a()
[   31.988759] Calling initcall 0xffffffff8056fa77: serial8250_init+0x0/0x13a()
[   32.014276] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   32.041916] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   32.066625] Calling initcall 0xffffffff805700da: parport_default_proc_register+0x0/0x1d()
[   32.095493] Calling initcall 0xffffffff805703ed: parport_pc_init+0x0/0x189()
[   32.122329] parport: PnPBIOS parport detected.
[   32.144066] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
[   32.246535] lp0: using parport0 (interrupt-driven).
[   32.269604] lp0: console ready
[   32.289304] Calling initcall 0xffffffff8057068b: firmware_class_init+0x0/0x70()
[   32.317882] Calling initcall 0xffffffff805706fb: topology_sysfs_init+0x0/0x4f()
[   32.346576] Calling initcall 0xffffffff805709e0: floppy_init+0x0/0x9cc()
[   32.374245] isa bounce pool size: 16 pages
[   32.396788] Floppy drive(s): fd0 is 1.44M
[   32.439721] FDC 0 is a post-1991 82077
[   32.462942] Calling initcall 0xffffffff805713ac: rd_init+0x0/0x1c7()
[   32.492645] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[   32.522977] Calling initcall 0xffffffff805715cc: loop_init+0x0/0x2c9()
[   32.552729] loop: loaded (max 8 devices)
[   32.576389] Calling initcall 0xffffffff80571895: pkt_init+0x0/0xe8()
[   32.605189] Calling initcall 0xffffffff8057197d: mm_init+0x0/0x1a0()
[   32.633698] v2.3 : Micro Memory(tm) PCI memory board block driver
[   32.661727] MM: desc_per_page = 128
[   32.684296] Calling initcall 0xffffffff80571b1d: e1000_init_module+0x0/0x45()
[   32.714528] Intel(R) PRO/1000 Network Driver - version 7.0.38-k4
[   32.742536] Copyright (c) 1999-2006 Intel Corporation.
[   32.768884] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
[   32.800120] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   32.909145] e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:13:20:e3:97:02
[   33.023464] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   33.053958] Calling initcall 0xffffffff80571bf5: net_olddevs_init+0x0/0xb7()
[   33.085102] Calling initcall 0xffffffff80571d81: dummy_init_module+0x0/0xb9()
[   33.116386] Calling initcall 0xffffffff80571e3a: tun_init+0x0/0x64()
[   33.145936] tun: Universal TUN/TAP device driver, 1.6
[   33.172747] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   33.201906] Calling initcall 0xffffffff802b4568: init_netconsole+0x0/0x5e()
[   33.232729] netconsole: device eth0 not up yet, forcing it
[   36.489028] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
[   36.500245]  [<0000000000000000>] stext+0x7feff0e8/0xe8
[   36.549518] PGD 0 
[   36.570488] Oops: 0010 [1] SMP 
[   36.593713] last sysfs file: 
[   36.616496] CPU 0 
[   36.637392] Modules linked in:
[   36.660367] Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm1 #1
[   36.688549] RIP: 0010:[<0000000000000000>]  [<0000000000000000>] stext+0x7feff0e8/0xe8
[   36.704388] RSP: 0000:ffffffff804f4f98  EFLAGS: 00010006
[   36.749115] RAX: 0000000000001d00 RBX: ffffffff8054fec8 RCX: 0000000000000000
[   36.780475] RDX: ffffffff8054fec8 RSI: ffffffff80544d00 RDI: 000000000000003a
[   36.811700] RBP: ffffffff804f4fb0 R08: ffffffff8054e000 R09: 000000000000002f
[   36.842745] R10: ffff810003002970 R11: ffffffff80512300 R12: 000000000000003a
[   36.873626] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   36.904373] FS:  0000000000000000(0000) GS:ffffffff80542000(0000) knlGS:0000000000000000
[   36.937031] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[   36.964797] CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
[   36.995261] Process idle (pid: 0, threadinfo ffffffff8054e000, task ffffffff80441800)
[   37.027224] Stack: ffffffff8010b711 ffffffff80107d21 0000000000000000 ffffffff8054fef0 
[   37.043298]        ffffffff80109708  <EOI> 000020250cff65fa 10250c8b4865c900 1fd8e98148000000 
[   37.076996]        0003582444f70000 00fe6ebf12740000 
[   37.103370] Call Trace:
[   37.140640]  <IRQ> [<ffffffff8010b711>] do_IRQ+0x4f/0x5e
[   37.167285]  [<ffffffff80107d21>] mwait_idle+0x0/0x53
[   37.193322]  [<ffffffff80109708>] ret_from_intr+0x0/0xa
[   37.219723]  <EOI>
[   37.239638] 
[   37.239639] Code:  Bad RIP value.
[   37.280189] RIP  [<0000000000000000>] stext+0x7feff0e8/0xe8 RSP <ffffffff804f4f98>
[   37.310891] CR2: 0000000000000000
[   37.332934]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
[   37.362625]  BUG: warning at kernel/panic.c:138/panic()
[   37.388627] 
[   37.388629] Call Trace:
[   37.426958]  <IRQ> [<ffffffff8012a29b>] panic+0x1f9/0x21e
[   37.453041]  [<ffffffff801f7dd8>] __up_read+0xaa/0xb2
[   37.478499]  [<ffffffff80137d51>] blocking_notifier_call_chain+0x47/0x51
[   37.507365]  [<ffffffff8012ca06>] do_exit+0x8e/0x8e1
[   37.532615]  [<ffffffff803b03ce>] do_page_fault+0x77a/0x806
[   37.559092]  [<ffffffff801244b4>] move_tasks+0xf1/0x2a8
[   37.584878]  [<ffffffff803ae0a3>] _spin_unlock+0x9/0xb
[   37.610360]  [<ffffffff80109edd>] error_exit+0x0/0x84
[   37.635490]  [<ffffffff8010b711>] do_IRQ+0x4f/0x5e
[   37.659887]  [<ffffffff80107d21>] mwait_idle+0x0/0x53
[   37.684661]  [<ffffffff80109708>] ret_from_intr+0x0/0xa
[   37.709657]  <EOI>




---
~Randy

--Multipart=_Wed__31_May_2006_18_25_07_-0700_S_CO=W_vjh+WtOj_
Content-Type: application/octet-stream;
 name="config-2617-rc5mm1"
Content-Disposition: attachment;
 filename="config-2617-rc5mm1"
Content-Transfer-Encoding: base64

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4xNy1yYzUtbW0xCiMgV2VkIE1heSAzMSAxNTowNToyMiAy
MDA2CiMKQ09ORklHX1g4Nl82ND15CkNPTkZJR182NEJJVD15CkNPTkZJR19YODY9eQpDT05GSUdf
U0VNQVBIT1JFX1NMRUVQRVJTPXkKQ09ORklHX01NVT15CkNPTkZJR19SV1NFTV9HRU5FUklDX1NQ
SU5MT0NLPXkKQ09ORklHX0dFTkVSSUNfSFdFSUdIVD15CkNPTkZJR19HRU5FUklDX0NBTElCUkFU
RV9ERUxBWT15CkNPTkZJR19YODZfQ01QWENIRz15CkNPTkZJR19FQVJMWV9QUklOVEs9eQpDT05G
SUdfR0VORVJJQ19JU0FfRE1BPXkKQ09ORklHX0dFTkVSSUNfSU9NQVA9eQpDT05GSUdfQVJDSF9N
QVlfSEFWRV9QQ19GREM9eQpDT05GSUdfRE1JPXkKQ09ORklHX0RFRkNPTkZJR19MSVNUPSIvbGli
L21vZHVsZXMvJFVOQU1FX1JFTEVBU0UvLmNvbmZpZyIKCiMKIyBDb2RlIG1hdHVyaXR5IGxldmVs
IG9wdGlvbnMKIwpDT05GSUdfRVhQRVJJTUVOVEFMPXkKQ09ORklHX0xPQ0tfS0VSTkVMPXkKQ09O
RklHX0lOSVRfRU5WX0FSR19MSU1JVD0zMgoKIwojIEdlbmVyYWwgc2V0dXAKIwpDT05GSUdfTE9D
QUxWRVJTSU9OPSIiCkNPTkZJR19MT0NBTFZFUlNJT05fQVVUTz15CkNPTkZJR19TV0FQPXkKQ09O
RklHX1NXQVBfUFJFRkVUQ0g9eQpDT05GSUdfU1lTVklQQz15CkNPTkZJR19QT1NJWF9NUVVFVUU9
eQojIENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUIGlzIG5vdCBzZXQKIyBDT05GSUdfVEFTS1NUQVRT
IGlzIG5vdCBzZXQKQ09ORklHX1NZU0NUTD15CiMgQ09ORklHX1VUU19OUyBpcyBub3Qgc2V0CkNP
TkZJR19BVURJVD15CkNPTkZJR19BVURJVFNZU0NBTEw9eQpDT05GSUdfSUtDT05GSUc9eQpDT05G
SUdfSUtDT05GSUdfUFJPQz15CiMgQ09ORklHX0NQVVNFVFMgaXMgbm90IHNldApDT05GSUdfUkVM
QVk9eQpDT05GSUdfSU5JVFJBTUZTX1NPVVJDRT0iIgpDT05GSUdfS0xJQkNfRVJSTElTVD15CkNP
TkZJR19LTElCQ19aTElCPXkKQ09ORklHX1VJRDE2PXkKQ09ORklHX1ZNODY9eQpDT05GSUdfQ0Nf
T1BUSU1JWkVfRk9SX1NJWkU9eQpDT05GSUdfRU1CRURERUQ9eQpDT05GSUdfS0FMTFNZTVM9eQoj
IENPTkZJR19LQUxMU1lNU19BTEwgaXMgbm90IHNldAojIENPTkZJR19LQUxMU1lNU19FWFRSQV9Q
QVNTIGlzIG5vdCBzZXQKQ09ORklHX0hPVFBMVUc9eQpDT05GSUdfUFJJTlRLPXkKQ09ORklHX0JV
Rz15CkNPTkZJR19FTEZfQ09SRT15CkNPTkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfUlRfTVVURVhF
Uz15CkNPTkZJR19GVVRFWD15CkNPTkZJR19FUE9MTD15CkNPTkZJR19TSE1FTT15CkNPTkZJR19T
TEFCPXkKIyBDT05GSUdfVElOWV9TSE1FTSBpcyBub3Qgc2V0CkNPTkZJR19CQVNFX1NNQUxMPTAK
IyBDT05GSUdfU0xPQiBpcyBub3Qgc2V0CgojCiMgTG9hZGFibGUgbW9kdWxlIHN1cHBvcnQKIwpD
T05GSUdfTU9EVUxFUz15CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKQ09ORklHX01PRFVMRV9GT1JD
RV9VTkxPQUQ9eQojIENPTkZJR19NT0RWRVJTSU9OUyBpcyBub3Qgc2V0CiMgQ09ORklHX01PRFVM
RV9TUkNWRVJTSU9OX0FMTCBpcyBub3Qgc2V0CkNPTkZJR19LTU9EPXkKQ09ORklHX1NUT1BfTUFD
SElORT15CgojCiMgQmxvY2sgbGF5ZXIKIwpDT05GSUdfTEJEPXkKIyBDT05GSUdfQkxLX0RFVl9J
T19UUkFDRSBpcyBub3Qgc2V0CkNPTkZJR19MU0Y9eQoKIwojIElPIFNjaGVkdWxlcnMKIwpDT05G
SUdfSU9TQ0hFRF9OT09QPXkKQ09ORklHX0lPU0NIRURfQVM9eQpDT05GSUdfSU9TQ0hFRF9ERUFE
TElORT15CkNPTkZJR19JT1NDSEVEX0NGUT15CiMgQ09ORklHX0RFRkFVTFRfQVMgaXMgbm90IHNl
dAojIENPTkZJR19ERUZBVUxUX0RFQURMSU5FIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfQ0ZR
PXkKIyBDT05GSUdfREVGQVVMVF9OT09QIGlzIG5vdCBzZXQKQ09ORklHX0RFRkFVTFRfSU9TQ0hF
RD0iY2ZxIgoKIwojIFByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcwojCkNPTkZJR19YODZfUEM9
eQojIENPTkZJR19YODZfVlNNUCBpcyBub3Qgc2V0CiMgQ09ORklHX01LOCBpcyBub3Qgc2V0CkNP
TkZJR19NUFNDPXkKIyBDT05GSUdfR0VORVJJQ19DUFUgaXMgbm90IHNldApDT05GSUdfWDg2X0wx
X0NBQ0hFX0JZVEVTPTEyOApDT05GSUdfWDg2X0wxX0NBQ0hFX1NISUZUPTcKQ09ORklHX1g4Nl9J
TlRFUk5PREVfQ0FDSEVfQllURVM9MTI4CkNPTkZJR19YODZfVFNDPXkKQ09ORklHX1g4Nl9HT09E
X0FQSUM9eQojIENPTkZJR19NSUNST0NPREUgaXMgbm90IHNldApDT05GSUdfWDg2X01TUj15CkNP
TkZJR19YODZfQ1BVSUQ9eQpDT05GSUdfWDg2X0hUPXkKQ09ORklHX1g4Nl9JT19BUElDPXkKQ09O
RklHX1g4Nl9MT0NBTF9BUElDPXkKQ09ORklHX01UUlI9eQpDT05GSUdfU01QPXkKIyBDT05GSUdf
U0NIRURfU01UIGlzIG5vdCBzZXQKQ09ORklHX1NDSEVEX01DPXkKQ09ORklHX1BSRUVNUFRfTk9O
RT15CiMgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZIGlzIG5vdCBzZXQKIyBDT05GSUdfUFJFRU1Q
VCBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUX0JLTD15CiMgQ09ORklHX05VTUEgaXMgbm90IHNl
dApDT05GSUdfQVJDSF9TUEFSU0VNRU1fRU5BQkxFPXkKQ09ORklHX0FSQ0hfRkxBVE1FTV9FTkFC
TEU9eQpDT05GSUdfU0VMRUNUX01FTU9SWV9NT0RFTD15CkNPTkZJR19GTEFUTUVNX01BTlVBTD15
CiMgQ09ORklHX0RJU0NPTlRJR01FTV9NQU5VQUwgaXMgbm90IHNldAojIENPTkZJR19TUEFSU0VN
RU1fTUFOVUFMIGlzIG5vdCBzZXQKQ09ORklHX0ZMQVRNRU09eQpDT05GSUdfRkxBVF9OT0RFX01F
TV9NQVA9eQojIENPTkZJR19TUEFSU0VNRU1fU1RBVElDIGlzIG5vdCBzZXQKQ09ORklHX1NQTElU
X1BUTE9DS19DUFVTPTQKQ09ORklHX1VOQUxJR05FRF9aT05FX0JPVU5EQVJJRVM9eQpDT05GSUdf
QURBUFRJVkVfUkVBREFIRUFEPXkKQ09ORklHX0RFQlVHX1JFQURBSEVBRD15CkNPTkZJR19SRUFE
QUhFQURfU01PT1RIX0FHSU5HPXkKQ09ORklHX05SX0NQVVM9OAojIENPTkZJR19IT1RQTFVHX0NQ
VSBpcyBub3Qgc2V0CkNPTkZJR19IUEVUX1RJTUVSPXkKQ09ORklHX0lPTU1VPXkKIyBDT05GSUdf
Q0FMR0FSWV9JT01NVSBpcyBub3Qgc2V0CkNPTkZJR19TV0lPVExCPXkKQ09ORklHX1g4Nl9NQ0U9
eQpDT05GSUdfWDg2X01DRV9JTlRFTD15CiMgQ09ORklHX1g4Nl9NQ0VfQU1EIGlzIG5vdCBzZXQK
IyBDT05GSUdfS0VYRUMgaXMgbm90IHNldAojIENPTkZJR19DUkFTSF9EVU1QIGlzIG5vdCBzZXQK
Q09ORklHX1BIWVNJQ0FMX1NUQVJUPTB4MTAwMDAwCkNPTkZJR19TRUNDT01QPXkKQ09ORklHX0ha
XzEwMD15CiMgQ09ORklHX0haXzI1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0haXzEwMDAgaXMgbm90
IHNldApDT05GSUdfSFo9MTAwCiMgQ09ORklHX1JFT1JERVIgaXMgbm90IHNldApDT05GSUdfSzhf
TkI9eQpDT05GSUdfR0VORVJJQ19IQVJESVJRUz15CkNPTkZJR19HRU5FUklDX0lSUV9QUk9CRT15
CkNPTkZJR19JU0FfRE1BX0FQST15CkNPTkZJR19HRU5FUklDX1BFTkRJTkdfSVJRPXkKCiMKIyBQ
b3dlciBtYW5hZ2VtZW50IG9wdGlvbnMKIwpDT05GSUdfUE09eQpDT05GSUdfUE1fTEVHQUNZPXkK
IyBDT05GSUdfUE1fREVCVUcgaXMgbm90IHNldAoKIwojIEFDUEkgKEFkdmFuY2VkIENvbmZpZ3Vy
YXRpb24gYW5kIFBvd2VyIEludGVyZmFjZSkgU3VwcG9ydAojCkNPTkZJR19BQ1BJPXkKQ09ORklH
X0FDUElfQUM9eQpDT05GSUdfQUNQSV9CQVRURVJZPXkKQ09ORklHX0FDUElfQlVUVE9OPXkKQ09O
RklHX0FDUElfVklERU89eQpDT05GSUdfQUNQSV9IT1RLRVk9eQpDT05GSUdfQUNQSV9GQU49eQoj
IENPTkZJR19BQ1BJX0RPQ0sgaXMgbm90IHNldApDT05GSUdfQUNQSV9QUk9DRVNTT1I9eQpDT05G
SUdfQUNQSV9USEVSTUFMPXkKIyBDT05GSUdfQUNQSV9BU1VTIGlzIG5vdCBzZXQKIyBDT05GSUdf
QUNQSV9BVExBUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfSUJNIGlzIG5vdCBzZXQKIyBDT05G
SUdfQUNQSV9UT1NISUJBIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNQSV9TT05ZIGlzIG5vdCBzZXQK
Q09ORklHX0FDUElfQkxBQ0tMSVNUX1lFQVI9MApDT05GSUdfQUNQSV9ERUJVRz15CkNPTkZJR19B
Q1BJX0VDPXkKQ09ORklHX0FDUElfUE9XRVI9eQpDT05GSUdfQUNQSV9TWVNURU09eQpDT05GSUdf
WDg2X1BNX1RJTUVSPXkKQ09ORklHX0FDUElfQ09OVEFJTkVSPXkKCiMKIyBDUFUgRnJlcXVlbmN5
IHNjYWxpbmcKIwpDT05GSUdfQ1BVX0ZSRVE9eQpDT05GSUdfQ1BVX0ZSRVFfVEFCTEU9eQojIENP
TkZJR19DUFVfRlJFUV9ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19DUFVfRlJFUV9TVEFUPXkKIyBD
T05GSUdfQ1BVX0ZSRVFfU1RBVF9ERVRBSUxTIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0RF
RkFVTFRfR09WX1BFUkZPUk1BTkNFPXkKIyBDT05GSUdfQ1BVX0ZSRVFfREVGQVVMVF9HT1ZfVVNF
UlNQQUNFIGlzIG5vdCBzZXQKQ09ORklHX0NQVV9GUkVRX0dPVl9QRVJGT1JNQU5DRT15CkNPTkZJ
R19DUFVfRlJFUV9HT1ZfUE9XRVJTQVZFPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9VU0VSU1BBQ0U9
eQpDT05GSUdfQ1BVX0ZSRVFfR09WX09OREVNQU5EPXkKQ09ORklHX0NQVV9GUkVRX0dPVl9DT05T
RVJWQVRJVkU9eQoKIwojIENQVUZyZXEgcHJvY2Vzc29yIGRyaXZlcnMKIwojIENPTkZJR19YODZf
UE9XRVJOT1dfSzggaXMgbm90IHNldApDT05GSUdfWDg2X1NQRUVEU1RFUF9DRU5UUklOTz15CkNP
TkZJR19YODZfU1BFRURTVEVQX0NFTlRSSU5PX0FDUEk9eQpDT05GSUdfWDg2X0FDUElfQ1BVRlJF
UT15CgojCiMgc2hhcmVkIG9wdGlvbnMKIwojIENPTkZJR19YODZfQUNQSV9DUFVGUkVRX1BST0Nf
SU5URiBpcyBub3Qgc2V0CiMgQ09ORklHX1g4Nl9QNF9DTE9DS01PRCBpcyBub3Qgc2V0CiMgQ09O
RklHX1g4Nl9TUEVFRFNURVBfTElCIGlzIG5vdCBzZXQKCiMKIyBCdXMgb3B0aW9ucyAoUENJIGV0
Yy4pCiMKQ09ORklHX1BDST15CkNPTkZJR19QQ0lfRElSRUNUPXkKQ09ORklHX1BDSV9NTUNPTkZJ
Rz15CkNPTkZJR19QQ0lFUE9SVEJVUz15CiMgQ09ORklHX0hPVFBMVUdfUENJX1BDSUUgaXMgbm90
IHNldApDT05GSUdfUENJX01TST15CiMgQ09ORklHX1BDSV9ERUJVRyBpcyBub3Qgc2V0CgojCiMg
UENDQVJEIChQQ01DSUEvQ2FyZEJ1cykgc3VwcG9ydAojCkNPTkZJR19QQ0NBUkQ9bQojIENPTkZJ
R19QQ01DSUFfREVCVUcgaXMgbm90IHNldApDT05GSUdfUENNQ0lBPW0KQ09ORklHX1BDTUNJQV9M
T0FEX0NJUz15CkNPTkZJR19QQ01DSUFfSU9DVEw9eQpDT05GSUdfQ0FSREJVUz15CgojCiMgUEMt
Y2FyZCBicmlkZ2VzCiMKQ09ORklHX1lFTlRBPW0KIyBDT05GSUdfWUVOVEFfTzIgaXMgbm90IHNl
dAojIENPTkZJR19ZRU5UQV9SSUNPSCBpcyBub3Qgc2V0CiMgQ09ORklHX1lFTlRBX1RJIGlzIG5v
dCBzZXQKIyBDT05GSUdfWUVOVEFfVE9TSElCQSBpcyBub3Qgc2V0CkNPTkZJR19QRDY3Mjk9bQpD
T05GSUdfSTgyMDkyPW0KQ09ORklHX1BDQ0FSRF9OT05TVEFUSUM9bQoKIwojIFBDSSBIb3RwbHVn
IFN1cHBvcnQKIwpDT05GSUdfSE9UUExVR19QQ0k9eQpDT05GSUdfSE9UUExVR19QQ0lfRkFLRT1t
CkNPTkZJR19IT1RQTFVHX1BDSV9BQ1BJPW0KIyBDT05GSUdfSE9UUExVR19QQ0lfQUNQSV9JQk0g
aXMgbm90IHNldAojIENPTkZJR19IT1RQTFVHX1BDSV9DUENJIGlzIG5vdCBzZXQKQ09ORklHX0hP
VFBMVUdfUENJX1NIUEM9bQojIENPTkZJR19IT1RQTFVHX1BDSV9TSFBDX1BPTExfRVZFTlRfTU9E
RSBpcyBub3Qgc2V0CgojCiMgRXhlY3V0YWJsZSBmaWxlIGZvcm1hdHMgLyBFbXVsYXRpb25zCiMK
Q09ORklHX0JJTkZNVF9FTEY9eQpDT05GSUdfQklORk1UX01JU0M9eQpDT05GSUdfSUEzMl9FTVVM
QVRJT049eQpDT05GSUdfSUEzMl9BT1VUPXkKQ09ORklHX0NPTVBBVD15CkNPTkZJR19TWVNWSVBD
X0NPTVBBVD15CgojCiMgTmV0d29ya2luZwojCkNPTkZJR19ORVQ9eQoKIwojIE5ldHdvcmtpbmcg
b3B0aW9ucwojCiMgQ09ORklHX05FVERFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1BBQ0tFVD15CkNP
TkZJR19QQUNLRVRfTU1BUD15CkNPTkZJR19VTklYPXkKIyBDT05GSUdfTkVUX0tFWSBpcyBub3Qg
c2V0CkNPTkZJR19JTkVUPXkKIyBDT05GSUdfSVBfTVVMVElDQVNUIGlzIG5vdCBzZXQKQ09ORklH
X0lQX0FEVkFOQ0VEX1JPVVRFUj15CkNPTkZJR19BU0tfSVBfRklCX0hBU0g9eQojIENPTkZJR19J
UF9GSUJfVFJJRSBpcyBub3Qgc2V0CkNPTkZJR19JUF9GSUJfSEFTSD15CiMgQ09ORklHX0lQX01V
TFRJUExFX1RBQkxFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1JPVVRFX01VTFRJUEFUSCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQX1JPVVRFX1ZFUkJPU0UgaXMgbm90IHNldAojIENPTkZJR19JUF9Q
TlAgaXMgbm90IHNldApDT05GSUdfTkVUX0lQSVA9eQpDT05GSUdfTkVUX0lQR1JFPXkKIyBDT05G
SUdfQVJQRCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZTl9DT09LSUVTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5FVF9BSCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfRVNQIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5FVF9JUENPTVAgaXMgbm90IHNldAojIENPTkZJR19JTkVUX1hGUk1fVFVOTkVMIGlzIG5v
dCBzZXQKQ09ORklHX0lORVRfVFVOTkVMPXkKIyBDT05GSUdfSU5FVF9YRlJNX01PREVfVFJBTlNQ
T1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9YRlJNX01PREVfVFVOTkVMIGlzIG5vdCBzZXQK
Q09ORklHX0lORVRfRElBRz15CkNPTkZJR19JTkVUX1RDUF9ESUFHPXkKIyBDT05GSUdfVENQX0NP
TkdfQURWQU5DRUQgaXMgbm90IHNldApDT05GSUdfVENQX0NPTkdfQklDPXkKIyBDT05GSUdfSVBW
NiBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05G
SUdfSU5FVDZfVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUV09SS19TRUNNQVJLIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVURklMVEVSIGlzIG5vdCBzZXQKCiMKIyBEQ0NQIENvbmZpZ3VyYXRp
b24gKEVYUEVSSU1FTlRBTCkKIwojIENPTkZJR19JUF9EQ0NQIGlzIG5vdCBzZXQKCiMKIyBTQ1RQ
IENvbmZpZ3VyYXRpb24gKEVYUEVSSU1FTlRBTCkKIwojIENPTkZJR19JUF9TQ1RQIGlzIG5vdCBz
ZXQKCiMKIyBUSVBDIENvbmZpZ3VyYXRpb24gKEVYUEVSSU1FTlRBTCkKIwojIENPTkZJR19USVBD
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJREdFIGlzIG5v
dCBzZXQKIyBDT05GSUdfVkxBTl84MDIxUSBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQ05FVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xMQzIgaXMgbm90IHNldAojIENPTkZJR19JUFggaXMgbm90IHNldAoj
IENPTkZJR19BVEFMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1gyNSBpcyBub3Qgc2V0CiMgQ09ORklH
X0xBUEIgaXMgbm90IHNldAojIENPTkZJR19ORVRfRElWRVJUIGlzIG5vdCBzZXQKIyBDT05GSUdf
RUNPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOX1JPVVRFUiBpcyBub3Qgc2V0CgojCiMgUW9T
IGFuZC9vciBmYWlyIHF1ZXVlaW5nCiMKIyBDT05GSUdfTkVUX1NDSEVEIGlzIG5vdCBzZXQKCiMK
IyBOZXR3b3JrIHRlc3RpbmcKIwojIENPTkZJR19ORVRfUEtUR0VOIGlzIG5vdCBzZXQKIyBDT05G
SUdfSEFNUkFESU8gaXMgbm90IHNldAojIENPTkZJR19JUkRBIGlzIG5vdCBzZXQKIyBDT05GSUdf
QlQgaXMgbm90IHNldAojIENPTkZJR19JRUVFODAyMTEgaXMgbm90IHNldAoKIwojIERldmljZSBE
cml2ZXJzCiMKCiMKIyBHZW5lcmljIERyaXZlciBPcHRpb25zCiMKQ09ORklHX1NUQU5EQUxPTkU9
eQpDT05GSUdfUFJFVkVOVF9GSVJNV0FSRV9CVUlMRD15CkNPTkZJR19GV19MT0FERVI9eQojIENP
TkZJR19ERUJVR19EUklWRVIgaXMgbm90IHNldAojIENPTkZJR19TWVNfSFlQRVJWSVNPUiBpcyBu
b3Qgc2V0CgojCiMgQ29ubmVjdG9yIC0gdW5pZmllZCB1c2Vyc3BhY2UgPC0+IGtlcm5lbHNwYWNl
IGxpbmtlcgojCkNPTkZJR19DT05ORUNUT1I9eQpDT05GSUdfUFJPQ19FVkVOVFM9eQoKIwojIE1l
bW9yeSBUZWNobm9sb2d5IERldmljZXMgKE1URCkKIwojIENPTkZJR19NVEQgaXMgbm90IHNldAoK
IwojIFBhcmFsbGVsIHBvcnQgc3VwcG9ydAojCkNPTkZJR19QQVJQT1JUPXkKQ09ORklHX1BBUlBP
UlRfUEM9eQojIENPTkZJR19QQVJQT1JUX1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBP
UlRfUENfRklGTyBpcyBub3Qgc2V0CiMgQ09ORklHX1BBUlBPUlRfUENfU1VQRVJJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BBUlBPUlRfUENfUENNQ0lBIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9S
VF9HU0MgaXMgbm90IHNldAojIENPTkZJR19QQVJQT1JUX0FYODg3OTYgaXMgbm90IHNldApDT05G
SUdfUEFSUE9SVF8xMjg0PXkKCiMKIyBQbHVnIGFuZCBQbGF5IHN1cHBvcnQKIwpDT05GSUdfUE5Q
PXkKIyBDT05GSUdfUE5QX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBQcm90b2NvbHMKIwpDT05GSUdf
UE5QQUNQST15CgojCiMgQmxvY2sgZGV2aWNlcwojCkNPTkZJR19CTEtfREVWX0ZEPXkKIyBDT05G
SUdfUEFSSURFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0NQUV9EQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19DUFFfQ0lTU19EQSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfREFDOTYwIGlz
IG5vdCBzZXQKQ09ORklHX0JMS19ERVZfVU1FTT15CiMgQ09ORklHX0JMS19ERVZfQ09XX0NPTU1P
TiBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0xPT1A9eQojIENPTkZJR19CTEtfREVWX0NSWVBU
T0xPT1AgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX05CRCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfU1g4IGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9VQiBpcyBub3Qgc2V0CkNP
TkZJR19CTEtfREVWX1JBTT15CkNPTkZJR19CTEtfREVWX1JBTV9DT1VOVD0xNgpDT05GSUdfQkxL
X0RFVl9SQU1fU0laRT00MDk2CkNPTkZJR19CTEtfREVWX0lOSVRSRD15CkNPTkZJR19DRFJPTV9Q
S1RDRFZEPXkKQ09ORklHX0NEUk9NX1BLVENEVkRfQlVGRkVSUz04CiMgQ09ORklHX0NEUk9NX1BL
VENEVkRfV0NBQ0hFIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBzZXQK
CiMKIyBBVEEvQVRBUEkvTUZNL1JMTCBzdXBwb3J0CiMKQ09ORklHX0lERT15CkNPTkZJR19JREVf
TUFYX0hXSUZTPTQKQ09ORklHX0JMS19ERVZfSURFPXkKCiMKIyBQbGVhc2Ugc2VlIERvY3VtZW50
YXRpb24vaWRlLnR4dCBmb3IgaGVscC9pbmZvIG9uIElERSBkcml2ZXMKIwojIENPTkZJR19CTEtf
REVWX0lERV9TQVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IRF9JREUgaXMgbm90IHNl
dApDT05GSUdfQkxLX0RFVl9JREVESVNLPXkKIyBDT05GSUdfSURFRElTS19NVUxUSV9NT0RFIGlz
IG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JREVDUyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVW
X0lERUNEPXkKIyBDT05GSUdfQkxLX0RFVl9JREVUQVBFIGlzIG5vdCBzZXQKQ09ORklHX0JMS19E
RVZfSURFRkxPUFBZPXkKQ09ORklHX0JMS19ERVZfSURFU0NTST15CiMgQ09ORklHX0lERV9UQVNL
X0lPQ1RMIGlzIG5vdCBzZXQKCiMKIyBJREUgY2hpcHNldCBzdXBwb3J0L2J1Z2ZpeGVzCiMKQ09O
RklHX0lERV9HRU5FUklDPXkKIyBDT05GSUdfQkxLX0RFVl9DTUQ2NDAgaXMgbm90IHNldAojIENP
TkZJR19CTEtfREVWX0lERVBOUCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX0lERVBDST15CkNP
TkZJR19JREVQQ0lfU0hBUkVfSVJRPXkKQ09ORklHX0JMS19ERVZfT0ZGQk9BUkQ9eQpDT05GSUdf
QkxLX0RFVl9HRU5FUklDPXkKIyBDT05GSUdfQkxLX0RFVl9PUFRJNjIxIGlzIG5vdCBzZXQKIyBD
T05GSUdfQkxLX0RFVl9SWjEwMDAgaXMgbm90IHNldApDT05GSUdfQkxLX0RFVl9JREVETUFfUENJ
PXkKIyBDT05GSUdfQkxLX0RFVl9JREVETUFfRk9SQ0VEIGlzIG5vdCBzZXQKQ09ORklHX0lERURN
QV9QQ0lfQVVUTz15CiMgQ09ORklHX0lERURNQV9PTkxZRElTSyBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfQUVDNjJYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQUxJMTVYMyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfQU1ENzRYWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DTUQ2NFggaXMgbm90IHNldAoj
IENPTkZJR19CTEtfREVWX1RSSUZMRVggaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0NZODJD
NjkzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9DUzU1MjAgaXMgbm90IHNldAojIENPTkZJ
R19CTEtfREVWX0NTNTUzMCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSFBUMzRYIGlzIG5v
dCBzZXQKIyBDT05GSUdfQkxLX0RFVl9IUFQzNjYgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVW
X1NDMTIwMCBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVWX1BJSVg9eQojIENPTkZJR19CTEtfREVW
X0lUODIxWCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfTlM4NzQxNSBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfUERDMjAyWFhfT0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9Q
REMyMDJYWF9ORVcgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX1NWV0tTIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9TSUlNQUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TSVM1
NTEzIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9TTEM5MEU2NiBpcyBub3Qgc2V0CiMgQ09O
RklHX0JMS19ERVZfVFJNMjkwIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9WSUE4MkNYWFgg
aXMgbm90IHNldAojIENPTkZJR19JREVfQVJNIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfSURF
RE1BPXkKQ09ORklHX0lERURNQV9JVkI9eQpDT05GSUdfSURFRE1BX0FVVE89eQojIENPTkZJR19C
TEtfREVWX0hEIGlzIG5vdCBzZXQKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdf
UkFJRF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJPXkKIyBDT05GSUdfU0NTSV9UR1QgaXMg
bm90IHNldApDT05GSUdfU0NTSV9QUk9DX0ZTPXkKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAoZGlz
aywgdGFwZSwgQ0QtUk9NKQojCkNPTkZJR19CTEtfREVWX1NEPXkKIyBDT05GSUdfQ0hSX0RFVl9T
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIUl9ERVZfT1NTVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtf
REVWX1NSPXkKIyBDT05GSUdfQkxLX0RFVl9TUl9WRU5ET1IgaXMgbm90IHNldApDT05GSUdfQ0hS
X0RFVl9TRz15CkNPTkZJR19DSFJfREVWX1NDSD1tCgojCiMgU29tZSBTQ1NJIGRldmljZXMgKGUu
Zy4gQ0QganVrZWJveCkgc3VwcG9ydCBtdWx0aXBsZSBMVU5zCiMKIyBDT05GSUdfU0NTSV9NVUxU
SV9MVU4gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0NPTlNUQU5UUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfTE9HR0lORyBpcyBub3Qgc2V0CgojCiMgU0NTSSBUcmFuc3BvcnRzCiMKQ09ORklH
X1NDU0lfU1BJX0FUVFJTPW0KIyBDT05GSUdfU0NTSV9GQ19BVFRSUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBU19BVFRSUyBp
cyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FTX0RPTUFJTl9BVFRSUyBpcyBub3Qgc2V0CgojCiMg
U0NTSSBsb3ctbGV2ZWwgZHJpdmVycwojCiMgQ09ORklHX0lTQ1NJX1RDUCBpcyBub3Qgc2V0CiMg
Q09ORklHX0JMS19ERVZfM1dfWFhYWF9SQUlEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV8zV185
WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9BQ0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfQUFDUkFJRCBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJX0FJQzdYWFg9bQpDT05GSUdfQUlDN1hY
WF9DTURTX1BFUl9ERVZJQ0U9MzIKQ09ORklHX0FJQzdYWFhfUkVTRVRfREVMQVlfTVM9NTAwMApD
T05GSUdfQUlDN1hYWF9ERUJVR19FTkFCTEU9eQpDT05GSUdfQUlDN1hYWF9ERUJVR19NQVNLPTAK
Q09ORklHX0FJQzdYWFhfUkVHX1BSRVRUWV9QUklOVD15CiMgQ09ORklHX1NDU0lfQUlDN1hYWF9P
TEQgaXMgbm90IHNldApDT05GSUdfU0NTSV9BSUM3OVhYPW0KQ09ORklHX0FJQzc5WFhfQ01EU19Q
RVJfREVWSUNFPTMyCkNPTkZJR19BSUM3OVhYX1JFU0VUX0RFTEFZX01TPTE1MDAwCiMgQ09ORklH
X0FJQzc5WFhfRU5BQkxFX1JEX1NUUk0gaXMgbm90IHNldApDT05GSUdfQUlDNzlYWF9ERUJVR19F
TkFCTEU9eQpDT05GSUdfQUlDNzlYWF9ERUJVR19NQVNLPTAKQ09ORklHX0FJQzc5WFhfUkVHX1BS
RVRUWV9QUklOVD15CiMgQ09ORklHX1NDU0lfQUlDOTRYWCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfQVJDTVNSIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVHQVJBSURfTkVXR0VOIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUVHQVJBSURfTEVHQUNZIGlzIG5vdCBzZXQKIyBDT05GSUdfTUVHQVJBSURfU0FT
IGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfU0FUQT15CkNPTkZJR19TQ1NJX1NBVEFfQUhDST15CiMg
Q09ORklHX1NDU0lfUEFUQV9BTEkgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BBVEFfQU1EIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TQVRBX1NWVyBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
UEFUQV9UUklGTEVYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QQVRBX01QSUlYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9QQVRBX09MRFBJSVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0FU
QV9QSUlYIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9TQVRBX01WIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9QQVRBX05FVENFTEwgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfTlYgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1BBVEFfT1BUSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
UERDX0FETUEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0hQVElPUCBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfU0FUQV9RU1RPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfUEFUQV9QREMyMDI3
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9QUk9NSVNFIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0NTSV9TQVRBX1NYNCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfU0FUQV9TSUwgaXMgbm90
IHNldAojIENPTkZJR19TQ1NJX1NBVEFfU0lMMjQgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1BB
VEFfU0lMNjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QQVRBX1NJUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0lfU0FUQV9TSVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfVUxJIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0NTSV9QQVRBX1ZJQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lf
U0FUQV9WSUEgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NBVEFfVklURVNTRSBpcyBub3Qgc2V0
CkNPTkZJR19TQ1NJX1NBVEFfSU5URUxfQ09NQklORUQ9eQojIENPTkZJR19TQ1NJX0JVU0xPR0lD
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9ETVgzMTkxRCBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
U0lfRUFUQSBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfRlVUVVJFX0RPTUFJTiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfR0RUSCBpcyBub3Qgc2V0CiMgQ09ORklHX1NDU0lfSVBTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0NTSV9JTklUSU8gaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0lOSUExMDAg
aXMgbm90IHNldApDT05GSUdfU0NTSV9QUEE9bQpDT05GSUdfU0NTSV9JTU09bQojIENPTkZJR19T
Q1NJX0laSVBfRVBQMTYgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0laSVBfU0xPV19DVFIgaXMg
bm90IHNldAojIENPTkZJR19TQ1NJX1NURVggaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NZTTUz
QzhYWF8yIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9JUFIgaXMgbm90IHNldAojIENPTkZJR19T
Q1NJX1FMT0dJQ18xMjgwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9RTEFfRkMgaXMgbm90IHNl
dAojIENPTkZJR19TQ1NJX0xQRkMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RDMzk1eCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfREMzOTBUIGlzIG5vdCBzZXQKQ09ORklHX1NDU0lfREVCVUc9
bQojIENPTkZJR19TQ1NJX1NSUCBpcyBub3Qgc2V0CgojCiMgUENNQ0lBIFNDU0kgYWRhcHRlciBz
dXBwb3J0CiMKIyBDT05GSUdfUENNQ0lBX0ZET01BSU4gaXMgbm90IHNldAojIENPTkZJR19QQ01D
SUFfUUxPR0lDIGlzIG5vdCBzZXQKIyBDT05GSUdfUENNQ0lBX1NZTTUzQzUwMCBpcyBub3Qgc2V0
CgojCiMgTXVsdGktZGV2aWNlIHN1cHBvcnQgKFJBSUQgYW5kIExWTSkKIwojIENPTkZJR19NRCBp
cyBub3Qgc2V0CgojCiMgRnVzaW9uIE1QVCBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX0ZVU0lP
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0lPTl9TUEkgaXMgbm90IHNldAojIENPTkZJR19GVVNJ
T05fRkMgaXMgbm90IHNldAojIENPTkZJR19GVVNJT05fU0FTIGlzIG5vdCBzZXQKCiMKIyBJRUVF
IDEzOTQgKEZpcmVXaXJlKSBzdXBwb3J0CiMKQ09ORklHX0lFRUUxMzk0PW0KCiMKIyBTdWJzeXN0
ZW0gT3B0aW9ucwojCkNPTkZJR19JRUVFMTM5NF9WRVJCT1NFREVCVUc9eQpDT05GSUdfSUVFRTEz
OTRfT1VJX0RCPXkKQ09ORklHX0lFRUUxMzk0X0VYVFJBX0NPTkZJR19ST01TPXkKQ09ORklHX0lF
RUUxMzk0X0NPTkZJR19ST01fSVAxMzk0PXkKIyBDT05GSUdfSUVFRTEzOTRfRVhQT1JUX0ZVTExf
QVBJIGlzIG5vdCBzZXQKCiMKIyBEZXZpY2UgRHJpdmVycwojCkNPTkZJR19JRUVFMTM5NF9QQ0lM
WU5YPW0KQ09ORklHX0lFRUUxMzk0X09IQ0kxMzk0PW0KCiMKIyBQcm90b2NvbCBEcml2ZXJzCiMK
Q09ORklHX0lFRUUxMzk0X1ZJREVPMTM5ND1tCkNPTkZJR19JRUVFMTM5NF9TQlAyPW0KIyBDT05G
SUdfSUVFRTEzOTRfU0JQMl9QSFlTX0RNQSBpcyBub3Qgc2V0CkNPTkZJR19JRUVFMTM5NF9FVEgx
Mzk0PW0KQ09ORklHX0lFRUUxMzk0X0RWMTM5ND1tCkNPTkZJR19JRUVFMTM5NF9SQVdJTz1tCgoj
CiMgSTJPIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfSTJPIGlzIG5vdCBzZXQKCiMKIyBOZXR3
b3JrIGRldmljZSBzdXBwb3J0CiMKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfRFVNTVk9eQoj
IENPTkZJR19CT05ESU5HIGlzIG5vdCBzZXQKIyBDT05GSUdfRVFVQUxJWkVSIGlzIG5vdCBzZXQK
Q09ORklHX1RVTj15CiMgQ09ORklHX05FVF9TQjEwMDAgaXMgbm90IHNldAoKIwojIEFSQ25ldCBk
ZXZpY2VzCiMKIyBDT05GSUdfQVJDTkVUIGlzIG5vdCBzZXQKCiMKIyBQSFkgZGV2aWNlIHN1cHBv
cnQKIwpDT05GSUdfUEhZTElCPXkKCiMKIyBNSUkgUEhZIGRldmljZSBkcml2ZXJzCiMKIyBDT05G
SUdfTUFSVkVMTF9QSFkgaXMgbm90IHNldAojIENPTkZJR19EQVZJQ09NX1BIWSBpcyBub3Qgc2V0
CiMgQ09ORklHX1FTRU1JX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0xYVF9QSFkgaXMgbm90IHNl
dAojIENPTkZJR19DSUNBREFfUEhZIGlzIG5vdCBzZXQKIyBDT05GSUdfU01TQ19QSFkgaXMgbm90
IHNldAoKIwojIEV0aGVybmV0ICgxMCBvciAxMDBNYml0KQojCkNPTkZJR19ORVRfRVRIRVJORVQ9
eQpDT05GSUdfTUlJPXkKIyBDT05GSUdfSEFQUFlNRUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VO
R0VNIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FTU0lOSSBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9W
RU5ET1JfM0NPTSBpcyBub3Qgc2V0CgojCiMgVHVsaXAgZmFtaWx5IG5ldHdvcmsgZGV2aWNlIHN1
cHBvcnQKIwojIENPTkZJR19ORVRfVFVMSVAgaXMgbm90IHNldAojIENPTkZJR19IUDEwMCBpcyBu
b3Qgc2V0CkNPTkZJR19ORVRfUENJPXkKIyBDT05GSUdfUENORVQzMiBpcyBub3Qgc2V0CiMgQ09O
RklHX0FNRDgxMTFfRVRIIGlzIG5vdCBzZXQKIyBDT05GSUdfQURBUFRFQ19TVEFSRklSRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0I0NCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZPUkNFREVUSCBpcyBub3Qg
c2V0CiMgQ09ORklHX0RHUlMgaXMgbm90IHNldAojIENPTkZJR19FRVBSTzEwMCBpcyBub3Qgc2V0
CiMgQ09ORklHX0UxMDAgaXMgbm90IHNldAojIENPTkZJR19GRUFMTlggaXMgbm90IHNldAojIENP
TkZJR19OQVRTRU1JIGlzIG5vdCBzZXQKIyBDT05GSUdfTkUyS19QQ0kgaXMgbm90IHNldAojIENP
TkZJR184MTM5Q1AgaXMgbm90IHNldAojIENPTkZJR184MTM5VE9PIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0lTOTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfRVBJQzEwMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1NVTkRBTkNFIGlzIG5vdCBzZXQKIyBDT05GSUdfVklBX1JISU5FIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkVUX1BPQ0tFVCBpcyBub3Qgc2V0CgojCiMgRXRoZXJuZXQgKDEwMDAgTWJpdCkKIwojIENP
TkZJR19BQ0VOSUMgaXMgbm90IHNldAojIENPTkZJR19ETDJLIGlzIG5vdCBzZXQKQ09ORklHX0Ux
MDAwPXkKIyBDT05GSUdfRTEwMDBfTkFQSSBpcyBub3Qgc2V0CkNPTkZJR19FMTAwMF9ESVNBQkxF
X1BBQ0tFVF9TUExJVD15CiMgQ09ORklHX05TODM4MjAgaXMgbm90IHNldAojIENPTkZJR19IQU1B
Q0hJIGlzIG5vdCBzZXQKIyBDT05GSUdfWUVMTE9XRklOIGlzIG5vdCBzZXQKIyBDT05GSUdfUjgx
NjkgaXMgbm90IHNldAojIENPTkZJR19TSVMxOTAgaXMgbm90IHNldAojIENPTkZJR19TS0dFIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0tZMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NLOThMSU4gaXMgbm90
IHNldAojIENPTkZJR19WSUFfVkVMT0NJVFkgaXMgbm90IHNldAojIENPTkZJR19USUdPTjMgaXMg
bm90IHNldAojIENPTkZJR19CTlgyIGlzIG5vdCBzZXQKCiMKIyBFdGhlcm5ldCAoMTAwMDAgTWJp
dCkKIwojIENPTkZJR19DSEVMU0lPX1QxIGlzIG5vdCBzZXQKIyBDT05GSUdfSVhHQiBpcyBub3Qg
c2V0CiMgQ09ORklHX1MySU8gaXMgbm90IHNldAojIENPTkZJR19NWVJJMTBHRSBpcyBub3Qgc2V0
CgojCiMgVG9rZW4gUmluZyBkZXZpY2VzCiMKIyBDT05GSUdfVFIgaXMgbm90IHNldAoKIwojIFdp
cmVsZXNzIExBTiAobm9uLWhhbXJhZGlvKQojCiMgQ09ORklHX05FVF9SQURJTyBpcyBub3Qgc2V0
CgojCiMgUENNQ0lBIG5ldHdvcmsgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19ORVRfUENNQ0lB
IGlzIG5vdCBzZXQKCiMKIyBXYW4gaW50ZXJmYWNlcwojCiMgQ09ORklHX1dBTiBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZEREkgaXMgbm90IHNldAojIENPTkZJR19ISVBQSSBpcyBub3Qgc2V0CiMgQ09O
RklHX1BMSVAgaXMgbm90IHNldAojIENPTkZJR19QUFAgaXMgbm90IHNldAojIENPTkZJR19TTElQ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0ZDIGlzIG5vdCBzZXQKIyBDT05GSUdfU0hBUEVSIGlz
IG5vdCBzZXQKQ09ORklHX05FVENPTlNPTEU9eQpDT05GSUdfTkVUUE9MTD15CiMgQ09ORklHX05F
VFBPTExfUlggaXMgbm90IHNldAojIENPTkZJR19ORVRQT0xMX1RSQVAgaXMgbm90IHNldApDT05G
SUdfTkVUX1BPTExfQ09OVFJPTExFUj15CgojCiMgSVNETiBzdWJzeXN0ZW0KIwojIENPTkZJR19J
U0ROIGlzIG5vdCBzZXQKCiMKIyBUZWxlcGhvbnkgU3VwcG9ydAojCiMgQ09ORklHX1BIT05FIGlz
IG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAojCkNPTkZJR19JTlBVVD15CgojCiMg
VXNlcmxhbmQgaW50ZXJmYWNlcwojCkNPTkZJR19JTlBVVF9NT1VTRURFVj15CkNPTkZJR19JTlBV
VF9NT1VTRURFVl9QU0FVWD15CkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWD0xMDI0CkNP
TkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5fWT03NjgKIyBDT05GSUdfSU5QVVRfSk9ZREVWIGlz
IG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfVFNERVYgaXMgbm90IHNldApDT05GSUdfSU5QVVRfRVZE
RVY9eQojIENPTkZJR19JTlBVVF9FVkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNlIERy
aXZlcnMKIwpDT05GSUdfSU5QVVRfS0VZQk9BUkQ9eQpDT05GSUdfS0VZQk9BUkRfQVRLQkQ9eQoj
IENPTkZJR19LRVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldAojIENPTkZJR19LRVlCT0FSRF9MS0tC
RCBpcyBub3Qgc2V0CiMgQ09ORklHX0tFWUJPQVJEX1hUS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdf
S0VZQk9BUkRfTkVXVE9OIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01PVVNFPXkKQ09ORklHX01P
VVNFX1BTMj15CiMgQ09ORklHX01PVVNFX1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX01PVVNF
X1ZTWFhYQUEgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9KT1lTVElDSyBpcyBub3Qgc2V0CiMg
Q09ORklHX0lOUFVUX1RPVUNIU0NSRUVOIGlzIG5vdCBzZXQKQ09ORklHX0lOUFVUX01JU0M9eQpD
T05GSUdfSU5QVVRfUENTUEtSPXkKQ09ORklHX0lOUFVUX1VJTlBVVD15CgojCiMgSGFyZHdhcmUg
SS9PIHBvcnRzCiMKQ09ORklHX1NFUklPPXkKQ09ORklHX1NFUklPX0k4MDQyPXkKIyBDT05GSUdf
U0VSSU9fU0VSUE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklPX0NUODJDNzEwIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VSSU9fUEFSS0JEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSU9fUENJUFMy
IGlzIG5vdCBzZXQKQ09ORklHX1NFUklPX0xJQlBTMj15CiMgQ09ORklHX1NFUklPX1JBVyBpcyBu
b3Qgc2V0CkNPTkZJR19HQU1FUE9SVD15CiMgQ09ORklHX0dBTUVQT1JUX05TNTU4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfR0FNRVBPUlRfTDQgaXMgbm90IHNldAojIENPTkZJR19HQU1FUE9SVF9FTVUx
MEsxIGlzIG5vdCBzZXQKIyBDT05GSUdfR0FNRVBPUlRfRk04MDEgaXMgbm90IHNldAoKIwojIENo
YXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1ZUPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdf
SFdfQ09OU09MRT15CiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0CgojCiMg
U2VyaWFsIGRyaXZlcnMKIwpDT05GSUdfU0VSSUFMXzgyNTA9eQpDT05GSUdfU0VSSUFMXzgyNTBf
Q09OU09MRT15CiMgQ09ORklHX1NFUklBTF84MjUwX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NF
UklBTF84MjUwX1BOUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NFUklBTF84MjUwX0NTIGlzIG5vdCBz
ZXQKQ09ORklHX1NFUklBTF84MjUwX05SX1VBUlRTPTQKQ09ORklHX1NFUklBTF84MjUwX1JVTlRJ
TUVfVUFSVFM9NAojIENPTkZJR19TRVJJQUxfODI1MF9FWFRFTkRFRCBpcyBub3Qgc2V0CgojCiMg
Tm9uLTgyNTAgc2VyaWFsIHBvcnQgc3VwcG9ydAojCkNPTkZJR19TRVJJQUxfQ09SRT15CkNPTkZJ
R19TRVJJQUxfQ09SRV9DT05TT0xFPXkKIyBDT05GSUdfU0VSSUFMX0pTTSBpcyBub3Qgc2V0CkNP
TkZJR19VTklYOThfUFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZ
X0NPVU5UPTI1NgpDT05GSUdfUFJJTlRFUj15CkNPTkZJR19MUF9DT05TT0xFPXkKQ09ORklHX1BQ
REVWPXkKIyBDT05GSUdfVElQQVIgaXMgbm90IHNldAoKIwojIElQTUkKIwojIENPTkZJR19JUE1J
X0hBTkRMRVIgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIENhcmRzCiMKQ09ORklHX1dBVENIRE9H
PXkKIyBDT05GSUdfV0FUQ0hET0dfTk9XQVlPVVQgaXMgbm90IHNldAoKIwojIFdhdGNoZG9nIERl
dmljZSBEcml2ZXJzCiMKQ09ORklHX1NPRlRfV0FUQ0hET0c9eQojIENPTkZJR19BQ1FVSVJFX1dE
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0FEVkFOVEVDSF9XRFQgaXMgbm90IHNldAojIENPTkZJR19B
TElNMTUzNV9XRFQgaXMgbm90IHNldAojIENPTkZJR19BTElNNzEwMV9XRFQgaXMgbm90IHNldAoj
IENPTkZJR19TQzUyMF9XRFQgaXMgbm90IHNldAojIENPTkZJR19FVVJPVEVDSF9XRFQgaXMgbm90
IHNldAojIENPTkZJR19JQjcwMF9XRFQgaXMgbm90IHNldAojIENPTkZJR19JQk1BU1IgaXMgbm90
IHNldAojIENPTkZJR19XQUZFUl9XRFQgaXMgbm90IHNldAojIENPTkZJR19JNjMwMEVTQl9XRFQg
aXMgbm90IHNldAojIENPTkZJR19JOFhYX1RDTyBpcyBub3Qgc2V0CiMgQ09ORklHX0lUQ09fV0RU
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0MxMjAwX1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHXzYwWFhf
V0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfU0JDODM2MF9XRFQgaXMgbm90IHNldAojIENPTkZJR19D
UFU1X1dEVCBpcyBub3Qgc2V0CiMgQ09ORklHX1c4MzYyN0hGX1dEVCBpcyBub3Qgc2V0CiMgQ09O
RklHX1c4Mzg3N0ZfV0RUIGlzIG5vdCBzZXQKIyBDT05GSUdfVzgzOTc3Rl9XRFQgaXMgbm90IHNl
dAojIENPTkZJR19NQUNIWl9XRFQgaXMgbm90IHNldAojIENPTkZJR19TQkNfRVBYX0MzX1dBVENI
RE9HIGlzIG5vdCBzZXQKCiMKIyBQQ0ktYmFzZWQgV2F0Y2hkb2cgQ2FyZHMKIwojIENPTkZJR19Q
Q0lQQ1dBVENIRE9HIGlzIG5vdCBzZXQKIyBDT05GSUdfV0RUUENJIGlzIG5vdCBzZXQKCiMKIyBV
U0ItYmFzZWQgV2F0Y2hkb2cgQ2FyZHMKIwojIENPTkZJR19VU0JQQ1dBVENIRE9HIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSFdfUkFORE9NIGlzIG5vdCBzZXQKQ09ORklHX05WUkFNPXkKIyBDT05GSUdf
UlRDIGlzIG5vdCBzZXQKQ09ORklHX0dFTl9SVEM9eQpDT05GSUdfR0VOX1JUQ19YPXkKIyBDT05G
SUdfRFRMSyBpcyBub3Qgc2V0CiMgQ09ORklHX1IzOTY0IGlzIG5vdCBzZXQKIyBDT05GSUdfQVBQ
TElDT00gaXMgbm90IHNldAoKIwojIEZ0YXBlLCB0aGUgZmxvcHB5IHRhcGUgZGV2aWNlIGRyaXZl
cgojCkNPTkZJR19BR1A9eQpDT05GSUdfQUdQX0FNRDY0PXkKIyBDT05GSUdfQUdQX0lOVEVMIGlz
IG5vdCBzZXQKIyBDT05GSUdfQUdQX1NJUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FHUF9WSUEgaXMg
bm90IHNldApDT05GSUdfRFJNPXkKIyBDT05GSUdfRFJNX1RERlggaXMgbm90IHNldAojIENPTkZJ
R19EUk1fUjEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0RSTV9SQURFT04gaXMgbm90IHNldAojIENP
TkZJR19EUk1fTUdBIGlzIG5vdCBzZXQKIyBDT05GSUdfRFJNX1NJUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0RSTV9WSUEgaXMgbm90IHNldAojIENPTkZJR19EUk1fU0FWQUdFIGlzIG5vdCBzZXQKCiMK
IyBQQ01DSUEgY2hhcmFjdGVyIGRldmljZXMKIwojIENPTkZJR19TWU5DTElOS19DUyBpcyBub3Qg
c2V0CiMgQ09ORklHX0NBUkRNQU5fNDAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0NBUkRNQU5fNDA0
MCBpcyBub3Qgc2V0CiMgQ09ORklHX01XQVZFIGlzIG5vdCBzZXQKIyBDT05GSUdfUkFXX0RSSVZF
UiBpcyBub3Qgc2V0CkNPTkZJR19IUEVUPXkKQ09ORklHX0hQRVRfUlRDX0lSUT15CkNPTkZJR19I
UEVUX01NQVA9eQpDT05GSUdfSEFOR0NIRUNLX1RJTUVSPXkKCiMKIyBUUE0gZGV2aWNlcwojCiMg
Q09ORklHX1RDR19UUE0gaXMgbm90IHNldAojIENPTkZJR19URUxDTE9DSyBpcyBub3Qgc2V0Cgoj
CiMgSTJDIHN1cHBvcnQKIwpDT05GSUdfSTJDPXkKQ09ORklHX0kyQ19DSEFSREVWPXkKCiMKIyBJ
MkMgQWxnb3JpdGhtcwojCkNPTkZJR19JMkNfQUxHT0JJVD15CiMgQ09ORklHX0kyQ19BTEdPUENG
IGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0FMR09QQ0EgaXMgbm90IHNldAoKIwojIEkyQyBIYXJk
d2FyZSBCdXMgc3VwcG9ydAojCiMgQ09ORklHX0kyQ19BTEkxNTM1IGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0FMSTE1NjMgaXMgbm90IHNldAojIENPTkZJR19JMkNfQUxJMTVYMyBpcyBub3Qgc2V0
CiMgQ09ORklHX0kyQ19BTUQ3NTYgaXMgbm90IHNldAojIENPTkZJR19JMkNfQU1EODExMSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19JODAxIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0k4MTAgaXMg
bm90IHNldAojIENPTkZJR19JMkNfUElJWDQgaXMgbm90IHNldAojIENPTkZJR19JMkNfTkZPUkNF
MiBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19QQVJQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJD
X1BBUlBPUlRfTElHSFQgaXMgbm90IHNldAojIENPTkZJR19JMkNfUFJPU0FWQUdFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfSTJDX1NBVkFHRTQgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lTNTU5NSBp
cyBub3Qgc2V0CiMgQ09ORklHX0kyQ19TSVM2MzAgaXMgbm90IHNldAojIENPTkZJR19JMkNfU0lT
OTZYIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NUVUIgaXMgbm90IHNldAojIENPTkZJR19JMkNf
VklBIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1ZJQVBSTyBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19WT09ET08zIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1BDQV9JU0EgaXMgbm90IHNldAojIENP
TkZJR19JMkNfT0NPUkVTIGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5lb3VzIEkyQyBDaGlwIHN1
cHBvcnQKIwojIENPTkZJR19TRU5TT1JTX0RTMTMzNyBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfRFMxMzc0IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19FRVBST00gaXMgbm90IHNldAoj
IENPTkZJR19TRU5TT1JTX1BDRjg1NzQgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDQTk1
MzkgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDRjg1OTEgaXMgbm90IHNldAojIENPTkZJ
R19TRU5TT1JTX01BWDY4NzUgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQ09SRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19BTEdPIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RF
QlVHX0JVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19DSElQIGlzIG5vdCBzZXQKCiMK
IyBTUEkgc3VwcG9ydAojCiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSV9NQVNU
RVIgaXMgbm90IHNldAoKIwojIERhbGxhcydzIDEtd2lyZSBidXMKIwojIENPTkZJR19XMSBpcyBu
b3Qgc2V0CgojCiMgSGFyZHdhcmUgTW9uaXRvcmluZyBzdXBwb3J0CiMKQ09ORklHX0hXTU9OPXkK
IyBDT05GSUdfSFdNT05fVklEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDIxIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDI1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19BRE0xMDI2IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19BRE0xMDMxIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19BRE05MjQwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19B
U0IxMDAgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0FUWFAxIGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19EUzE2MjEgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JTX0Y3MTgwNUYgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX0ZTQ0hFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNP
UlNfRlNDUE9TIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19HTDUxOFNNIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19HTDUyMFNNIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19JVDg3
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTYzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19MTTc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTc3IGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VOU09SU19MTTc4IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgwIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTgzIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19M
TTg1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTg3IGlzIG5vdCBzZXQKIyBDT05GSUdf
U0VOU09SU19MTTkwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19MTTkyIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VOU09SU19NQVgxNjE5IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19QQzg3
MzYwIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19TSVM1NTk1IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0VOU09SU19TTVNDNDdNMSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3TTE5
MiBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfU01TQzQ3QjM5NyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NFTlNPUlNfVklBNjg2QSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFTlNPUlNfVlQ4MjMxIGlz
IG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3ODFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VO
U09SU19XODM3OTFEIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM3OTJEIGlzIG5vdCBz
ZXQKIyBDT05GSUdfU0VOU09SU19XODNMNzg1VFMgaXMgbm90IHNldAojIENPTkZJR19TRU5TT1JT
X1c4MzYyN0hGIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19XODM2MjdFSEYgaXMgbm90IHNl
dAojIENPTkZJR19TRU5TT1JTX0hEQVBTIGlzIG5vdCBzZXQKIyBDT05GSUdfSFdNT05fREVCVUdf
Q0hJUCBpcyBub3Qgc2V0CgojCiMgTWlzYyBkZXZpY2VzCiMKIyBDT05GSUdfSUJNX0FTTSBpcyBu
b3Qgc2V0CgojCiMgTXVsdGltZWRpYSBkZXZpY2VzCiMKQ09ORklHX1ZJREVPX0RFVj15CkNPTkZJ
R19WSURFT19WNEwxPXkKQ09ORklHX1ZJREVPX1Y0TDFfQ09NUEFUPXkKQ09ORklHX1ZJREVPX1Y0
TDI9eQoKIwojIFZpZGVvIENhcHR1cmUgQWRhcHRlcnMKIwoKIwojIFZpZGVvIENhcHR1cmUgQWRh
cHRlcnMKIwojIENPTkZJR19WSURFT19BRFZfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19WSURF
T19WSVZJIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fQlQ4NDggaXMgbm90IHNldAojIENPTkZJ
R19WSURFT19CV1FDQU0gaXMgbm90IHNldAojIENPTkZJR19WSURFT19DUUNBTSBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZJREVPX1c5OTY2IGlzIG5vdCBzZXQKQ09ORklHX1ZJREVPX0NQSUE9bQojIENP
TkZJR19WSURFT19DUElBX1BQIGlzIG5vdCBzZXQKQ09ORklHX1ZJREVPX0NQSUFfVVNCPW0KIyBD
T05GSUdfVklERU9fQ1BJQTIgaXMgbm90IHNldAojIENPTkZJR19WSURFT19TQUE1MjQ2QSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1ZJREVPX1NBQTUyNDkgaXMgbm90IHNldAojIENPTkZJR19UVU5FUl8z
MDM2IGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fU1RSQURJUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1ZJREVPX1pPUkFOIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fU0FBNzEzNCBpcyBub3Qgc2V0
CiMgQ09ORklHX1ZJREVPX01YQiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX0RQQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZJREVPX0hFWElVTV9PUklPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVP
X0hFWElVTV9HRU1JTkkgaXMgbm90IHNldAojIENPTkZJR19WSURFT19DWDg4IGlzIG5vdCBzZXQK
IyBDT05GSUdfVklERU9fT1ZDQU1DSElQIGlzIG5vdCBzZXQKCiMKIyBFbmNvZGVycyBhbmQgRGVj
b2RlcnMKIwojIENPTkZJR19WSURFT19NU1AzNDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9f
Q1M1M0wzMkEgaXMgbm90IHNldAojIENPTkZJR19WSURFT19XTTg3NzUgaXMgbm90IHNldAojIENP
TkZJR19WSURFT19XTTg3MzkgaXMgbm90IHNldAojIENPTkZJR19WSURFT19DWDI1ODQwIGlzIG5v
dCBzZXQKIyBDT05GSUdfVklERU9fU0FBNzExWCBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX1NB
QTcxMjcgaXMgbm90IHNldAojIENPTkZJR19WSURFT19VUEQ2NDAzMUEgaXMgbm90IHNldAojIENP
TkZJR19WSURFT19VUEQ2NDA4MyBpcyBub3Qgc2V0CgojCiMgVjRMIFVTQiBkZXZpY2VzCiMKIyBD
T05GSUdfVklERU9fRU0yOFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RTQlIgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfVklDQU0gaXMgbm90IHNldAojIENPTkZJR19VU0JfSUJNQ0FNIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX0tPTklDQVdDIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1FVSUNL
Q0FNX01FU1NFTkdFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FVDYxWDI1MSBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9PVjUxMSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRTQwMSBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9TTjlDMTAyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUVjY4MCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9XOTk2OENGIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1pD
MDMwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9QV0MgaXMgbm90IHNldAoKIwojIFJhZGlvIEFk
YXB0ZXJzCiMKIyBDT05GSUdfUkFESU9fR0VNVEVLX1BDSSBpcyBub3Qgc2V0CiMgQ09ORklHX1JB
RElPX01BWElSQURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX1JBRElPX01BRVNUUk8gaXMgbm90IHNl
dAoKIwojIERpZ2l0YWwgVmlkZW8gQnJvYWRjYXN0aW5nIERldmljZXMKIwojIENPTkZJR19EVkIg
aXMgbm90IHNldAojIENPTkZJR19VU0JfREFCVVNCIGlzIG5vdCBzZXQKCiMKIyBHcmFwaGljcyBz
dXBwb3J0CiMKQ09ORklHX0ZJUk1XQVJFX0VESUQ9eQpDT05GSUdfRkI9eQpDT05GSUdfRkJfQ0ZC
X0ZJTExSRUNUPXkKQ09ORklHX0ZCX0NGQl9DT1BZQVJFQT15CkNPTkZJR19GQl9DRkJfSU1BR0VC
TElUPXkKIyBDT05GSUdfRkJfTUFDTU9ERVMgaXMgbm90IHNldAojIENPTkZJR19GQl9CQUNLTElH
SFQgaXMgbm90IHNldApDT05GSUdfRkJfTU9ERV9IRUxQRVJTPXkKQ09ORklHX0ZCX1RJTEVCTElU
VElORz15CiMgQ09ORklHX0ZCX0NJUlJVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1BNMiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0ZCX0NZQkVSMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FSQyBp
cyBub3Qgc2V0CiMgQ09ORklHX0ZCX0FTSUxJQU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfSU1T
VFQgaXMgbm90IHNldApDT05GSUdfRkJfVkdBMTY9eQpDT05GSUdfRkJfVkVTQT15CiMgQ09ORklH
X0ZCX0hHQSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZCX1MxRDEzWFhYIGlzIG5vdCBzZXQKIyBDT05G
SUdfRkJfTlZJRElBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfUklWQSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZCX0lOVEVMIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUFUUk9YIGlzIG5vdCBzZXQKIyBD
T05GSUdfRkJfUkFERU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfQVRZMTI4IGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfQVRZIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU0FWQUdFIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfU0lTIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTkVPTUFHSUMgaXMgbm90IHNl
dAojIENPTkZJR19GQl9LWVJPIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfM0RGWCBpcyBub3Qgc2V0
CiMgQ09ORklHX0ZCX1ZPT0RPTzEgaXMgbm90IHNldAojIENPTkZJR19GQl9UUklERU5UIGlzIG5v
dCBzZXQKIyBDT05GSUdfRkJfR0VPREUgaXMgbm90IHNldAojIENPTkZJR19GQl9WSVJUVUFMIGlz
IG5vdCBzZXQKCiMKIyBDb25zb2xlIGRpc3BsYXkgZHJpdmVyIHN1cHBvcnQKIwpDT05GSUdfVkdB
X0NPTlNPTEU9eQpDT05GSUdfVkdBQ09OX1NPRlRfU0NST0xMQkFDSz15CkNPTkZJR19WR0FDT05f
U09GVF9TQ1JPTExCQUNLX1NJWkU9NjQKQ09ORklHX1ZJREVPX1NFTEVDVD15CkNPTkZJR19EVU1N
WV9DT05TT0xFPXkKQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEU9eQojIENPTkZJR19GUkFNRUJV
RkZFUl9DT05TT0xFX1JPVEFUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfRk9OVFMgaXMgbm90IHNl
dApDT05GSUdfRk9OVF84eDg9eQpDT05GSUdfRk9OVF84eDE2PXkKCiMKIyBMb2dvIGNvbmZpZ3Vy
YXRpb24KIwojIENPTkZJR19MT0dPIGlzIG5vdCBzZXQKIyBDT05GSUdfQkFDS0xJR0hUX0xDRF9T
VVBQT1JUIGlzIG5vdCBzZXQKCiMKIyBTb3VuZAojCkNPTkZJR19TT1VORD15CgojCiMgQWR2YW5j
ZWQgTGludXggU291bmQgQXJjaGl0ZWN0dXJlCiMKQ09ORklHX1NORD15CkNPTkZJR19TTkRfVElN
RVI9eQpDT05GSUdfU05EX1BDTT15CkNPTkZJR19TTkRfU0VRVUVOQ0VSPXkKIyBDT05GSUdfU05E
X1NFUV9EVU1NWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NSVhFUl9PU1MgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfUENNX09TUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9TRVFVRU5DRVJfT1NT
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RZTkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKQ09ORklH
X1NORF9TVVBQT1JUX09MRF9BUEk9eQpDT05GSUdfU05EX1ZFUkJPU0VfUFJPQ0ZTPXkKIyBDT05G
SUdfU05EX1ZFUkJPU0VfUFJJTlRLIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0RFQlVHIGlzIG5v
dCBzZXQKCiMKIyBHZW5lcmljIGRldmljZXMKIwojIENPTkZJR19TTkRfRFVNTVkgaXMgbm90IHNl
dAojIENPTkZJR19TTkRfVklSTUlESSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9NVFBBViBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9TRVJJQUxfVTE2NTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X01QVTQwMSBpcyBub3Qgc2V0CgojCiMgUENJIGRldmljZXMKIwojIENPTkZJR19TTkRfQUQxODg5
IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FMUzMwMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9B
TFM0MDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FMSTU0NTEgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfQVRJSVhQIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0FUSUlYUF9NT0RFTSBpcyBub3Qg
c2V0CiMgQ09ORklHX1NORF9BVTg4MTAgaXMgbm90IHNldAojIENPTkZJR19TTkRfQVU4ODIwIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX0FVODgzMCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9BWlQz
MzI4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0JUODdYIGlzIG5vdCBzZXQKIyBDT05GSUdfU05E
X0NBMDEwNiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9DTUlQQ0kgaXMgbm90IHNldAojIENPTkZJ
R19TTkRfQ1M0MjgxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0NTNDZYWCBpcyBub3Qgc2V0CiMg
Q09ORklHX1NORF9FTVUxMEsxIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0VNVTEwSzFYIGlzIG5v
dCBzZXQKIyBDT05GSUdfU05EX0VOUzEzNzAgaXMgbm90IHNldAojIENPTkZJR19TTkRfRU5TMTM3
MSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9FUzE5MzggaXMgbm90IHNldAojIENPTkZJR19TTkRf
RVMxOTY4IGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0ZNODAxIGlzIG5vdCBzZXQKQ09ORklHX1NO
RF9IREFfSU5URUw9eQojIENPTkZJR19TTkRfSERTUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9I
RFNQTSBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9JQ0UxNzEyIGlzIG5vdCBzZXQKIyBDT05GSUdf
U05EX0lDRTE3MjQgaXMgbm90IHNldAojIENPTkZJR19TTkRfSU5URUw4WDAgaXMgbm90IHNldAoj
IENPTkZJR19TTkRfSU5URUw4WDBNIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX0tPUkcxMjEyIGlz
IG5vdCBzZXQKIyBDT05GSUdfU05EX01BRVNUUk8zIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX01J
WEFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9OTTI1NiBpcyBub3Qgc2V0CiMgQ09ORklHX1NO
RF9QQ1hIUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9SSVBUSURFIGlzIG5vdCBzZXQKIyBDT05G
SUdfU05EX1JNRTMyIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1JNRTk2IGlzIG5vdCBzZXQKIyBD
T05GSUdfU05EX1JNRTk2NTIgaXMgbm90IHNldAojIENPTkZJR19TTkRfU09OSUNWSUJFUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NORF9UUklERU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1ZJQTgy
WFggaXMgbm90IHNldAojIENPTkZJR19TTkRfVklBODJYWF9NT0RFTSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9WWDIyMiBpcyBub3Qgc2V0CiMgQ09ORklHX1NORF9ZTUZQQ0kgaXMgbm90IHNldAoK
IwojIFVTQiBkZXZpY2VzCiMKIyBDT05GSUdfU05EX1VTQl9BVURJTyBpcyBub3Qgc2V0CiMgQ09O
RklHX1NORF9VU0JfVVNYMlkgaXMgbm90IHNldAoKIwojIFBDTUNJQSBkZXZpY2VzCiMKIyBDT05G
SUdfU05EX1ZYUE9DS0VUIGlzIG5vdCBzZXQKIyBDT05GSUdfU05EX1BEQVVESU9DRiBpcyBub3Qg
c2V0CgojCiMgT3BlbiBTb3VuZCBTeXN0ZW0KIwojIENPTkZJR19TT1VORF9QUklNRSBpcyBub3Qg
c2V0CgojCiMgVVNCIHN1cHBvcnQKIwpDT05GSUdfVVNCX0FSQ0hfSEFTX0hDRD15CkNPTkZJR19V
U0JfQVJDSF9IQVNfT0hDST15CkNPTkZJR19VU0JfQVJDSF9IQVNfRUhDST15CkNPTkZJR19VU0I9
eQpDT05GSUdfVVNCX0RFQlVHPXkKCiMKIyBNaXNjZWxsYW5lb3VzIFVTQiBvcHRpb25zCiMKQ09O
RklHX1VTQl9ERVZJQ0VGUz15CiMgQ09ORklHX1VTQl9CQU5EV0lEVEggaXMgbm90IHNldAojIENP
TkZJR19VU0JfRFlOQU1JQ19NSU5PUlMgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1VTUEVORCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PVEcgaXMgbm90IHNldAoKIwojIFVTQiBIb3N0IENvbnRy
b2xsZXIgRHJpdmVycwojCkNPTkZJR19VU0JfRUhDSV9IQ0Q9eQojIENPTkZJR19VU0JfRUhDSV9T
UExJVF9JU08gaXMgbm90IHNldAojIENPTkZJR19VU0JfRUhDSV9ST09UX0hVQl9UVCBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9JU1AxMTZYX0hDRCBpcyBub3Qgc2V0CkNPTkZJR19VU0JfT0hDSV9I
Q0Q9eQojIENPTkZJR19VU0JfT0hDSV9CSUdfRU5ESUFOIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9P
SENJX0xJVFRMRV9FTkRJQU49eQpDT05GSUdfVVNCX1VIQ0lfSENEPXkKIyBDT05GSUdfVVNCX1NM
ODExX0hDRCBpcyBub3Qgc2V0CgojCiMgVVNCIERldmljZSBDbGFzcyBkcml2ZXJzCiMKQ09ORklH
X1VTQl9BQ009bQpDT05GSUdfVVNCX1BSSU5URVI9bQoKIwojIE5PVEU6IFVTQl9TVE9SQUdFIGVu
YWJsZXMgU0NTSSwgYW5kICdTQ1NJIGRpc2sgc3VwcG9ydCcKIwoKIwojIG1heSBhbHNvIGJlIG5l
ZWRlZDsgc2VlIFVTQl9TVE9SQUdFIEhlbHAgZm9yIG1vcmUgaW5mb3JtYXRpb24KIwpDT05GSUdf
VVNCX1NUT1JBR0U9bQojIENPTkZJR19VU0JfU1RPUkFHRV9ERUJVRyBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TVE9SQUdFX0RBVEFGQUIgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9G
UkVFQ09NIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfSVNEMjAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NUT1JBR0VfRFBDTSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVE9SQUdF
X1VTQkFUIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjA5IGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NUT1JBR0VfU0REUjU1IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NUT1JB
R0VfSlVNUFNIT1QgaXMgbm90IHNldAojIENPTkZJR19VU0JfU1RPUkFHRV9BTEFVREEgaXMgbm90
IHNldApDT05GSUdfVVNCX0xJQlVTVUFMPXkKCiMKIyBVU0IgSW5wdXQgRGV2aWNlcwojCkNPTkZJ
R19VU0JfSElEPXkKQ09ORklHX1VTQl9ISURJTlBVVD15CiMgQ09ORklHX1VTQl9ISURJTlBVVF9Q
T1dFUkJPT0sgaXMgbm90IHNldAojIENPTkZJR19ISURfRkYgaXMgbm90IHNldApDT05GSUdfVVNC
X0hJRERFVj15CiMgQ09ORklHX1VTQl9BSVBURUsgaXMgbm90IHNldAojIENPTkZJR19VU0JfV0FD
T00gaXMgbm90IHNldAojIENPTkZJR19VU0JfQUNFQ0FEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0tCVEFCIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BPV0VSTUFURSBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9UT1VDSFNDUkVFTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9ZRUFMSU5LIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1hQQUQgaXMgbm90IHNldAojIENPTkZJR19VU0JfQVRJX1JFTU9U
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BVElfUkVNT1RFMiBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9LRVlTUEFOX1JFTU9URSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BUFBMRVRPVUNIIGlz
IG5vdCBzZXQKCiMKIyBVU0IgSW1hZ2luZyBkZXZpY2VzCiMKIyBDT05GSUdfVVNCX01EQzgwMCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0CgojCiMgVVNCIE5ldHdv
cmsgQWRhcHRlcnMKIwojIENPTkZJR19VU0JfQ0FUQyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9L
QVdFVEggaXMgbm90IHNldAojIENPTkZJR19VU0JfUEVHQVNVUyBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9SVEw4MTUwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1VTQk5FVCBpcyBub3Qgc2V0CkNP
TkZJR19VU0JfTU9OPXkKCiMKIyBVU0IgcG9ydCBkcml2ZXJzCiMKIyBDT05GSUdfVVNCX1VTUzcy
MCBpcyBub3Qgc2V0CgojCiMgVVNCIFNlcmlhbCBDb252ZXJ0ZXIgc3VwcG9ydAojCkNPTkZJR19V
U0JfU0VSSUFMPXkKQ09ORklHX1VTQl9TRVJJQUxfQ09OU09MRT15CkNPTkZJR19VU0JfU0VSSUFM
X0dFTkVSSUM9eQojIENPTkZJR19VU0JfU0VSSUFMX0FJUlBSSU1FIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX1NFUklBTF9BTllEQVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9BUksz
MTE2IGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TRVJJQUxfQkVMS0lOPXkKIyBDT05GSUdfVVNCX1NF
UklBTF9XSElURUhFQVQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0RJR0lfQUNDRUxF
UE9SVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1AyMTAxIGlzIG5vdCBzZXQKIyBD
T05GSUdfVVNCX1NFUklBTF9DWVBSRVNTX004IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklB
TF9FTVBFRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRlRESV9TSU8gaXMgbm90IHNl
dAojIENPTkZJR19VU0JfU0VSSUFMX0ZVTlNPRlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VS
SUFMX1ZJU09SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9JUEFRIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX1NFUklBTF9JUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfRURH
RVBPUlQgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0VER0VQT1JUX1RJIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVVNCX1NFUklBTF9HQVJNSU4gaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VS
SUFMX0lQVyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9QREEgaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU4gaXMgbm90IHNldAojIENPTkZJR19VU0Jf
U0VSSUFMX0tMU0kgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX0tPQklMX1NDVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfTUNUX1UyMzIgaXMgbm90IHNldAojIENPTkZJR19V
U0JfU0VSSUFMX01PUzc3MjAgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0VSSUFMX05BVk1BTiBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJQUxfUEwyMzAzIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX1NFUklBTF9IUDRYIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9TQUZFIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9USSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVJJ
QUxfQ1lCRVJKQUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1NFUklBTF9YSVJDT00gaXMgbm90
IHNldAojIENPTkZJR19VU0JfU0VSSUFMX09QVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
RVJJQUxfT01OSU5FVCBpcyBub3Qgc2V0CgojCiMgVVNCIE1pc2NlbGxhbmVvdXMgZHJpdmVycwoj
CiMgQ09ORklHX1VTQl9FTUk2MiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9FTUkyNiBpcyBub3Qg
c2V0CiMgQ09ORklHX1VTQl9BVUVSU1dBTEQgaXMgbm90IHNldAojIENPTkZJR19VU0JfUklPNTAw
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFR09UT1dFUiBpcyBub3Qgc2V0CkNPTkZJR19VU0Jf
TENEPW0KQ09ORklHX1VTQl9MRUQ9bQpDT05GSUdfVVNCX0NZVEhFUk09bQojIENPTkZJR19VU0Jf
R09URU1QIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9QSElER0VUS0lUPW0KQ09ORklHX1VTQl9QSElE
R0VUU0VSVk89bQojIENPTkZJR19VU0JfSURNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9B
UFBMRURJU1BMQVkgaXMgbm90IHNldAojIENPTkZJR19VU0JfU0lTVVNCVkdBIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0xEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1RFU1QgaXMgbm90IHNldAoK
IwojIFVTQiBEU0wgbW9kZW0gc3VwcG9ydAojCgojCiMgVVNCIEdhZGdldCBTdXBwb3J0CiMKIyBD
T05GSUdfVVNCX0dBREdFVCBpcyBub3Qgc2V0CgojCiMgTU1DL1NEIENhcmQgc3VwcG9ydAojCiMg
Q09ORklHX01NQyBpcyBub3Qgc2V0CgojCiMgTEVEIGRldmljZXMKIwojIENPTkZJR19ORVdfTEVE
UyBpcyBub3Qgc2V0CgojCiMgTEVEIGRyaXZlcnMKIwoKIwojIExFRCBUcmlnZ2VycwojCgojCiMg
SW5maW5pQmFuZCBzdXBwb3J0CiMKIyBDT05GSUdfSU5GSU5JQkFORCBpcyBub3Qgc2V0CiMgQ09O
RklHX0lQQVRIX0NPUkUgaXMgbm90IHNldAoKIwojIEVEQUMgLSBlcnJvciBkZXRlY3Rpb24gYW5k
IHJlcG9ydGluZyAoUkFTKSAoRVhQRVJJTUVOVEFMKQojCiMgQ09ORklHX0VEQUMgaXMgbm90IHNl
dAoKIwojIFJlYWwgVGltZSBDbG9jawojCiMgQ09ORklHX1JUQ19DTEFTUyBpcyBub3Qgc2V0Cgoj
CiMgRE1BIEVuZ2luZSBzdXBwb3J0CiMKIyBDT05GSUdfRE1BX0VOR0lORSBpcyBub3Qgc2V0Cgoj
CiMgRE1BIENsaWVudHMKIwoKIwojIERNQSBEZXZpY2VzCiMKCiMKIyBGaXJtd2FyZSBEcml2ZXJz
CiMKQ09ORklHX0VERD15CiMgQ09ORklHX0RFTExfUkJVIGlzIG5vdCBzZXQKIyBDT05GSUdfRENE
QkFTIGlzIG5vdCBzZXQKCiMKIyBGaWxlIHN5c3RlbXMKIwpDT05GSUdfRVhUMl9GUz15CiMgQ09O
RklHX0VYVDJfRlNfWEFUVFIgaXMgbm90IHNldAojIENPTkZJR19FWFQyX0ZTX1hJUCBpcyBub3Qg
c2V0CkNPTkZJR19FWFQzX0ZTPXkKIyBDT05GSUdfRVhUM19GU19YQVRUUiBpcyBub3Qgc2V0CkNP
TkZJR19KQkQ9eQojIENPTkZJR19KQkRfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19SRUlTRVI0
X0ZTIGlzIG5vdCBzZXQKQ09ORklHX1JFSVNFUkZTX0ZTPW0KIyBDT05GSUdfUkVJU0VSRlNfQ0hF
Q0sgaXMgbm90IHNldApDT05GSUdfUkVJU0VSRlNfUFJPQ19JTkZPPXkKIyBDT05GSUdfUkVJU0VS
RlNfRlNfWEFUVFIgaXMgbm90IHNldApDT05GSUdfSkZTX0ZTPW0KIyBDT05GSUdfSkZTX1BPU0lY
X0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19TRUNVUklUWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0pGU19ERUJVRyBpcyBub3Qgc2V0CkNPTkZJR19KRlNfU1RBVElTVElDUz15CiMgQ09ORklHX0ZT
X1BPU0lYX0FDTCBpcyBub3Qgc2V0CkNPTkZJR19YRlNfRlM9bQpDT05GSUdfWEZTX0VYUE9SVD15
CiMgQ09ORklHX1hGU19RVU9UQSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGU19TRUNVUklUWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1hGU19QT1NJWF9BQ0wgaXMgbm90IHNldAojIENPTkZJR19YRlNfUlQg
aXMgbm90IHNldAojIENPTkZJR19HRlMyX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfT0NGUzJfRlMg
aXMgbm90IHNldApDT05GSUdfTUlOSVhfRlM9bQpDT05GSUdfUk9NRlNfRlM9eQpDT05GSUdfSU5P
VElGWT15CkNPTkZJR19JTk9USUZZX1VTRVI9eQojIENPTkZJR19RVU9UQSBpcyBub3Qgc2V0CkNP
TkZJR19ETk9USUZZPXkKIyBDT05GSUdfQVVUT0ZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVU
T0ZTNF9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAoKIwojIENELVJP
TS9EVkQgRmlsZXN5c3RlbXMKIwpDT05GSUdfSVNPOTY2MF9GUz15CkNPTkZJR19KT0xJRVQ9eQpD
T05GSUdfWklTT0ZTPXkKQ09ORklHX1pJU09GU19GUz15CkNPTkZJR19VREZfRlM9bQpDT05GSUdf
VURGX05MUz15CgojCiMgRE9TL0ZBVC9OVCBGaWxlc3lzdGVtcwojCkNPTkZJR19GQVRfRlM9eQpD
T05GSUdfTVNET1NfRlM9eQpDT05GSUdfVkZBVF9GUz15CkNPTkZJR19GQVRfREVGQVVMVF9DT0RF
UEFHRT00MzcKQ09ORklHX0ZBVF9ERUZBVUxUX0lPQ0hBUlNFVD0iaXNvODg1OS0xIgpDT05GSUdf
TlRGU19GUz1tCiMgQ09ORklHX05URlNfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19OVEZTX1JX
IGlzIG5vdCBzZXQKCiMKIyBQc2V1ZG8gZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJPQ19GUz15CkNP
TkZJR19QUk9DX0tDT1JFPXkKQ09ORklHX1NZU0ZTPXkKQ09ORklHX1RNUEZTPXkKQ09ORklHX0hV
R0VUTEJGUz15CkNPTkZJR19IVUdFVExCX1BBR0U9eQpDT05GSUdfUkFNRlM9eQpDT05GSUdfQ09O
RklHRlNfRlM9eQoKIwojIE1pc2NlbGxhbmVvdXMgZmlsZXN5c3RlbXMKIwojIENPTkZJR19BREZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU1BMVVNfRlMgaXMgbm90IHNldAojIENPTkZJR19CRUZT
X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZT
IGlzIG5vdCBzZXQKQ09ORklHX0NSQU1GUz15CiMgQ09ORklHX1ZYRlNfRlMgaXMgbm90IHNldAoj
IENPTkZJR19IUEZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfUU5YNEZTX0ZTIGlzIG5vdCBzZXQK
Q09ORklHX1NZU1ZfRlM9bQpDT05GSUdfVUZTX0ZTPW0KIyBDT05GSUdfVUZTX0ZTX1dSSVRFIGlz
IG5vdCBzZXQKCiMKIyBOZXR3b3JrIEZpbGUgU3lzdGVtcwojCiMgQ09ORklHX05GU19GUyBpcyBu
b3Qgc2V0CkNPTkZJR19ORlNEPW0KQ09ORklHX05GU0RfVjM9eQojIENPTkZJR19ORlNEX1YzX0FD
TCBpcyBub3Qgc2V0CiMgQ09ORklHX05GU0RfVjQgaXMgbm90IHNldApDT05GSUdfTkZTRF9UQ1A9
eQpDT05GSUdfTE9DS0Q9bQpDT05GSUdfTE9DS0RfVjQ9eQpDT05GSUdfRVhQT1JURlM9bQpDT05G
SUdfTkZTX0NPTU1PTj15CkNPTkZJR19TVU5SUEM9bQojIENPTkZJR19SUENTRUNfR1NTX0tSQjUg
aXMgbm90IHNldAojIENPTkZJR19SUENTRUNfR1NTX1NQS00zIGlzIG5vdCBzZXQKIyBDT05GSUdf
U01CX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0lGUyBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0NPREFfRlMgaXMgbm90IHNldAojIENPTkZJR19BRlNfRlMg
aXMgbm90IHNldAojIENPTkZJR185UF9GUyBpcyBub3Qgc2V0CgojCiMgUGFydGl0aW9uIFR5cGVz
CiMKQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRD15CiMgQ09ORklHX0FDT1JOX1BBUlRJVElPTiBp
cyBub3Qgc2V0CiMgQ09ORklHX09TRl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19BTUlH
QV9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19BVEFSSV9QQVJUSVRJT04gaXMgbm90IHNl
dAojIENPTkZJR19NQUNfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX01TRE9TX1BBUlRJVElP
Tj15CiMgQ09ORklHX0JTRF9ESVNLTEFCRUwgaXMgbm90IHNldAojIENPTkZJR19NSU5JWF9TVUJQ
QVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TT0xBUklTX1g4Nl9QQVJUSVRJT04gaXMgbm90
IHNldAojIENPTkZJR19VTklYV0FSRV9ESVNLTEFCRUwgaXMgbm90IHNldAojIENPTkZJR19MRE1f
UEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU0dJX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMg
Q09ORklHX1VMVFJJWF9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19TVU5fUEFSVElUSU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfS0FSTUFfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
RUZJX1BBUlRJVElPTiBpcyBub3Qgc2V0CgojCiMgTmF0aXZlIExhbmd1YWdlIFN1cHBvcnQKIwpD
T05GSUdfTkxTPXkKQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5LTEiCkNPTkZJR19OTFNfQ09E
RVBBR0VfNDM3PXkKIyBDT05GSUdfTkxTX0NPREVQQUdFXzczNyBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV83NzUgaXMgbm90IHNldApDT05GSUdfTkxTX0NPREVQQUdFXzg1MD15CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV84NjAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYx
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV84NjMgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY0IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19DT0RFUEFHRV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
MTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9eQpDT05GSUdfTkxTX0lTTzg4NTlfMT15
CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8z
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5Xzkg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMgQ09ORklHX05M
U19JU084ODU5XzE0IGlzIG5vdCBzZXQKQ09ORklHX05MU19JU084ODU5XzE1PXkKIyBDT05GSUdf
TkxTX0tPSThfUiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19LT0k4X1UgaXMgbm90IHNldApDT05G
SUdfTkxTX1VURjg9eQoKIwojIERpc3RyaWJ1dGVkIExvY2sgTWFuYWdlcgojCgojCiMgSW5zdHJ1
bWVudGF0aW9uIFN1cHBvcnQKIwpDT05GSUdfUFJPRklMSU5HPXkKIyBDT05GSUdfT1BST0ZJTEUg
aXMgbm90IHNldApDT05GSUdfS1BST0JFUz15CgojCiMgS2VybmVsIGhhY2tpbmcKIwpDT05GSUdf
UFJJTlRLX1RJTUU9eQpDT05GSUdfTUFHSUNfU1lTUlE9eQpDT05GSUdfVU5VU0VEX1NZTUJPTFM9
eQpDT05GSUdfREVCVUdfU0hJUlE9eQpDT05GSUdfREVCVUdfS0VSTkVMPXkKQ09ORklHX0xPR19C
VUZfU0hJRlQ9MTYKQ09ORklHX0RFVEVDVF9TT0ZUTE9DS1VQPXkKIyBDT05GSUdfU0NIRURTVEFU
UyBpcyBub3Qgc2V0CkNPTkZJR19ERUJVR19TTEFCPXkKQ09ORklHX0RFQlVHX1NMQUJfTEVBSz15
CiMgQ09ORklHX0RFQlVHX01VVEVYRVMgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19SVF9NVVRF
WEVTIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRfTVVURVhfVEVTVEVSIGlzIG5vdCBzZXQKQ09ORklH
X0RFQlVHX1NQSU5MT0NLPXkKIyBDT05GSUdfUFJPVkVfU1BJTl9MT0NLSU5HIGlzIG5vdCBzZXQK
IyBDT05GSUdfUFJPVkVfUldfTE9DS0lORyBpcyBub3Qgc2V0CiMgQ09ORklHX1BST1ZFX01VVEVY
X0xPQ0tJTkcgaXMgbm90IHNldAojIENPTkZJR19QUk9WRV9SV1NFTV9MT0NLSU5HIGlzIG5vdCBz
ZXQKQ09ORklHX0RFQlVHX1NQSU5MT0NLX1NMRUVQPXkKIyBDT05GSUdfREVCVUdfTE9DS0lOR19B
UElfU0VMRlRFU1RTIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfS09CSkVDVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0RFQlVHX0lORk8gaXMgbm90IHNldAojIENPTkZJR19QQUdFX09XTkVSIGlzIG5v
dCBzZXQKQ09ORklHX0RFQlVHX0ZTPXkKQ09ORklHX0RFQlVHX1ZNPXkKQ09ORklHX0ZSQU1FX1BP
SU5URVI9eQojIENPTkZJR19VTldJTkRfSU5GTyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZPUkNFRF9J
TkxJTklORyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NZTkNIUk9fVEVTVCBpcyBub3Qgc2V0
CiMgQ09ORklHX1JDVV9UT1JUVVJFX1RFU1QgaXMgbm90IHNldAojIENPTkZJR19QUk9GSUxFX0xJ
S0VMWSBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTlRfRVhUUkFfREVCVUdfSU5GT1JNQVRJT04gaXMg
bm90IHNldApDT05GSUdfREVCVUdfUk9EQVRBPXkKIyBDT05GSUdfSU9NTVVfREVCVUcgaXMgbm90
IHNldAoKIwojIFNlY3VyaXR5IG9wdGlvbnMKIwojIENPTkZJR19LRVlTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU0VDVVJJVFkgaXMgbm90IHNldAoKIwojIENyeXB0b2dyYXBoaWMgb3B0aW9ucwojCiMg
Q09ORklHX0NSWVBUTyBpcyBub3Qgc2V0CgojCiMgSGFyZHdhcmUgY3J5cHRvIGRldmljZXMKIwoK
IwojIExpYnJhcnkgcm91dGluZXMKIwpDT05GSUdfQ1JDX0NDSVRUPXkKQ09ORklHX0NSQzE2PXkK
Q09ORklHX0NSQzMyPXkKQ09ORklHX0xJQkNSQzMyQz15CkNPTkZJR19aTElCX0lORkxBVEU9eQpD
T05GSUdfUExJU1Q9eQo=

--Multipart=_Wed__31_May_2006_18_25_07_-0700_S_CO=W_vjh+WtOj_--
