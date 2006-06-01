Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWFAKiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWFAKiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWFAKiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:38:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:44452 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750745AbWFAKiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:38:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYxDLbIlDjN7kKrBb7tE42yBQG+ZNaEtky2NF/z29Z138rqHyu0C7LfK6+BJqZMXUOzGkyf1gjT+ru0KV33K9as70DWxSrbOdM0WkHxkgX29giVN5BVjYbF+DYgYtoiNH5doxs1MtPjvocUuf32aA84c2j6WbjzChkb03FpwPu4=
Message-ID: <20f65d530606010338h23dbd152u2670000ba6130fc6@mail.gmail.com>
Date: Thu, 1 Jun 2006 22:38:07 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: "Erik Mouw" <erik@harddisk-recovery.com>
Subject: Re: IO APIC IRQ assignment
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060601094214.GA14431@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
	 <20060530135017.GD5151@harddisk-recovery.com>
	 <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
	 <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr>
	 <20f65d530605311612n15820847sca559d0c443fc230@mail.gmail.com>
	 <20060601094214.GA14431@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik

> Could you post a boot log?
>

Please find the boot long below:

==============================
May 31 01:35:35 itx229 syslogd 1.4.1: restart.
May 31 01:35:35 itx229 syslog: syslogd startup succeeded
May 31 01:35:35 itx229 kernel: klogd 1.4.1, log source = /proc/kmsg started.
May 31 01:35:35 itx229 kernel: [4294667.296000] Linux version
2.6.16.18 (root@itx229.e3solutions.net) (gcc version 3.4.4 20050721
(Red Hat 3.4.4-2)) #3 Wed May 31 00:56:02 NZST 2006
May 31 01:35:35 itx229 kernel: [4294667.296000] BIOS-provided physical RAM map:
May 31 01:35:35 itx229 kernel: [4294667.296000]  BIOS-e820:
0000000000000000 - 000000000009fc00 (usable)
May 31 01:35:35 itx229 kernel: [4294667.296000]  BIOS-e820:
000000000009fc00 - 00000000000a0000 (reserved)
May 31 01:35:35 itx229 kernel: [4294667.296000]  BIOS-e820:
00000000000f0000 - 0000000000100000 (reserved)
May 31 01:35:35 itx229 kernel: [4294667.296000]  BIOS-e820:
0000000000100000 - 000000003dff0000 (usable)
May 31 01:35:35 itx229 kernel: [4294667.296000]  BIOS-e820:
000000003dff0000 - 000000003dff3000 (ACPI NVS)
May 31 01:35:35 itx229 kernel: [4294667.296000]  BIOS-e820:
000000003dff3000 - 000000003e000000 (ACPI data)
May 31 01:35:35 itx229 kernel: [4294667.296000]  BIOS-e820:
00000000fec00000 - 0000000100000000 (reserved)
May 31 01:35:35 itx229 kernel: [4294667.296000] 95MB HIGHMEM available.
May 31 01:35:35 itx229 kernel: [4294667.296000] 896MB LOWMEM available.
May 31 01:35:35 itx229 syslog: klogd startup succeeded
May 31 01:35:35 itx229 kernel: [4294667.296000] found SMP MP-table at 000f4a40
May 31 01:35:35 itx229 autofs: automount startup succeeded
May 31 01:35:35 itx229 acpid: acpid startup succeeded
May 31 01:35:35 itx229 kernel: [4294667.296000] DMI 2.2 present.
May 31 01:35:36 itx229 sshd:  succeeded
May 31 01:35:36 itx229 kernel: [4294667.296000] ACPI: PM-Timer IO Port: 0x408
May 31 01:35:37 itx229 kernel: [4294667.296000] ACPI: LAPIC
(acpi_id[0x00] lapic_id[0x00] enabled)
May 31 01:35:37 itx229 kernel: [4294667.296000] Processor #0 6:13 APIC
version 20
May 31 01:35:37 itx229 kernel: [4294667.296000] ACPI: LAPIC_NMI
(acpi_id[0x00] high edge lint[0x1])
May 31 01:35:37 itx229 kernel: [4294667.296000] ACPI: IOAPIC (id[0x02]
address[0xfec00000] gsi_base[0])
May 31 01:35:37 itx229 kernel: [4294667.296000] IOAPIC[0]: apic_id 2,
version 32, address 0xfec00000, GSI 0-23
May 31 01:35:37 itx229 kernel: [4294667.296000] ACPI: INT_SRC_OVR (bus
0 bus_irq 0 global_irq 2 dfl dfl)
May 31 01:35:37 itx229 kernel: [4294667.296000] ACPI: INT_SRC_OVR (bus
0 bus_irq 9 global_irq 9 high level)
May 31 01:35:37 itx229 kernel: [4294667.296000] Enabling APIC mode:
Flat.  Using 1 I/O APICs
May 31 01:35:37 itx229 kernel: [4294667.296000] Using ACPI (MADT) for
SMP configuration information
May 31 01:35:37 itx229 kernel: [4294667.296000] Allocating PCI
resources starting at 40000000 (gap: 3e000000:c0c00000)
May 31 01:35:37 itx229 kernel: [4294667.296000] Built 1 zonelists
May 31 01:35:37 itx229 kernel: [4294667.296000] Kernel command line:
ro root=/dev/VolGroup00/LogVol00 rhgb quiet console=tty0
console=ttyS1,115200n8 apic=debug
May 31 01:35:26 itx229 start_udev: Starting udev:  succeeded
May 31 01:35:27 itx229 udevsend[993]: starting udevd daemon
May 31 01:35:30 itx229 rc.sysinit: -e
May 31 01:35:39 itx229 kernel: [4294667.296000] Enabling fast FPU save
and restore... done.
May 31 01:35:32 itx229 sysctl: net.ipv4.ip_forward = 0
May 31 01:35:39 itx229 kernel: [4294667.296000] Enabling unmasked SIMD
FPU exception support... done.
May 31 01:35:32 itx229 sysctl: net.ipv4.conf.default.rp_filter = 1
May 31 01:35:39 itx229 kernel: [4294667.296000] Initializing CPU#0
May 31 01:35:32 itx229 sysctl: net.ipv4.conf.default.accept_source_route = 0
May 31 01:35:39 itx229 kernel: [4294667.296000] PID hash table
entries: 4096 (order: 12, 65536 bytes)
May 31 01:35:32 itx229 sysctl: kernel.sysrq = 0
May 31 01:35:39 itx229 kernel: [4294667.296000] Detected 1699.934 MHz processor.
May 31 01:35:32 itx229 sysctl: kernel.core_uses_pid = 1
May 31 01:35:39 itx229 kernel: [4294667.296000] Using pmtmr for
high-res timesource
May 31 01:35:32 itx229 rc.sysinit: Configuring kernel parameters:  succeeded
May 31 01:35:39 itx229 kernel: [4294667.296000] Console: colour VGA+ 80x25
May 31 01:35:33 itx229 date: Wed May 31 01:35:33 NZST 2006
May 31 01:35:39 itx229 kernel: [4294667.534000] Dentry cache hash
table entries: 131072 (order: 7, 524288 bytes)
May 31 01:35:33 itx229 rc.sysinit: Setting clock  (utc): Wed May 31
01:35:33 NZST 2006 succeeded
May 31 01:35:39 itx229 kernel: [4294667.534000] Inode-cache hash table
entries: 65536 (order: 6, 262144 bytes)
May 31 01:35:33 itx229 rc.sysinit: Setting hostname
itx229.e3solutions.net:  succeeded
May 31 01:35:39 itx229 kernel: [4294667.563000] Memory:
1002196k/1015744k available (1925k kernel code, 12988k reserved, 750k
data, 180k init, 98240k highmem)
May 31 01:35:33 itx229 fsck: [/sbin/fsck.ext3 (1) -- /]
May 31 01:35:39 itx229 kernel: [4294667.563000] Checking if this
processor honours the WP bit even in supervisor mode... Ok.
May 31 01:35:33 itx229 fsck: fsck.ext3 -a /dev/VolGroup00/LogVol00
May 31 01:35:39 itx229 kernel: [4294667.623000] Calibrating delay
using timer specific routine.. 3402.89 BogoMIPS (lpj=1701445)
May 31 01:35:33 itx229 fsck: /dev/VolGroup00/LogVol00: clean,
279908/9502720 files, 3002733/18989056 blocks
May 31 01:35:39 itx229 kernel: [4294667.623000] Security Framework
v1.0.0 initialized
May 31 01:35:33 itx229 rc.sysinit: Checking root filesystem succeeded
May 31 01:35:39 itx229 kernel: [4294667.623000] SELinux:  Initializing.
May 31 01:35:33 itx229 rc.sysinit: Remounting root filesystem in
read-write mode:  succeeded
May 31 01:35:39 itx229 kernel: [4294667.623000] SELinux:  Starting in
permissive mode
May 31 01:35:33 itx229 lvm.static:   2 logical volume(s) in volume
group VolGroup00 now active
May 31 01:35:39 itx229 kernel: [4294667.623000]
selinux_register_security:  Registering secondary module capability
May 31 01:35:33 itx229 rc.sysinit: Setting up Logical Volume
Management: succeeded
May 31 01:35:39 itx229 kernel: [4294667.623000] Capability LSM
initialized as secondary
May 31 01:35:33 itx229 fsck: Checking all file systems.
May 31 01:35:39 itx229 kernel: [4294667.623000] Mount-cache hash table
entries: 512
May 31 01:35:33 itx229 fsck: [/sbin/fsck.ext3 (1) -- /boot] fsck.ext3
-a /dev/hda1
May 31 01:35:33 itx229 fsck: /boot: clean, 48/26104 files, 26871/104388 blocks
May 31 01:35:33 itx229 rc.sysinit: Checking filesystems succeeded
May 31 01:35:39 itx229 kernel: [4294667.623000] CPU: L1 I cache: 32K,
L1 D cache: 32K
May 31 01:35:33 itx229 rc.sysinit: Mounting local filesystems:  succeeded
May 31 01:35:39 itx229 kernel: [4294667.623000] CPU: L2 cache: 2048K
May 31 01:35:33 itx229 rc.sysinit: Enabling local filesystem quotas:  succeeded
May 31 01:35:34 itx229 rc.sysinit: Enabling swap space:  succeeded
May 31 01:35:39 itx229 kernel: [4294667.623000] Intel machine check
architecture supported.
May 31 01:35:34 itx229 init: Entering runlevel: 5
May 31 01:35:39 itx229 kernel: [4294667.623000] Intel machine check
reporting enabled on CPU#0.
May 31 01:35:34 itx229 sysctl: net.ipv4.ip_forward = 0
May 31 01:35:39 itx229 kernel: [4294667.623000] CPU: Intel(R)
Pentium(R) M processor 1.70GHz stepping 06
May 31 01:35:34 itx229 sysctl: net.ipv4.conf.default.rp_filter = 1
May 31 01:35:39 itx229 kernel: [4294667.623000] Checking 'hlt'
instruction... OK.
May 31 01:35:34 itx229 sysctl: net.ipv4.conf.default.accept_source_route = 0
May 31 01:35:39 itx229 kernel: [4294667.637000] Getting VERSION: 50014
May 31 01:35:34 itx229 sysctl: kernel.sysrq = 0
May 31 01:35:39 itx229 kernel: [4294667.637000] Getting VERSION: 50014
May 31 01:35:34 itx229 sysctl: kernel.core_uses_pid = 1
May 31 01:35:39 itx229 kernel: [4294667.637000] Getting ID: 0
May 31 01:35:34 itx229 network: Setting network parameters:  succeeded
May 31 01:35:39 itx229 kernel: [4294667.637000] Getting LVT0: 700
May 31 01:35:34 itx229 modprobe: FATAL: Module ip_tables not found.
May 31 01:35:39 itx229 kernel: [4294667.637000] Getting LVT1: 400
May 31 01:35:35 itx229 network: Bringing up loopback interface:  succeeded
May 31 01:35:39 itx229 kernel: [4294667.637000] enabled ExtINT on CPU#0
May 31 01:35:39 itx229 kernel: [4294667.637000] ENABLING IO-APIC IRQs
May 31 01:35:39 itx229 kernel: [4294667.637000] ..TIMER: vector=0x31
apic1=0 pin1=2 apic2=-1 pin2=-1
May 31 01:35:39 itx229 kernel: [4294667.647000] Using local APIC timer
interrupts.
May 31 01:35:39 itx229 kernel: [4294667.647000] calibrating APIC timer ...
May 31 01:35:39 itx229 kernel: [4294667.647000] ..... CPU clock speed
is 1699.0591 MHz.
May 31 01:35:39 itx229 kernel: [4294667.647000] ..... host bus clock
speed is 99.0975 MHz.
May 31 01:35:39 itx229 kernel: [4294667.748000] checking if image is
initramfs... it is
May 31 01:35:39 itx229 kernel: [4294667.843000] Freeing initrd memory:
937k freed
May 31 01:35:39 itx229 kernel: [4294667.844000] NET: Registered
protocol family 16
May 31 01:35:39 itx229 kernel: [4294667.844000] ACPI: bus type pci registered
May 31 01:35:39 itx229 kernel: [4294667.857000] PCI: PCI BIOS revision
2.10 entry at 0xfaa10, last bus=1
May 31 01:35:39 itx229 kernel: [4294667.857000] PCI: Using configuration type 1
May 31 01:35:39 itx229 kernel: [4294667.858000] ACPI: Subsystem
revision 20060127
May 31 01:35:39 itx229 kernel: [4294667.869000] ACPI: Interpreter enabled
May 31 01:35:39 itx229 kernel: [4294667.869000] ACPI: Using IOAPIC for
interrupt routing
May 31 01:35:39 itx229 kernel: [4294667.871000] ACPI: PCI Root Bridge
[PCI0] (0000:00)
May 31 01:35:39 itx229 kernel: [4294667.873000] PCI quirk: region
0400-047f claimed by ICH4 ACPI/GPIO/TCO
May 31 01:35:39 itx229 kernel: [4294667.873000] PCI quirk: region
0480-04bf claimed by ICH4 GPIO
May 31 01:35:39 itx229 kernel: [4294667.874000] PCI: Ignoring BAR0-3
of IDE controller 0000:00:1f.1
May 31 01:35:39 itx229 kernel: [4294667.875000] PCI: Transparent
bridge - 0000:00:1e.0
May 31 01:35:39 itx229 kernel: [4294667.894000] ACPI: Device [UAR3]
status [0000000c]: functional but not present; setting present
May 31 01:35:39 itx229 kernel: [4294667.895000] ACPI: Device [UAR4]
status [0000000c]: functional but not present; setting present
May 31 01:35:39 itx229 kernel: [4294667.900000] ACPI: PCI Interrupt
Link [LNKA] (IRQs 3 4 5 7 9 *10 11 12 14 15)
May 31 01:35:39 itx229 kernel: [4294667.901000] ACPI: PCI Interrupt
Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12 14 15)
May 31 01:35:39 itx229 kernel: [4294667.901000] ACPI: PCI Interrupt
Link [LNKC] (IRQs 3 4 5 *7 9 10 11 12 14 15)
May 31 01:35:39 itx229 kernel: [4294667.902000] ACPI: PCI Interrupt
Link [LNKD] (IRQs 3 4 5 7 9 10 11 *12 14 15)
May 31 01:35:39 itx229 kernel: [4294667.902000] ACPI: PCI Interrupt
Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12 14 15)
May 31 01:35:39 itx229 kernel: [4294667.903000] ACPI: PCI Interrupt
Link [LNKF] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
May 31 01:35:39 itx229 kernel: [4294667.903000] ACPI: PCI Interrupt
Link [LNK0] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
May 31 01:35:39 itx229 kernel: [4294667.904000] ACPI: PCI Interrupt
Link [LNK1] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
May 31 01:35:39 itx229 kernel: [4294667.905000] Linux Plug and Play
Support v0.97 (c) Adam Belay
May 31 01:35:39 itx229 kernel: [4294667.905000] pnp: PnP ACPI init
May 31 01:35:40 itx229 kernel: [4294667.911000] pnp: PnP ACPI: found 12 devices
May 31 01:35:40 itx229 kernel: [4294667.912000] usbcore: registered
new driver usbfs
May 31 01:35:40 itx229 kernel: [4294667.912000] usbcore: registered
new driver hub
May 31 01:35:40 itx229 kernel: [4294667.912000] PCI: Using ACPI for IRQ routing
May 31 01:35:40 itx229 kernel: [4294667.912000] PCI: If a device
doesn't work, try "pci=routeirq".  If it helps, post a report
May 31 01:35:40 itx229 kernel: [4294667.912000] testing the IO
APIC.......................
May 31 01:35:40 itx229 kernel: [4294667.913000] Using vector-based indexing
May 31 01:35:40 itx229 kernel: [4294667.913000]
.................................... done.
May 31 01:35:40 itx229 kernel: [4294667.924000] pnp: 00:09: ioport
range 0x400-0x4bf could not be reserved
May 31 01:35:40 itx229 kernel: [4294667.927000] PCI: Ignore bogus
resource 6 [0:0] of 0000:00:02.0
May 31 01:35:40 itx229 kernel: [4294667.928000] PCI: Bridge: 0000:00:1e.0
May 31 01:35:40 itx229 kernel: [4294667.928000]   IO window: d000-dfff
May 31 01:35:40 itx229 kernel: [4294667.928000]   MEM window: e8000000-e80fffff
May 31 01:35:40 itx229 kernel: [4294667.928000]   PREFETCH window:
e8100000-e81fffff
May 31 01:35:40 itx229 kernel: [4294667.928000] apm: BIOS version 1.2
Flags 0x07 (Driver version 1.16ac)
May 31 01:35:40 itx229 kernel: [4294667.928000] apm: overridden by ACPI.
May 31 01:35:40 itx229 kernel: [4294667.937000] audit: initializing
netlink socket (disabled)
May 31 01:35:40 itx229 kernel: [4294667.937000]
audit(1148996119.936:1): initialized
May 31 01:35:40 itx229 kernel: [4294667.937000] highmem bounce pool
size: 64 pages
May 31 01:35:40 itx229 lsb_log_message:  succeeded
May 31 01:35:40 itx229 kernel: [4294667.937000] Total HugeTLB memory
allocated, 0
May 31 01:35:40 itx229 kernel: [4294667.937000] VFS: Disk quotas dquot_6.5.1
May 31 01:35:40 itx229 kernel: [4294667.937000] Dquot-cache hash table
entries: 1024 (order 0, 4096 bytes)
May 31 01:35:40 itx229 crond: crond startup succeeded
May 31 01:35:40 itx229 kernel: [4294667.938000] SELinux:  Registering
netfilter hooks
May 31 01:35:40 itx229 kernel: [4294667.945000] Initializing Cryptographic API
May 31 01:35:40 itx229 kernel: [4294667.945000] io scheduler noop registered
May 31 01:35:40 itx229 kernel: [4294667.945000] io scheduler
anticipatory registered (default)
May 31 01:35:41 itx229 kernel: [4294667.945000] io scheduler deadline registered
May 31 01:35:41 itx229 kernel: [4294667.945000] io scheduler cfq registered
May 31 01:35:41 itx229 kernel: [4294667.945000] pci_hotplug: PCI Hot
Plug PCI Core version: 0.5
May 31 01:35:42 itx229 xfs: xfs startup succeeded
May 31 01:35:42 itx229 xfs[2549]: ignoring font path element
/usr/X11R6/lib/X11/fonts/Speedo (unreadable)
May 31 01:35:42 itx229 kernel: [4294667.946000] ACPI: Fan [FAN] (on)
May 31 01:35:42 itx229 kernel: [4294667.946000] ACPI: Processor [CPU0]
(supports 2 throttling states)
May 31 01:35:42 itx229 net.agent[2593]: remove event not handled
May 31 01:35:42 itx229 net.agent[2602]: remove event not handled
May 31 01:35:42 itx229 kernel: [4294667.947000] ACPI: Thermal Zone [THRM] (55 C)
May 31 01:35:42 itx229 kernel: [4294667.947000] isapnp: Scanning for
PnP cards...
May 31 01:35:42 itx229 kernel: [4294668.304000] isapnp: No Plug & Play
device found
May 31 01:35:42 itx229 kernel: [4294668.327000] Real Time Clock Driver v1.12ac
May 31 01:35:42 itx229 kernel: [4294668.327000] Linux agpgart
interface v0.101 (c) Dave Jones
May 31 01:35:42 itx229 kernel: [4294668.329000] agpgart: Detected an
Intel 855 Chipset.
May 31 01:35:42 itx229 kernel: [4294668.330000] agpgart: Detected
32636K stolen memory.
May 31 01:35:42 itx229 kernel: [4294668.337000] agpgart: AGP aperture
is 128M @ 0xd8000000
May 31 01:35:42 itx229 kernel: [4294668.338000] [drm] Initialized drm
1.0.1 20051102
May 31 01:35:42 itx229 kernel: [4294668.339000] PNP: PS/2 Controller
[PNP0303:PS2K] at 0x60,0x64 irq 1
May 31 01:35:42 itx229 kernel: [4294668.339000] PNP: PS/2 controller
doesn't have AUX irq; using default 12
May 31 01:35:42 itx229 kernel: [4294668.341000] serio: i8042 AUX port
at 0x60,0x64 irq 12
May 31 01:35:42 itx229 kernel: [4294668.341000] serio: i8042 KBD port
at 0x60,0x64 irq 1
May 31 01:35:42 itx229 kernel: [4294668.341000] Serial: 8250/16550
driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
May 31 01:35:42 itx229 kernel: [4294668.586000] serial8250: ttyS0 at
I/O 0x3f8 (irq = 4) is a 16550A
May 31 01:35:42 itx229 kernel: [4294668.830000] serial8250: ttyS1 at
I/O 0x2f8 (irq = 3) is a 16550A
May 31 01:35:42 itx229 kernel: [4294668.831000] 00:06: ttyS0 at I/O
0x3f8 (irq = 4) is a 16550A
May 31 01:35:42 itx229 kernel: [4294668.832000] 00:07: ttyS1 at I/O
0x2f8 (irq = 3) is a 16550A
May 31 01:35:42 itx229 kernel: [4294668.838000] RAMDISK driver
initialized: 16 RAM disks of 16384K size 1024 blocksize
May 31 01:35:42 itx229 kernel: [4294668.839000] Uniform Multi-Platform
E-IDE driver Revision: 7.00alpha2
May 31 01:35:42 itx229 kernel: [4294668.839000] ide: Assuming 33MHz
system bus speed for PIO modes; override with idebus=xx
May 31 01:35:42 itx229 kernel: [4294668.839000] ICH4: IDE controller
at PCI slot 0000:00:1f.1
May 31 01:35:42 itx229 kernel: [4294668.839000] ACPI: PCI Interrupt
0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 169
May 31 01:35:42 itx229 kernel: [4294668.839000] ICH4: chipset revision 2
May 31 01:35:42 itx229 kernel: [4294668.839000] ICH4: not 100% native
mode: will probe irqs later
May 31 01:35:42 itx229 kernel: [4294668.839000]     ide0: BM-DMA at
0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
May 31 01:35:42 itx229 kernel: [4294668.839000]     ide1: BM-DMA at
0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
May 31 01:35:42 itx229 kernel: [4294669.103000] hda: HTS541080G9AT00,
ATA DISK drive
May 31 01:35:42 itx229 kernel: [4294669.715000] ide0 at
0x1f0-0x1f7,0x3f6 on irq 14
May 31 01:35:42 itx229 kernel: [4294670.759000] hda: max request size: 512KiB
May 31 01:35:42 itx229 kernel: [4294670.775000] hda: 156301488 sectors
(80026 MB) w/7539KiB Cache, CHS=16383/255/63, UDMA(100)
May 31 01:35:42 itx229 kernel: [4294670.776000] hda: cache flushes supported
May 31 01:35:42 itx229 kernel: [4294670.776000]  hda: hda1 hda2
May 31 01:35:42 itx229 kernel: [4294670.787000] ide-floppy driver 0.99.newide
May 31 01:35:42 itx229 kernel: [4294670.788000] usbcore: registered
new driver hiddev
May 31 01:35:42 itx229 kernel: [4294670.788000] usbcore: registered
new driver usbhid
May 31 01:35:42 itx229 kernel: [4294670.788000]
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
May 31 01:35:42 itx229 kernel: [4294670.788000] mice: PS/2 mouse
device common for all mice
May 31 01:35:42 itx229 kernel: [4294670.788000] md: md driver 0.90.3
MAX_MD_DEVS=256, MD_SB_DISKS=27
May 31 01:35:42 itx229 kernel: [4294670.788000] md: bitmap version 4.39
May 31 01:35:42 itx229 kernel: [4294670.788000] NET: Registered
protocol family 2
May 31 01:35:42 itx229 kernel: [4294670.798000] IP route cache hash
table entries: 32768 (order: 5, 131072 bytes)
May 31 01:35:42 itx229 kernel: [4294670.798000] TCP established hash
table entries: 131072 (order: 9, 2097152 bytes)
May 31 01:35:42 itx229 kernel: [4294670.801000] TCP bind hash table
entries: 65536 (order: 8, 1310720 bytes)
May 31 01:35:42 itx229 kernel: [4294670.803000] TCP: Hash tables
configured (established 131072 bind 65536)
May 31 01:35:42 itx229 kernel: [4294670.803000] TCP reno registered
May 31 01:35:42 itx229 kernel: [4294670.804000] TCP bic registered
May 31 01:35:42 itx229 kernel: [4294670.804000] Initializing IPsec
netlink socket
May 31 01:35:42 itx229 kernel: [4294670.804000] NET: Registered
protocol family 1
May 31 01:35:42 itx229 kernel: [4294670.804000] NET: Registered
protocol family 17
May 31 01:35:42 itx229 kernel: [4294670.804000] Using IPI Shortcut mode
May 31 01:35:42 itx229 kernel: [4294670.804000] ACPI wakeup devices:
May 31 01:35:42 itx229 kernel: [4294670.804000] PCI0 HUB0 UAR1 UAR2
USB0 USB1 USB2 USBE MODM
May 31 01:35:42 itx229 kernel: [4294670.804000] ACPI: (supports S0 S1 S4 S5)
May 31 01:35:42 itx229 kernel: [4294670.804000] Freeing unused kernel
memory: 180k freed
May 31 01:35:43 itx229 kernel: [4294670.827000] device-mapper:
4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
May 31 01:35:43 itx229 kernel: [4294671.018000] input: AT Translated
Set 2 keyboard as /class/input/input0
May 31 01:35:43 itx229 kernel: [4294671.171000] kjournald starting.
Commit interval 5 seconds
May 31 01:35:43 itx229 kernel: [4294671.171000] EXT3-fs: mounted
filesystem with ordered data mode.
May 31 01:35:43 itx229 kernel: [4294671.570000] SELinux:  Disabled at runtime.
May 31 01:35:43 itx229 kernel: [4294671.570000] SELinux:
Unregistering netfilter hooks
May 31 01:35:43 itx229 kernel: [4294675.803000] e100: Intel(R) PRO/100
Network Driver, 3.5.10-k2-NAPI
May 31 01:35:43 itx229 kernel: [4294675.803000] e100: Copyright(c)
1999-2005 Intel Corporation
May 31 01:35:43 itx229 kernel: [4294675.812000] ACPI: PCI Interrupt
0000:01:08.0[A] -> GSI 20 (level, low) -> IRQ 177
May 31 01:35:43 itx229 kernel: [4294675.845000] e100: eth0:
e100_probe: addr 0xe8001000, irq 177, MAC addr 00:0A:9D:08:7B:94
May 31 01:35:43 itx229 kernel: [4294676.352000] ACPI: PCI Interrupt
0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 185
May 31 01:35:43 itx229 kernel: [4294676.663000]
intel8x0_measure_ac97_clock: measured 50752 usecs
May 31 01:35:43 itx229 kernel: [4294676.663000] intel8x0: clocking to 48000
May 31 01:35:43 itx229 kernel: [4294677.034000] hw_random: RNG not detected
May 31 01:35:43 itx229 kernel: [4294677.111000] Linux video capture
interface: v1.00
May 31 01:35:43 itx229 kernel: [4294677.313000] bttv: driver version
0.9.16 loaded
May 31 01:35:43 itx229 kernel: [4294677.313000] bttv: using 8 buffers
with 2080k (520 pages) each for capture
May 31 01:35:43 itx229 kernel: [4294677.313000] bttv: pci latency fixup [64]
May 31 01:35:43 itx229 kernel: [4294677.323000] bttv: Bt8xx card found (0).
May 31 01:35:43 itx229 kernel: [4294677.323000] ACPI: PCI Interrupt
0000:01:04.0[A] -> GSI 16 (level, low) -> IRQ 193
May 31 01:35:43 itx229 kernel: [4294677.323000] bttv0: Bt878 (rev 17)
at 0000:01:04.0, irq: 193, latency: 32, mmio: 0xe8100000
May 31 01:35:43 itx229 kernel: [4294677.323000] bttv0: subsystem:
5453:4200 (UNKNOWN)
May 31 01:35:43 itx229 kernel: [4294677.323000] bttv0: using: STB,
Gateway P/N 6000699 (bt848) [card=3,insmod option]
May 31 01:35:43 itx229 kernel: [4294677.323000] bttv0: setting pci timer to 64
May 31 01:35:43 itx229 kernel: [4294677.336000] bttv0: using tuner=2
May 31 01:35:43 itx229 kernel: [4294677.336000] bttv0: i2c: checking
for TDA9875 @ 0xb0... not found
May 31 01:35:43 itx229 kernel: [4294677.338000] bttv0: i2c: checking
for TDA7432 @ 0x8a... not found
May 31 01:35:43 itx229 kernel: [4294677.392000] bttv0: i2c: checking
for TDA9887 @ 0x86... not found
May 31 01:35:43 itx229 kernel: [4294677.494000] bttv: Overlay support disabled.
May 31 01:35:43 itx229 kernel: [4294677.505000] bttv0: registered device video0
May 31 01:35:43 itx229 kernel: [4294677.515000] bttv0: registered device vbi0
May 31 01:35:43 itx229 kernel: [4294677.525000] bttv0: registered device radio0
May 31 01:35:43 itx229 kernel: [4294677.525000] bttv0: PLL: 28636363
=> 35468950 .. ok
May 31 01:35:43 itx229 kernel: [4294677.547000] bttv: Bt8xx card found (1).
May 31 01:35:43 itx229 kernel: [4294677.547000] ACPI: PCI Interrupt
0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 185
May 31 01:35:43 itx229 kernel: [4294677.547000] bttv1: Bt878 (rev 17)
at 0000:01:05.0, irq: 185, latency: 32, mmio: 0xe8102000
May 31 01:35:43 itx229 kernel: [4294677.547000] bttv1: subsystem:
5453:4201 (UNKNOWN)
May 31 01:35:43 itx229 kernel: [4294677.547000] bttv1: using: STB,
Gateway P/N 6000699 (bt848) [card=3,insmod option]
May 31 01:35:43 itx229 kernel: [4294677.547000] bttv1: setting pci timer to 64
May 31 01:35:43 itx229 kernel: [4294677.623000] bttv1: using tuner=2
May 31 01:35:43 itx229 kernel: [4294677.623000] bttv1: i2c: checking
for TDA9875 @ 0xb0... not found
May 31 01:35:43 itx229 kernel: [4294677.625000] bttv1: i2c: checking
for TDA7432 @ 0x8a... not found
May 31 01:35:43 itx229 kernel: [4294677.633000] bttv1: i2c: checking
for TDA9887 @ 0x86... not found
May 31 01:35:43 itx229 kernel: [4294677.640000] bttv: Overlay support disabled.
May 31 01:35:43 itx229 kernel: [4294677.650000] bttv1: registered device video1
May 31 01:35:43 itx229 kernel: [4294677.656000] bttv1: registered device vbi1
May 31 01:35:43 itx229 kernel: [4294677.659000] bttv1: registered device radio1
May 31 01:35:43 itx229 kernel: [4294677.659000] bttv1: PLL: 28636363
=> 35468950 .. ok
May 31 01:35:43 itx229 kernel: [4294677.681000] bttv: Bt8xx card found (2).
May 31 01:35:43 itx229 kernel: [4294677.681000] ACPI: PCI Interrupt
0000:01:06.0[A] -> GSI 18 (level, low) -> IRQ 169
May 31 01:35:43 itx229 kernel: [4294677.681000] bttv2: Bt878 (rev 17)
at 0000:01:06.0, irq: 169, latency: 32, mmio: 0xe8104000
May 31 01:35:43 itx229 kernel: [4294677.681000] bttv2: subsystem:
5453:4202 (UNKNOWN)
May 31 01:35:43 itx229 kernel: [4294677.681000] bttv2: using: STB,
Gateway P/N 6000699 (bt848) [card=3,insmod option]
May 31 01:35:43 itx229 kernel: [4294677.681000] bttv2: setting pci timer to 64
May 31 01:35:43 itx229 kernel: [4294677.749000] bttv2: using tuner=2
May 31 01:35:43 itx229 kernel: [4294677.749000] bttv2: i2c: checking
for TDA9875 @ 0xb0... not found
May 31 01:35:43 itx229 kernel: [4294677.751000] bttv2: i2c: checking
for TDA7432 @ 0x8a... not found
May 31 01:35:43 itx229 kernel: [4294677.759000] bttv2: i2c: checking
for TDA9887 @ 0x86... not found
May 31 01:35:43 itx229 kernel: [4294677.767000] bttv: Overlay support disabled.
May 31 01:35:43 itx229 kernel: [4294677.777000] bttv2: registered device video2
May 31 01:35:43 itx229 kernel: [4294677.786000] bttv2: registered device vbi2
May 31 01:35:43 itx229 kernel: [4294677.797000] bttv2: registered device radio2
May 31 01:35:43 itx229 kernel: [4294677.797000] bttv2: PLL: 28636363
=> 35468950 .. ok
May 31 01:35:43 itx229 kernel: [4294677.819000] bttv: Bt8xx card found (3).
May 31 01:35:43 itx229 kernel: [4294677.819000] ACPI: PCI Interrupt
0000:01:07.0[A] -> GSI 19 (level, low) -> IRQ 201
May 31 01:35:43 itx229 kernel: [4294677.819000] bttv3: Bt878 (rev 17)
at 0000:01:07.0, irq: 201, latency: 32, mmio: 0xe8106000
May 31 01:35:43 itx229 kernel: [4294677.819000] bttv3: subsystem:
5453:4203 (UNKNOWN)
May 31 01:35:43 itx229 modprobe: FATAL: Module ip_tables not found.
May 31 01:35:43 itx229 kernel: [4294677.819000] bttv3: using: STB,
Gateway P/N 6000699 (bt848) [card=3,insmod option]
May 31 01:35:43 itx229 kernel: [4294677.819000] bttv3: setting pci timer to 64
May 31 01:35:43 itx229 kernel: [4294677.895000] bttv3: using tuner=2
May 31 01:35:43 itx229 kernel: [4294677.895000] bttv3: i2c: checking
for TDA9875 @ 0xb0... not found
May 31 01:35:43 itx229 kernel: [4294677.897000] bttv3: i2c: checking
for TDA7432 @ 0x8a... not found
May 31 01:35:43 itx229 kernel: [4294677.904000] bttv3: i2c: checking
for TDA9887 @ 0x86... not found
May 31 01:35:43 itx229 kernel: [4294677.912000] bttv: Overlay support disabled.
May 31 01:35:43 itx229 kernel: [4294677.922000] bttv3: registered device video3
May 31 01:35:43 itx229 kernel: [4294677.931000] bttv3: registered device vbi3
May 31 01:35:43 itx229 kernel: [4294677.942000] bttv3: registered device radio3
May 31 01:35:43 itx229 kernel: [4294677.942000] bttv3: PLL: 28636363
=> 35468950 .. ok
May 31 01:35:43 itx229 kernel: [4294677.990000] bt878: AUDIO driver
version 0.0.0 loaded
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: Bt878 AUDIO
function found (0).
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI Interrupt
0000:01:04.1[A] -> GSI 16 (level, low) -> IRQ 193
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878_probe: card
id=[0x42005453], Unknown card.
May 31 01:35:43 itx229 kernel: [4294677.999000] Exiting..
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI interrupt
for device 0000:01:04.1 disabled
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: probe of
0000:01:04.1 failed with error -22
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: Bt878 AUDIO
function found (0).
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI Interrupt
0000:01:05.1[A] -> GSI 17 (level, low) -> IRQ 185
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878_probe: card
id=[0x42015453], Unknown card.
May 31 01:35:43 itx229 kernel: [4294677.999000] Exiting..
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI interrupt
for device 0000:01:05.1 disabled
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: probe of
0000:01:05.1 failed with error -22
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: Bt878 AUDIO
function found (0).
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI Interrupt
0000:01:06.1[A] -> GSI 18 (level, low) -> IRQ 169
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878_probe: card
id=[0x42025453], Unknown card.
May 31 01:35:43 itx229 kernel: [4294677.999000] Exiting..
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI interrupt
for device 0000:01:06.1 disabled
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: probe of
0000:01:06.1 failed with error -22
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: Bt878 AUDIO
function found (0).
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI Interrupt
0000:01:07.1[A] -> GSI 19 (level, low) -> IRQ 201
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878_probe: card
id=[0x42035453], Unknown card.
May 31 01:35:43 itx229 kernel: [4294677.999000] Exiting..
May 31 01:35:43 itx229 kernel: [4294677.999000] ACPI: PCI interrupt
for device 0000:01:07.1 disabled
May 31 01:35:43 itx229 kernel: [4294677.999000] bt878: probe of
0000:01:07.1 failed with error -22
May 31 01:35:43 itx229 kernel: [4294678.099000] USB Universal Host
Controller Interface driver v2.3
May 31 01:35:43 itx229 kernel: [4294678.109000] ACPI: PCI Interrupt
0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 193
May 31 01:35:43 itx229 kernel: [4294678.109000] uhci_hcd 0000:00:1d.0:
UHCI Host Controller
May 31 01:35:43 itx229 kernel: [4294678.119000] uhci_hcd 0000:00:1d.0:
new USB bus registered, assigned bus number 1
May 31 01:35:43 itx229 kernel: [4294678.119000] uhci_hcd 0000:00:1d.0:
irq 193, io base 0x0000e000
May 31 01:35:43 itx229 kernel: [4294678.122000] usb usb1:
configuration #1 chosen from 1 choice
May 31 01:35:43 itx229 kernel: [4294678.124000] hub 1-0:1.0: USB hub found
May 31 01:35:43 itx229 kernel: [4294678.124000] hub 1-0:1.0: 2 ports detected
May 31 01:35:43 itx229 kernel: [4294678.250000] ACPI: PCI Interrupt
0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 201
May 31 01:35:43 itx229 kernel: [4294678.250000] uhci_hcd 0000:00:1d.1:
UHCI Host Controller
May 31 01:35:43 itx229 kernel: [4294678.268000] uhci_hcd 0000:00:1d.1:
new USB bus registered, assigned bus number 2
May 31 01:35:43 itx229 kernel: [4294678.268000] uhci_hcd 0000:00:1d.1:
irq 201, io base 0x0000e100
May 31 01:35:43 itx229 kernel: [4294678.270000] usb usb2:
configuration #1 chosen from 1 choice
May 31 01:35:43 itx229 kernel: [4294678.273000] hub 2-0:1.0: USB hub found
May 31 01:35:43 itx229 kernel: [4294678.273000] hub 2-0:1.0: 2 ports detected
May 31 01:35:43 itx229 kernel: [4294678.456000] usb 1-1: new full
speed USB device using uhci_hcd and address 2
May 31 01:35:43 itx229 kernel: [4294678.614000] usb 1-1: configuration
#1 chosen from 1 choice
May 31 01:35:43 itx229 kernel: [4294678.836000] ACPI: PCI Interrupt
0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 169
May 31 01:35:43 itx229 kernel: [4294678.836000] uhci_hcd 0000:00:1d.2:
UHCI Host Controller
May 31 01:35:43 itx229 kernel: [4294678.846000] uhci_hcd 0000:00:1d.2:
new USB bus registered, assigned bus number 3
May 31 01:35:43 itx229 kernel: [4294678.846000] uhci_hcd 0000:00:1d.2:
irq 169, io base 0x0000e200
May 31 01:35:43 itx229 kernel: [4294678.849000] usb usb3:
configuration #1 chosen from 1 choice
May 31 01:35:43 itx229 kernel: [4294678.851000] hub 3-0:1.0: USB hub found
May 31 01:35:43 itx229 kernel: [4294678.851000] hub 3-0:1.0: 2 ports detected
May 31 01:35:43 itx229 kernel: [4294679.976000] md: Autodetecting RAID arrays.
May 31 01:35:43 itx229 kernel: [4294679.976000] md: autorun ...
May 31 01:35:43 itx229 kernel: [4294679.976000] md: ... autorun DONE.
==============================

Regards
Keith
