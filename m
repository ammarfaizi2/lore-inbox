Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVBTUwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVBTUwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 15:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVBTUwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 15:52:13 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:30459 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261898AbVBTUuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 15:50:39 -0500
Message-ID: <4218F81B.5020209@tiscali.de>
Date: Sun, 20 Feb 2005 21:50:35 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic in 2.6.11-rc4
References: <4218E251.1010000@candelatech.com>
In-Reply-To: <4218E251.1010000@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

> I see this panic when booting 2.6.11-rc4 (plus some of my own 
> patches...but my modules
> have not loaded at the point of the crash).
>
> The system is a Shuttle system with the FB65 motherboard.  CPU is 
> 3.0Ghz P4 with
> 1MB cache and hyperthreading.  HD is an 80GB SATA disk.  NVIDIA card 
> is installed
> (but I have not installed the NVIDIA drivers).
>
> The system boots the latest FC2 kernel (2.6.10-1-something) fine, and 
> other
> FC2 kernels too.  The system hangs trying to discover hardware
> when I try to boot a 2.6.9 kernel I compiled...
>
> Also, the system will not save it's BIOS settings.  I'm not sure exactly
> what that indicates, other than potentially flaky hardware of some 
> sort...
>
> Any ideas are welcome!
>
> Thanks,
> Ben
>
>
> Linux version 2.6.11-rc4 (greear@lanforge-nx) (gcc version 3.3.3 
> 20040412 (Red Hat Linux 3.3.3-7)5BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
>  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 511MB LOWMEM available.
> found SMP MP-table at 000f52c0
> DMI 2.2 present.
> ACPI: PM-Timer IO Port: 0x408
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 15:4 APIC version 20
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 15:4 APIC version 20
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Built 1 zonelists
> Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0
> Initializing CPU#0
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 3008.737 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 514532k/524224k available (2124k kernel code, 9052k reserved, 
> 838k data, 232k init, 0k hi)Checking if this processor honours the WP 
> bit even in supervisor mode... Ok.
> Security Framework v1.0.0 initialized
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> selinux_register_security:  Registering secondary module capability
> Capability LSM initialized as secondary
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> monitor/mwait feature present.
> using mwait in idle threads.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU0: Thermal monitoring enabled
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
> per-CPU timeslice cutoff: 2926.21 usecs.
> task migration cache decay timeout: 3 msecs.
> Booting processor 1/1 eip 3000
> Initializing CPU#1
> monitor/mwait feature present.
> CPU: Trace cache: 12K uops, L1 D cache: 16K
> CPU: L2 cache: 1024K
> CPU: Physical Processor ID: 0
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#1.
> CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU1: Thermal monitoring enabled
> CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
> Total of 2 processors activated (11960.32 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> checking TSC synchronization across 2 CPUs: passed.
> Brought up 2 CPUs
> checking if image is initramfs...it isn't (no cpio magic); looks like 
> an initrd
> Freeing initrd memory: 293k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfb460, last bus=3
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20050125
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 7 9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 *9 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI init
> pnp: PnP ACPI: found 13 devices
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> ** PCI interrupts are no longer routed automatically.  If this
> ** causes a device to stop working, it is probably because the
> ** driver failed to call pci_enable_device().  As a temporary
> ** workaround, the "pci=routeirq" argument restores the old
> ** behavior.  If this argument makes the device work again,
> ** please email the output of "lspci" to bjorn.helgaas@hp.com
> ** so I can fix the driver.
> pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
> apm: disabled - APM is not SMP safe.
> audit: initializing netlink socket (disabled)
> audit(1108901323.944:0): initialized
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> SELinux:  Registering netfilter hooks
> Initializing Cryptographic API
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> ACPI: Fan [FAN] (on)
> ACPI: Thermal Zone [THRM] (55 C)
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected an Intel 865 Chipset.
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: AGP aperture is 64M @ 0xf0000000
> [drm] Initialized drm 1.0.0 20040925
> ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
> ACPI: PS/2 Mouse Controller [PS2M] at irq 12
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
> \uffffttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> hda: CRW-5232AS, ATAPI CD/DVD-ROM drive
> ide1: I/O resource 0x170-0x177 not free.
> ide1: ports already in use, skipping probe
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache
> Uniform CD-ROM driver Revision: 3.20
> ide-floppy driver 0.99.newide
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 32Kbytes
> TCP established hash table entries: 32768 (order: 7, 524288 bytes)
> TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 32768 bind 32768)
> Initializing IPsec netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Starting balanced_irq
> ACPI wakeup devices:
> PCI0 HUB0 UAR1 USB0 USB1 USB2 USB3 USBE MODM
> ACPI: (supports S0 S1 S4 S5)
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> SCSI subsystem initialized
> ata_piix: combined mode detected
> ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
> ata: 0x1f0 IDE port busy
> ata1: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> ata1: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48
> ata1: dev 0 configured for UDMA/133
> scsi0 : ata_piix
>   Vendor: ATA       Model: ST380817AS        Rev: 3.42
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Unable to handle kernel paging request at virtual address e09a68e8
>  printing eip:
> c014976e
> *pde = 0151f067
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in: ext3 jbd ata_piix libata sd_mod scsi_mod
> CPU:    1
> EIP:    0060:[<c014976e>]    Not tainted VLI
> EFLAGS: 00010006   (2.6.11-rc4)
> EIP is at cache_alloc_refill+0x20e/0x240
> eax: 0000006c   ebx: 0000001b   ecx: 0000001b   edx: df667990
> esi: e09a68e8   edi: df667990   ebp: df667980   esp: df5d1cd4
> ds: 007b   es: 007b   ss: 0068
> Process linuxrc (pid: 392, threadinfo=df5d0000 task=dfc62a80)
> Stack: df625d80 df625de0 df5d1d64 df625da8 dfc8b254 dfd05c00 00000020 
> 00000020
>        00000046 df625d80 dfd05400 c0149980 df66c000 dfd0559c 00000000 
> e0856113
>        00000020 dfd0559c 00000000 dfd05400 e08561a1 dfd05400 dfc8b254 
> dff07e00
> Call Trace:
>  [<c0149980>] kmem_cache_alloc+0x50/0x70
>  [<e0856113>] __scsi_get_command+0x23/0x80 [scsi_mod]
>  [<e08561a1>] scsi_get_command+0x31/0xf0 [scsi_mod]
>  [<e085c793>] scsi_prep_fn+0x133/0x1e0 [scsi_mod]
>  [<c0245f6c>] elv_next_request+0x4c/0xf0
>  [<c0247e9b>] blk_remove_plug+0x3b/0x70
>  [<c0247ef2>] __generic_unplug_device+0x22/0x30
>  [<c0247f15>] generic_unplug_device+0x15/0x30
>  [<c0247f30>] blk_backing_dev_unplug+0x0/0x20
>  [<c0247f42>] blk_backing_dev_unplug+0x12/0x20
>  [<c0163fc6>] block_sync_page+0x36/0x40
>  [<c0140d5c>] sync_page+0x3c/0x50
>  [<c031155b>] __wait_on_bit_lock+0x5b/0x70
>  [<c0140d20>] sync_page+0x0/0x50
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c01414f0>] __lock_page+0x90/0xa0
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0311f40>] _spin_unlock_irq+0x20/0x40
>  [<c0141cc7>] do_generic_mapping_read+0x427/0x510
>  [<c01b5b02>] avc_has_perm_noaudit+0x92/0x140
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c0142094>] __generic_file_aio_read+0x1f4/0x230
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c01421c5>] generic_file_read+0x95/0xb0
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0166c07>] block_llseek+0x27/0xf0
>  [<c015f4b3>] vfs_read+0xc3/0x130
>  [<c015f767>] sys_read+0x47/0x80
>  [<c0103109>] sysenter_past_esp+0x52/0x75
> Code: 51 ff ff ff 39 c3 0f 47 d8 29 d8 89 02 8d 04 9d 00 00 00 00 89 
> 5d 00 8b 4c 24 14 8d 55 10 8
>  <6>note: linuxrc[392] exited with preempt_count 2
> scheduling while atomic: linuxrc/0x00000002/392
>  [<c0310982>] schedule+0xb52/0xb60
>  [<c011af67>] try_to_wake_up+0x237/0x260
>  [<c011ca37>] __wake_up_common+0x37/0x70
>  [<c0310b14>] wait_for_completion+0x94/0xe0
>  [<c011c9f0>] default_wake_function+0x0/0x10
>  [<c011c9f0>] default_wake_function+0x0/0x10
>  [<c0130a55>] call_usermodehelper+0x125/0x130
>  [<c01308e0>] __call_usermodehelper+0x0/0x50
>  [<c01cacd3>] kobject_hotplug+0x253/0x2b0
>  [<c019a77d>] sysfs_hash_and_remove+0x8d/0xfc
>  [<c01ca38d>] kobject_del+0xd/0x20
>  [<c0242492>] class_device_del+0xa2/0xc0
>  [<c02424b8>] class_device_unregister+0x8/0x10
>  [<c0218371>] vcs_remove_devfs+0x11/0x24
>  [<c021f5b4>] con_close+0x74/0x80
>  [<c020fc95>] release_dev+0x795/0x7c0
>  [<c0145789>] free_hot_cold_page+0xe9/0x140
>  [<c0145f4c>] __pagevec_free+0x1c/0x30
>  [<c014abec>] release_pages+0x5c/0x150
>  [<c03121c8>] lock_kernel+0x28/0x40
>  [<c01616c5>] invalidate_inode_buffers+0x15/0x90
>  [<c021015f>] tty_release+0xf/0x20
>  [<c0160526>] __fput+0x146/0x160
>  [<c015ebef>] filp_close+0x4f/0x80
>  [<c0122cd1>] put_files_struct+0x61/0xb0
>  [<c0123931>] do_exit+0xd1/0x360
>  [<c0104369>] die+0x179/0x180
>  [<c0118fa9>] do_page_fault+0x2d9/0x56a
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0144636>] mempool_alloc+0x76/0x150
>  [<c0149535>] cache_grow+0x105/0x130
>  [<c0249a67>] submit_bio+0x57/0xe0
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0118cd0>] do_page_fault+0x0/0x56a
>  [<c0103c03>] error_code+0x2b/0x30
>  [<c014976e>] cache_alloc_refill+0x20e/0x240
>  [<c0149980>] kmem_cache_alloc+0x50/0x70
>  [<e0856113>] __scsi_get_command+0x23/0x80 [scsi_mod]
>  [<e08561a1>] scsi_get_command+0x31/0xf0 [scsi_mod]
>  [<e085c793>] scsi_prep_fn+0x133/0x1e0 [scsi_mod]
>  [<c0245f6c>] elv_next_request+0x4c/0xf0
>  [<c0247e9b>] blk_remove_plug+0x3b/0x70
>  [<c0247ef2>] __generic_unplug_device+0x22/0x30
>  [<c0247f15>] generic_unplug_device+0x15/0x30
>  [<c0247f30>] blk_backing_dev_unplug+0x0/0x20
>  [<c0247f42>] blk_backing_dev_unplug+0x12/0x20
>  [<c0163fc6>] block_sync_page+0x36/0x40
>  [<c0140d5c>] sync_page+0x3c/0x50
>  [<c031155b>] __wait_on_bit_lock+0x5b/0x70
>  [<c0140d20>] sync_page+0x0/0x50
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c01414f0>] __lock_page+0x90/0xa0
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0311f40>] _spin_unlock_irq+0x20/0x40
>  [<c0141cc7>] do_generic_mapping_read+0x427/0x510
>  [<c01b5b02>] avc_has_perm_noaudit+0x92/0x140
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c0142094>] __generic_file_aio_read+0x1f4/0x230
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c01421c5>] generic_file_read+0x95/0xb0
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0166c07>] block_llseek+0x27/0xf0
>  [<c015f4b3>] vfs_read+0xc3/0x130
>  [<c015f767>] sys_read+0x47/0x80
>  [<c0103109>] sysenter_past_esp+0x52/0x75
> scheduling while atomic: linuxrc/0x00000002/392
>  [<c0310982>] schedule+0xb52/0xb60
>  [<c011af67>] try_to_wake_up+0x237/0x260
>  [<c011ca37>] __wake_up_common+0x37/0x70
>  [<c0310b14>] wait_for_completion+0x94/0xe0
>  [<c011c9f0>] default_wake_function+0x0/0x10
>  [<c011c9f0>] default_wake_function+0x0/0x10
>  [<c0130a55>] call_usermodehelper+0x125/0x130
>  [<c01308e0>] __call_usermodehelper+0x0/0x50
>  [<c01cacd3>] kobject_hotplug+0x253/0x2b0
>  [<c019a77d>] sysfs_hash_and_remove+0x8d/0xfc
>  [<c01ca38d>] kobject_del+0xd/0x20
>  [<c0242492>] class_device_del+0xa2/0xc0
>  [<c02424b8>] class_device_unregister+0x8/0x10
>  [<c021f5b4>] con_close+0x74/0x80
>  [<c020fc95>] release_dev+0x795/0x7c0
>  [<c0145789>] free_hot_cold_page+0xe9/0x140
>  [<c0145f4c>] __pagevec_free+0x1c/0x30
>  [<c014abec>] release_pages+0x5c/0x150
>  [<c03121c8>] lock_kernel+0x28/0x40
>  [<c01616c5>] invalidate_inode_buffers+0x15/0x90
>  [<c021015f>] tty_release+0xf/0x20
>  [<c0160526>] __fput+0x146/0x160
>  [<c015ebef>] filp_close+0x4f/0x80
>  [<c0122cd1>] put_files_struct+0x61/0xb0
>  [<c0123931>] do_exit+0xd1/0x360
>  [<c0104369>] die+0x179/0x180
>  [<c0118fa9>] do_page_fault+0x2d9/0x56a
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0144636>] mempool_alloc+0x76/0x150
>  [<c0149535>] cache_grow+0x105/0x130
>  [<c0249a67>] submit_bio+0x57/0xe0
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0118cd0>] do_page_fault+0x0/0x56a
>  [<c0103c03>] error_code+0x2b/0x30
>  [<c014976e>] cache_alloc_refill+0x20e/0x240
>  [<c0149980>] kmem_cache_alloc+0x50/0x70
>  [<e0856113>] __scsi_get_command+0x23/0x80 [scsi_mod]
>  [<e08561a1>] scsi_get_command+0x31/0xf0 [scsi_mod]
>  [<e085c793>] scsi_prep_fn+0x133/0x1e0 [scsi_mod]
>  [<c0245f6c>] elv_next_request+0x4c/0xf0
>  [<c0247e9b>] blk_remove_plug+0x3b/0x70
>  [<c0247ef2>] __generic_unplug_device+0x22/0x30
>  [<c0247f15>] generic_unplug_device+0x15/0x30
>  [<c0247f30>] blk_backing_dev_unplug+0x0/0x20
>  [<c0247f42>] blk_backing_dev_unplug+0x12/0x20
>  [<c0163fc6>] block_sync_page+0x36/0x40
>  [<c0140d5c>] sync_page+0x3c/0x50
>  [<c031155b>] __wait_on_bit_lock+0x5b/0x70
>  [<c0140d20>] sync_page+0x0/0x50
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c01414f0>] __lock_page+0x90/0xa0
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0311f40>] _spin_unlock_irq+0x20/0x40
>  [<c0141cc7>] do_generic_mapping_read+0x427/0x510
>  [<c01b5b02>] avc_has_perm_noaudit+0x92/0x140
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c0142094>] __generic_file_aio_read+0x1f4/0x230
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c01421c5>] generic_file_read+0x95/0xb0
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0166c07>] block_llseek+0x27/0xf0
>  [<c015f4b3>] vfs_read+0xc3/0x130
>  [<c015f767>] sys_read+0x47/0x80
>  [<c0103109>] sysenter_past_esp+0x52/0x75
> scheduling while atomic: linuxrc/0x00000002/392
>  [<c0310982>] schedule+0xb52/0xb60
>  [<c01352f0>] prepare_to_wait+0x20/0x70
>  [<c0130eea>] flush_cpu_workqueue+0x9a/0x1b0
>  [<c01616c5>] invalidate_inode_buffers+0x15/0x90
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0131062>] flush_workqueue+0x62/0xa0
>  [<c020fa05>] release_dev+0x505/0x7c0
>  [<c0145789>] free_hot_cold_page+0xe9/0x140
>  [<c0145f4c>] __pagevec_free+0x1c/0x30
>  [<c014abec>] release_pages+0x5c/0x150
>  [<c03121c8>] lock_kernel+0x28/0x40
>  [<c01616c5>] invalidate_inode_buffers+0x15/0x90
>  [<c021015f>] tty_release+0xf/0x20
>  [<c0160526>] __fput+0x146/0x160
>  [<c015ebef>] filp_close+0x4f/0x80
>  [<c0122cd1>] put_files_struct+0x61/0xb0
>  [<c0123931>] do_exit+0xd1/0x360
>  [<c0104369>] die+0x179/0x180
>  [<c0118fa9>] do_page_fault+0x2d9/0x56a
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0144636>] mempool_alloc+0x76/0x150
>  [<c0149535>] cache_grow+0x105/0x130
>  [<c0249a67>] submit_bio+0x57/0xe0
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0118cd0>] do_page_fault+0x0/0x56a
>  [<c0103c03>] error_code+0x2b/0x30
>  [<c014976e>] cache_alloc_refill+0x20e/0x240
>  [<c0149980>] kmem_cache_alloc+0x50/0x70
>  [<e0856113>] __scsi_get_command+0x23/0x80 [scsi_mod]
>  [<e08561a1>] scsi_get_command+0x31/0xf0 [scsi_mod]
>  [<e085c793>] scsi_prep_fn+0x133/0x1e0 [scsi_mod]
>  [<c0245f6c>] elv_next_request+0x4c/0xf0
>  [<c0247e9b>] blk_remove_plug+0x3b/0x70
>  [<c0247ef2>] __generic_unplug_device+0x22/0x30
>  [<c0247f15>] generic_unplug_device+0x15/0x30
>  [<c0247f30>] blk_backing_dev_unplug+0x0/0x20
>  [<c0247f42>] blk_backing_dev_unplug+0x12/0x20
>  [<c0163fc6>] block_sync_page+0x36/0x40
>  [<c0140d5c>] sync_page+0x3c/0x50
>  [<c031155b>] __wait_on_bit_lock+0x5b/0x70
>  [<c0140d20>] sync_page+0x0/0x50
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c01414f0>] __lock_page+0x90/0xa0
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0135470>] wake_bit_function+0x0/0x60
>  [<c0311f40>] _spin_unlock_irq+0x20/0x40
>  [<c0141cc7>] do_generic_mapping_read+0x427/0x510
>  [<c01b5b02>] avc_has_perm_noaudit+0x92/0x140
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c0142094>] __generic_file_aio_read+0x1f4/0x230
>  [<c0141db0>] file_read_actor+0x0/0xf0
>  [<c01421c5>] generic_file_read+0x95/0xb0
>  [<c0135420>] autoremove_wake_function+0x0/0x50
>  [<c0166c07>] block_llseek+0x27/0xf0
>  [<c015f4b3>] vfs_read+0xc3/0x130
>  [<c015f767>] sys_read+0x47/0x80
>  [<c0103109>] sysenter_past_esp+0x52/0x75
>
Hi!
The first one is allocation error (linuxrc wants to get/read memory, but 
the allocation fails?). The other errors are _maybe_ caused by the first 
error (the scheduler schedules while a atomic operation is in progress). 
Is your Kernel configuration different to the configuration of the 
Fedora Kernel? If so: What did you change?
It's strange that you can't change you Bios settings. Is the write 
protection jumper set to 1 (TRUE/ENABLED)? Is your Bios up2date?

Matthias-Christian Ott
