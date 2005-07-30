Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVG3CYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVG3CYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVG3CYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:24:18 -0400
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:16891 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262705AbVG3CYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 22:24:15 -0400
Message-ID: <42EAE4CE.7060908@jtholmes.com>
Date: Fri, 29 Jul 2005 22:24:14 -0400
From: jt <jt@jtholmes.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 stalls at boot Andrew M. asked for this initcall dump
Content-Type: multipart/mixed;
 boundary="------------060800020106040207030500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060800020106040207030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


In one of his messages Andrew Morton asked for a dump of the stall 
encountered
in 2.6.12  using  ALT + Sys Req + P    and  ALT + Sys Req + T

I am having the stall problem so here is the dmesg output up and 
including the trace
It is in the attachment



--------------060800020106040207030500
Content-Type: text/plain;
 name="dump1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dump1"

Linux version 2.6.12 (root@jtlsuse) (gcc version 3.3.4 (pre 3.3.5 20040809)) #5 SMP Fri Jul 29 10:26:15 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bf70000 (usable)
 BIOS-e820: 000000001bf70000 - 000000001bf7b000 (ACPI data)
 BIOS-e820: 000000001bf7b000 - 000000001bf80000 (ACPI NVS)
 BIOS-e820: 000000001bf80000 - 000000001c000000 (reserved)
 BIOS-e820: 000000002bf80000 - 000000002c000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
