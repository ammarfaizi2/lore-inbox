Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVAODDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVAODDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVAODCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:02:39 -0500
Received: from holomorphy.com ([66.93.40.71]:3466 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262169AbVAOC6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:58:15 -0500
Date: Fri, 14 Jan 2005 18:58:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050115025810.GF3474@holomorphy.com>
References: <20050114002352.5a038710.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 12:23:52AM -0800, Andrew Morton wrote:
> - Added bk-xfs to the -mm "external trees" lineup.
> - Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>   haven't yet taken as close a look at LTT as I should have.  Probably neither
>   have you.
>   It needs a bit of work on the kernel<->user periphery, which is not a big
>   deal.
[...]

No idea what hit me just yet. x86-64 doesn't boot. Still going through
the various architectures. The same system (including the initrd FPOS
bullcrap, though, of course, I'm using an initrd built just for this
kernel) boots various 2.6.x up to 2.6.10-mm1. There are vague indications
something in/around SCSI and/or initrd's has violently exploded in my face.


-- wli

  Booting '2.6.11-rc1-mm1'

kernel (hd0,0)/vmlinuz-2.6.11-rc1-mm1 early_printk=serial root=/dev/sda2 consol
e=ttyS0,9600 profile=1 debug initcall_debug nmi_watchdog=2 elevator=cfq splash=
silent showopts resume=/dev/sda3 desktop
   [Linux-bzImage, setup=0x1600, size=0x1c4711]
initrd (hd0,0)/initrd-2.6.11-rc1-mm1
   [Linux-initrd @ 0x37ceb000, 0x304d0d bytes]

Bootdata ok (command line is early_printk=serial root=/dev/sda2 console=ttyS0,9600 profile=1 debug initcall_debug nmi_watchdog=2 elevator=cfq splash=silent showopts resume=/dev/sda3 desktop)
Linux version 2.6.11-rc1-mm1 (wli@residue) (gcc version 3.3.3 (SuSE Linux)) #2 SMP Fri Jan 14 18:00:33 PST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebbd0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffd0000 (usable)
 BIOS-e820: 000000007ffd0000 - 000000007ffdf000 (ACPI data)
 BIOS-e820: 000000007ffdf000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f6710
ACPI: RSDT (v001 A M I  OEMRSDT  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0000
ACPI: FADT (v002 A M I  OEMFACP  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0200
ACPI: MADT (v001 A M I  OEMAPIC  0x05000427 MSFT 0x00000097) @ 0x000000007ffd0390
ACPI: MCFG (v001 Intel  Cayuse   0x00000001 MSFT 0x00000001) @ 0x000000007ffd0420
ACPI: OEMB (v001 A M I  AMI_OEM  0x05000427 MSFT 0x00000097) @ 0x000000007ffdf040
ACPI: HPET (v001 A M I  OEMHPET  0x05000427 MSFT 0x00000097) @ 0x000000007ffd7460
ACPI: DSDT (v001  CYCRB CYCRB039 0x00000039 INTL 0x02002026) @ 0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-0000000180000000
Bootmem setup node 0 0000000000000000-0000000180000000
On node 0 totalpages: 1572864
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1568768 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 16
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec81000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec81000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec81400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec81400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Checking aperture...
Built 1 zonelists
Initializing CPU#0
Kernel command line: early_printk=serial root=/dev/sda2 console=ttyS0,9600 profile=1 debug initcall_debug nmi_watchdog=2 elevator=cfq splash=silent showopts resume=/dev/sda3 desktop
kernel profiling enabled (shift: 1)
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz HPET timer.
time.c: Detected 3400.235 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Placing software IO TLB between 0x7528000 - 0x9528000
Memory: 4048952k/6291456k available (2395k kernel code, 0k reserved, 1484k data, 224k init)
Calibrating delay loop... 6750.20 BogoMIPS (lpj=3375104)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU0:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
per-CPU timeslice cutoff: 1023.90 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/6 rip 6000 rsp ffff81007ff95f58
Initializing CPU#1
Calibrating delay loop... 6782.97 BogoMIPS (lpj=3391488)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
Booting processor 2/1 rip 6000 rsp ffff810037c8df58
Initializing CPU#2
Calibrating delay loop... 6782.97 BogoMIPS (lpj=3391488)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU2: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
Booting processor 3/7 rip 6000 rsp ffff81007ff03f58
Initializing CPU#3
Calibrating delay loop... 6782.97 BogoMIPS (lpj=3391488)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 3
CPU3: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
Total of 4 processors activated (27099.13 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
checking TSC synchronization across 4 CPUs: passed.
time.c: Using HPET based timekeeping.
Brought up 4 CPUs
CPU0 attaching sched-domain:
 domain 0: span 05
  groups: 01 04
  domain 1: span 0f
   groups: 05 0a
   domain 2: span 0f
    groups: 0f
CPU1 attaching sched-domain:
 domain 0: span 0a
  groups: 02 08
  domain 1: span 0f
   groups: 0a 05
   domain 2: span 0f
    groups: 0f
CPU2 attaching sched-domain:
 domain 0: span 05
  groups: 04 01
  domain 1: span 0f
   groups: 05 0a
   domain 2: span 0f
    groups: 0f
CPU3 attaching sched-domain:
 domain 0: span 0a
  groups: 08 02
  domain 1: span 0f
   groups: 0a 05
   domain 2: span 0f
    groups: 0f
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Calling initcall 0xffffffff805633a0: cpufreq_tsc+0x0/0x90()
Calling initcall 0xffffffff8056e390: init_elf32_binfmt+0x0/0x10()
Calling initcall 0xffffffff80570180: helper_init+0x0/0x40()
Calling initcall 0xffffffff80570280: pm_init+0x0/0x30()
Calling initcall 0xffffffff80570400: ksysfs_init+0x0/0x30()
Losing some ticks... checking if CPU frequency changed.
Calling initcall 0xffffffff80572510: filelock_init+0x0/0x40()
Calling initcall 0xffffffff80572ce0: init_script_binfmt+0x0/0x10()
Calling initcall 0xffffffff80572cf0: init_elf_binfmt+0x0/0x10()
Calling initcall 0xffffffff805809f0: netlink_proto_init+0x0/0x200()
NET: Registered protocol family 16
Calling initcall 0xffffffff805744c0: kobject_uevent_init+0x0/0x40()
Calling initcall 0xffffffff805745a0: pcibus_class_init+0x0/0x10()
Calling initcall 0xffffffff80574c20: pci_driver_init+0x0/0x10()
Calling initcall 0xffffffff80578520: tty_class_init+0x0/0x30()
Calling initcall 0xffffffff8057ac90: register_node_type+0x0/0x10()
Calling initcall 0xffffffff80566490: mtrr_if_init+0x0/0x80()
Calling initcall 0xffffffff8057f100: pci_direct_init+0x0/0x1b0()
PCI: Using configuration type 1
Calling initcall 0xffffffff8057fe30: pci_mmcfg_init+0x0/0x90()
PCI: Using MMCONFIG at e0000000
Calling initcall 0xffffffff805662f0: mtrr_init+0x0/0x1a0()
mtrr: v2.0 (20020519)
Calling initcall 0xffffffff8056d290: topology_init+0x0/0x70()
Calling initcall 0xffffffff801541a0: pm_sysrq_init+0x0/0x20()
Calling initcall 0xffffffff80572240: init_bio+0x0/0x190()
Calling initcall 0xffffffff805754d0: fbmem_init+0x0/0xb0()
Calling initcall 0xffffffff80577622: acpi_init+0x0/0x1f1()
ACPI: Subsystem revision 20041203
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
Calling initcall 0xffffffff8057792c: acpi_ec_init+0x0/0x5e()
Calling initcall 0xffffffff80577d09: acpi_pci_root_init+0x0/0x20()
Calling initcall 0xffffffff80577e85: acpi_pci_link_init+0x0/0x42()
Calling initcall 0xffffffff80577ec7: acpi_power_init+0x0/0x74()
Calling initcall 0xffffffff80577f3b: acpi_system_init+0x0/0xc7()
Calling initcall 0xffffffff80578002: acpi_event_init+0x0/0x3e()
Calling initcall 0xffffffff80578040: acpi_scan_init+0x0/0xc4()
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2.P2P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
Calling initcall 0xffffffff80578e60: misc_init+0x0/0x90()
Calling initcall 0xffffffff8057ae10: device_init+0x0/0x40()
Calling initcall 0xffffffff8057e850: input_init+0x0/0x170()
Calling initcall 0xffffffff8057f320: pci_acpi_init+0x0/0x130()
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Calling initcall 0xffffffff8057f450: pci_legacy_init+0x0/0x100()
Calling initcall 0xffffffff8057f970: pcibios_irq_init+0x0/0x450()
Calling initcall 0xffffffff8057fdc0: pcibios_init+0x0/0x70()
Calling initcall 0xffffffff80580360: net_dev_init+0x0/0x200()
Calling initcall 0xffffffff805808f0: pktsched_init+0x0/0xc0()
Calling initcall 0xffffffff805809b0: tc_filter_init+0x0/0x40()
Calling initcall 0xffffffff80563430: late_hpet_init+0x0/0xc0()
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 64-bit timers
Calling initcall 0xffffffff8056c1f0: pci_iommu_init+0x0/0x610()
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Calling initcall 0xffffffff80572490: init_pipe_fs+0x0/0x50()
Calling initcall 0xffffffff80578104: acpi_motherboard_init+0x0/0x1bc()
Calling initcall 0xffffffff805782c0: chr_dev_init+0x0/0x90()
Calling initcall 0xffffffff8057ed20: cpufreq_gov_performance_init+0x0/0x10()
Calling initcall 0xffffffff8057ed30: pcibios_assign_resources+0x0/0xf0()
Calling initcall 0xffffffff8057fec0: fill_mp_bus_to_cpumask+0x0/0x100()
Calling initcall 0xffffffff80112800: time_init_device+0x0/0x30()
Calling initcall 0xffffffff80564a80: init_timer_sysfs+0x0/0x30()
Calling initcall 0xffffffff80564a50: i8259A_init_sysfs+0x0/0x30()
Calling initcall 0xffffffff80564f50: vsyscall_init+0x0/0x90()
Calling initcall 0xffffffff805654b0: sbf_init+0x0/0xd0()
Calling initcall 0xffffffff80566040: mce_init_device+0x0/0xf0()
Calling initcall 0xffffffff80565fd0: periodic_mcheck_init+0x0/0x30()
Calling initcall 0xffffffff80568300: init_lapic_sysfs+0x0/0x40()
Calling initcall 0xffffffff805697d0: ioapic_init_sysfs+0x0/0xd0()
Calling initcall 0xffffffff8056d330: x8664_sysctl_init+0x0/0x20()
Calling initcall 0xffffffff8056e370: ia32_init+0x0/0x20()
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Calling initcall 0xffffffff8056e3a0: ia32_binfmt_init+0x0/0x20()
Calling initcall 0xffffffff8056e3c0: init_syscall32+0x0/0x120()
Calling initcall 0xffffffff8056e4e0: init_aout_binfmt+0x0/0x10()
Calling initcall 0xffffffff8056f450: create_proc_profile+0x0/0x410()
Calling initcall 0xffffffff8056f930: ioresources_init+0x0/0x50()
Calling initcall 0xffffffff8056fae0: uid_cache_init+0x0/0xb0()
Calling initcall 0xffffffff8056fed0: param_sysfs_init+0x0/0x200()
Calling initcall 0xffffffff805700d0: init_posix_timers+0x0/0xb0()
Calling initcall 0xffffffff805701c0: init+0x0/0x60()
Calling initcall 0xffffffff80570220: proc_dma_init+0x0/0x30()
Calling initcall 0xffffffff8014f870: percpu_modinit+0x0/0x90()
Calling initcall 0xffffffff80570250: kallsyms_init+0x0/0x30()
Calling initcall 0xffffffff805702b0: ikconfig_init+0x0/0x40()
Calling initcall 0xffffffff80570370: audit_init+0x0/0x90()
audit: initializing netlink socket (disabled)
audit(1105757136.391:0): initialized
Calling initcall 0xffffffff80570fb0: init_per_zone_pages_min+0x0/0x50()
Calling initcall 0xffffffff80571ae0: pdflush_init+0x0/0x20()
Calling initcall 0xffffffff80571b00: cpucache_init+0x0/0x30()
Calling initcall 0xffffffff80571e80: kswapd_init+0x0/0x60()
Calling initcall 0xffffffff80571f20: procswaps_init+0x0/0x30()
Calling initcall 0xffffffff80571f50: hugetlb_init+0x0/0xb0()
Total HugeTLB memory allocated, 0
Calling initcall 0xffffffff805720d0: init_tmpfs+0x0/0xe0()
Calling initcall 0xffffffff805724e0: fasync_init+0x0/0x30()
Calling initcall 0xffffffff80572b20: aio_setup+0x0/0x70()
Calling initcall 0xffffffff80572b90: eventpoll_init+0x0/0xf0()
Calling initcall 0xffffffff80572c80: init_sys32_ioctl+0x0/0x60()
Calling initcall 0xffffffff80572d00: init_mbcache+0x0/0x30()
Calling initcall 0xffffffff80572d30: dquot_init+0x0/0x100()
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Calling initcall 0xffffffff80572e30: dnotify_init+0x0/0x30()
Calling initcall 0xffffffff805732b0: init_devpts_fs+0x0/0x40()
Calling initcall 0xffffffff805732f0: init_ext2_fs+0x0/0x70()
Calling initcall 0xffffffff805733a0: init_ramfs_fs+0x0/0x10()
Calling initcall 0xffffffff805733c0: init_hugetlbfs_fs+0x0/0x80()
Calling initcall 0xffffffff80573440: init_minix_fs+0x0/0x60()
Calling initcall 0xffffffff805734a0: init_iso9660_fs+0x0/0x70()
Calling initcall 0xffffffff805735a0: init_nfs_fs+0x0/0xa0()
Calling initcall 0xffffffff80573d00: init_nlm+0x0/0x30()
Calling initcall 0xffffffff80573d30: ipc_init+0x0/0x20()
Calling initcall 0xffffffff80573ed0: init_mqueue_fs+0x0/0xe0()
Calling initcall 0xffffffff80574100: selinux_nf_ip_init+0x0/0x60()
SELinux:  Registering netfilter hooks
Calling initcall 0xffffffff80574240: init_sel_fs+0x0/0x70()
Calling initcall 0xffffffff805742b0: selnl_init+0x0/0x50()
Calling initcall 0xffffffff80574300: sel_netif_init+0x0/0x80()
Calling initcall 0xffffffff80574420: init_crypto+0x0/0x20()
Initializing Cryptographic API
Calling initcall 0xffffffff80574470: init+0x0/0x10()
Calling initcall 0xffffffff80574480: init+0x0/0x40()
Calling initcall 0xffffffff80228860: pci_init+0x0/0x30()
Intel E7520/7320/7525 detected.<7>Calling initcall 0xffffffff80574c30: pci_sysfs_init+0x0/0x40()
Calling initcall 0xffffffff80574c70: pci_proc_init+0x0/0x70()
Calling initcall 0xffffffff805751a0: fb_console_init+0x0/0x70()
Calling initcall 0xffffffff80576b50: vesafb_init+0x0/0x68()
Calling initcall 0xffffffff80577e50: irqrouter_init_sysfs+0x0/0x35()
Calling initcall 0xffffffff80578350: rand_initialize+0x0/0x1b0()
Calling initcall 0xffffffff80578550: tty_init+0x0/0x1e0()
Calling initcall 0xffffffff80578770: inotify_init+0x0/0x100()
inotify device minor=63
Calling initcall 0xffffffff80578870: pty_init+0x0/0x5f0()
Calling initcall 0xffffffff80579430: rtc_init+0x0/0x200()
Real Time Clock Driver v1.12
Calling initcall 0xffffffff80579630: hpet_init+0x0/0x70()
hpet_acpi_add: no address or irqs in _CRS
Calling initcall 0xffffffff805796a0: nvram_init+0x0/0x90()
Non-volatile memory driver v1.2
Calling initcall 0xffffffff80579790: agp_init+0x0/0x30()
Linux agpgart interface v0.101 (c) Dave Jones
Calling initcall 0xffffffff805798a0: serio_init+0x0/0x60()
Calling initcall 0xffffffff80579990: i8042_init+0x0/0x650()
Calling initcall 0xffffffff8057a3d0: serial8250_init+0x0/0x110()
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Calling initcall 0xffffffff8057a5b0: serial8250_pci_init+0x0/0x10()
Calling initcall 0xffffffff80286e90: elevator_global_init+0x0/0x10()
Calling initcall 0xffffffff8057ae50: noop_init+0x0/0x10()
io scheduler noop registered
Calling initcall 0xffffffff8057ae60: as_init+0x0/0x60()
io scheduler anticipatory registered
Calling initcall 0xffffffff8057aec0: deadline_init+0x0/0x60()
io scheduler deadline registered
Calling initcall 0xffffffff80294810: cfq_init+0x0/0xb0()
io scheduler cfq registered (default)
Calling initcall 0xffffffff8057af20: rd_init+0x0/0x1c0()
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
Calling initcall 0xffffffff8057b150: loop_init+0x0/0x340()
loop: loaded (max 8 devices)
Calling initcall 0xffffffff8057b500: net_olddevs_init+0x0/0xe0()
Calling initcall 0xffffffff80296e30: aec62xx_ide_init+0x0/0x10()
Calling initcall 0xffffffff80297540: ali15x3_ide_init+0x0/0x10()
Calling initcall 0xffffffff80298630: amd74xx_ide_init+0x0/0x10()
Calling initcall 0xffffffff80299820: atiixp_ide_init+0x0/0x10()
Calling initcall 0xffffffff80299dd0: cmd64x_ide_init+0x0/0x10()
Calling initcall 0xffffffff8029b200: sc1200_ide_init+0x0/0x10()
Calling initcall 0xffffffff8029bd20: cy82c693_ide_init+0x0/0x10()
Calling initcall 0xffffffff8029c050: hpt34x_ide_init+0x0/0x10()
Calling initcall 0xffffffff8029c730: hpt366_ide_init+0x0/0x10()
Calling initcall 0xffffffff8029e640: ns87415_ide_init+0x0/0x10()
Calling initcall 0xffffffff8029ea00: pdc202xx_ide_init+0x0/0x10()
Calling initcall 0xffffffff8029fac0: pdc202new_ide_init+0x0/0x10()
Calling initcall 0xffffffff8057c3c0: piix_ide_init+0x0/0xd0()
Calling initcall 0xffffffff802a1050: rz1000_ide_init+0x0/0x10()
Calling initcall 0xffffffff802a1130: svwks_ide_init+0x0/0x10()
Calling initcall 0xffffffff802a1ac0: siimage_ide_init+0x0/0x10()
Calling initcall 0xffffffff802a31f0: sis5513_ide_init+0x0/0x10()
Calling initcall 0xffffffff802a4280: slc90e66_ide_init+0x0/0x10()
Calling initcall 0xffffffff802a47e0: triflex_ide_init+0x0/0x10()
Calling initcall 0xffffffff802a4cb0: via_ide_init+0x0/0x10()
Calling initcall 0xffffffff802a5f40: generic_ide_init+0x0/0x10()
Calling initcall 0xffffffff8057df40: ide_init+0x0/0x80()
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Calling initcall 0xffffffff8057e820: ide_generic_init+0x0/0x20()
Probing IDE interface ide0...
hda: TEAC DW-548D, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Calling initcall 0xffffffff802b3bf0: idedisk_init+0x0/0x10()
Calling initcall 0xffffffff802b5cb0: ide_cdrom_init+0x0/0x20()
hda: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Calling initcall 0xffffffff802ba550: idefloppy_init+0x0/0x30()
ide-floppy driver 0.99.newide
Calling initcall 0xffffffff8057e840: cdrom_init+0x0/0x10()
Calling initcall 0xffffffff8057e9c0: mousedev_init+0x0/0xe0()
mice: PS/2 mouse device common for all mice
Calling initcall 0xffffffff8057eaa0: atkbd_init+0x0/0x20()
Calling initcall 0xffffffff8057eac0: psmouse_init+0x0/0xb0()
Calling initcall 0xffffffff8057eb70: pcspkr_init+0x0/0x80()
input: PC Speaker
Calling initcall 0xffffffff8057ebf0: md_init+0x0/0x130()
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Calling initcall 0xffffffff80580140: flow_cache_init+0x0/0x220()
Calling initcall 0xffffffff805807c0: llc_init+0x0/0x70()
Calling initcall 0xffffffff80580830: snap_init+0x0/0x40()
Calling initcall 0xffffffff80580870: rif_init+0x0/0x80()
Calling initcall 0xffffffff805816b0: inet_init+0x0/0x3f0()
NET: Registered protocol family 2
IP: routing cache hash table of 32768 buckets, 512Kbytes
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
Calling initcall 0xffffffff80583970: tcpdiag_init+0x0/0x30()
Calling initcall 0xffffffff80583b70: af_unix_init+0x0/0x80()
NET: Registered protocol family 1
Calling initcall 0xffffffff80583bf0: init_sunrpc+0x0/0x50()
Calling initcall 0xffffffff80583c40: init_rpcsec_gss+0x0/0x40()
Calling initcall 0xffffffff80583c80: init_kerberos_module+0x0/0x25()
Calling initcall 0xffffffff80568c60: init_lapic_nmi_sysfs+0x0/0x40()
Calling initcall 0xffffffff8025480c: acpi_poweroff_init+0x0/0x3a()
Calling initcall 0xffffffff80577450: acpi_wakeup_device_init+0x0/0xec()
ACPI wakeup devices:
P0P1 MC97 USB1 USB2 USB3 USB4 EUSB P2P3 P2P4
Calling initcall 0xffffffff8057755d: acpi_sleep_init+0x0/0xc5()
ACPI: (supports S0 S1 S3 S4 S5)
Calling initcall 0xffffffff80254d18: acpi_sleep_proc_init+0x0/0x94()
Calling initcall 0xffffffff80578500: seqgen_init+0x0/0x20()
Calling initcall 0xffffffff8057a3a0: serial8250_late_console_init+0x0/0x30()
Calling initcall 0xffffffff8057aab0: early_uart_console_switch+0x0/0x90()
Calling initcall 0xffffffff802e6090: net_random_reseed+0x0/0x50()
Calling initcall 0xffffffff80582820: ip_auto_config+0x0/0xf00()
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Waiting 19sec for root device...
VFS: Waiting 18sec for root device...
VFS: Waiting 17sec for root device...
VFS: Waiting 16sec for root device...
VFS: Waiting 15sec for root device...
VFS: Waiting 14sec for root device...
VFS: Waiting 13sec for root device...
VFS: Waiting 12sec for root device...
VFS: Waiting 11sec for root device...
VFS: Waiting 10sec for root device...
VFS: Waiting 9sec for root device...
VFS: Waiting 8sec for root device...
VFS: Waiting 7sec for root device...
VFS: Waiting 6sec for root device...
VFS: Waiting 5sec for root device...
VFS: Waiting 4sec for root device...
VFS: Waiting 3sec for root device...
VFS: Waiting 2sec for root device...
VFS: Waiting 1sec for root device...
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
