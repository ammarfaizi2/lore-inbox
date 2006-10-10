Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWJJWRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWJJWRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbWJJWRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:17:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:5518 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030588AbWJJWRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:17:37 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:17:15 -0700
Message-Id: <1160518635.28299.1.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 00:09 -0700, Andrew Morton wrote: 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/


I hate to report always failures, I hope you don't hate me
for that :)

My EM64T box doesn't boot -mm1. Seems like IRQ problem ?

Thanks,
Badari

Linux version 2.6.19-rc1-mm1-smp (root@elm3a241) (gcc version 4.1.1 20060612 (Red Hat 4.1.1-3)) #2 SMP Tue Oct 10 10:37:46 PDT 2006
Command line: ro root=/dev/VolGroup00/LogVol00 console=tty0 console=ttyS0,38400 rhgb verbose
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d7fcca80 (usable)
 BIOS-e820: 00000000d7fcca80 - 00000000d7fd0000 (ACPI data)
 BIOS-e820: 00000000d7fd0000 - 00000000d8000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
end_pfn_map = 1212416
DMI 2.3 present.
  >>> ERROR: Invalid checksum
No NUMA configuration found
Faking a node at 0000000000000000-0000000128000000
Bootmem setup node 0 0000000000000000-0000000128000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1212416
early_node_map[3] active PFN ranges
    0:        0 ->      157
    0:      256 ->   884684
    0:  1048576 ->  1212416
Intel MultiProcessor Specification v1.4
MPTABLE: OEM ID: IBM ENSW MPTABLE: Product ID: x346 SMP     MPTABLE: APIC at: 0xFEE00000
Processor #0 (Bootup-CPU)
Processor #6
I/O APIC #14 at 0xFEC00000.
I/O APIC #13 at 0xFEC84000.
I/O APIC #12 at 0xFEC84400.
I/O APIC #11 at 0xFEC80000.
I/O APIC #10 at 0xFEC80400.
Setting APIC routing to physical flat
Processors: 2
Nosave address range: 000000000009d000 - 000000000009e000
Nosave address range: 000000000009e000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 00000000d7fcc000 - 00000000d7fcd000
Nosave address range: 00000000d7fcd000 - 00000000d7fd0000
Nosave address range: 00000000d7fd0000 - 00000000d8000000
Nosave address range: 00000000d8000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at dc000000 (gap: d8000000:26c00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 50432 bytes of per cpu data
Built 1 zonelists.  Total pages: 1019681
Kernel command line: ro root=/dev/VolGroup00/LogVol00 console=tty0 console=ttyS0,38400 rhgb verbose
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
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
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x1675000 - 0x5675000
Memory: 4004408k/4849664k available (2714k kernel code, 189292k reserved, 2094k data, 328k init)
Calibrating delay using timer specific routine.. 6014.59 BogoMIPS (lpj=12029192)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
lockdep: not fixing up alternatives.
Using local APIC timer interrupts.
result 12500678
Detected 12.500 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x6
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.53 BogoMIPS (lpj=12001079)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 1/6 -> Node 0
CPU: Physical Processor ID: 3
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Brought up 2 CPUs
testing NMI watchdog ... OK.
time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
time.c: Detected 3000.178 MHz processor.
migration_cost=1820
checking if image is initramfs... it is
Freeing initrd memory: 1743k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
ACPI: Interpreter disabled.
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI quirk: region 0580-05ff claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0400-043f claimed by ICH4 GPIO
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:1d.7[D] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
PCI->APIC IRQ transform: 0000:05:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:06:00.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:08:07.0[A] -> IRQ 27
PCI->APIC IRQ transform: 0000:08:07.1[B] -> IRQ 24
PCI->APIC IRQ transform: 0000:01:06.0[A] -> IRQ 20
PCI-GART: No AMD northbridge found.
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: dd000000-deffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: db000000-dcffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:07:00.0
  IO window: 4000-4fff
  MEM window: d9000000-daffffff
  PREFETCH window: df000000-df0fffff
PCI: Bridge: 0000:07:00.2
  IO window: 5000-ffff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: 4000-ffff
  MEM window: d9000000-daffffff
  PREFETCH window: df000000-df0fffff
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-3fff
  MEM window: f8000000-f8ffffff
  PREFETCH window: f0000000-f7ffffff
PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Probably buggy MP table.
PCI: No IRQ known for interrupt pin A of device 0000:00:04.0. Probably buggy MP table.
PCI: No IRQ known for interrupt pin A of device 0000:00:05.0. Probably buggy MP table.
PCI: No IRQ known for interrupt pin A of device 0000:00:06.0. Probably buggy MP table.
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 65536 (order: 9, 3670016 bytes)
TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1160515309.208:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcie_portdrv_probe->Dev[3595:8086] has invalid IRQ. Check vendor BIOS
pcie_portdrv_probe->Dev[3597:8086] has invalid IRQ. Check vendor BIOS
pcie_portdrv_probe->Dev[3598:8086] has invalid IRQ. Check vendor BIOS
pcie_portdrv_probe->Dev[3599:8086] has invalid IRQ. Check vendor BIOS
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
tg3.c:v3.66 (September 23, 2006)
eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:11:25:8f:60:06
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]
eth1: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:11:25:8f:60:07
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[1]
eth1: dma_rwctrl[76180000] dma_mask[64-bit]
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
scsi 1:0:0:0: Direct-Access     IBM-ESXS MAP3367NC     FN C101 PQ: 0 ANSI: 3
 target1:0:0: asynchronous
scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
 target1:0:0: Beginning Domain Validation
 target1:0:0: wide asynchronous
 target1:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI PCOMP (6.25 ns, offset 127)
 target1:0:0: Ending Domain Validation
scsi 1:0:2:0: Direct-Access     IBM-ESXS MAP3367NC     FN C101 PQ: 0 ANSI: 3
 target1:0:2: asynchronous
scsi1:A:2:0: Tagged Queuing enabled.  Depth 32
 target1:0:2: Beginning Domain Validation
 target1:0:2: wide asynchronous
 target1:0:2: FAST-160 WIDE SCSI 320.0 MB/s DT IU RTI PCOMP (6.25 ns, offset 127)
 target1:0:2: Ending Domain Validation
scsi 1:0:8:0: Processor         IBM      25R5170a S320  0 1    PQ: 0 ANSI: 2
 target1:0:8: asynchronous
 target1:0:8: Beginning Domain Validation
 target1:0:8: Ending Domain Validation
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
 sda: sda1 sda2
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
sd 1:0:2:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:2:0: Attached scsi generic sg1 type 0
scsi 1:0:8:0: Attached scsi generic sg2 type 3
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
NET: Registered protocol family 1
Freeing unused kernel memory: 328k freed
Write protecting the kernel read-only data: 565k
input: AT Translated Set 2 keyboard as /class/input/input1
Red Hat nash version 5.0.41 starting
Mounting proc filesystem
Mounting sysfs filesystem
Creating /dev
Creating initial device nodes
Setting up hotplug.
input: PS/2 Generic Mouse as /class/input/input2
Creating block device nodes.
Loading ide-core.ko module
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Loading ide-disk.ko module
Loading dm-mod.ko module
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
Loading dm-mirror.ko module
Loading dm-zero.ko module
Loading dm-snapshot.ko module
Making device-mapper control node
Scanning logical volumes
  Reading all physical volumes.  This may take a while...
  Found volume group "VolGroup00" using metadata type lvm2
Activating logical volumes
  2 logical volume(s) in volume group "VolGroup00" now active
Creating root device.
Mounting root filesystem.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Setting up other filesystems.
Setting up new root fs
no fstab.sys, mounting internal defaults
Switching to new root and running init.
unmounting old /dev
unmounting old /proc
unmounting old /proc/bus/usb
ERROR unmounting old /proc/bus/usb: No such file or directory
forcing unmount of /proc/bus/usb
unmounting old /sys
INIT: version 2.86 booting
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
                Welcome to Red Hat Enterprise Linux
                Press 'I' to enter interactive startup.
warning: process `date' used the removed sysctl system call
Setting clock  (utc): Tue Oct 10 14:22:36 PDT 2006 [  OK  ]
Starting udev: udevd[539]: add_to_rules: unknown key 'MODALIAS'
udevd[539]: add_to_rules: unknown key 'MODALIAS'
udevd[539]: add_to_rules: unknown key 'MODALIAS'
[  OK  ]
Setting hostname elm3a241:  [  OK  ]
Setting up Logical Volume Management:   2 logical volume(s) in volume group "VolGroup00" now active
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/VolGroup00/LogVol00
/dev/VolGroup00/LogVol00: clean, 454331/8339520 files, 6170765/8339456 blocks
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sda1
/boot: clean, 67/26104 files, 101516/104388 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling local swap partitions:  swapon: /dev/dm-1: Device or resource busy
                                                                           [FAILED]
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting readahead_early:  Starting background readahead: [  OK  ]
[  OK  ]
FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.19-rc1-mm1-smp/kernel/arch/x86_64/kernel/cpufreq/acpi-cpufreq.ko): No such device
Applying ip6tables firewall rules: [  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting irqbalance: [  OK  ]
Starting portmap: [  OK  ]
Starting NFS statd: [  OK  ]
Starting RPC idmapd: [  OK  ]
Starting system message bus: [  OK  ]
[  OK  ] Bluetooth services:[  OK  ]
Mounting other filesystems:  [  OK  ]
Starting hidd: [  OK  ]
Loading autofs4: [  OK  ]
Starting automount: [  OK  ]
Starting smartd: [  OK  ]
Starting hpiod: [  OK  ]
Starting hpssd: [  OK  ]
Starting cups: [  OK  ]
Starting sshd: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting anacron: [  OK  ]
Starting atd: [  OK  ]
Starting yum-updatesd: [  OK  ]
Starting Avahi daemon: do_IRQ: 0.57 No irq handler for vector


