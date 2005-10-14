Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVJNV67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVJNV67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 17:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVJNV67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 17:58:59 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:4984 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750927AbVJNV66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 17:58:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer;
        b=AVfQULt//mpwjPbOXF1Qw5zszTPzgB7irp+QShmV4nZ0fboqBFBW+j2WvT6h+MhkubpyRu+OOGWqeSr2yxyaZl4O1Qwy2rPeIFhKAF2qTT3UQV3oO19tKmvCx5BGTsHh7U9Tg36hNIbWN8XZ+8E69ENKp+26kUvsnhJziiZh36Q=
Subject: 2.6.14-rc4-rt5 problems
From: Badari Pulavarty <pbadari@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <E1EQX5p-0001QE-RS@localhost.localdomain>
References: <E1EQX5p-0001QE-RS@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-OaCBTSDwVpdij6JLiiVQ"
Date: Fri, 14 Oct 2005 14:58:19 -0700
Message-Id: <1129327099.6266.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OaCBTSDwVpdij6JLiiVQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Having boot problems on 2.6.14-rc4-rt5 on my amd64 box.

I get "NMI Watchdog detected LOCKUP"s. Do I need to disable
that ?

Here is the console log.

Thanks,
Badari



--=-OaCBTSDwVpdij6JLiiVQ
Content-Disposition: attachment; filename=amd64.log
Content-Type: text/x-log; name=amd64.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bootdata ok (command line is root=/dev/hda2 vga=0x314 selinux=0 splash=silent console=tty0 console=ttyS0,38400 resume=/dev/hda1 profile=2)
Linux version 2.6.14-rc4-rt5 (root@elm3b29) (gcc version 3.3.3 (SuSE Linux)) #1 SMP PREEMPT Fri Oct 14 16:27:34 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfef0000 (usable)
 BIOS-e820: 00000000dfef0000 - 00000000dfeff000 (ACPI data)
 BIOS-e820: 00000000dfeff000 - 00000000dff00000 (ACPI NVS)
 BIOS-e820: 00000000dff00000 - 00000000e0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001e0000000 (usable)
Scanning NUMA topology in Northbridge 24
Number of nodes 4
Node 0 MemBase 0000000000000000 Limit 000000017fffffff
Node 1 MemBase 0000000180000000 Limit 000000019fffffff
Node 2 MemBase 00000001a0000000 Limit 00000001bfffffff
Node 3 MemBase 00000001c0000000 Limit 00000001dfffffff
Using node hash shift of 21
Bootmem setup node 0 0000000000000000-000000017fffffff
Bootmem setup node 1 0000000180000000-000000019fffffff
Bootmem setup node 2 00000001a0000000-00000001bfffffff
Bootmem setup node 3 00000001c0000000-00000001dfffffff
ACPI: PM-Timer IO Port: 0x8008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfa3e0000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xfa3e0000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xfa3e1000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xfa3e1000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xfa3e2000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xfa3e2000, GSI 32-35
ACPI: IOAPIC (id[0x08] address[0xfa3e4000] gsi_base[36])
IOAPIC[4]: apic_id 8, version 17, address 0xfa3e4000, GSI 36-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 4 zonelists
Kernel command line: root=/dev/hda2 vga=0x314 selinux=0 splash=silent console=tty0 console=ttyS0,38400 resume=/dev/hda1 profile=2
kernel profiling enabled (shift: 2)
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1398.210 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 7144236k/7864320k available (3074k kernel code, 195344k reserved, 1646k data, 232k init)
WARNING: swapper/0 changed soft IRQ-flags.

Call Trace:<ffffffff8016a618>{__alloc_pages+1048} <ffffffff8016d506>{cache_grow+294}
       <ffffffff8016d99e>{cache_alloc_refill+414} <ffffffff8016dba5>{kmem_cache_alloc+149}
       <ffffffff8016ebe6>{kmem_cache_create+310} <ffffffff806a5ace>{kmem_cache_init+318}
       <ffffffff8069070f>{start_kernel+351} <ffffffff80690240>{_sinittext+576}
       
Calibrating delay using timer specific routine.. 2801.67 BogoMIPS (lpj=5603344)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.484 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 2796.59 BogoMIPS (lpj=5593189)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
Opteron MP w/ 1MB stepping 00
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 982 cycles)
softlockup thread 1 started up.
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 2796.64 BogoMIPS (lpj=5593296)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2 -> Core 0
Opteron MP w/ 1MB stepping 00
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 981 cycles)
softlockup thread 2 started up.
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 2796.61 BogoMIPS (lpj=5593227)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3 -> Core 0
Opteron MP w/ 1MB stepping 00
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff 3 cycles, maxerr 1612 cycles)
Brought up 4 CPUs
softlockup thread 3 started up.
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
ACPI: PCI Root Bridge [PCI1] (0000:08)
PCI: Probing PCI hardware (bus 08)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
PCI: Bridge: 0000:00:06.0
  IO window: 2000-2fff
  MEM window: fa000000-fa0fffff
  PREFETCH window: e2000000-e20fffff
PCI: Bridge: 0000:09:01.0
  IO window: disabled.
  MEM window: fa400000-faffffff
  PREFETCH window: fc000000-fdffffff
PCI: Bridge: 0000:08:01.0
  IO window: disabled.
  MEM window: fa400000-faffffff
  PREFETCH window: fc000000-fdffffff
PCI: Bridge: 0000:08:02.0
  IO window: 3000-3fff
  MEM window: fb000000-fb0fffff
  PREFETCH window: e2100000-e21fffff
PCI: Bridge: 0000:08:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:08:04.0
  IO window: 4000-4fff
  MEM window: fb100000-fb1fffff
  PREFETCH window: e2200000-e22fffff