447MB LOWMEM available.
found SMP MP-table at 000f6ae0
On node 0 totalpages: 114544
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 110448 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
Using APIC driver default
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: RS300 Board APIC at: 0xFEE00000
Processor #0 15:3 APIC version 20
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 2c000000 (gap: 2c000000:d2c00000)
Built 1 zonelists
Kernel command line: root=/dev/hda6 vga=0x317 selinux=0 apm=off acpi=off resume=/dev/hda6 desktop elevator=as splash=silent initcall_debug
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 3067.413 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 447792k/458176k available (2082k kernel code, 9820k reserved, 919k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 6078.46 BogoMIPS (lpj=3039232)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000459d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000459d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000459d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Mobile Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 04
Total of 1 processors activated (6078.46 BogoMIPS).
WARNING: 1 siblings found for CPU0, should be 2
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 00000001
  groups: 00000001
  domain 1: span 00000001
   groups: 00000001
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1144k freed
Calling initcall 0xc03fe890: reboot_init+0x0/0x10()
Calling initcall 0xc0405d00: helper_init+0x0/0x30()
Calling initcall 0xc0405e50: pm_init+0x0/0x20()
Calling initcall 0xc0405fa0: ksysfs_init+0x0/0x20()
Calling initcall 0xc0407b10: filelock_init+0x0/0x30()
Calling initcall 0xc0408170: init_script_binfmt+0x0/0x10()
Calling initcall 0xc0408180: init_elf_binfmt+0x0/0x10()
Calling initcall 0xc0413780: netlink_proto_init+0x0/0x1e0()
NET: Registered protocol family 16
Calling initcall 0xc0408f50: kobject_uevent_init+0x0/0x30()
Calling initcall 0xc0409020: pcibus_class_init+0x0/0x10()
Calling initcall 0xc0409700: pci_driver_init+0x0/0x10()
Calling initcall 0xc040c490: tty_class_init+0x0/0x20()
Calling initcall 0xc03fd7c0: mtrr_if_init+0x0/0x70()
Calling initcall 0xc0412400: pci_pcbios_init+0x0/0x40()
PCI: PCI BIOS revision 2.10 entry at 0xfd958, last bus=2
Calling initcall 0xc0412440: pci_mmcfg_init+0x0/0x50()
Calling initcall 0xc04125d0: pci_direct_init+0x0/0xe0()
PCI: Using configuration type 1
Calling initcall 0xc03fd680: mtrr_init+0x0/0x140()
mtrr: v2.0 (20020519)
Calling initcall 0xc0404c50: topology_init+0x0/0x30()
Calling initcall 0xc0138e90: pm_sysrq_init+0x0/0x20()
Calling initcall 0xc0407930: init_bio+0x0/0xd0()
Calling initcall 0xc0409df0: fbmem_init+0x0/0x80()
Calling initcall 0xc040b4ac: acpi_init+0x0/0xb4()
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
Calling initcall 0xc040b887: acpi_ec_init+0x0/0x51()
Calling initcall 0xc040b8e5: acpi_pci_root_init+0x0/0x1c()
Calling initcall 0xc040ba40: acpi_pci_link_init+0x0/0x3a()
Calling initcall 0xc040ba7a: acpi_power_init+0x0/0x65()
Calling initcall 0xc040badf: acpi_system_init+0x0/0xaf()
Calling initcall 0xc040bb8e: acpi_event_init+0x0/0x39()
Calling initcall 0xc040bbc7: acpi_scan_init+0x0/0x5e()
Calling initcall 0xc040be20: pnp_init+0x0/0x20()
Linux Plug and Play Support v0.97 (c) Adam Belay
Calling initcall 0xc040c300: pnpacpi_init+0x0/0x60()
pnp: PnP ACPI: disabled
Calling initcall 0xc040cba0: misc_init+0x0/0x70()
Calling initcall 0xc040e320: genhd_device_init+0x0/0x30()
Calling initcall 0xc0411e50: input_init+0x0/0x90()
Calling initcall 0xc0412710: pci_acpi_init+0x0/0xa0()
Calling initcall 0xc04127b0: pci_legacy_init+0x0/0x50()
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
Boot video device is 0000:01:05.0
PCI: Transparent bridge - 0000:00:14.4
Calling initcall 0xc0412fa0: pcibios_irq_init+0x0/0xd0()
PCI: Using IRQ router default [1002/434c] at 0000:00:14.3
PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:13.1[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:13.2[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:14.1[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:14.5[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:14.6[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:02:02.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:02:03.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:02:04.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:02:04.1[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:02:04.2[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:02:04.3[B] -> IRQ 17
Calling initcall 0xc0413070: pcibios_init+0x0/0x90()
Calling initcall 0xc0413190: proto_init+0x0/0x30()
Calling initcall 0xc04133f0: net_dev_init+0x0/0x150()
Calling initcall 0xc0413690: pktsched_init+0x0/0xb0()
Calling initcall 0xc0413740: tc_filter_init+0x0/0x40()
Calling initcall 0xc0407aa0: init_pipe_fs+0x0/0x40()
Calling initcall 0xc040bdf3: acpi_motherboard_init+0x0/0x2d()
Calling initcall 0xc040bf00: pnp_system_init+0x0/0x10()
Calling initcall 0xc040c3a0: chr_dev_init+0x0/0x80()
Calling initcall 0xc04122f0: pcibios_assign_resources+0x0/0xf0()
Calling initcall 0xc0109350: time_init_device+0x0/0x20()
Calling initcall 0xc03fa8e0: i8259A_init_sysfs+0x0/0x20()
Calling initcall 0xc03fafe0: sbf_init+0x0/0x50()
Calling initcall 0xc010c0c0: cache_register_driver+0x0/0x20()
Number of CPUs sharing cache didn't match any known set of CPUs
Number of CPUs sharing cache didn't match any known set of CPUs
Calling initcall 0xc03fdb90: init_timer_sysfs+0x0/0x20()
Calling initcall 0xc0400cf0: init_lapic_sysfs+0x0/0x30()
Calling initcall 0xc0402d00: ioapic_init_sysfs+0x0/0xd0()
Calling initcall 0xc0403140: sysenter_setup+0x0/0x90()
Calling initcall 0xc0405570: create_proc_profile+0x0/0x50()
Calling initcall 0xc0405620: ioresources_init+0x0/0x40()
Calling initcall 0xc0405790: uid_cache_init+0x0/0x80()
Calling initcall 0xc0405c50: param_sysfs_init+0x0/0x20()
Calling initcall 0xc0405c70: init_posix_timers+0x0/0x90()
Calling initcall 0xc0405d30: init_posix_cpu_timers+0x0/0x90()
Calling initcall 0xc0405dc0: init+0x0/0x50()
Calling initcall 0xc0405e10: proc_dma_init+0x0/0x20()
Calling initcall 0xc0135280: percpu_modinit+0x0/0x80()
Calling initcall 0xc0405e30: kallsyms_init+0x0/0x20()
Calling initcall 0xc0405e70: ikconfig_init+0x0/0x30()
Calling initcall 0xc0405ea0: audit_init+0x0/0x90()
audit: initializing netlink socket (disabled)
audit(1122647680.110:0): initialized
Calling initcall 0xc0406f60: init_per_zone_pages_min+0x0/0x50()
Calling initcall 0xc0407240: pdflush_init+0x0/0x10()
Calling initcall 0xc04074e0: cpucache_init+0x0/0x50()
Calling initcall 0xc0407550: kswapd_init+0x0/0x50()
Calling initcall 0xc04075a0: init_emergency_pool+0x0/0x60()
Calling initcall 0xc0407680: gate_vma_init+0x0/0x40()
Calling initcall 0xc04076f0: procswaps_init+0x0/0x20()
Calling initcall 0xc0407710: hugetlb_init+0x0/0xa0()
Total HugeTLB memory allocated, 0
Calling initcall 0xc04077e0: init_tmpfs+0x0/0x80()
Calling initcall 0xc0407ae0: fasync_init+0x0/0x30()
Calling initcall 0xc0408060: aio_setup+0x0/0x60()
Calling initcall 0xc04080c0: eventpoll_init+0x0/0xb0()
Calling initcall 0xc0408190: init_mbcache+0x0/0x20()
Calling initcall 0xc04081b0: dnotify_init+0x0/0x30()
Calling initcall 0xc0408590: init_devpts_fs+0x0/0x30()
Calling initcall 0xc04085c0: init_ext2_fs+0x0/0x40()
Calling initcall 0xc0408630: init_ramfs_fs+0x0/0x10()
Calling initcall 0xc0408650: init_hugetlbfs_fs+0x0/0x70()
Calling initcall 0xc04086c0: init_bfs_fs+0x0/0x30()
Calling initcall 0xc04086f0: init_iso9660_fs+0x0/0x40()
Calling initcall 0xc04087b0: init_hfsplus_fs+0x0/0x60()
Calling initcall 0xc0408810: init_hfs_fs+0x0/0x60()
Calling initcall 0xc0408870: init_nfs_fs+0x0/0x80()
Calling initcall 0xc04088f0: init_nlm+0x0/0x20()
Calling initcall 0xc0408910: init_nls_utf8+0x0/0x20()
Calling initcall 0xc0408930: init_efs_fs+0x0/0x40()
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
Calling initcall 0xc0408970: init_affs_fs+0x0/0x30()
Calling initcall 0xc04089a0: init_autofs_fs+0x0/0x10()
Calling initcall 0xc04089b0: init_autofs4_fs+0x0/0x10()
Calling initcall 0xc04089c0: init_befs_fs+0x0/0x40()
BeFS version: 0.9.3
Calling initcall 0xc0408a00: ipc_init+0x0/0x20()
Calling initcall 0xc0408d60: selinux_nf_ip_init+0x0/0x40()
Calling initcall 0xc0408dc0: init_sel_fs+0x0/0x60()
Calling initcall 0xc0408e20: selnl_init+0x0/0x40()
Calling initcall 0xc0408e60: sel_netif_init+0x0/0x60()
Calling initcall 0xc0408ec0: init_crypto+0x0/0x20()
Initializing Cryptographic API
Calling initcall 0xc0408f00: init+0x0/0x10()
Calling initcall 0xc0408f10: init+0x0/0x40()
Calling initcall 0xc01fa9f0: pci_init+0x0/0x30()
Calling initcall 0xc0409710: pci_sysfs_init+0x0/0x30()
Calling initcall 0xc0409740: pci_proc_init+0x0/0x70()
Calling initcall 0xc0409d90: fb_console_init+0x0/0x60()
Calling initcall 0xc040a010: imsttfb_init+0x0/0x40()
Calling initcall 0xc040a8b0: vesafb_init+0x0/0x4e()
vesafb: framebuffer at 0xf0000000, mapped to 0xdc880000, using 3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:52d0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Calling initcall 0xc040ba12: irqrouter_init_sysfs+0x0/0x2e()
Calling initcall 0xc040c420: rand_initialize+0x0/0x30()
Calling initcall 0xc040c4b0: tty_init+0x0/0x1a0()
Calling initcall 0xc040cb90: pty_init+0x0/0x10()
Calling initcall 0xc040d060: serio_init+0x0/0x70()
Calling initcall 0xc040d560: i8042_init+0x0/0x180()
PNP: No PS/2 controller found. Probing ports directly.
i8042.c: Detected active multiplexing controller, rev 1.9.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Calling initcall 0xc040db60: serial8250_init+0x0/0xa0()
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Calling initcall 0xc040dc00: serial8250_pnp_init+0x0/0x10()
Calling initcall 0xc040dc10: serial8250_pci_init+0x0/0x10()
Calling initcall 0xc040e350: noop_init+0x0/0x10()
io scheduler noop registered
Calling initcall 0xc040e360: as_init+0x0/0x50()
io scheduler anticipatory registered
Calling initcall 0xc040e3b0: deadline_init+0x0/0x50()
io scheduler deadline registered
Calling initcall 0xc040e480: cfq_init+0x0/0x30()
io scheduler cfq registered
Calling initcall 0xc040ec00: floppy_init+0x0/0x570()
floppy0: no floppy controllers found
Calling initcall 0xc040f170: rd_init+0x0/0x190()
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
Calling initcall 0xc040f350: loop_init+0x0/0x2f0()
loop: loaded (max 8 devices)
Calling initcall 0xc040f730: net_olddevs_init+0x0/0x30()
Calling initcall 0xc0263ea0: aec62xx_ide_init+0x0/0x10()
Calling initcall 0xc0264c30: ali15x3_ide_init+0x0/0x10()
Calling initcall 0xc0265f50: amd74xx_ide_init+0x0/0x10()
Calling initcall 0xc02665f0: atiixp_ide_init+0x0/0x10()
Calling initcall 0xc02679b0: cmd64x_ide_init+0x0/0x10()
Calling initcall 0xc0268440: sc1200_ide_init+0x0/0x10()
Calling initcall 0xc0268800: cy82c693_ide_init+0x0/0x10()
Calling initcall 0xc0268db0: hpt34x_ide_init+0x0/0x10()
Calling initcall 0xc026abd0: hpt366_ide_init+0x0/0x10()
Calling initcall 0xc026ae10: ns87415_ide_init+0x0/0x10()
Calling initcall 0xc026b290: opti621_ide_init+0x0/0x10()
Calling initcall 0xc026c270: pdc202xx_ide_init+0x0/0x10()
Calling initcall 0xc026cd50: pdc202new_ide_init+0x0/0x10()
Calling initcall 0xc0410550: piix_ide_init+0x0/0x10()
Calling initcall 0xc026d9a0: rz1000_ide_init+0x0/0x10()
Calling initcall 0xc026e770: svwks_ide_init+0x0/0x10()
Calling initcall 0xc026fe10: siimage_ide_init+0x0/0x10()
Calling initcall 0xc02719a0: sis5513_ide_init+0x0/0x10()
Calling initcall 0xc0271f90: slc90e66_ide_init+0x0/0x10()
Calling initcall 0xc02721d0: triflex_ide_init+0x0/0x10()
Calling initcall 0xc0272640: trm290_ide_init+0x0/0x10()
Calling initcall 0xc0273a50: via_ide_init+0x0/0x10()
Calling initcall 0xc0273ba0: generic_ide_init+0x0/0x10()
Calling initcall 0xc04115a0: ide_init+0x0/0x60()
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
ATIIXP: chipset revision 0
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8070-0x8077, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8078-0x807f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N060ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-RAM UJ-820S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Calling initcall 0xc0411d80: ide_generic_init+0x0/0x10()
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
Calling initcall 0xc02818d0: idedisk_init+0x0/0xa()
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
Calling initcall 0xc0283aa0: idefloppy_init+0x0/0x16()
ide-floppy driver 0.99.newide
Calling initcall 0xc0411ee0: mousedev_init+0x0/0xd0()
mice: PS/2 mouse device common for all mice
Calling initcall 0xc0411fb0: atkbd_init+0x0/0x10()
Calling initcall 0xc0411fc0: psmouse_init+0x0/0x10()
Calling initcall 0xc0411fd0: pcspkr_init+0x0/0x80()
input: PC Speaker
Calling initcall 0xc0412050: md_init+0x0/0xd0()
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Calling initcall 0xc0413200: flow_cache_init+0x0/0x110()
Calling initcall 0xc0414490: inet_init+0x0/0x1a0()
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
Calling initcall 0xc0414880: init_syncookies+0x0/0x20()
Calling initcall 0xc04148a0: tcpdiag_init+0x0/0x20()
Calling initcall 0xc0414a70: af_unix_init+0x0/0x60()
NET: Registered protocol family 1
Calling initcall 0xc0414ad0: init_sunrpc+0x0/0x50()
Calling initcall 0xc0414b20: init_rpcsec_gss+0x0/0x40()
Calling initcall 0xc0414b60: init_kerberos_module+0x0/0x24()
Calling initcall 0xc04013d0: check_nmi_watchdog+0x0/0xf0()
Calling initcall 0xc0401580: init_lapic_nmi_sysfs+0x0/0x30()
Calling initcall 0xc0401610: balanced_irq_init+0x0/0x190()
Calling initcall 0xc0402ce0: io_apic_bug_finalize+0x0/0x20()
Calling initcall 0xc0223f3d: acpi_poweroff_init+0x0/0x2f()
Calling initcall 0xc040b0f2: acpi_wakeup_device_init+0x0/0xc7()
Calling initcall 0xc040b1d5: acpi_sleep_init+0x0/0xad()
Calling initcall 0xc0224dd6: acpi_sleep_proc_init+0x0/0x7e()
Calling initcall 0xc040c450: seqgen_init+0x0/0x10()
Calling initcall 0xc040e0e0: early_uart_console_switch+0x0/0x80()
Calling initcall 0xc02a4dc0: net_random_reseed+0x0/0x40()
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio4
SysRq : Show Regs

Pid: 1385, comm:                 udev
EIP: 0073:[<08052e77>] CPU: 0
EIP is at 0x8052e77
 ESP: 007b:bfd6bab4 EFLAGS: 00000287    Not tainted  (2.6.12)
EAX: fffffffc EBX: bfd6bad9 ECX: b7e9d0d9 EDX: 6fe9cf79
ESI: bfd6bad0 EDI: bfd6bc18 EBP: bfd6bab8 DS: 007b ES: 007b
CR0: 8005003b CR2: b7eda000 CR3: 1b5f1000 CR4: 000006d0
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
swapper       S 00000000     0     1      0     2               (L-TLB)
dbe3ff2c 00000046 00000000 00000000 dbd81020 c011c972 dbd81020 00000000 
       c1384e80 c1384520 00000000 00083b47 21478a44 00000005 dbd81020 c14eda40 
       c14edb64 00000000 00000246 c14edae8 00000004 fffffe00 c14eda40 c0121343 
Call Trace:
 [<c011c972>] copy_process+0x5d2/0xcb0
 [<c0121343>] do_wait+0x313/0x3a0
 [<c0119940>] default_wake_function+0x0/0x10
 [<c03f52c0>] do_linuxrc+0x0/0x80
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0121479>] sys_wait4+0x29/0x30
 [<c03f5431>] handle_initrd+0xf1/0x240
 [<c03f55d5>] initrd_load+0x55/0x70
 [<c03f2e88>] prepare_namespace+0x38/0x120
 [<c010047c>] init+0x15c/0x180
 [<c0100320>] init+0x0/0x180
 [<c01023f5>] kernel_thread_helper+0x5/0x10
migration/0   S 00000000     0     2      1             3       (L-TLB)
c1501fac 00000046 c035a960 00000000 c14ed020 c03064e1 c1501fc4 00000000 
       c0437420 c1384520 00000000 00000349 6bec32cb 00000003 c14ed020 c14ed530 
       c14ed654 000014fa 6bec10cd c1384e60 c1384520 c1500000 c1501fc4 c011ab1c 
Call Trace:
 [<c03064e1>] schedule+0x3c1/0xca0
 [<c011ab1c>] migration_thread+0xfc/0x180
 [<c011aa20>] migration_thread+0x0/0x180
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
ksoftirqd/0   S 00000000     0     3      1             4     2 (L-TLB)
c1505fb0 00000046 00000000 00000000 dbf5fa40 c1505fc4 dbf5fa40 00000000 
       c1384e80 c1384520 00000000 000001f4 749d76fc 00000003 c035abc0 c14ed020 
       c14ed144 00000000 00000000 c1504000 c042a380 c1504000 ffffe000 c0122d7a 
Call Trace:
 [<c0122d7a>] ksoftirqd+0xca/0xd0
 [<c0122cb0>] ksoftirqd+0x0/0xd0
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
events/0      R running     0     4      1             5     3 (L-TLB)
khelper       S 00000000     0     5      1             6     4 (L-TLB)
dbe43f54 00000046 00000082 00000000 db4a4530 dbd73ecc db4a4530 00000000 
       c1384e80 c1384520 00000000 0000012b b636982c 00000005 db4a4530 dbf5f530 
       dbf5f654 00000000 00000246 dbea8014 dbea8000 dbe43f98 dbd73ea4 c012ca69 
Call Trace:
 [<c012ca69>] worker_thread+0x129/0x230
 [<c012c6c0>] __call_usermodehelper+0x0/0x50
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0119940>] default_wake_function+0x0/0x10
 [<c012c940>] worker_thread+0x0/0x230
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
kthread       S 00000000     0     6      1     8      66     5 (L-TLB)
dbe47f54 00000046 00000082 00000000 dbed3a40 dbe3ff68 dbed3a40 00000000 
       c1384e80 c1384520 00000000 0000068f 70f03643 00000003 dbed3a40 dbf5f020 
       dbf5f144 00000000 00000246 dbe44014 dbe44000 dbe47f98 dbe3ff44 c012ca69 
Call Trace:
 [<c012ca69>] worker_thread+0x129/0x230
 [<c0130820>] keventd_create_kthread+0x0/0x40
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0119940>] default_wake_function+0x0/0x10
 [<c012c940>] worker_thread+0x0/0x230
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
kblockd/0     S 00000000     0     8      6            64       (L-TLB)
dbd09f54 00000046 c011784c 00000000 dbf4f530 00000001 dbf4f530 00000000 
       c1384e80 c1384520 00000000 0000068f 706aedc8 00000003 dbf4f530 dbf4fa40 
       dbf4fb64 00000000 00000246 c15fc014 c15fc000 dbd09f98 c012c940 c012ca69 
Call Trace:
 [<c011784c>] recalc_task_prio+0xfc/0x180
 [<c012c940>] worker_thread+0x0/0x230
 [<c012ca69>] worker_thread+0x129/0x230
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0119940>] default_wake_function+0x0/0x10
 [<c012c940>] worker_thread+0x0/0x230
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
pdflush       S 00000001     0    64      6            65     8 (L-TLB)
dbd0bf90 00000046 00000001 00000001 dbf5f020 00000000 dbf5f020 00000000 
       c1384e80 c1384520 00000000 00000724 70eeba8f 00000003 dbf5f020 dbf4f530 
       dbf4f654 00000000 dbf4f530 dbd0a000 dbd0bfa8 dbd0bfb4 c0143a40 c0143913 
Call Trace:
 [<c0143a40>] pdflush+0x0/0x20
 [<c0143913>] __pdflush+0x83/0x1b0
 [<c0143a5a>] pdflush+0x1a/0x20
 [<c0143a40>] pdflush+0x0/0x20
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
pdflush       S FFFB33EF     0    65      6            67    64 (L-TLB)
dbd2bf90 00000046 c0143172 fffb33ef 00000000 00000000 dbd2bf44 00000400 
       00000000 c1384520 00000000 00000429 dce266bc 00000006 c035abc0 dbf4f020 
       dbf4f144 00000000 00000000 dbd2a000 dbd2bfa8 dbd2bfb4 c0143a40 c0143913 
Call Trace:
 [<c0143172>] wb_kupdate+0xe2/0x100
 [<c0143a40>] pdflush+0x0/0x20
 [<c0143913>] __pdflush+0x83/0x1b0
 [<c0143a5a>] pdflush+0x1a/0x20
 [<c0143a40>] pdflush+0x0/0x20
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
aio/0         S 00000001     0    67      6                  65 (L-TLB)
dbd31f54 00000046 c011784c 00000001 dbf5f530 00000001 dbf5f530 00000000 
       c1384e80 c1384520 00000000 000008f1 70f52c76 00000003 dbf5f530 dbed3530 
       dbed3654 00000000 00000246 dbd2e014 dbd2e000 dbd31f98 c012c940 c012ca69 
Call Trace:
 [<c011784c>] recalc_task_prio+0xfc/0x180
 [<c012c940>] worker_thread+0x0/0x230
 [<c012ca69>] worker_thread+0x129/0x230
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0119940>] default_wake_function+0x0/0x10
 [<c012c940>] worker_thread+0x0/0x230
 [<c01307f6>] kthread+0x86/0xb0
 [<c0130770>] kthread+0x0/0xb0
 [<c01023f5>] kernel_thread_helper+0x5/0x10
kswapd0       S FFFFFFFF     0    66      1           653     6 (L-TLB)
dbd2df8c 00000046 c011a91d ffffffff c14eda40 00000001 c14eda40 00000000 
       c1384e80 c1384520 00000000 00001169 70f04a6f 00000003 c14eda40 dbed3a40 
       dbed3b64 00000000 c0130af6 c0360500 c0363cd0 00000000 dbd2c000 c0148bf8 
Call Trace:
 [<c011a91d>] set_cpus_allowed+0xed/0x140
 [<c0130af6>] prepare_to_wait+0x16/0x60
 [<c0148bf8>] kswapd+0x118/0x130
 [<c0130be0>] autoremove_wake_function+0x0/0x30
 [<c0130be0>] autoremove_wake_function+0x0/0x30
 [<c0148ae0>] kswapd+0x0/0x130
 [<c01023f5>] kernel_thread_helper+0x5/0x10
kseriod       S 00000000     0   653      1           786    66 (L-TLB)
dbd73f8c 00000046 dbdc76e0 00000000 dbd81a40 c0384a60 dbd81a40 00000000 
       c1384e80 c1384520 00000000 00000375 d012a148 00000005 dbd81a40 dbed3020 
       dbed3144 00000000 c0130af6 dbd73fb8 ffffe000 dbd72000 dbd73fc4 c02404ab 
Call Trace:
 [<c0130af6>] prepare_to_wait+0x16/0x60
 [<c02404ab>] serio_thread+0x9b/0x120
 [<c0130be0>] autoremove_wake_function+0x0/0x30
 [<c0103e86>] ret_from_fork+0x6/0x20
 [<c0130be0>] autoremove_wake_function+0x0/0x30
 [<c0240410>] serio_thread+0x0/0x120
 [<c01023f5>] kernel_thread_helper+0x5/0x10
linuxrc       S 00000000     0   786      1   795           653 (NOTLB)
dbdd1f40 00000086 c0115ff9 00000000 dbd81530 08070798 dbd81530 00000000 
       c1384e80 c1384520 00000000 00006297 22d43998 00000005 dbd81530 dbd81020 
       dbd81144 00000000 00000246 dbd810c8 00000004 fffffe00 dbd81020 c0121343 
Call Trace:
 [<c0115ff9>] do_page_fault+0x1a9/0x57a
 [<c0121343>] do_wait+0x313/0x3a0
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0121479>] sys_wait4+0x29/0x30
 [<c0103f99>] syscall_call+0x7/0xb
udevstart     S 00000001     0   795    786  1443               (NOTLB)
c1631f40 00000082 c0115ff9 00000001 00000001 bfb4f1a4 00000007 c1631fbc 
       c1631fbc c1384520 00000000 00001785 6f687b15 00000006 c035abc0 dbd81530 
       dbd81654 dbed0080 00000000 dbd815d8 00000004 fffffe00 dbd81530 c0121343 
Call Trace:
 [<c0115ff9>] do_page_fault+0x1a9/0x57a
 [<c0121343>] do_wait+0x313/0x3a0
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0119940>] default_wake_function+0x0/0x10
 [<c0121479>] sys_wait4+0x29/0x30
 [<c0103f99>] syscall_call+0x7/0xb
udev          S 00000000     0  1443    795                     (NOTLB)
db4b3f64 00000082 00000000 00000000 00000000 00000000 00001000 00000000 
       42ea3e92 c1384520 00000000 00001a98 992b2631 00000007 c035abc0 dbd81a40 
       dbd81b64 00000246 00000000 fffbb969 000003ea 00000000 fa09bac0 c03075de 
Call Trace:
 [<c03075de>] schedule_timeout+0x5e/0xb0
 [<c0126690>] process_timeout+0x0/0x10
 [<c0126776>] sys_nanosleep+0xc6/0x150
 [<c0103f99>] syscall_call+0x7/0xb
EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3 filesystem as ext2

--------------060800020106040207030500--
