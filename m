Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbVG3Rec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVG3Rec (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVG3ReX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:34:23 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:57992 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261409AbVG3RdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:33:04 -0400
Message-ID: <42EBB9CD.7090706@jtholmes.com>
Date: Sat, 30 Jul 2005 13:33:01 -0400
From: jt <jt@jtholmes.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 stalls Andrew M. req this extended dmesg dump
Content-Type: multipart/mixed;
 boundary="------------070008080404070602080205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070008080404070602080205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew M.
Here is the  dmesg extended dump for the  stall you mailed me about earlier

sequence is

boot params
    initcall_debug  log_buf_len=512k

at stall

ALT + Sys Req  + P
small amout of output (8-9 lines)

then

ALT + Sys Req +T
about 500+ lines of trace

wait about 100 Seconds

boot continues

let me know how I can be of further assistance


--------------070008080404070602080205
Content-Type: text/plain;
 name="dmesg2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg2"

[4294667.296000] Linux version 2.6.12 (root@jtlsuse) (gcc version 3.3.4 (pre 3.3.5 20040809)) #6 SMP Sat Jul 30 10:20:37 EDT 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000001bf70000 (usable)
[4294667.296000]  BIOS-e820: 000000001bf70000 - 000000001bf7b000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000001bf7b000 - 000000001bf80000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000001bf80000 - 000000001c000000 (reserved)
[4294667.296000]  BIOS-e820: 000000002bf80000 - 000000002c000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[4294667.296000] 0MB HIGHMEM available.
[4294667.296000] 447MB LOWMEM available.
[4294667.296000] found SMP MP-table at 000f6ae0
[4294667.296000] On node 0 totalpages: 114544
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 110448 pages, LIFO batch:31
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI present.
[4294667.296000] Using APIC driver default
[4294667.296000] Intel MultiProcessor Specification v1.4
[4294667.296000]     Virtual Wire compatibility mode.
[4294667.296000] OEM ID:   Product ID: RS300 Board APIC at: 0xFEE00000
[4294667.296000] Processor #0 15:3 APIC version 20
[4294667.296000] I/O APIC #2 Version 17 at 0xFEC00000.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Processors: 1
[4294667.296000] Allocating PCI resources starting at 2c000000 (gap: 2c000000:d2c00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/hda6 vga=0x317 selinux=0 apm=off acpi=off resume=/dev/hda6 desktop elevator=as splash=silent initcall_debug log_buf_len=512k
[4294667.296000] log_buf_len: 524288
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 3067.393 MHz processor.
[   23.036035] Using tsc for high-res timesource
[   23.036072] Console: colour dummy device 80x25
[   23.036635] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   23.037010] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   23.046226] Memory: 447272k/458176k available (2082k kernel code, 10340k reserved, 927k data, 240k init, 0k highmem)
[   23.046236] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   23.046331] Calibrating delay loop... 6078.46 BogoMIPS (lpj=3039232)
[   23.068420] Security Framework v1.0.0 initialized
[   23.068427] SELinux:  Disabled at boot.
[   23.068442] Mount-cache hash table entries: 512
[   23.068537] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000459d 00000000 00000000
[   23.068547] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 0000459d 00000000 00000000
[   23.068554] monitor/mwait feature present.
[   23.068557] using mwait in idle threads.
[   23.068565] CPU: Trace cache: 12K uops, L1 D cache: 16K
[   23.068569] CPU: L2 cache: 1024K
[   23.068573] CPU: Physical Processor ID: 0
[   23.068576] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000459d 00000000 00000000
[   23.068584] Intel machine check architecture supported.
[   23.068591] Intel machine check reporting enabled on CPU#0.
[   23.068595] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[   23.068600] CPU0: Thermal monitoring enabled
[   23.068604] Enabling fast FPU save and restore... done.
[   23.068608] Enabling unmasked SIMD FPU exception support... done.
[   23.068615] Checking 'hlt' instruction... OK.
[   23.072467] CPU0: Intel Mobile Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 04
[   23.072505] Total of 1 processors activated (6078.46 BogoMIPS).
[   23.072510] WARNING: 1 siblings found for CPU0, should be 2
[   23.072549] ENABLING IO-APIC IRQs
[   23.072709] ..TIMER: vector=0x31 pin1=2 pin2=0
[   23.184090] Brought up 1 CPUs
[   23.184105] CPU0 attaching sched-domain:
[   23.184108]  domain 0: span 00000001
[   23.184111]   groups: 00000001
[   23.184115]   domain 1: span 00000001
[   23.184119]    groups: 00000001
[   23.184229] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[   23.238502] Freeing initrd memory: 1146k freed
[   23.238916] Calling initcall 0xc0400890: reboot_init+0x0/0x10()
[   23.238930] Calling initcall 0xc0407d00: helper_init+0x0/0x30()
[   23.238954] Calling initcall 0xc0407e50: pm_init+0x0/0x20()
[   23.238961] Calling initcall 0xc0407fa0: ksysfs_init+0x0/0x20()
[   23.238968] Calling initcall 0xc0409b10: filelock_init+0x0/0x30()
[   23.238977] Calling initcall 0xc040a170: init_script_binfmt+0x0/0x10()
[   23.238983] Calling initcall 0xc040a180: init_elf_binfmt+0x0/0x10()
[   23.238987] Calling initcall 0xc0415780: netlink_proto_init+0x0/0x1e0()
[   23.238997] NET: Registered protocol family 16
[   23.239011] Calling initcall 0xc040af50: kobject_uevent_init+0x0/0x30()
[   23.239017] Calling initcall 0xc040b020: pcibus_class_init+0x0/0x10()
[   23.239026] Calling initcall 0xc040b700: pci_driver_init+0x0/0x10()
[   23.239035] Calling initcall 0xc040e490: tty_class_init+0x0/0x20()
[   23.239043] Calling initcall 0xc03ff7c0: mtrr_if_init+0x0/0x70()
[   23.239048] Calling initcall 0xc0414400: pci_pcbios_init+0x0/0x40()
[   23.258868] PCI: PCI BIOS revision 2.10 entry at 0xfd958, last bus=2
[   23.258872] Calling initcall 0xc0414440: pci_mmcfg_init+0x0/0x50()
[   23.258877] Calling initcall 0xc04145d0: pci_direct_init+0x0/0xe0()
[   23.258887] PCI: Using configuration type 1
[   23.258890] Calling initcall 0xc03ff680: mtrr_init+0x0/0x140()
[   23.258895] mtrr: v2.0 (20020519)
[   23.258904] Calling initcall 0xc0406c50: topology_init+0x0/0x30()
[   23.258971] Calling initcall 0xc0138e90: pm_sysrq_init+0x0/0x20()
[   23.258983] Calling initcall 0xc0409930: init_bio+0x0/0xd0()
[   23.259343] Calling initcall 0xc040bdf0: fbmem_init+0x0/0x80()
[   23.259357] Calling initcall 0xc040d4ac: acpi_init+0x0/0xb4()
[   23.259363] ACPI: Subsystem revision 20050309
[   23.259366] ACPI: Interpreter disabled.
[   23.259369] Calling initcall 0xc040d887: acpi_ec_init+0x0/0x51()
[   23.259373] Calling initcall 0xc040d8e5: acpi_pci_root_init+0x0/0x1c()
[   23.259378] Calling initcall 0xc040da40: acpi_pci_link_init+0x0/0x3a()
[   23.259382] Calling initcall 0xc040da7a: acpi_power_init+0x0/0x65()
[   23.259386] Calling initcall 0xc040dadf: acpi_system_init+0x0/0xaf()
[   23.259390] Calling initcall 0xc040db8e: acpi_event_init+0x0/0x39()
[   23.259394] Calling initcall 0xc040dbc7: acpi_scan_init+0x0/0x5e()
[   23.259398] Calling initcall 0xc040de20: pnp_init+0x0/0x20()
[   23.259402] Linux Plug and Play Support v0.97 (c) Adam Belay
[   23.259411] Calling initcall 0xc040e300: pnpacpi_init+0x0/0x60()
[   23.259416] pnp: PnP ACPI: disabled
[   23.259419] Calling initcall 0xc040eba0: misc_init+0x0/0x70()
[   23.259427] Calling initcall 0xc0410320: genhd_device_init+0x0/0x30()
[   23.259465] Calling initcall 0xc0413e50: input_init+0x0/0x90()
[   23.259475] Calling initcall 0xc0414710: pci_acpi_init+0x0/0xa0()
[   23.259480] Calling initcall 0xc04147b0: pci_legacy_init+0x0/0x50()
[   23.259484] PCI: Probing PCI hardware
[   23.259488] PCI: Probing PCI hardware (bus 00)
[   23.259791] PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
[   23.260023] Boot video device is 0000:01:05.0
[   23.260516] PCI: Transparent bridge - 0000:00:14.4
[   23.261266] Calling initcall 0xc0414fa0: pcibios_irq_init+0x0/0xd0()
[   23.261304] PCI: Using IRQ router default [1002/434c] at 0000:00:14.3
[   23.261318] PCI->APIC IRQ transform: 0000:00:13.0[A] -> IRQ 19
[   23.261323] PCI->APIC IRQ transform: 0000:00:13.1[A] -> IRQ 19
[   23.261327] PCI->APIC IRQ transform: 0000:00:13.2[A] -> IRQ 19
[   23.261333] PCI->APIC IRQ transform: 0000:00:14.1[A] -> IRQ 17
[   23.261340] PCI->APIC IRQ transform: 0000:00:14.5[B] -> IRQ 17
[   23.261344] PCI->APIC IRQ transform: 0000:00:14.6[B] -> IRQ 17
[   23.261349] PCI->APIC IRQ transform: 0000:01:05.0[A] -> IRQ 16
[   23.261354] PCI->APIC IRQ transform: 0000:02:00.0[A] -> IRQ 16
[   23.261359] PCI->APIC IRQ transform: 0000:02:02.0[A] -> IRQ 18
[   23.261364] PCI->APIC IRQ transform: 0000:02:03.0[A] -> IRQ 19
[   23.261369] PCI->APIC IRQ transform: 0000:02:04.0[A] -> IRQ 17
[   23.261374] PCI->APIC IRQ transform: 0000:02:04.1[B] -> IRQ 17
[   23.261379] PCI->APIC IRQ transform: 0000:02:04.2[B] -> IRQ 17
[   23.261384] PCI->APIC IRQ transform: 0000:02:04.3[B] -> IRQ 17
[   23.261387] Calling initcall 0xc0415070: pcibios_init+0x0/0x90()
[   23.267111] Calling initcall 0xc0415190: proto_init+0x0/0x30()
[   23.267117] Calling initcall 0xc04153f0: net_dev_init+0x0/0x150()
[   23.267147] Calling initcall 0xc0415690: pktsched_init+0x0/0xb0()
[   23.267154] Calling initcall 0xc0415740: tc_filter_init+0x0/0x40()
[   23.267158] Calling initcall 0xc0409aa0: init_pipe_fs+0x0/0x40()
[   23.267166] Calling initcall 0xc040ddf3: acpi_motherboard_init+0x0/0x2d()
[   23.267171] Calling initcall 0xc040df00: pnp_system_init+0x0/0x10()
[   23.267203] Calling initcall 0xc040e3a0: chr_dev_init+0x0/0x80()
[   23.267437] Calling initcall 0xc04142f0: pcibios_assign_resources+0x0/0xf0()
[   23.267452] Calling initcall 0xc0109350: time_init_device+0x0/0x20()
[   23.267485] Calling initcall 0xc03fc8e0: i8259A_init_sysfs+0x0/0x20()
[   23.267516] Calling initcall 0xc03fcfe0: sbf_init+0x0/0x50()
[   23.267522] Calling initcall 0xc010c0c0: cache_register_driver+0x0/0x20()
[   23.267529] Number of CPUs sharing cache didn't match any known set of CPUs
[   23.267534] Number of CPUs sharing cache didn't match any known set of CPUs
[   23.267611] Calling initcall 0xc03ffb90: init_timer_sysfs+0x0/0x20()
[   23.267648] Calling initcall 0xc0402cf0: init_lapic_sysfs+0x0/0x30()
[   23.267681] Calling initcall 0xc0404d00: ioapic_init_sysfs+0x0/0xd0()
[   23.267712] Calling initcall 0xc0405140: sysenter_setup+0x0/0x90()
[   23.267729] Calling initcall 0xc0407570: create_proc_profile+0x0/0x50()
[   23.267735] Calling initcall 0xc0407620: ioresources_init+0x0/0x40()
[   23.267741] Calling initcall 0xc0407790: uid_cache_init+0x0/0x80()
[   23.267755] Calling initcall 0xc0407c50: param_sysfs_init+0x0/0x20()
[   23.268109] Calling initcall 0xc0407c70: init_posix_timers+0x0/0x90()
[   23.268119] Calling initcall 0xc0407d30: init_posix_cpu_timers+0x0/0x90()
[   23.268123] Calling initcall 0xc0407dc0: init+0x0/0x50()
[   23.268132] Calling initcall 0xc0407e10: proc_dma_init+0x0/0x20()
[   23.268137] Calling initcall 0xc0135280: percpu_modinit+0x0/0x80()
[   23.268143] Calling initcall 0xc0407e30: kallsyms_init+0x0/0x20()
[   23.268147] Calling initcall 0xc0407e70: ikconfig_init+0x0/0x30()
[   23.268153] Calling initcall 0xc0407ea0: audit_init+0x0/0x90()
[   23.268157] audit: initializing netlink socket (disabled)
[   23.268170] audit(1122729808.218:0): initialized
[   23.268174] Calling initcall 0xc0408f60: init_per_zone_pages_min+0x0/0x50()
[   23.268181] Calling initcall 0xc0409240: pdflush_init+0x0/0x10()
[   23.268210] Calling initcall 0xc04094e0: cpucache_init+0x0/0x50()
[   23.268217] Calling initcall 0xc0409550: kswapd_init+0x0/0x50()
[   23.268227] Calling initcall 0xc04095a0: init_emergency_pool+0x0/0x60()
[   23.268233] Calling initcall 0xc0409680: gate_vma_init+0x0/0x40()
[   23.268237] Calling initcall 0xc04096f0: procswaps_init+0x0/0x20()
[   23.268242] Calling initcall 0xc0409710: hugetlb_init+0x0/0xa0()
[   23.268246] Total HugeTLB memory allocated, 0
[   23.268249] Calling initcall 0xc04097e0: init_tmpfs+0x0/0x80()
[   23.268265] Calling initcall 0xc0409ae0: fasync_init+0x0/0x30()
[   23.268272] Calling initcall 0xc040a060: aio_setup+0x0/0x60()
[   23.268310] Calling initcall 0xc040a0c0: eventpoll_init+0x0/0xb0()
[   23.268325] Calling initcall 0xc040a190: init_mbcache+0x0/0x20()
[   23.268329] Calling initcall 0xc040a1b0: dnotify_init+0x0/0x30()
[   23.268337] Calling initcall 0xc040a590: init_devpts_fs+0x0/0x30()
[   23.268348] Calling initcall 0xc040a5c0: init_ext2_fs+0x0/0x40()
[   23.268359] Calling initcall 0xc040a630: init_ramfs_fs+0x0/0x10()
[   23.268364] Calling initcall 0xc040a650: init_hugetlbfs_fs+0x0/0x70()
[   23.268380] Calling initcall 0xc040a6c0: init_bfs_fs+0x0/0x30()
[   23.268388] Calling initcall 0xc040a6f0: init_iso9660_fs+0x0/0x40()
[   23.268409] Calling initcall 0xc040a7b0: init_hfsplus_fs+0x0/0x60()
[   23.268416] Calling initcall 0xc040a810: init_hfs_fs+0x0/0x60()
[   23.268425] Calling initcall 0xc040a870: init_nfs_fs+0x0/0x80()
[   23.268461] Calling initcall 0xc040a8f0: init_nlm+0x0/0x20()
[   23.268473] Calling initcall 0xc040a910: init_nls_utf8+0x0/0x20()
[   23.268478] Calling initcall 0xc040a930: init_efs_fs+0x0/0x40()
[   23.268482] EFS: 1.0a - http://aeschi.ch.eu.org/efs/
[   23.268490] Calling initcall 0xc040a970: init_affs_fs+0x0/0x30()
[   23.268498] Calling initcall 0xc040a9a0: init_autofs_fs+0x0/0x10()
[   23.268503] Calling initcall 0xc040a9b0: init_autofs4_fs+0x0/0x10()
[   23.268507] Calling initcall 0xc040a9c0: init_befs_fs+0x0/0x40()
[   23.268511] BeFS version: 0.9.3
[   23.268517] Calling initcall 0xc040aa00: ipc_init+0x0/0x20()
[   23.268526] Calling initcall 0xc040ad60: selinux_nf_ip_init+0x0/0x40()
[   23.268530] Calling initcall 0xc040adc0: init_sel_fs+0x0/0x60()
[   23.268534] Calling initcall 0xc040ae20: selnl_init+0x0/0x40()
[   23.268540] Calling initcall 0xc040ae60: sel_netif_init+0x0/0x60()
[   23.268544] Calling initcall 0xc040aec0: init_crypto+0x0/0x20()
[   23.268548] Initializing Cryptographic API
[   23.268552] Calling initcall 0xc040af00: init+0x0/0x10()
[   23.268556] Calling initcall 0xc040af10: init+0x0/0x40()
[   23.268560] Calling initcall 0xc01fa9f0: pci_init+0x0/0x30()
[   23.268579] Calling initcall 0xc040b710: pci_sysfs_init+0x0/0x30()
[   23.268602] Calling initcall 0xc040b740: pci_proc_init+0x0/0x70()
[   23.268627] Calling initcall 0xc040bd90: fb_console_init+0x0/0x60()
[   23.268632] Calling initcall 0xc040c010: imsttfb_init+0x0/0x40()
[   23.268678] Calling initcall 0xc040c8b0: vesafb_init+0x0/0x4e()
[   23.268747] vesafb: framebuffer at 0xf0000000, mapped to 0xdc880000, using 3072k, total 65536k
[   23.268754] vesafb: mode is 1024x768x16, linelength=2048, pages=41
[   23.268757] vesafb: protected mode interface info at c000:52d0
[   23.268761] vesafb: scrolling: redraw
[   23.268765] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[   23.288719] Console: switching to colour frame buffer device 128x48
[   23.288851] fb0: VESA VGA frame buffer device
[   23.288940] Calling initcall 0xc040da12: irqrouter_init_sysfs+0x0/0x2e()
[   23.288951] Calling initcall 0xc040e420: rand_initialize+0x0/0x30()
[   23.288963] Calling initcall 0xc040e4b0: tty_init+0x0/0x1a0()
[   23.290710] Calling initcall 0xc040eb90: pty_init+0x0/0x10()
[   23.305901] Calling initcall 0xc040f060: serio_init+0x0/0x70()
[   23.305919] Calling initcall 0xc040f560: i8042_init+0x0/0x180()
[   23.306032] PNP: No PS/2 controller found. Probing ports directly.
[   23.316329] i8042.c: Detected active multiplexing controller, rev 1.9.
[   23.323177] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[   23.324325] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[   23.325468] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[   23.326622] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[   23.327778] serio: i8042 KBD port at 0x60,0x64 irq 1
[   23.327892] Calling initcall 0xc040fb60: serial8250_init+0x0/0xa0()
[   23.327902] Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
[   23.328444] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   23.330338] Calling initcall 0xc040fc00: serial8250_pnp_init+0x0/0x10()
[   23.330368] Calling initcall 0xc040fc10: serial8250_pci_init+0x0/0x10()
[   23.330423] Calling initcall 0xc0410350: noop_init+0x0/0x10()
[   23.330429] io scheduler noop registered
[   23.330514] Calling initcall 0xc0410360: as_init+0x0/0x50()
[   23.330536] io scheduler anticipatory registered
[   23.330640] Calling initcall 0xc04103b0: deadline_init+0x0/0x50()
[   23.330649] io scheduler deadline registered
[   23.330739] Calling initcall 0xc0410480: cfq_init+0x0/0x30()
[   23.330752] io scheduler cfq registered
[   23.330832] Calling initcall 0xc0410c00: floppy_init+0x0/0x570()
[   26.334917] floppy0: no floppy controllers found
[   26.335028] Calling initcall 0xc0411170: rd_init+0x0/0x190()
[   26.335459] RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
[   26.335604] Calling initcall 0xc0411350: loop_init+0x0/0x2f0()
[   26.335820] loop: loaded (max 8 devices)
[   26.335899] Calling initcall 0xc0411730: net_olddevs_init+0x0/0x30()
[   26.335958] Calling initcall 0xc0263ea0: aec62xx_ide_init+0x0/0x10()
[   26.335967] Calling initcall 0xc0264c30: ali15x3_ide_init+0x0/0x10()
[   26.335973] Calling initcall 0xc0265f50: amd74xx_ide_init+0x0/0x10()
[   26.335977] Calling initcall 0xc02665f0: atiixp_ide_init+0x0/0x10()
[   26.335981] Calling initcall 0xc02679b0: cmd64x_ide_init+0x0/0x10()
[   26.335985] Calling initcall 0xc0268440: sc1200_ide_init+0x0/0x10()
[   26.335989] Calling initcall 0xc0268800: cy82c693_ide_init+0x0/0x10()
[   26.335993] Calling initcall 0xc0268db0: hpt34x_ide_init+0x0/0x10()
[   26.335997] Calling initcall 0xc026abd0: hpt366_ide_init+0x0/0x10()
[   26.336001] Calling initcall 0xc026ae10: ns87415_ide_init+0x0/0x10()
[   26.336005] Calling initcall 0xc026b290: opti621_ide_init+0x0/0x10()
[   26.336009] Calling initcall 0xc026c270: pdc202xx_ide_init+0x0/0x10()
[   26.336013] Calling initcall 0xc026cd50: pdc202new_ide_init+0x0/0x10()
[   26.336018] Calling initcall 0xc0412550: piix_ide_init+0x0/0x10()
[   26.336024] Calling initcall 0xc026d9a0: rz1000_ide_init+0x0/0x10()
[   26.336028] Calling initcall 0xc026e770: svwks_ide_init+0x0/0x10()
[   26.336032] Calling initcall 0xc026fe10: siimage_ide_init+0x0/0x10()
[   26.336037] Calling initcall 0xc02719a0: sis5513_ide_init+0x0/0x10()
[   26.336048] Calling initcall 0xc0271f90: slc90e66_ide_init+0x0/0x10()
[   26.336052] Calling initcall 0xc02721d0: triflex_ide_init+0x0/0x10()
[   26.336056] Calling initcall 0xc0272640: trm290_ide_init+0x0/0x10()
[   26.336060] Calling initcall 0xc0273a50: via_ide_init+0x0/0x10()
[   26.336064] Calling initcall 0xc0273ba0: generic_ide_init+0x0/0x10()
[   26.336067] Calling initcall 0xc04135a0: ide_init+0x0/0x60()
[   26.336072] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   26.336197] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   26.336379] ATIIXP: IDE controller at PCI slot 0000:00:14.1
[   26.336496] ATIIXP: chipset revision 0
[   26.336568] ATIIXP: not 100% native mode: will probe irqs later
[   26.336686]     ide0: BM-DMA at 0x8070-0x8077, BIOS settings: hda:DMA, hdb:pio
[   26.340186]     ide1: BM-DMA at 0x8078-0x807f, BIOS settings: hdc:DMA, hdd:pio
[   26.343699] Probing IDE interface ide0...
[   26.861579] hda: IC25N060ATMR04-0, ATA DISK drive
[   27.475853] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   27.479499] Probing IDE interface ide1...
[   28.149833] hdc: MATSHITADVD-RAM UJ-820S, ATAPI CD/DVD-ROM drive
[   28.458766] ide1 at 0x170-0x177,0x376 on irq 15
[   28.463308] Calling initcall 0xc0413d80: ide_generic_init+0x0/0x10()
[   28.463314] Probing IDE interface ide2...
[   28.975250] Probing IDE interface ide3...
[   29.486766] Probing IDE interface ide4...
[   29.998281] Probing IDE interface ide5...
[   30.509797] Calling initcall 0xc02818d0: idedisk_init+0x0/0xa()
[   30.509842] hda: max request size: 1024KiB
[   30.874026] hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
[   30.878403] hda: cache flushes supported
[   30.882515]  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
[   31.042292] Calling initcall 0xc0283aa0: idefloppy_init+0x0/0x16()
[   31.042298] ide-floppy driver 0.99.newide
[   31.046499] Calling initcall 0xc0413ee0: mousedev_init+0x0/0xd0()
[   31.046563] mice: PS/2 mouse device common for all mice
[   31.050834] Calling initcall 0xc0413fb0: atkbd_init+0x0/0x10()
[   31.050840] Calling initcall 0xc0413fc0: psmouse_init+0x0/0x10()
[   31.050845] Calling initcall 0xc0413fd0: pcspkr_init+0x0/0x80()
[   31.050893] input: PC Speaker
[   31.055080] Calling initcall 0xc0414050: md_init+0x0/0xd0()
[   31.055086] md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   31.059378] Calling initcall 0xc0415200: flow_cache_init+0x0/0x110()
[   31.059396] Calling initcall 0xc0416490: inet_init+0x0/0x1a0()
[   31.059414] NET: Registered protocol family 2
[   31.073298] IP: routing cache hash table of 4096 buckets, 32Kbytes
[   31.077773] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   31.082220] TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
[   31.086709] TCP: Hash tables configured (established 16384 bind 16384)
[   31.091146] Calling initcall 0xc0416880: init_syncookies+0x0/0x20()
[   31.091190] Calling initcall 0xc04168a0: tcpdiag_init+0x0/0x20()
[   31.091198] Calling initcall 0xc0416a70: af_unix_init+0x0/0x60()
[   31.091207] NET: Registered protocol family 1
[   31.095572] Calling initcall 0xc0416ad0: init_sunrpc+0x0/0x50()
[   31.095616] Calling initcall 0xc0416b20: init_rpcsec_gss+0x0/0x40()
[   31.095625] Calling initcall 0xc0416b60: init_kerberos_module+0x0/0x24()
[   31.095633] Calling initcall 0xc04033d0: check_nmi_watchdog+0x0/0xf0()
[   31.095639] Calling initcall 0xc0403580: init_lapic_nmi_sysfs+0x0/0x30()
[   31.095644] Calling initcall 0xc0403610: balanced_irq_init+0x0/0x190()
[   31.095649] Calling initcall 0xc0404ce0: io_apic_bug_finalize+0x0/0x20()
[   31.095653] Calling initcall 0xc0223f3d: acpi_poweroff_init+0x0/0x2f()
[   31.095661] Calling initcall 0xc040d0f2: acpi_wakeup_device_init+0x0/0xc7()
[   31.095667] Calling initcall 0xc040d1d5: acpi_sleep_init+0x0/0xad()
[   31.095673] Calling initcall 0xc0224dd6: acpi_sleep_proc_init+0x0/0x7e()
[   31.095677] Calling initcall 0xc040e450: seqgen_init+0x0/0x10()
[   31.095694] Calling initcall 0xc04100e0: early_uart_console_switch+0x0/0x80()
[   31.095699] Calling initcall 0xc02a4dc0: net_random_reseed+0x0/0x40()
[   31.095864] md: Autodetecting RAID arrays.
[   31.100177] md: autorun ...
[   31.104426] md: ... autorun DONE.
[   31.108761] RAMDISK: Compressed image found at block 0
[   31.174583] VFS: Mounted root (ext2 filesystem).
[   31.895942] input: AT Translated Set 2 keyboard on isa0060/serio0
[   33.674983] input: PS/2 Generic Mouse on isa0060/serio4
[   37.193067] SysRq : Show Regs
[   37.197765] 
[   37.201936] Pid: 0, comm:              swapper
[   37.206184] EIP: 0060:[<c01022a5>] CPU: 0
[   37.210437] EIP is at mwait_idle+0x25/0x50
[   37.214631]  EFLAGS: 00000246    Not tainted  (2.6.12)
[   37.218790] EAX: 00000000 EBX: c03f2008 ECX: 00000000 EDX: 00000000
[   37.222998] ESI: c03f2000 EDI: c042c380 EBP: c042c300 DS: 007b ES: 007b
[   37.227258] CR0: 8005003b CR2: bfffbffc CR3: 1b4f6000 CR4: 000006d0
[   37.231546]  [<c01020d6>] cpu_idle+0x36/0x80
[   37.235864]  [<c03f4896>] start_kernel+0x186/0x1f0
[   40.062565] SysRq : Show State
[   40.067305] 
[   40.067308]                                                sibling
[   40.075542]   task             PC      pid father child younger older
[   40.079623] swapper       S 00000000     0     1      0     2               (L-TLB)
[   40.083732] dbe3ff2c 00000046 00000000 00000000 c1601a40 c011c972 c1601a40 00000000 
[   40.083926]        c1384e80 c1384520 00000000 00128c3b 42685b7e 00000007 c1601a40 c156da40 
[   40.088100]        c156db64 00000000 00000246 c156dae8 00000004 fffffe00 c156da40 c0121343 
[   40.092323] Call Trace:
[   40.100473]  [<c011c972>] copy_process+0x5d2/0xcb0
[   40.104628]  [<c0121343>] do_wait+0x313/0x3a0
[   40.108763]  [<c0119940>] default_wake_function+0x0/0x10
[   40.112895]  [<c03f72c0>] do_linuxrc+0x0/0x80
[   40.116980]  [<c0119940>] default_wake_function+0x0/0x10
[   40.121080]  [<c0121479>] sys_wait4+0x29/0x30
[   40.125104]  [<c03f7431>] handle_initrd+0xf1/0x240
[   40.129072]  [<c03f75d5>] initrd_load+0x55/0x70
[   40.132984]  [<c03f4e88>] prepare_namespace+0x38/0x120
[   40.136865]  [<c010047c>] init+0x15c/0x180
[   40.140708]  [<c0100320>] init+0x0/0x180
[   40.144505]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.148287] migration/0   S 00000000     0     2      1             3       (L-TLB)
[   40.152158] c1581fac 00000046 c035a960 00000000 c156d020 c03064e1 c1581fc4 00000000 
[   40.152350]        c0439420 c1384520 00000000 00000351 65e10fe5 00000005 c156d020 c156d530 
[   40.156279]        c156d654 0000144a 65e0edc5 c1384e60 c1384520 c1580000 c1581fc4 c011ab1c 
[   40.160205] Call Trace:
[   40.167718]  [<c03064e1>] schedule+0x3c1/0xca0
[   40.171521]  [<c011ab1c>] migration_thread+0xfc/0x180
[   40.175341]  [<c011aa20>] migration_thread+0x0/0x180
[   40.179136]  [<c01307f6>] kthread+0x86/0xb0
[   40.182948]  [<c0130770>] kthread+0x0/0xb0
[   40.186704]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.190471] ksoftirqd/0   S 00000000     0     3      1             4     2 (L-TLB)
[   40.194329] c1585fb0 00000046 00000000 00000000 dbf5fa40 c1585fc4 dbf5fa40 00000000 
[   40.194522]        c1384e80 c1384520 00000000 000001ca 6ea134ed 00000005 c035abc0 c156d020 
[   40.199034]        c156d144 00000000 00000000 c1584000 c042c380 c1584000 ffffe000 c0122d7a 
[   40.203026] Call Trace:
[   40.210705]  [<c0122d7a>] ksoftirqd+0xca/0xd0
[   40.214670]  [<c0122cb0>] ksoftirqd+0x0/0xd0
[   40.218620]  [<c01307f6>] kthread+0x86/0xb0
[   40.222545]  [<c0130770>] kthread+0x0/0xb0
[   40.226446]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.230357] events/0      R running     0     4      1             5     3 (L-TLB)
[   40.234351] khelper       S 00000000     0     5      1             6     4 (L-TLB)
[   40.238334] dbe43f54 00000046 00000082 00000000 db536530 dbdf3ecc db536530 00000000 
[   40.238528]        c1384e80 c1384520 00000000 00000121 d72b149d 00000007 db536530 dbf5f530 
[   40.242551]        dbf5f654 00000000 00000246 dbea8014 dbea8000 dbe43f98 dbdf3ea4 c012ca69 
[   40.246606] Call Trace:
[   40.254488]  [<c012ca69>] worker_thread+0x129/0x230
[   40.258569]  [<c012c6c0>] __call_usermodehelper+0x0/0x50
[   40.262719]  [<c0119940>] default_wake_function+0x0/0x10
[   40.266843]  [<c0119940>] default_wake_function+0x0/0x10
[   40.270875]  [<c012c940>] worker_thread+0x0/0x230
[   40.274846]  [<c01307f6>] kthread+0x86/0xb0
[   40.278738]  [<c0130770>] kthread+0x0/0xb0
[   40.284076]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.287865] kthread       S 00000000     0     6      1     8      66     5 (L-TLB)
[   40.291761] dbe47f54 00000046 00000082 00000000 dbed3a40 dbe3ff68 dbed3a40 00000000 
[   40.291955]        c1384e80 c1384520 00000000 000006a2 6ae61c8c 00000005 dbed3a40 dbf5f020 
[   40.295928]        dbf5f144 00000000 00000246 dbe44014 dbe44000 dbe47f98 dbe3ff44 c012ca69 
[   40.299956] Call Trace:
[   40.307793]  [<c012ca69>] worker_thread+0x129/0x230
[   40.311827]  [<c0130820>] keventd_create_kthread+0x0/0x40
[   40.315864]  [<c0119940>] default_wake_function+0x0/0x10
[   40.319922]  [<c0119940>] default_wake_function+0x0/0x10
[   40.323920]  [<c012c940>] worker_thread+0x0/0x230
[   40.327898]  [<c01307f6>] kthread+0x86/0xb0
[   40.331900]  [<c0130770>] kthread+0x0/0xb0
[   40.335857]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.339819] kblockd/0     S 00000000     0     8      6            64       (L-TLB)
[   40.343831] dbd89f54 00000046 c011784c 00000000 dbf4f530 00000001 dbf4f530 00000000 
[   40.344024]        c1384e80 c1384520 00000000 00000712 6a600fe4 00000005 dbf4f530 dbf4fa40 
[   40.348065]        dbf4fb64 00000000 00000246 dbc7c014 dbc7c000 dbd89f98 c012c940 c012ca69 
[   40.352121] Call Trace:
[   40.359891]  [<c011784c>] recalc_task_prio+0xfc/0x180
[   40.363893]  [<c012c940>] worker_thread+0x0/0x230
[   40.367919]  [<c012ca69>] worker_thread+0x129/0x230
[   40.371919]  [<c0119940>] default_wake_function+0x0/0x10
[   40.375968]  [<c0119940>] default_wake_function+0x0/0x10
[   40.379963]  [<c012c940>] worker_thread+0x0/0x230
[   40.383911]  [<c01307f6>] kthread+0x86/0xb0
[   40.387793]  [<c0130770>] kthread+0x0/0xb0
[   40.391574]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.395358] pdflush       S 00000001     0    64      6            65     8 (L-TLB)
[   40.399181] dbd8bf90 00000046 00000001 00000001 dbf5f020 00000000 dbf5f020 00000000 
[   40.399373]        c1384e80 c1384520 00000000 0000068f 6ae48901 00000005 dbf5f020 dbf4f530 
[   40.403279]        dbf4f654 00000000 dbf4f530 dbd8a000 dbd8bfa8 dbd8bfb4 c0143a40 c0143913 
[   40.407269] Call Trace:
[   40.415130]  [<c0143a40>] pdflush+0x0/0x20
[   40.419164]  [<c0143913>] __pdflush+0x83/0x1b0
[   40.423173]  [<c0143a5a>] pdflush+0x1a/0x20
[   40.427156]  [<c0143a40>] pdflush+0x0/0x20
[   40.431038]  [<c01307f6>] kthread+0x86/0xb0
[   40.435350]  [<c0130770>] kthread+0x0/0xb0
[   40.439080]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.442752] pdflush       S FFFB345B     0    65      6            67    64 (L-TLB)
[   40.446534] dbdabf90 00000046 c0143172 fffb345b 00000000 00000000 dbdabf44 00000400 
[   40.446727]        00000000 c1384520 00000000 0000040a d7f85a8c 00000008 c035abc0 dbf4f020 
[   40.450603]        dbf4f144 00000000 00000000 dbdaa000 dbdabfa8 dbdabfb4 c0143a40 c0143913 
[   40.454535] Call Trace:
[   40.462283]  [<c0143172>] wb_kupdate+0xe2/0x100
[   40.466281]  [<c0143a40>] pdflush+0x0/0x20
[   40.470286]  [<c0143913>] __pdflush+0x83/0x1b0
[   40.474271]  [<c0143a5a>] pdflush+0x1a/0x20
[   40.478200]  [<c0143a40>] pdflush+0x0/0x20
[   40.482037]  [<c01307f6>] kthread+0x86/0xb0
[   40.485802]  [<c0130770>] kthread+0x0/0xb0
[   40.489479]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.493118] aio/0         S 00000001     0    67      6                  65 (L-TLB)
[   40.496844] dbdb1f54 00000046 c011784c 00000001 dbf5f530 00000001 dbf5f530 00000000 
[   40.497036]        c1384e80 c1384520 00000000 00000872 6aeb7ad9 00000005 dbf5f530 dbed3530 
[   40.500852]        dbed3654 00000000 00000246 dbdae014 dbdae000 dbdb1f98 c012c940 c012ca69 
[   40.504730] Call Trace:
[   40.512395]  [<c011784c>] recalc_task_prio+0xfc/0x180
[   40.516355]  [<c012c940>] worker_thread+0x0/0x230
[   40.520337]  [<c012ca69>] worker_thread+0x129/0x230
[   40.524293]  [<c0119940>] default_wake_function+0x0/0x10
[   40.528242]  [<c0119940>] default_wake_function+0x0/0x10
[   40.532069]  [<c012c940>] worker_thread+0x0/0x230
[   40.535824]  [<c01307f6>] kthread+0x86/0xb0
[   40.539514]  [<c0130770>] kthread+0x0/0xb0
[   40.543096]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.546687] kswapd0       S FFFFFFFF     0    66      1           653     6 (L-TLB)
[   40.550410] dbdadf8c 00000046 c011a91d ffffffff c156da40 00000001 c156da40 00000000 
[   40.550603]        c1384e80 c1384520 00000000 00001060 6ae62f7b 00000005 c156da40 dbed3a40 
[   40.554435]        dbed3b64 00000000 c0130af6 c0360500 c0363cd0 00000000 dbdac000 c0148bf8 
[   40.558332] Call Trace:
[   40.566024]  [<c011a91d>] set_cpus_allowed+0xed/0x140
[   40.569993]  [<c0130af6>] prepare_to_wait+0x16/0x60
[   40.573996]  [<c0148bf8>] kswapd+0x118/0x130
[   40.577989]  [<c0130be0>] autoremove_wake_function+0x0/0x30
[   40.581972]  [<c0130be0>] autoremove_wake_function+0x0/0x30
[   40.585840]  [<c0148ae0>] kswapd+0x0/0x130
[   40.589645]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.593409] kseriod       S 00000000     0   653      1           786    66 (L-TLB)
[   40.597231] dbdf3f8c 00000046 c16476e0 00000000 c1601020 c0384a60 c1601020 00000000 
[   40.597424]        c1384e80 c1384520 00000000 0000039b f122f8c3 00000007 c1601020 dbed3020 
[   40.601328]        dbed3144 00000000 c0130af6 dbdf3fb8 ffffe000 dbdf2000 dbdf3fc4 c02404ab 
[   40.605310] Call Trace:
[   40.613131]  [<c0130af6>] prepare_to_wait+0x16/0x60
[   40.617196]  [<c02404ab>] serio_thread+0x9b/0x120
[   40.621288]  [<c0130be0>] autoremove_wake_function+0x0/0x30
[   40.625414]  [<c0103e86>] ret_from_fork+0x6/0x20
[   40.629493]  [<c0130be0>] autoremove_wake_function+0x0/0x30
[   40.633539]  [<c0240410>] serio_thread+0x0/0x120
[   40.637519]  [<c01023f5>] kernel_thread_helper+0x5/0x10
[   40.641468] linuxrc       S 00000000     0   786      1   795           653 (NOTLB)
[   40.645466] c1651f40 00000086 c0115ff9 00000000 c1601020 08070798 c1601020 00000000 
[   40.645659]        c1384e80 c1384520 00000000 0000666c 4411f8ad 00000007 c1601020 c1601a40 
[   40.649731]        c1601b64 00000000 00000246 c1601ae8 00000004 fffffe00 c1601a40 c0121343 
[   40.653881] Call Trace:
[   40.661986]  [<c0115ff9>] do_page_fault+0x1a9/0x57a
[   40.666208]  [<c0121343>] do_wait+0x313/0x3a0
[   40.670429]  [<c0119940>] default_wake_function+0x0/0x10
[   40.674701]  [<c0119940>] default_wake_function+0x0/0x10
[   40.678920]  [<c0121479>] sys_wait4+0x29/0x30
[   40.683096]  [<c0103f99>] syscall_call+0x7/0xb
[   40.687191] udevstart     S 00000000     0   795    786  1443               (NOTLB)
[   40.691350] c16b1f40 00000082 c0115ff9 00000000 c1601530 bfd67d94 c1601530 00000000 
[   40.691544]        c1384e80 c1384520 00000000 0000122d 8cc9bc6a 00000008 c1601530 c1601020 
[   40.695744]        c1601144 00000000 00000246 c16010c8 00000004 fffffe00 c1601020 c0121343 
[   40.699932] Call Trace:
[   40.708026]  [<c0115ff9>] do_page_fault+0x1a9/0x57a
[   40.712230]  [<c0121343>] do_wait+0x313/0x3a0
[   40.716403]  [<c0119940>] default_wake_function+0x0/0x10
[   40.720663]  [<c0119940>] default_wake_function+0x0/0x10
[   40.724858]  [<c0121479>] sys_wait4+0x29/0x30
[   40.729039]  [<c0103f99>] syscall_call+0x7/0xb
[   40.733255] udev          S 00000000     0  1443    795                     (NOTLB)
[   40.737575] db533f64 00000082 00000000 00000000 00000000 00000000 00001000 00000000 
[   40.737766]        42eb7f60 c1384520 00000000 00001a9e 3f629e4a 00000009 c035abc0 c1601530 
[   40.742137]        c1601654 00000246 00000000 fffbb44a 000003ea 00000000 fa09bac0 c03075de 
[   40.746498] Call Trace:
[   40.754791]  [<c03075de>] schedule_timeout+0x5e/0xb0
[   40.758975]  [<c0126690>] process_timeout+0x0/0x10
[   40.763137]  [<c0126776>] sys_nanosleep+0xc6/0x150
[   40.767289]  [<c0103f99>] syscall_call+0x7/0xb
[  147.456608] EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3 filesystem as ext2
[  147.460919] 
[  147.465087] VFS: Mounted root (ext2 filesystem) readonly.
[  147.469283] Trying to move old root to /initrd ... failed
[  147.480738] Unmounting old root
[  147.486976] Trying to free ramdisk memory ... okay
[  147.492451] Freeing unused kernel memory: 240k freed
[  151.490740] usbcore: registered new driver usbfs
[  151.496564] usbcore: registered new driver hub
[  151.942321] md: Autodetecting RAID arrays.
[  151.946224] md: autorun ...
[  151.950065] md: ... autorun DONE.
[  152.297238] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[  154.940497] kjournald starting.  Commit interval 5 seconds
[  154.944813] EXT3 FS on hda7, internal journal
[  154.948828] EXT3-fs: mounted filesystem with ordered data mode.
[  154.986454] kjournald starting.  Commit interval 5 seconds
[  154.990696] EXT3 FS on hda8, internal journal
[  154.994710] EXT3-fs: mounted filesystem with ordered data mode.
[  155.126141] kjournald starting.  Commit interval 5 seconds
[  155.190137] EXT3 FS on hda9, internal journal
[  155.194247] EXT3-fs: mounted filesystem with ordered data mode.
[  155.290713] kjournald starting.  Commit interval 5 seconds
[  155.332123] EXT3 FS on hda10, internal journal
[  155.336445] EXT3-fs: mounted filesystem with ordered data mode.
[  155.389403] hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
[  155.393906] Uniform CD-ROM driver Revision: 3.20
[  155.449715] cdrom: open failed.
[  156.098443] cdrom: open failed.
[  157.529171] ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[  157.549146] ohci_hcd 0000:00:13.0: OHCI Host Controller
[  157.841146] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
[  157.845558] ohci_hcd 0000:00:13.0: irq 19, io mem 0xe8001000
[  157.953988] hub 1-0:1.0: USB hub found
[  157.958476] hub 1-0:1.0: 3 ports detected
[  157.973629] ohci_hcd 0000:00:13.1: OHCI Host Controller
[  158.248115] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
[  158.252621] ohci_hcd 0000:00:13.1: irq 19, io mem 0xe8002000
[  158.412066] hub 2-0:1.0: USB hub found
[  158.416409] hub 2-0:1.0: 3 ports detected
[  158.484384] usb 1-1: new low speed USB device using ohci_hcd and address 2
[  158.776734] ehci_hcd 0000:00:13.2: EHCI Host Controller
[  158.809006] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
[  158.813393] ehci_hcd 0000:00:13.2: irq 19, io mem 0xe8003000
[  158.817792] ehci_hcd 0000:00:13.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
[  158.904204] hub 3-0:1.0: USB hub found
[  158.908627] hub 3-0:1.0: 6 ports detected
[  158.972990] usb 1-1: USB disconnect, address 2
[  159.712813] usb 1-1: new low speed USB device using ohci_hcd and address 3
[  160.563513] Linux Kernel Card Services
[  160.567931]   options:  [pci] [cardbus] [pm]
[  160.612854] ieee1394: Initialized config rom entry `ip1394'
[  160.636799] ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
[  160.760418] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[e8214000-e82147ff]  Max Packet=[2048]
[  160.787842] Yenta: CardBus bridge found at 0000:02:04.0 [1179:ff01]
[  160.912114] Yenta: ISA IRQ mask 0x0280, PCI irq 17
[  160.916612] Socket status: 30000006
[  161.844583] Adding 1542200k swap on /dev/hda5.  Priority:42 extents:1
[  162.026119] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f4656401551]
[  162.028140] 8139too Fast Ethernet driver 0.9.27
[  162.074968] eth0: RealTek RTL8139 at 0xa000, 00:02:3f:d5:0b:c6, IRQ 19
[  162.074976] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[  164.353189] usbcore: registered new driver hiddev
[  164.434429] input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:00:13.0-1
[  164.434451] usbcore: registered new driver usbhid
[  164.434455] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[  167.774386] SCSI subsystem initialized
[  167.988151] st: Version 20050312, fixed bufsize 32768, s/g segs 256
[  172.082033] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[  175.886804] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[  175.967111] NET: Registered protocol family 17
[  179.510351] ALSA sound/pci/atiixp.c:518: atiixp: codec reset timeout
[  187.044032] parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
[  187.138842] lp0: using parport0 (polling).

--------------070008080404070602080205--