ACPI: PCI Interrupt 0000:08:04.0[A] -> GSI 36 (level, low) -> IRQ 16
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1129348787.792:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
JFS: nTxBlock = 8192, nTxLock = 65536
Initializing Cryptographic API
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
vesafb: framebuffer at 0xfc000000, mapped to 0xffffc20000700000, using 1875k, total 16384k
vesafb: mode is 800x600x16, linelength=1600, pages=16
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
mtrr: type mismatch for fc000000,1000000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,800000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,400000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,200000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,100000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,80000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,40000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,20000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,10000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,8000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,4000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,2000 old: write-back new: write-combining
mtrr: type mismatch for fc000000,1000 old: write-back new: write-combining
vesafb: Mode is not VGA compatible
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
tg3.c:v3.42 (Oct 3, 2005)
ACPI: PCI Interrupt 0000:19:02.0[A] -> GSI 38 (level, low) -> IRQ 17
eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:f0:f9:aa
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
eth0: dma_rwctrl[76ff000f]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L080AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
input: PS/2 Generic Mouse on isa0060/serio1
TCP established hash table entries: 32768 (order: 9, 2883584 bytes)
TCP bind hash table entries: 32768 (order: 9, 2621440 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 232k freed
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
fsck 1.35 (28-Feb-2004)
[/sbin/fsck.reiserfs (1) -- /] fsck.reiserfs -a /dev/hda2 
Reiserfs super block in block 16 on 0x302 of format 3.6 with standard journal
Blocks (total/free): 19842352/8993990 by 4096 bytes
Filesystem is clean
Filesystem seems mounted read-only. Skipping journal replay.
Checking internal tree..finished
7[?25l[1A[80C[10D[1;32mdone[m8[?25h[m[?25hmd: raidstart(pid 1371) used deprecated START_ARRAY ioctl. This will not be supported beyond 2.6
md: could not open unknown-block(8,224).
md: autostart failed!
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Initializing Multiple Devices...
considering /dev/md0...
handling MD device /dev/md0
analyzing super-block
couldn't open device /dev/sdo -- No such device or address
mkraidevice-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
d: aborted.
(In addition to the above messages, see the syslog and /proc/mdstat as well
 for potential clues.)
/dev/md0: Invalid argument
Activating device mapper...
Creating /dev/mapper/control character device with major:10 minor:63.
7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hScanning for LVM volume groups...
  Reading all physical volumes.  This may take a while...
  No volume groups found
Activating LVM volume groups...
  No volume groups found
7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
Checking file systems...
fsck 1.35 (28-Feb-2004)
Checking all file systems.
7[?25l[1A[80C[10D[1;32mdone[m8[?25hSetting up7[?25l[80C[10D[1;32mdone[m8[?25h
Mounting local file systems...
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
tmpfs on /dev/shm type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
mount: fs type subfs not supported by kernel
mount: fs type subfs not supported by kernel
7[?25l[1A[80C[10D[1;31mfailed[m8[?25h[m[?25h[m[?25hLoading required kernel modules
7[?25l[1A[80C[10D[1;32mdone[m8[?25hRestore device permissions7[?25l[80C[10D[1;32mdone[m8[?25h
Setting up the CMOS clock7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25h[m[?25hActivating remaining swap-devices in /etc/fstab...
Adding 1048784k swap on /dev/hda1.  Priority:42 extents:1 across:1048784k
7[?25l[1A[80C[10D[1;32mdone[m8[?25h[m[?25hChecking quotas. This may take some time.
Turning quota on
7[?25l[80C[10D[1;32mdone[m8[?25h
Setting up timezone data7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hSetting scheduling timeslices 7[?25l[80C[10D[1munused[m8[?25h
Setting current sysctl status from /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.rp_filter = 1
7[?25l[80C[10D[1;32mdone[m8[?25h
Setting up hostname 'elm3b29'7[?25l[80C[10D[1;32mdone[m8[?25h
Setting up loopback interface     lo       
    lo        IP address: 127.0.0.1/8   
7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hEnabling syn flood protection[80C[10D[1;32mdone[m
Disabling IP forwarding7[?25l[80C[10D[1;32mdone[m8[?25h
7[?25l[80C[10D[1;32mdone[m8[?25h
Creating /var/log/boot.msg
7[?25l[1A[80C[10D[1;32mdone[m8[?25hshowconsole: Warning: the ioctl TIOCGDEV is not known by the kernel
[m[?25hSystem Boot Control: The system has been [80C[10D[1mset up[m
Skipped features: [80C[28D[1;33mboot.cycle boot.sched[m
System Boot Control: Running /etc/init.d/boot.local
7[?25l[1A[80C[10D[1;32mdone[m8[?25hINIT: Entering runlevel: 5
Boot logging started on /dev/ttyS0(/dev/console) at Fri Oct 14 21:00:20 2005
Master Resource Control: previous runlevel: N, switching to runlevel: [80C[10D[1m5[m
Hotplug is already active  (disable with  NOHOTPLUG=1 at the boot prompt)7[?25l[80C[10D[1;32mdone[m8[?25h
Initializing random number generator7[?25l[80C[10D[1;32mdone[m8[?25h
Starting irqbalance 7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hcoldplug scanning input: ***7[?25l[80C[10D[1;32mdone[m8[?25h
         scanning pci: **.******************hw_random: AMD768 system management I/O registers at 0x8000.
hw_random hardware driver 1.0.0 loaded
****W*W*W*W*W**.7[?25l[80C[10D[1;32mdone[m8[?25h
         scanning usb: usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 18
7[?25l[80C[ohci_hcd 0000:01:00.0: OHCI Host Controller
10D[1;32mdone[m8[?25h
         .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:00.0: irq 18, io mem 0xfa000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
QLogic Fibre Channel HBA Driver
qla2200: Unknown symbol qla2x00_remove_one
qla2200: Unknown symbol qla2x00_probe_one
modprobe: FATAL: Error inserting qla2200 (/lib/modules/2.6.14-rc4-rt5/kernel/drivers/scsi/qla2xxx/qla2200.ko): Unknown symbol in module, or unknown parameter (see dmesg)

modprobe: FATAL: Module qlogicfc not found.

ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 18
ohci_hcd 0000:01:00.1: OHCI Host Controller
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.1: irq 18, io mem 0xfa001000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 16 (level, low) -> IRQ 19
qla2200 0000:01:04.0: Found an ISP2200, irq 19, iobase 0xffffc20000aac000
qla2200 0000:01:04.0: Configuring PCI space...
qla2200 0000:01:04.0: Configure NVRAM parameters...
qla2200 0000:01:04.0: Verifying loaded RISC code...
Setting up network interfaces:
    lo       
qla2200 000    lo        0:01:04.0: LIP reset occured (f725).
IP address: 127.0.0.1/8   
qla2200 0000:01:04.0: Waiting for LIP to complete...
7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0      device: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
    eth0      configuration: eth-id-00:04:76:f0:f9:aa
qla2200 0000:01:04.0: LIP occured (f725).
qla2200 0000:01:04.0: LOOP UP detected (1 Gbps).
qla2200 0000:01:04.0: Topology - (Loop), Host Loop address 0x7d
scsi0 : qla2xxx
qla2200 0000:01:04.0: 
 QLogic Fibre Channel HBA Driver: 8.01.00-k
  QLogic QLA22xx - 
  ISP2200: PCI (33 MHz) @ 0000:01:04.0 hdma+, host#=0, fw=2.02.08 TP
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 20
qla2200 0000:01:05.0: Found an ISP2200, irq 20, iobase 0xffffc20000aae000
qla2200 0000:01:05.0: Configuring PCI space...
SCSI device sda: drive cache: write through
qla2200 0000:01:05.0: Configure NVRAM parameters...
qla2200 0000:01:05.0: Verifying loaded RISC code...
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write through
 sda: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
qla2200 0000:01:05.0: LIP reset occured (f71f).
qla2200 0000:01:05.0: Waiting for LIP to complete...
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
    eth0      IP address: 9.47.67.29/24   
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
qla2200 0000:01:05.0: LIP occured (f71f).
qla2200 0000:01:05.0: LOOP UP detected (1 Gbps).
qla2200 0000:01:05.0: Topology - (Loop), Host Loop address 0x7d
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdc: drive cache: write through
SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdc: drive cache: write through
 sdc: unknown partition table
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
  Vendor: SEAGATE   Model: <6>scsi1 : qla2xxx
qla2200 0000:01:05.0: 
 QLogic Fibre Channel HBA Driver: 8.01.00-k
  QLogic QLA22xx - 
  ISP2200: PCI (33 MHz) @ 0000:01:05.0 hdma+, host#=1, fw=2.02.08 TP
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdd: drive cache: write through
ST318304FC        Rev: FA17
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
  Type:   Direct-Access     <7>Losing some ticks... checking if CPU frequency changed.
                 ANSI SCSI revision: 03
SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
ACPI: PCI Interrupt 0000:19:01.0[A] -> <5>SCSI device sde: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sde: drive cache: write through
SCSI device sdd: drive cache: write through
 sdd:GSI 37 (level, low) -> IRQ 21
 unknown partition table
SCSI device sde: 35566480 512-byte hdwr sectors (18210 MB)
Attached scsi disk sdd at scsi1, channel 0, id 0, lun 0
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdf: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdf: drive cache: write through
qla2200 0000:19:01.0: Found an ISP2200, irq 21, iobase 0xffffc20000ab0000
SCSI device sde: drive cache: write through
 sde:<5>SCSI device sdf: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdf: drive cache: write through
 sdf: unknown partition table
Attached scsi disk sde at scsi0, channel 0, id 3, lun 0
 unknown partition table
Attached scsi disk sdf at scsi1, channel 0, id 1, lun 0
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdg: 35566480 512-byte hdwr sectors (18210 MB)
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdg: drive cache: write through
SCSI device sdh: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdh: drive cache: write through
SCSI device sdg: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdg: drive cache: write through
 sdg:<5>SCSI device sdh: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdh: drive cache: write through
 sdh: unknown partition table
Attached scsi disk sdg at scsi0, channel 0, id 4, lun 0
 unknown partition table
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdi: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdi: drive cache: write through
Attached scsi disk sdh at scsi1, channel 0, id 2, lun 0
SCSI device sdi: 35566480 512-byte hdwr sectors (18210 MB)
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdi: drive cache: write through
 sdi:<5>SCSI device sdj: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdj: drive cache: write through
 unknown partition table
SCSI device sdj: 35566480 512-byte hdwr sectors (18210 MB)
Attached scsi disk sdi at scsi0, channel 0, id 5, lun 0
  Vendor: IBM-PSG   Model: ST318304FC    !#  Rev: B333
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdj: drive cache: write through
 sdj:<5>SCSI device sdk: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sdk: drive cache: write back
 unknown partition table
Attached scsi disk sdj at scsi1, channel 0, id 3, lun 0
SCSI device sdk: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sdk: drive cache: write back
 sdk:<5>  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdl: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdl: drive cache: write through
 unknown partition table
Attached scsi disk sdk at scsi0, channel 0, id 6, lun 0
SCSI device sdl: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdl: drive cache: write through
 sdl:<5>  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdm: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdm: drive cache: write through
 unknown partition table
Attached scsi disk sdl at scsi1, channel 0, id 4, lun 0
SCSI device sdm: 35566480 512-byte hdwr sectors (18210 MB)
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdm: drive cache: write through
 sdm:<5>SCSI device sdn: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdn: drive cache: write through
 unknown partition table
Attached scsi disk sdm at scsi0, channel 0, id 7, lun 0
SCSI device sdn: 35566480 512-byte hdwr sectors (18210 MB)
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdn: drive cache: write through
 sdn:<5>SCSI device sdo: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdo: drive cache: write through
 unknown partition table
Attached scsi disk sdn at scsi1, channel 0, id 5, lun 0
  Vendor: SEAGATE   Model: ST318304FC        Rev: FA17
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdo: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdp: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdo: drive cache: write through
 sdo:<5>SCSI device sdp: drive cache: write through
 unknown partition table
Attached scsi disk sdo at scsi0, channel 0, id 8, lun 0
SCSI device sdp: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sdp: drive cache: write through
 sdp: unknown partition table
  Vendor: IBM       Model: EXP500            Rev: 9150
  Type:   Enclosure                          ANSI SCSI revision: 02
Attached scsi disk sdp at scsi1, channel 0, id 6, lun 0
  Vendor: IBM       Model: EXP500            Rev: 9150
  Type:   Enclosure                          ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
qla2200 0000:19:01.0: Configuring PCI space...
qla2200 0000:19:01.0: Configure NVRAM parameters...
qla2200 0000:19:01.0: Verifying loaded RISC code...
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 0
qla2200 0000:19:01.0: Waiting for LIP to complete...
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg4 at scsi0, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg5 at scsi1, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg6 at scsi0, channel 0, id 4, lun 0,  type 0
Attached scsi generic sg7 at scsi1, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg8 at scsi0, channel 0, id 5, lun 0,  type 0
Attached scsi generic sg9 at scsi1, channel 0, id 3, lun 0,  type 0
Attached scsi generic sg10 at scsi0, channel 0, id 6, lun 0,  type 0
Attached scsi generic sg11 at scsi1, channel 0, id 4, lun 0,  type 0
Attached scsi generic sg12 at scsi0, channel 0, id 7, lun 0,  type 0
Attached scsi generic sg13 at scsi1, channel 0, id 5, lun 0,  type 0
Attached scsi generic sg14 at scsi0, channel 0, id 8, lun 0,  type 0
Attached scsi generic sg15 at scsi0, channel 0, id 9, lun 0,  type 13
Attached scsi generic sg16 at scsi1, channel 0, id 6, lun 0,  type 0
Attached scsi generic sg17 at scsi1, channel 0, id 7, lun 0,  type 13
7[?25l[1A[80C[10D[1;32mdone[m8[?25hSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hStarting syslog services7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hStarting RPC portmap daemon7[?25l[80C[10D[1;32mdone[m8[?25h
Starting resource manager7[?25l[80C[10D[1;32mdone[m8[?25h
Starting slpd 7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hst: Version 20050830, fixed bufsize 32768, s/g segs 256
Importing Net File System (NFS)[80C[10D[1munused[m
Starting nfsboot (sm-notify) program hwscan is using a deprecated SCSI ioctl, please convert it to SG_IO
7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hIA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
ACPI: PCI Interrupt 0000:0f:01.0[A] -> GSI 29 (level, low) -> IRQ 22
qla2300 0000:0f:01.0: Found an ISP2312, irq 22, iobase 0xffffc20000ab2000
qla2300 0000:0f:01.0: Configuring PCI space...
qla2300 0000:0f:01.0: Configure NVRAM parameters...
microcode: CPU1 not a capable Intel processor
microcode: CPU0 not a capable Intel processor
microcode: CPU2 not a capable Intel processor
modprobe/8006[CPU#1]: BUG in __cache_alloc at mm/slab.c:2183

Call Trace: <IRQ> <ffffffff80138052>{__WARN_ON+114} <ffffffff8016da7d>{__kmalloc+125}
       <ffffffff802b7d98>{soft_cursor+120} <ffffffff802b007c>{bit_cursor+1180}
       <ffffffff802ab6ae>{fbcon_cursor+718} <ffffffff802e5531>{hide_cursor+33}
       <ffffffff802e5803>{vt_console_print+179} <ffffffff8013749c>{__call_console_drivers+76}
       <ffffffff80137767>{release_console_sem+295} <ffffffff80137f04>{vprintk+708}
       <ffffffff80137fcd>{printk+141} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff880c5040>{:microcode:collect_cpu_info+0} <ffffffff8011ac78>{unmask_IO_APIC_irq+40}
88057ea0>{:qla2xxx:qla2x00_nvram_config+144}
       <ffffffff8805a4b6>{:qla2xxx:qla2x00_initialize_adapter+246}
       <ffffffff88056362>{:qla2xxx:qla2x00_probe_one+3106}
       <ffffffff80133a8f>{set_cpus_allowed+367} <ffffffff803f0033>{cache_check+931}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff802a57dc>{pci_device_probe+252}
       <ffffffff802fc6bf>{driver_probe_device+79} <ffffffff802fc76c>{__driver_attach+60}
       <ffffffff802fc730>{__driver_attach+0} <ffffffff802fc089>{bus_for_each_dev+73}
       <ffffffff802fbab8>{bus_add_driver+136} <ffffffff802a5502>{pci_register_driver+146}
       <ffffffff801593be>{sys_init_module+206} <ffffffff8010de8e>{system_call+126}
       
modprobe/8006[CPU#1]: BUG in __cache_alloc at mm/slab.c:2183

release_console_sem+295} <ffffffff80137f04>{vprintk+708}
       <ffffffff80137fcd>{printk+141} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff880c5040>{:microcode:collect_cpu_info+0} <ffffffff8011ac78>{unmask_IO_APIC_irq+40}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff80162458>{__do_IRQ+296}
       <ffffffff80118919>{smp_call_function_interrupt+73} <ffffffff8010eb8c>{call_function_interrupt+132}
        <EOI> <ffffffff8029c9f8>{__delay+8} <ffffffff880659f6>{:qla2xxx:qla2x00_get_nvram_word+86}
       <ffffffff88065edc>{:qla2xxx:qla2x00_read_nvram_data+76}
       <ffffffff88057ea0>{:qla2xxx:qla2x00_nvram_config+144}
       <ffffffff8805a4b6>{:qla2xxx:qla2x00_initialize_adapter+246}
       <ffffffff88056362>{:qla2xxx:qla2x00_probe_one+3106}
       <ffffffff80133a8f>{set_cpus_allowed+367} <ffffffff803f0033>{cache_check+931}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff802a57dc>{pci_device_probe+252}
e>{sys_init_module+206} <ffffffff8010de8e>{system_call+126}
       
modprobe/8006[CPU#1]: BUG in kfree at mm/slab.c:2642

Call Trace: <IRQ> <ffffffff80138052>{__WARN_ON+114} <ffffffff8016cc3e>{kfree+366}
       <ffffffff802b7edb>{soft_cursor+443} <ffffffff802b007c>{bit_cursor+1180}
       <ffffffff802b007c>{bit_cursor+1180} <ffffffff802ab6ae>{fbcon_cursor+718}
       <ffffffff802aee1a>{fbcon_scroll+154} <ffffffff802e568b>{scrup+123}
       <ffffffff802e572c>{lf+28} <ffffffff802e58cf>{vt_console_print+383}
       <ffffffff8013749c>{__call_console_drivers+76} <ffffffff80137767>{release_console_sem+295}
       <ffffffff80137f04>{vprintk+708} <ffffffff80137fcd>{printk+141}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff880c5040>{:microcode:collect_cpu_info+0}
     <ffffffff8805a4b6>{:qla2xxx:qla2x00_initialize_adapter+246}
       <ffffffff88056362>{:qla2xxx:qla2x00_probe_one+3106}
       <ffffffff80133a8f>{set_cpus_allowed+367} <ffffffff803f0033>{cache_check+931}
Checking/updating CPU microcode7[?25l[80C[10D[1;32mdone[m8[?25h
Starting sound driver7[?25l[80C[10D[1;32mdone[m8[?25h
Starting cupsd7[?25l[80C[10D[1;32mdone[m8[?25h
Starting SSH daemon7[?25l[80C[10D[1;32mdone[m8[?25h
Starting ldap-server7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hStarting mail service (Postfix)7[?25l[80C[10D[1;32mdone[m8[?25h
loading ACPI modules (ac battery button fan processor thermal ) Starting powersaved 7[?25l[80C[10D[1;32mdone[m8[?25h
Loading keymap qwerty/us.map.gz
7[?25l[1A[80C[10D[1;32mdone[m8[?25hLoading compose table winkeys shiftctrl latin1.add7[?25l[80C[10D[1;32mdone[m8[?25h
Start Unicode mode
7[?25l[1A[80C[10D[1;32mdone[m8[?25hLoading console font lat9w-16.psfu  -m trivial (K
7[?25l[1A[80C[10D[1;32mdone[m8[?25h[m[?25hStarting hardware scan on bootMount SMB/ CIFS File Systems [80C[10D[1munused[m
Starting CRON daemon7[?25l[80C[10D[1;32mdone[m8[?25h
Starting Name Service Cache Daemon7[?25l[80C[10D[1;32mdone[m8[?25h
7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hStarting service kdm7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hStarting staf: 
[m[?25hMaster Resource Control: runlevel 5 has been [80C[10D[1mreached[m
Skipped services in runlevel 5: [80C[23D[1;33mnfs splash smbfs[m
HostName: elm3b29.ibm.com
Machine name: elm3b29


Welcome to SUSE LINUX Enterprise Server 9 (x86_64) - Kernel 2.6.14-rc4-rt5 (ttyS0).


elm3b29 login: 
STAFProc version 2.6.2 initialized
NMI Watchdog detected LOCKUP on CPU 1
CPU 1 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 13, comm: softirq-timer/1 Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff803fbca1>] <ffffffff803fbca1>{.text.lock.spinlock+22}
RSP: 0018:ffff8101c164bdc0  EFLAGS: 00000086
CPU 3:
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 13610, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff801189f6>] <ffffffff801189f6>{__smp_call_function+118}
RSP: 0018:ffff81017e01fe38  EFLAGS: 00000297
RAX: 0000000000000002 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000040 RDI: 0f0f0f0f0f0f0f0f
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: 0000ffff0000ffff R11: 00ff00ff00ff00ff R12: ffffffff8018abe0
R13: 0000000000000000 R14: ffffffff8018abe0 R15: 00000000ffffffff
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fd00(0000) knlGS:0000000056d62bb0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaadd0c68 CR3: 000000017e0c1000 CR4: 00000000000006e0

Call Trace: <NMI>  <EOE> <ffffffff8018abe0>{invalidate_bh_lru+0}
       <ffffffff80118aef>{smp_call_function+63} <ffffffff8018bb6b>{invalidate_bdev+43}
       <ffffffff8019112e>{kill_bdev+14} <ffffffff801913ca>{blkdev_put+90}
       <ffffffff8018a112>{__fput+178} <ffffffff80186e1e>{filp_close+110}
       <ffffffff80186ee0>{sys_close+160} <ffffffff8010de8e>{system_call+126}
       
RAX: ffff8101c164bfd8 RBX: ffff81019e06dee8 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101c164a010 RDI: ffff81017e3fa768
RBP: ffff81019e06c000 R08: 0000000000000000 R09: ffff8101bfff5030
R10: 0000000000000001 R11: 0000000000000001 R12: ffff81019e06de08
R13: ffff81019e06dee0 R14: ffff81019e06c000 R15: ffff81019e06de08
FS:  00002aaaab35e4c0(0000) GS:ffffffff8066fc00(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaab26d7e8 CR3: 0000000006793000 CR4: 00000000000006e0
Process softirq-timer/1 (pid: 13, threadinfo ffff8101c164a000, task ffff8101bfff2810)
Stack: ffffffff80152487 ffff810180718ed8 ffff81017e3fa030 ffff81019e06dee0 
       ffff81019e06dee0 ffff810180716c60 ffff8101c164be98 ffff810180716cb0 
       ffffffff80152b69 ffff810180718f18 
Call Trace:<ffffffff80152487>{pick_new_owner+167} <ffffffff80152b69>{__up_mutex_waiter_nosavestate+41}
       <ffffffff80152d46>{rt_up+102} <ffffffff88056750>{:qla2xxx:qla2x00_timer+0}
       <ffffffff880568ef>{:qla2xxx:qla2x00_timer+415} <ffffffff80140da6>{run_timer_softirq+1014}
       <ffffffff8013d0fd>{ksoftirqd+237} <ffffffff8013d010>{ksoftirqd+0}
       <ffffffff8014de1b>{kthread+219} <ffffffff8010ef6a>{child_rip+8}
       <ffffffff8014dd40>{kthread+0} <ffffffff8010ef62>{child_rip+0}
       

Code: 80 3f 00 7e f9 e9 74 f9 ff ff e8 24 11 ea ff e9 9a f9 ff ff 
console shuts up ...
 <6>note: softirq-timer/1[13] exited with preempt_count 4
BUG: scheduling while atomic: softirq-timer/1/0x00000004/13
caller is do_exit+0xc3b/0xcb0

Call Trace: <NMI> <ffffffff803f847c>{__schedule+156} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8014427b>{do_notify_parent+427} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8013bacb>{do_exit+3131}
       <ffffffff8010fdeb>{die_nmi+123} <ffffffff80119d72>{nmi_watchdog_tick+338}
       <ffffffff8010fc72>{default_do_nmi+130} <ffffffff8010f0eb>{nmi+127}
       <ffffffff803fbca1>{.text.lock.spinlock+22}  <EOE> <ffffffff80152487>{pick_new_owner+167}
       <ffffffff80152b69>{__up_mutex_waiter_nosavestate+41}
       <ffffffff80152d46>{rt_up+102} <ffffffff88056750>{:qla2xxx:qla2x00_timer+0}
       <ffffffff880568ef>{:qla2xxx:qla2x00_timer+415} <ffffffff80140da6>{run_timer_softirq+1014}
       <ffffffff8013d0fd>{ksoftirqd+237} <ffffffff8013d010>{ksoftirqd+0}
       <ffffffff8014de1b>{kthread+219} <ffffffff8010ef6a>{child_rip+8}
       <ffffffff8014dd40>{kthread+0} <ffffffff8010ef62>{child_rip+0}
       
end_request: I/O error, dev sds, sector 0
printk: 8 messages suppressed.
Buffer I/O error on device sds, logical block 0
end_request: I/O error, dev sds, sector 0
end_request: I/O error, dev sdu, sector 0
end_request: I/O error, dev sdu, sector 0
end_request: I/O error, dev sdx, sector 0
end_request: I/O error, dev sdx, sector 0
CPU 2:
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0033:[<00002aaaaabf13c7>] [<00002aaaaabf13c7>]
RSP: 002b:00007fffffe06360  EFLAGS: 00000287
RAX: 00002aaaaabf169a RBX: 00002aaaaad737d0 RCX: 0000000000011002
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000011002 R08: 0000000000000006 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: 00002aaaaad96a60 R14: 00007fffffe06440 R15: 00002aaaaadc9140
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000598628 CR3: 00000001bd526000 CR4: 00000000000006e0

Call Trace: <NMI>  <EOE> <1>Unable to handle kernel paging request at 00007fffffe07000 RIP: 
<ffffffff8010f940>{show_trace+496}
PGD 1bb756067 PUD 1bf4af067 PMD 1be3ae067 PTE 0
Oops: 0000 [1] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff8010f940>] <ffffffff8010f940>{show_trace+496}
RSP: 0000:ffff8101bffe8e68  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101bea0c010 RDI: 0000000000000003
RBP: 00007fffffe07000 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: ffff8101dffebfc0 R15: ffffffff806c2100
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffe07000 CR3: 00000001bd526000 CR4: 00000000000006e0
Process hwscan (pid: 21809, threadinfo ffff8101bea0c000, task ffff81017ffd6810)
Stack: 0000000000000100 ffffffff80404d30 00000004bffe8f58 000000000000c8a1 
       ffff8101bffe8f58 0000000000000000 00002aaaaad96a60 00007fffffe06440 
       00002aaaaadc9140 ffffffff80119c67 
Call Trace: <NMI> <ffffffff80119c67>{nmi_watchdog_tick+71} <ffffffff8014572f>{notifier_call_chain+31}
       <ffffffff8010fc72>{default_do_nmi+130} <ffffffff8010f0eb>{nmi+127}
        <EOE> <1>Unable to handle kernel paging request at 00007fffffe07000 RIP: 
<ffffffff8010f940>{show_trace+496}
PGD 1bb756067 PUD 1bf4af067 PMD 1be3ae067 PTE 0
Oops: 0000 [2] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff8010f940>] <ffffffff8010f940>{show_trace+496}
RSP: 0000:ffff8101bffe8bb8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101bea0c010 RDI: 0000000000000003
RBP: 00007fffffe07000 R08: 0000000000000005 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff8101dffebfc0 R15: ffffffff806c2100
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffe07000 CR3: 00000001bd526000 CR4: 00000000000006e0
Process hwscan (pid: 21809, threadinfo ffff8101bea0c000, task ffff81017ffd6810)
Stack: 0000000000000100 ffffffff80404d30 0000000400000001 ffff8101bffe8eb8 
       000000000000000a ffff8101dffebfc0 ffff8101dffe7fc0 0000000000000000 
       ffff8101bffe8db8 ffffffff8010fac7 
Call Trace: <NMI> <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff80119c67>{nmi_watchdog_tick+71} <ffffffff8014572f>{notifier_call_chain+31}
       <ffffffff8010fc72>{default_do_nmi+130} <ffffffff8010f0eb>{nmi+127}
        <EOE> <1>Unable to handle kernel paging request at 00007fffffe07000 RIP: 
<ffffffff8010f940>{show_trace+496}
PGD 1bb756067 PUD 1bf4af067 PMD 1be3ae067 PTE 0
Oops: 0000 [3] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff8010f940>] <ffffffff8010f940>{show_trace+496}
RSP: 0000:ffff8101bffe8908  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101bea0c010 RDI: 0000000000000003
RBP: 00007fffffe07000 R08: 0000000000000005 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff8101dffebfc0 R15: ffffffff806c2100
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffe07000 CR3: 00000001bd526000 CR4: 00000000000006e0
Process hwscan (pid: 21809, threadinfo ffff8101bea0c000, task ffff81017ffd6810)
Stack: 0000000000000100 ffffffff80404d30 0000000400000001 ffff8101bffe8c08 
       000000000000000a ffff8101dffebfc0 ffff8101dffe7fc0 0000000000000000 
       ffff8101bffe8b08 ffffffff8010fac7 
Call Trace: <NMI> <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff80119c67>{nmi_watchdog_tick+71}
       <ffffffff8014572f>{notifier_call_chain+31} <ffffffff8010fc72>{default_do_nmi+130}
       <ffffffff8010f0eb>{nmi+127}  <EOE> <1>Unable to handle kernel paging request at 00007fffffe07000 RIP: 
<ffffffff8010f940>{show_trace+496}
PGD 1bb756067 PUD 1bf4af067 PMD 1be3ae067 PTE 0
Oops: 0000 [4] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff8010f940>] <ffffffff8010f940>{show_trace+496}
RSP: 0000:ffff8101bffe8658  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101bea0c010 RDI: 0000000000000003
RBP: 00007fffffe07000 R08: 0000000000000005 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000023 R14: ffff8101dffebfc0 R15: ffffffff806c2100
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffe07000 CR3: 00000001bd526000 CR4: 00000000000006e0
Process hwscan (pid: 21809, threadinfo ffff8101bea0c000, task ffff81017ffd6810)
Stack: 0000000000000100 ffffffff80404d30 0000000400000001 ffff8101bffe8958 
       000000000000000a ffff8101dffebfc0 ffff8101dffe7fc0 0000000000000000 
       ffff8101bffe8858 ffffffff8010fac7 
Call Trace: <NMI> <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff80119c67>{nmi_watchdog_tick+71} <ffffffff8014572f>{notifier_call_chain+31}
       <ffffffff8010fc72>{default_do_nmi+130} <ffffffff8010f0eb>{nmi+127}
        <EOE> <1>Unable to handle kernel paging request at 00007fffffe07000 RIP: 
<ffffffff8010f940>{show_trace+496}
PGD 1bb756067 PUD 1bf4af067 PMD 1be3ae067 PTE 0
Oops: 0000 [5] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff8010f940>] <ffffffff8010f940>{show_trace+496}
RSP: 0000:ffff8101bffe83a8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101bea0c010 RDI: 0000000000000003
RBP: 00007fffffe07000 R08: 0000000000000005 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff8101dffebfc0 R15: ffffffff806c2100
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffe07000 CR3: 00000001bd526000 CR4: 00000000000006e0
Process hwscan (pid: 21809, threadinfo ffff8101bea0c000, task ffff81017ffd6810)
Stack: 0000000000000100 ffffffff80404d30 0000000400000001 ffff8101bffe86a8 
       000000000000000a ffff8101dffebfc0 ffff8101dffe7fc0 0000000000000000 
       ffff8101bffe85a8 ffffffff8010fac7 
Call Trace: <NMI> <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff80119c67>{nmi_watchdog_tick+71}
       <ffffffff8014572f>{notifier_call_chain+31} <ffffffff8010fc72>{default_do_nmi+130}
       <ffffffff8010f0eb>{nmi+127}  <EOE> <1>Unable to handle kernel paging request at 00007fffffe07000 RIP: 
<ffffffff8010f940>{show_trace+496}
PGD 1bb756067 PUD 1bf4af067 PMD 1be3ae067 PTE 0
Oops: 0000 [6] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff8010f940>] <ffffffff8010f940>{show_trace+496}
RSP: 0000:ffff8101bffe80f8  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101bea0c010 RDI: 0000000000000003
RBP: 00007fffffe07000 R08: 0000000000000005 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000023 R14: ffff8101dffebfc0 R15: ffffffff806c2100
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffe07000 CR3: 00000001bd526000 CR4: 00000000000006e0
Process hwscan (pid: 21809, threadinfo ffff8101bea0c000, task ffff81017ffd6810)
Stack: 0000000000000100 ffffffff80404d30 0000000400000001 ffff8101bffe83f8 
       000000000000000a ffff8101dffebfc0 ffff8101dffe7fc0 0000000000000000 
       ffff8101bffe82f8 ffffffff8010fac7 
Call Trace: <NMI> <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff80119c67>{nmi_watchdog_tick+71} <ffffffff8014572f>{notifier_call_chain+31}
       <ffffffff8010fc72>{default_do_nmi+130} <ffffffff8010f0eb>{nmi+127}
        <EOE> <1>Unable to handle kernel paging request at 00007fffffe07000 RIP: 
<ffffffff8010f940>{show_trace+496}
PGD 1bb756067 PUD 1bf4af067 PMD 1be3ae067 PTE 0
Oops: 0000 [7] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 21809, comm: hwscan Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff8010f940>] <ffffffff8010f940>{show_trace+496}
RSP: 0000:ffff8101bffe7e48  EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000003
RDX: 0000000000000000 RSI: ffff8101bea0c010 RDI: 0000000000000003
RBP: 00007fffffe07000 R08: 0000000000000005 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000007 R14: ffff8101dffebfc0 R15: ffffffff806c2100
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fffffe07000 CR3: 00000001bd526000 CR4: 00000000000006e0
Process hwscan (pid: 21809, threadinfo ffff8101bea0c000, task ffff81017ffd6810)
Stack: 0000000000000100 ffffffff80404d30 0000000400000001 ffff8101bffe8148 
       000000000000000a ffff8101dffebfc0 ffff8101dffe7fc0 0000000000000000 
       ffff8101bffe8048 ffffffff8010fac7 
Call Trace:<ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       

Code: 48 8b 5d 00 48 83 c5 08 48 89 df e8 e0 bb 03 00 85 c0 74 3c 
RIP <ffffffff8010f940>{show_trace+496} RSP <ffff8101bffe7e48>
CR2: 00007fffffe07000
 <6>note: hwscan[21809] exited with preempt_count 1
BUG: scheduling while atomic: hwscan/0x00000001/21809
caller is do_exit+0xc3b/0xcb0

Call Trace:<ffffffff803f847c>{__schedule+156} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8014427b>{do_notify_parent+427}end_request: I/O error, dev sdx, sector 0
printk: 26 messages suppressed.
Buffer I/O error on device sdx, logical block 0
end_request: I/O error, dev sdx, sector 0
 <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff803fb982>{_raw_spin_unlock_irqrestore+50} <ffffffff8012e8ac>{sched_exit+236}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8013bacb>{do_exit+3131}
       <ffffffff803fd547>{do_page_fault+1959} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8010edb5>{error_exit+0}
       <ffffffff8010f940>{show_trace+496} <ffffffff8010f950>{show_trace+512}
       <ffffffff8010fac7>{show_stack+231} <ffffffff8010fb6d>{show_registers+141}
       <ffffffff8010fe8b>{__die+155} <ffffffff803fd4da>{do_page_fault+1850}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       
Unable to handle kernel paging request at ffffffffffffffae RIP: 
<ffffffff803f95da>{thread_return+34}
PGD 103027 PUD 1c0712067 PMD 0 
Oops: 0002 [8] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 0, comm: swapper Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<ffffffff803f95da>] <ffffffff803f95da>{thread_return+34}
RSP: 0000:ffff8101bffe7d08  EFLAGS: 00257d92
RAX: ffff81017ffd6810 RBX: ffff8101a07156a0 RCX: 0000000000000018
RDX: 0000000000000000 RSI: ffff8101dffe7030 RDI: ffff81017ffd6810
RBP: 0000000000000096 R08: ffff8101bffe6000 R09: ffff8101dffe7030
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000040
R13: ffff8101b8916a00 R14: ffff8101bffe7c48 R15: 00000000ffffffff
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffffffffffae CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff8101bffe6000, task ffff8101dffe7030)
Stack: ffffffff80426c75 ffffffff805c7311 ffff8101dffe7fc0 ffffffff80137f04 
       0000000000000096 000000000000002b ffff8101bffe9000 ffffffff803fba70 
       0000000000000000 0000000000000046 
Call Trace:<ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} 

Code: 48 89 85 18 ff ff ff 48 c7 c0 40 57 6c 80 65 48 8b 14 25 08 
RIP <ffffffff803f95da>{thread_return+34} RSP <ffff8101bffe7d08>
CR2: ffffffffffffffae
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 <1>Unable to handle kernel paging request at 0000000000010400 RIP: 
[<0000000000010400>]
PGD 0 
Oops: 0010 [9] PREEMPT SMP 
CPU 2 
Modules linked in: floppy usbserial thermal processor fan button battery ac parport_pc lp parport ipv6 qla2300 evdev joydev st sr_mod sg qla2200 qla2xxx firmware_class ohci_hcd usbcore hw_random dm_mod
Pid: 0, comm: swapper Not tainted 2.6.14-rc4-rt5 #1
RIP: 0010:[<0000000000010400>] [<0000000000010400>]
RSP: 0000:ffff8101dffebfa0  EFLAGS: 00253006
RAX: ffff8101bffe7fd8 RBX: 00000000fffffffc RCX: 0000000000000000
RDX: 0000000000010400 RSI: 0000000000000040 RDI: 0000000000000040
RBP: ffff8101bffe7938 R08: 0000000000000001 R09: 0000000000000001
R10: 0000ffff0000ffff R11: 00ff00ff00ff00ff R12: 0000000000000000
R13: 0000000000000009 R14: 0000000000000002 R15: ffff8101bffe7c58
FS:  00002aaaab1004c0(0000) GS:ffffffff8066fc80(0000) knlGS:000000005584b300
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000010400 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff8101bffe6000, task ffff8101dffe7030)
Stack: ffffffff80118919 ffffffff80428260 ffffffff8010eb8c ffff8101bffe7938  <EOI> 
       ffff8101bffe7c58 0000000000000002 0000000000000009 0000000000000000 
       0000000000000000 ffffffff80428260 
Call Trace: <IRQ> <ffffffff80118919>{smp_call_function_interrupt+73}
       <ffffffff8010eb8c>{call_function_interrupt+132}  <EOI> <ffffffff80118a9c>{smp_send_stop+92}
       <ffffffff80118a96>{smp_send_stop+86} <ffffffff801373a1>{panic+225}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff80137fcd>{printk+141}
       <ffffffff803fba70>{_raw_spin_unlock+48} <ffffffff8013af15>{do_exit+133}
       <ffffffff802e7837>{do_unblank_screen+103} <ffffffff803fd547>{do_page_fault+1959}
       <ffffffff8012e8ac>{sched_exit+236} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff803f95da>{thread_return+34}
       <ffffffff80137f04>{vprintk+708} <ffffffff803fba70>{_raw_spin_unlock+48}
       <ffffffff8010edb5>{error_exit+0} <ffffffff8010f940>{show_trace+496}
       <ffffffff8010f950>{show_trace+512} <ffffffff8010fac7>{show_stack+231}
       <ffffffff8010fb6d>{show_registers+141} <ffffffff8010fe8b>{__die+155}
       <ffffffff803fd4da>{do_page_fault+1850} <ffffffff801377c1>{release_console_sem+385}
       <ffffffff801377c1>{release_console_sem+385} <ffffffff80137f04>{vprintk+708}
       <ffffffff803fba70>{_raw_spin_unlock+48} 

Code:  Bad RIP value.
RIP [<0000000000010400>] RSP <ffff8101dffebfa0>
CR2: 0000000000010400
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 

--=-OaCBTSDwVpdij6JLiiVQ--

