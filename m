Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267271AbUHWElN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267271AbUHWElN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 00:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUHWElB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 00:41:01 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:54601 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267271AbUHWEke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 00:40:34 -0400
Message-ID: <4129753F.5060903@blueyonder.co.uk>
Date: Mon, 23 Aug 2004 05:40:31 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.8.1-mm4
Content-Type: multipart/mixed;
 boundary="------------060302080300070506070607"
X-OriginalArrivalTime: 23 Aug 2004 04:40:54.0538 (UTC) FILETIME=[601BA6A0:01C488CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302080300070506070607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It only boots with acpi=off, hangs after outputting "starting sound 
driver: intel8x0", but looks like an ACPI bug. Tried pci=routeirq and 
pci=noacpi also.
Athlon 3000+/512M, Asus A7N8X-E, nForce2 chipset.

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====


--------------060302080300070506070607
Content-Type: text/plain;
 name="2681mm4-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2681mm4-2"

Linux version 2.6.8.1-mm4 (root@barrabas) (gcc version 3.3.3 (SuSE Linux)) #3 Mon Aug 23 02:31:00 BST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f75e0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7640
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda1 vga=0x31a desktop /dev/hdb=ide-cd splash=silent 3 console=ttyS1
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2162.945 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514232k/524224k available (2337k kernel code, 9484k reserved, 1239k data, 192k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 3000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................................................................................................................................................
Table [DSDT](id F004) - 701 Objects with 75 Devices 260 Methods 27 Regions
ACPI Namespace successfully loaded at root c04ce65c
evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000004020 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-0980 [07] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs at 00000000000044A0 on int 0x9
evgpeblk-0989 [07] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:........................................................................
Initialized 27/27 Regions 1/1 Fields 28/28 Buffers 16/24 Packages (710 nodes)
Executing all Device _STA and_INI methods:..............................................................................
78 Devices found containing: 78 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbef0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf20, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
vesafb: framebuffer at 0xd8000000, mapped to 0xe0880000, size 5120k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:dfe0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
Machine check exception polling timer started.
cpufreq: Detected nForce2 chipset revision C1
cpufreq: FSB changing is maybe unstable and can lead to crashes and data loss.
cpufreq: FSB currently at 166 MHz, FID 13.0
cpufreq: Old CPU frequency 2145000 kHz, new 2158000 kHz
Warning: CPU frequency is 2145000, cpufreq assumed 2158000 kHz.
cpufreq: Changed FSB successfully to 166
cpufreq: Old CPU frequency 2145000 kHz, new 2158000 kHz
Warning: CPU frequency is 2145000, cpufreq assumed 2158000 kHz.
cpufreq: Changed FSB successfully to 166
audit: initializing netlink socket (disabled)
audit(1093233080.628:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: Processor [CPU0] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 160x64
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
acpi_floppy_resource: 6 ioports at 0x3f0
acpi_floppy_resource: 1 ioports at 0x3f7
floppy: controller ACPI FDC0 at I/O 0x3f0-0x3f5, 0x3f7-0x3f7 irq 6 dma channel 2
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: HDS722512VLAT80, ATA DISK drive
hdb: ATAPI COMBO48XMAX, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6Y160P0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 1024KiB
hda: 241254720 sectors (123522 MB) w/7938KiB Cache, CHS=16383/255/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2
hdc: max request size: 1024KiB
hdc: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
hdc: cache flushes supported
 hdc: hdc1 hdc2
hdb: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
I2O Core - (C) Copyright 1999 Red Hat Software
i2o: max_drivers=4
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
PERFCTR INIT: vendor 2, family 6, model 10, stepping 0, clock 2162945 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 169 cycles
PERFCTR INIT: rdtsc cost is 14.1 cycles (1075 total)
PERFCTR INIT: rdpmc cost is 14.3 cycles (1088 total)
PERFCTR INIT: rdmsr (counter) cost is 51.9 cycles (3492 total)
PERFCTR INIT: rdmsr (evntsel) cost is 52.6 cycles (3541 total)
PERFCTR INIT: wrmsr (counter) cost is 79.6 cycles (5267 total)
PERFCTR INIT: wrmsr (evntsel) cost is 231.4 cycles (14984 total)
PERFCTR INIT: read cr4 cost is 2.3 cycles (321 total)
PERFCTR INIT: write cr4 cost is 63.0 cycles (4205 total)
PERFCTR INIT: write LVTPC cost is 10.3 cycles (831 total)
PERFCTR INIT: sync_core cost is 73.6 cycles (4883 total)
perfctr: driver 2.7.5, cpu type AMD K7/K8 at 2162945 kHz
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
INIT: version 2.85 booting
System Boot Control: Running /etc/init.d/boot
Mounting /proc filesystem7[?25l[80C[10D[1;32mdone[m8[?25h
Mounting sysfs on /sys7[?25l[80C[10D[1;32mdone[m8[?25h
Mounting /dev/pts7[?25l[80C[10D[1;32mdone[m8[?25h
Configuring serial ports...
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
/dev/ttyS1 at 0x02f8 (irq = 3) is a 16550A
Configured serial ports
7[?25l[1A[80C[10D[1;32mdone[m8[?25h[m[?25hMounting shared memory FS on /dev/shm[80C[10D[1;32mdone[m
[m[?25hshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking root file system...
fsck 1.34 (25-Jul-2003)
[/sbin/fsck.reiserfs (1) -- /] fsck.reiserfs -a /dev/hda1 
Reiserfs super block in block 16 on 0x301 of format 3.6 with standard journal
Blocks (total/free): 29623840/23507954 by 4096 bytes
Filesystem is clean
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished
7[?25l[1A[80C[10D[1;32mdone[m8[?25h[m[?25hActivating device mapper...
FATAL: Module dm_mod not found.
device-mapper kernel module not loaded: can't create /dev/mapper/control.
7[?25l[80C[10D[1;31mfailed[m8[?25h
[m[?25hshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.34 (25-Jul-2003)
Checking all file systems.
[/sbin/fsck.reiserfs (1) -- /data1] fsck.reiserfs -a /dev/hdc1 
Reiserfs super block in block 16 on 0x1601 of format 3.6 with standard journal
Blocks (total/free): 39064047/15341304 by 4096 bytes
Filesystem is clean
Replaying journal..
Reiserfs journal '/dev/hdc1' in blocks [18..8211]: 0 transactions replayed
Checking internal tree..finished
7[?25l[1A[80C[10D[1;32mdone[m8[?25hSetting up7[?25l[80C[10D[1;32mdone[cdrom: open failed.
m8[?25h
Mounting local file systems...
proccdrom: open failed.
 on /proc type pcdrom: open failed.
roc (rw)
tmpfs cdrom: open failed.
on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
^[[?60;9;cmount: you didn't specify a filesystem type for /dev/cdrecorder
       I will try all types mentioned in /etc/filesystems or /proc/filesystems
Trying vfat
mount: No medium found
mount: you didn't specify a filesystem type for /dev/cdrom
       I will try all types mentioned in /etc/filesystems or /proc/filesystems
Trying vfat
mountAdding 2128604k swap on /dev/hda2.  Priority:42 extents:1
: mount point /mAdding 3823460k swap on /dev/hdc2.  Priority:42 extents:1
edia/cdrom does not exist
mount: you didn't specify a filesystem type for /dev/dvd
       I will try all types mentioned in /etc/filesystems or /proc/filesystems
Trying vfat
mount: mount point /media/dvd does not exist
mount: you didn't specify a filesystem type for /dev/fd0
       I will try all types mentioned in /etc/filesystems or /proc/filesystems
Trying vfat
mount: /dev/fd0 is not a valid block device
7[?25l[1A[80C[10D[1;31mfailed[m8[?25h[m[?25h[m[?25hLoading required kernel modules
7[?25l[1A[80C[10D[1;32mdone[m8[?25hRestore device permissions7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hRegister IL ExecutablesFATAL: Module binfmt_misc not found.
FATAL: Error running install command for binfmt_misc
/bin/ilrun: the operating system does not support registration
7[?25l[80C[10D[1;31mfailed[m8[?25h
Activating remaining swap-devices in /etc/fstab...
7[?25l[1A[80C[10D[1;32mdone[m8[?25h[m[?25hSetting up the CMOS clock7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25h[m[?25hSetting up timezone data7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hSetting scheduling timeslices 7[?25l[80C[10D[1munused[m8[?25h
Setting up hostname 'barrabas'7[?25l[80C[10D[1;32mdone[m8[?25h
Setting up loopback interface     lo       
    lo        IP address: 127.0.0.1/8   
7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hEnabling syn flood protection[80C[10D[1;32mdone[m
Disabling IP forwarding7[?25l[80C[10D[1;32mdone[m8[?25h
Creating /var/log/boot.msg
7[?25l[1A[80C[10D[1;32mdone[m8[?25hshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
[m[?25hSystem Boot Control: The system has been [80C[10D[1mset up[m
Failed features: [80C[16D[1;31mboot.pnet[m
Skipped features: [80C[17D[1;33mboot.sched[m
System Boot Control: Running /etc/init.d/boot.local
7[?25l[1A[80C[10D[1;32mdone[m8[?25hINIT: Entering runlevel: 3
Boot logging started on /dev/ttyS1(/dev/console) at Mon Aug 23 04:52:01 2004
Master Resource Control: previous runlevel: N, switching to runlevel: [80C[10D[1m3[m
Hotplug is already active  (disable with  NOHOTPLUG=1 at the boot prompt)7[?25l[80C[10D[1;32mdone[m8[?25h
Initializing random number generator7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hcoldplug scanning input: **7[?25l[80C[10D[1;32mdone[m8[?25h
         scanning pci: *WWWWW******WWforcedeth.c: Reverse Engineered nForce ethernet driver. Ve*rsion 0.28.
.ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
Unable to handle kernel paging request at virtual address c048d230
 printing eip:
c048d2*30
*pde = 004e8027
*pte = 0048d000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: forcedeth vfat fat
CPU:    0
EIP:    0060:[<c048d230>]    Not tainted VLI
EFLAGS: 00010286   (2.6.8.1-mm4) 
EIP is at assign_irq_vector+0x0/0xa0
eax: 00000016   ebx: 00000016   ecx: 00000016   edx: c04b7fc8
esi: 00000001   edi: d9fd9dc8   ebp: d9fd9dd4   esp: d9fd9d90
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1753, threadinfo=d9fd8000 task=d7907a60)
Stack: c0115063 00200000 0000026e d9fd9dd4 00000000 00000016 d9fd9dd8 c023643e 
       00200000 0000010d 00000016 00000000 00018900 01000000 00000016 00000016 
       00000000 d9fd9e04 c01131bb 00000001 00000000 00000000 00400000 00000016 
Call Trace:
 [<c0106c56>] show_stack+0xa6/0xb0
 [<c0106dcd>] show_registers+0x14d/0x1c0
 [<c0106fc0>] die+0xf0/0x180
 [<c0117007>] do_page_fault+0x417/0x5bb
 [<c0106849>] error_code+0x2d/0x38
 [<c01131bb>] mp_register_gsi+0x11b/0x140
 [<c0112e2b>] acpi_register_gsi+0x8b/0xb0
 [<c023db9b>] acpi_pci_irq_enable+0x191/0x1fe
 [<c02cfff7>] pcibios_enable_device+0x17/0x20
 [<c020da21>] pci_enable_device_bars+0x21/0x40
 [<c020da57>] pci_enable_device+0x17/0x40
 [<e0842b7e>] nv_probe+0x9e/0x620 [forcedeth]
 [<c020f197>] pci_device_probe_static+0x47/0x70
 [<c020f1f7>] __pci_device_probe+0x37/0x50
 [<c020f236>] pci_device_probe+0x26/0x50
 [<c026d585>] bus_match+0x35/0x70
 [<c026d6af>] driver_attach+0x4f/0x90
 [<c026db33>] bus_add_driver+0x83/0xb0
 [<c026e06b>] driver_register+0x2b/0x30
 [<c020f479>] pci_register_driver+0x59/0x80
 [<e0847024>] init_nic+0x24/0x30 [forcedeth]
 [<c01325d6>] sys_init_module+0xd6/0x220
 [<c0105dc9>] sysenter_past_esp+0x52/0x71
Code:  Bad EIP value.
 **W7[?25l[80C[10D[1;32mdone[m8[?25h
         scanning usb: <6>usbcore: registered new driver usbfs
usbcore: registered new driver hub
7[?25l[80C[10D[1;32mdone[m8[?25h
         .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hSetting up network interfaces:
    lo       
    lo        IP address: 127.0.0.1/8   
7[?25l[1A[80C[10D[1;32mdone[m8[?25hWaiting for mandatory devices:  eth-id-00:0e:a6:48:32:5c
20 19 Linux agpgart interface v0.100 (c) Dave Jones
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
18 17 ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
16 ieee1394: Initialized config rom entry `ip1394'
15 14 13 12 11 9 8 7 6 5 4 3 2 1 0 
    eth-id-00:0e:a6:48:32:5c            No interface found
7[?25l[1A[80C[10D[1;31mfailed[m8[?25hSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;31mfailed[m8[?25h
[m[?25hStarting syslog services7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hMount SMB/ CIFS File Systems [80C[10D[1munused[m
Starting RPC portmap daemon7[?25l[80C[10D[1;32mdone[m8[?25h
Starting resource manager7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hStarting nfsboot (sm-notify) 7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hStarting SSH daemon7[?25l[80C[10D[1;32mdone[m8[?25h
Starting service MySQL
7[?25l[80C[10D[1;32mdone[m8[?25h
ACPI: Power Button (FF) [PWRF]
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03f6a40(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device d6a44c00(sit0)
cpufreq: Old CPU frequency 2158000 kHz, new 2132000 kHz
cpufreq: Changed FSloading ACPI modules (ac batteryB button ) Starting powersaved 7[?25l[80C[10sD[1;32mdone[mu8[?25h
ccessfully to 164
cpufreq: OldStarting sound driver:  intel8x0 CPU frequency 2132000 kHz, new 2106000 kHz
cpufreq: Changed FSB successfully to 162
cpufreq: Old CPU frequency 2106000 kHz, new 2080000 kHz
cpufreq: Changed FSB successfully to 160
cpufreq: Old CPU frequency 2080000 kHz, new 2054000 kHz
cpufreq: Changed FSB successfully to 158
cpufreq: Old CPU frequency 2054000 kHz, new 2028000 kHz
cpufreq: Changed FSB successfully to 156
cpufreq: Old CPU frequency 2028000 kHz, new 2002000 kHz
cpufreq: Changed FSB successfully to 154
cpufreq: Old CPU frequency 2002000 kHz, new 1976000 kHz
cpufreq: Changed FSB successfully to 152
cpufreq: Old CPU frequency 1976000 kHz, new 1950000 kHz
cpufreq: Changed FSB successfully to 150
^[SysRq : Show State
SysRq : Show Regs
SysRq : Emergency Sync
SysRq : Emergency Remount R/O
SysRq : Resetting
Oops: 0000 [#2]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: ipv6 button battery ac snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sk98lin ohci1394 ieee1394 ehci_hcd ohci_hcd nvidia_agp agpgart evdev usbcore forcedeth vfat fat
CPU:    0
EIP:    0060:[<c048cfe0>]    Not tainted VLI
EFLAGS: 00010246   (2.6.8.1-mm4) 
EIP is at find_isa_irq_pin+0x0/0x80
eax: 00000000   ebx: c03f2b88   ecx: 0000003f   edx: 00000003
esi: 00000062   edi: 00000000   ebp: c0481e54   esp: c0481e3c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0480000 task=c03a9a60)
Stack: c0114aa0 0000007b 0000007b c03f2b88 00000062 00000000 c0481e68 c0112f8d 
       c011bec8 c03f2b88 00000062 c0481e8c c0261984 c037e8b4 c037d1e0 00000001 
       c0481fa0 00000001 deba3ec4 00000030 c0481ea8 c025b913 c0481fa0 00000001 
Call Trace:
 [<c0106c56>] show_stack+0xa6/0xb0
 [<c0106dcd>] show_registers+0x14d/0x1c0
 [<c0106fc0>] die+0xf0/0x180
 [<c0117007>] do_page_fault+0x417/0x5bb
 [<c0106849>] error_code+0x2d/0x38
 [<c0112f8d>] machine_restart+0xd/0x80
 [<c0261984>] __handle_sysrq+0x64/0xe0
 [<c025b913>] kbd_event+0xd3/0x100
 [<c02bc2d2>] input_event+0x162/0x3b0
 [<c02bf9df>] atkbd_report_key+0x2f/0x70
 [<c02bfc5a>] atkbd_interrupt+0x23a/0x600
 [<c0263e7e>] serio_interrupt+0x3e/0xa2
 [<c026447b>] i8042_interrupt+0xab/0x130
 [<c01083b0>] handle_IRQ_event+0x30/0x60
 [<c0108739>] do_IRQ+0xa9/0x170
 [<c0106788>] common_interrupt+0x18/0x20
 [<c0103eed>] cpu_idle+0x2d/0x40
 [<c04827fa>] start_kernel+0x17a/0x1c0
 [<c010019f>] 0xc010019f
Code:  Bad EIP value.
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 
--------------060302080300070506070607--
