Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVBXBkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVBXBkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVBXBkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 20:40:05 -0500
Received: from smtp1.xs4all.be ([195.144.64.135]:49063 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S261717AbVBXBjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 20:39:40 -0500
Message-ID: <421D30DC.3070602@xs4all.be>
Date: Thu, 24 Feb 2005 02:41:48 +0100
From: yves geunes <geunes@xs4all.be>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Oops: Unable to handle kernel paging request
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run installed and updated sarge. I downloaded 2.6.10 from kernel.org.
When I use apt-get under 2.4.27 everything is OK
When I use apt-get under 2.6.10, I get a segfault

I run the same combination (allthough a different configuration on  a Pentium III (Coppermine) and 
on a Intel(R) Pentium(R) M processor 1.50GHz, but there it works fine

The faulty system is configured for 686.
I hope this is useful for you

0
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/hda1 ro
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2993.709 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1030900k/1047744k available (1703k kernel code, 16028k reserved, 768k data, 288k init, 130168k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5914.62 BogoMIPS (lpj=2957312)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 04
per-CPU timeslice cutoff: 2925.86 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay loop... 5980.16 BogoMIPS (lpj=2990080)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 04
Total of 2 processors activated (11894.78 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:
 domain 0: span 03
  groups: 01 02
CPU1:
 domain 0: span 03
  groups: 02 01
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like an initrd
Freeing initrd memory: 3684k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
ACPI: Subsystem revision 20041105
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:407f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:407f
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
elevator: using anticipatory as default io scheduler
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
ACPI wakeup devices: 
TANA P0P3 AC97 USB0 USB1 USB2 USB3 USB7 UAR1 UAR2 SLPB 
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 3684KiB [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 288k freed
unix: disagrees about version of symbol sock_register
unix: Unknown symbol sock_register
unix: disagrees about version of symbol sock_wake_async
unix: Unknown symbol sock_wake_async
kobject_register failed for scsi_mod (-17)
 [<c01aeafb>] kobject_register+0x5b/0x60
 [<c0132b3d>] mod_sysfs_setup+0x7d/0x100
 [<c0133e8e>] load_module+0x99e/0xc70
 [<c01341c1>] sys_init_module+0x61/0x220
 [<c010318f>] syscall_call+0x7/0xb
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HDS722580VLAT20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 1024KiB
hda: 160836480 sectors (82348 MB) w/1794KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
Probing IDE interface ide1...
hdc: TSSTcorpCD/DVDW TS-H552B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
NET: Registered protocol family 1
Adding 4883720k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Real Time Clock Driver v1.12
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
md: md0 stopped.
md: bind<sdb1>
md: bind<sda1>
md: raid1 personality registered as nr 3
raid1: raid set md0 active with 2 out of 2 mirrors
device-mapper: 4.3.0-ioctl (2004-09-30) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Intel(R) PRO/1000 Network Driver - version 5.5.4-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:02:01.0 to 64
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:03:08.0[A] -> GSI 20 (level, low) -> IRQ 20
e100: eth1: e100_probe: addr 0xfeafe000, irq 20, MAC addr 00:0C:F1:E3:F7:C5
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:1d.7: continuing after BIOS bug...
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfebffc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xf8000000
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
hw_random hardware driver 1.0.0 loaded
Evaluate _OSC Set fails. Status = 0x0005
pciehp: add_host_bridge: status 5
pciehp: Fails to gain control of native hot-plug
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 17
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0335ae0(lo)
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present
eth0: no IPv6 routers present
Unable to handle kernel paging request at virtual address fa7c14c0
 printing eip:
f890610c
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP 
Modules linked in: md5 ipv6 af_packet eepro100 hw_random shpchp pci_hotplug intel_agp agpgart evdev ehci_hcd usbcore e100 mii e1000 dm_mod raid1 ide_cd cdrom rtc unix ext3 jbd ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old pdc202xx_new opti621 ns87415 hpt366 ide_disk hpt34x generic cy82c693 cs5530 cmd64x atiixp amd74xx alim15x3 aec62xx ide_core sd_mod
CPU:    1
EIP:    0060:[<f890610c>]    Not tainted VLI
EFLAGS: 00010202   (2.6.10) 
EIP is at ext3_block_truncate_page+0x12c/0x330 [ext3]
eax: 00000000   ebx: 00000000   ecx: 000002d0   edx: 00000b40
esi: 00000000   edi: fa7c14c0   ebp: c174f820   esp: f559bddc
ds: 007b   es: 007b   ss: 0068
Process dpkg (pid: 4709, threadinfo=f559a000 task=f78d3520)
Stack: f587d6a0 00001000 000000d2 00000000 00000000 f14314f4 00000b40 000004c0 
       f1bf0ddc 00000001 00000000 f587d6a0 00000000 f8906a7d f587d6a0 c174f820 
       f1431598 000004c0 00000000 f1431598 c174f820 f1431598 00000400 f1431430 
Call Trace:
 [<f8906a7d>] ext3_truncate+0x14d/0x5e0 [ext3]
 [<f8906930>] ext3_truncate+0x0/0x5e0 [ext3]
 [<c014858d>] vmtruncate+0xbd/0x150
 [<c0173186>] inode_setattr+0x176/0x190
 [<f8907bae>] ext3_setattr+0x13e/0x290 [ext3]
 [<c01733b5>] notify_change+0x1b5/0x1f0
 [<c0155dec>] do_truncate+0x6c/0xb0
 [<c0158dd9>] fget+0x49/0x60
 [<c015648c>] sys_ftruncate64+0xcc/0x130
 [<c010318f>] syscall_call+0x7/0xb
Code: 85 db 75 6b a1 90 f4 3c c0 89 ef 8b 54 24 1c 8b 4c 24 18 29 c7 c1 ff 05 c1 e7 0c 31 c0 8d bc 3a 00 00 00 c0 c1 e9 02 8b 54 24 18 <f3> ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa 8b 4c 24 14 31 db 
 
F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
4 S root         1     0  0  76   0 -   375 -      02:57 ?        00:00:00 init [2]  
1 S root         2     1  0 -40   0 -     0 migrat 02:57 ?        00:00:00 [migration/0]
1 S root         3     1  0  94  19 -     0 ksofti 02:57 ?        00:00:00 [ksoftirqd/0]
1 S root         4     1  0 -40   0 -     0 migrat 02:57 ?        00:00:00 [migration/1]
1 S root         5     1  0  94  19 -     0 ksofti 02:57 ?        00:00:00 [ksoftirqd/1]
1 S root         6     1  0  65 -10 -     0 worker 02:57 ?        00:00:00 [events/0]
1 S root         7     1  0  65 -10 -     0 worker 02:57 ?        00:00:00 [events/1]
1 S root         8     6  0  70 -10 -     0 worker 02:57 ?        00:00:00 [khelper]
1 S root        27     6  0  75 -10 -     0 worker 02:57 ?        00:00:00 [kacpid]
1 S root       110     6  0  65 -10 -     0 worker 02:57 ?        00:00:00 [kblockd/0]
1 S root       111     6  0  65 -10 -     0 worker 02:57 ?        00:00:00 [kblockd/1]
1 S root       157     6  0  80   0 -     0 pdflus 02:57 ?        00:00:00 [pdflush]
1 D root       158     6  0  75   0 -     0 start_ 02:57 ?        00:00:00 [pdflush]
1 S root       160     6  0  74 -10 -     0 worker 02:57 ?        00:00:00 [aio/0]
1 S root       159     1  0  85   0 -     0 kswapd 02:57 ?        00:00:00 [kswapd0]
1 S root       161     6  0  65 -10 -     0 worker 02:57 ?        00:00:00 [aio/1]
1 S root       747     1  0  85   0 -     0 serio_ 02:57 ?        00:00:00 [kseriod]
1 S root       772     6  0  65 -10 -     0 worker 02:57 ?        00:00:00 [ata/0]
1 S root       773     6  0  73 -10 -     0 worker 02:57 ?        00:00:00 [ata/1]
1 S root       775     1  0  85   0 -     0 375512 02:57 ?        00:00:00 [scsi_eh_0]
1 S root       776     1  0  85   0 -     0 375513 02:57 ?        00:00:00 [scsi_eh_1]
1 S root       791     1  0  75   0 -     0 -      02:57 ?        00:00:00 [kirqd]
1 S root       993     1  0  75   0 -     0 kjourn 02:57 ?        00:00:00 [kjournald]
1 S root      1769     1  0  75   0 -     0 md_thr 02:57 ?        00:00:00 [md0_raid1]
1 S root      1849     1  0  78   0 -     0 kjourn 02:57 ?        00:00:00 [kjournald]
1 S root      1850     1  0  75   0 -     0 kjourn 02:57 ?        00:00:00 [kjournald]
1 S root      1851     1  0  75   0 -     0 kjourn 02:57 ?        00:00:00 [kjournald]
1 D root      1852     1  0  75   0 -     0 journa 02:57 ?        00:00:00 [kjournald]
1 S root      1853     1  0  79   0 -     0 kjourn 02:57 ?        00:00:00 [kjournald]
1 S root      2215     1  0  79   0 -     0 hub_th 02:57 ?        00:00:00 [khubd]
1 S root      2630     1  0  85   0 -     0 -      02:57 ?        00:00:00 [shpchpd_event]
5 S root      3235     1  0  75   0 -   593 -      02:58 ?        00:00:00 dhclient -e -pf /var/run/dhclient.eth1.pid -lf /var/run/dhclient.eth1.leases eth1
5 S daemon    3243     1  0  75   0 -   404 -      02:58 ?        00:00:00 /sbin/portmap
5 D root      3585     1  0  76   0 -   564 start_ 02:58 ?        00:00:00 /sbin/syslogd
5 S root      3588     1  0  76   0 -   594 syslog 02:58 ?        00:00:00 /sbin/klogd
5 S root      3598     1  0  77   0 -   559 -      02:58 ?        00:00:00 /usr/sbin/inetd
5 S lp        3602     1  0  78   0 -   615 -      02:58 ?        00:00:00 /usr/sbin/lpd -s
4 D postfix   3696     1  0  76   0 -   918 start_ 02:58 ?        00:00:00 /usr/lib/postfix/master
4 D postfix   3739  3696  0  76   0 -   744 start_ 02:58 ?        00:00:00 pickup -l -t fifo -u -c
4 S postfix   3740  3696  0  76   0 -   752 -      02:58 ?        00:00:00 qmgr -l -t fifo -u -c
5 S root      3741     1  0  76   0 -  1388 -      02:58 ?        00:00:00 /usr/sbin/nmbd -D
5 S root      3743     1  0  78   0 -  1933 -      02:58 ?        00:00:00 /usr/sbin/smbd -D
1 S root      3749  3743  0  78   0 -  1933 pause  02:58 ?        00:00:00 /usr/sbin/smbd -D
5 S root      3750     1  0  76   0 -   867 -      02:58 ?        00:00:00 /usr/sbin/sshd
5 S root      3757     1  0  78   0 -   594 -      02:58 ?        00:00:00 /sbin/rpc.statd
5 S root      3760     1  0  76   0 -   425 -      02:58 ?        00:00:00 /sbin/mdadm -F -i /var/run/mdadm.pid -m root -f -s
5 S root      3773     1  0  78   0 -  1036 wait   02:58 ?        00:00:00 /usr/sbin/squid -D -sYC
4 D proxy     3775  3773  0  76   0 -  1762 start_ 02:58 ?        00:00:00 (squid) -D -sYC
0 S proxy     3777  3775  0  77   0 -   336 pipe_w 02:58 ?        00:00:00 (unlinkd)
1 S daemon    3780     1  0  79   0 -   420 -      02:58 ?        00:00:00 /usr/sbin/atd
5 S root      3783     1  0  76   0 -   440 -      02:58 ?        00:00:00 /usr/sbin/cron
5 S root      3795  3750  0  76   0 -  3613 -      02:58 ?        00:00:00 sshd: root@pts/0
5 S root      3797     1  0  76   0 -  2282 -      02:58 ?        00:00:00 /usr/bin/perl /usr/share/webmin/miniserv.pl /etc/webmin/miniserv.conf
5 S root      3816     1  0  76   0 -  4641 -      02:58 ?        00:00:00 /usr/sbin/apache
5 S www-data  3827  3816  0  77   0 -  4641 -      02:58 ?        00:00:00 /usr/sbin/apache
5 S www-data  3828  3816  0  81   0 -  4641 -      02:58 ?        00:00:00 /usr/sbin/apache
5 S www-data  3829  3816  0  82   0 -  4641 -      02:58 ?        00:00:00 /usr/sbin/apache
5 S www-data  3831  3816  0  81   0 -  4641 -      02:58 ?        00:00:00 /usr/sbin/apache
5 S www-data  3832  3816  0  81   0 -  4641 -      02:58 ?        00:00:00 /usr/sbin/apache
4 S root      3835     1  0  76   0 -   376 322431 02:58 tty1     00:00:00 /sbin/getty 38400 tty1
4 S root      3839     1  0  77   0 -   376 322431 02:58 tty2     00:00:00 /sbin/getty 38400 tty2
4 S root      3840     1  0  76   0 -   374 322431 02:58 tty3     00:00:00 /sbin/getty 38400 tty3
4 S root      3841     1  0  77   0 -   374 322431 02:58 tty4     00:00:00 /sbin/getty 38400 tty4
4 S root      3842     1  0  76   0 -   374 322431 02:58 tty5     00:00:00 /sbin/getty 38400 tty5
4 S root      3843     1  0  77   0 -   374 322431 02:58 tty6     00:00:00 /sbin/getty 38400 tty6
4 S root      4171  3795  0  76   0 -   757 wait   02:58 pts/0    00:00:00 -bash
5 S root      4541  3750  0  75   0 -  3654 -      02:59 ?        00:00:00 sshd: root@pts/1
4 S root      4544  4541  0  77   0 -   753 wait   02:59 pts/1    00:00:00 -bash
4 S root      4546  4544  1  76   0 -  8297 wait   02:59 pts/1    00:00:04 dselect
4 S root      4561  4546  0  75   0 -   690 wait   03:01 pts/1    00:00:00 /bin/bash /usr/lib/dpkg/methods/apt/install /var/lib/dpkg apt apt
4 D root      4710  4561  0  81   0 -  5304 -      03:01 pts/1    00:00:00 /usr/bin/dpkg --admindir=/var/lib/dpkg --configure -a
5 S root      4711  3783  0  78   0 -   512 pipe_w 03:02 ?        00:00:00 /USR/SBIN/CRON
4 S logcheck  4712  4711  0  78   0 -   675 wait   03:02 ?        00:00:00 /bin/sh -c    if [ -x /usr/sbin/logcheck ]; then nice -n10 /usr/sbin/logcheck; fi
0 S logcheck  4713  4712  0  86  10 -   698 wait   03:02 ?        00:00:00 /bin/bash /usr/sbin/logcheck
0 D logcheck  4717  4713  0  90  10 -   375 start_ 03:02 ?        00:00:00 lockfile-create --retry 1 /var/lock/logcheck
4 R root      4726  4171  0  78   0 -   625 -      03:03 pts/0    00:00:00 ps -edalf

