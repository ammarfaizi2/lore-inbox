Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWCNNgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWCNNgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWCNNgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:36:37 -0500
Received: from mxsf15.cluster1.charter.net ([209.225.28.215]:58797 "EHLO
	mxsf15.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932445AbWCNNgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 08:36:37 -0500
X-IronPort-AV: i="4.02,190,1139202000"; 
   d="cap'?gz'50?scan'50,208,50"; a="2049270204:sNHT58027346"
Message-ID: <4416C6DD.80209@cybsft.com>
Date: Tue, 14 Mar 2006 07:36:29 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
Subject: Re: 2.6.16-rc6-rt3
References: <20060314084658.GA28947@elte.hu>
In-Reply-To: <20060314084658.GA28947@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------060209090608080403080803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060209090608080403080803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the 2.6.16-rc6-rt3 tree, which can be downloaded from 
> the usual place:
> 

This one doesn't want to boot on the old SMP box. Log and config attached.

-- 
   kr

--------------060209090608080403080803
Content-Type: text/plain;
 name="2.6.16-rc6-rt3.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.16-rc6-rt3.cap"

Linux version 2.6.16-rc6-rt3 (kr@porky.cybersoft.int) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #19 SMP PREEMPT Tue Mar 14 07:12:19 CST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
 BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 931.007 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0 nmi_watchdog=1 
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 2048 (order: 11, 32768 bytes)
requested: 50000000  calculated 49992350 ns 50 cyc error: 7650
Event source pit installed with caps set: 01
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 506304k/523896k available (1785k kernel code, 17208k reserved, 921k data, 280k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1862.56 BogoMIPS (lpj=931284)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1861.67 BogoMIPS (lpj=930838)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3724.24 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Event source lapic installed with caps set: 04
checking TSC synchronization across 2 CPUs: passed.
Event source lapic installed with caps set: 04
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 433k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfc03e, last bus=4
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0d: ioport range 0x800-0x85f could not be reserved
pnp: 00:0d: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0d: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fdffffff
  PREFETCH window: f4000000-f5ffffff
PCI: Bridge: 0000:02:1f.0
  IO window: disabled.
  MEM window: fb000000-fb0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: fb000000-fbffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: f9000000-faffffff
  PREFETCH window: 30000000-300fffff
No per-cpu room for modules.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
nvidiafb: PCI id - 10de002d
nvidiafb: Actual id - 10de002d
nvidiafb: nVidia device/chipset 10DE002D
nvidiafb: HW is currently programmed for CRT
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
nvidiafb: PCI nVidia NV2 framebuffer (32MB @ 0xF4000000)
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG CD-R/RW SW-248F, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 9, 2490368 bytes)
TCP bind hash table entries: 32768 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
NET: Registered protocol family 8
NET: Registered protocol family 20
Testing NMI watchdog ... OK.
Starting balanced_irq
Using IPI Shortcut mode
*****************************************************************************
*                                                                           *
requested: 50000000  calculated 50000000 ns 46550352 cyc error: 0
Time: tsc clocksource has been installed.
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 280k freed
Could not allocate 8 bytes percpu data
BUG: Unable to handle kernel paging request at virtual address f3010000
 printing eip:
c0131c79
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0131c79>]    Not tainted VLI
EFLAGS: 00010297   (2.6.16-rc6-rt3 #19) 
EIP is at __find_symbol+0x37/0x1da
eax: ffffffff   ebx: 000004b0   ecx: c02fe964   edx: c02fab00
esi: f3010000   edi: e08255d0   ebp: de78fe9c   esp: de78fe8c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process insmod (pid: 804, threadinfo=de78e000 task=de4f9840 stack_left=7768 worst_left=-1)
Stack: <0>000004b0 e082adc0 e082bc80 e08255d0 de78fec8 c0132cc6 e08255d0 de78feb4 
       de78feb8 00000001 00000000 e082adc0 e082adc0 00000370 00000032 de78fef0 
       c013321c e0824930 0000000b e08255d0 e082bc80 00000000 e0824930 e082bc8d 
Call Trace:
 [<c01038fb>] show_stack_log_lvl+0xa5/0xad (44)
 [<c0103a67>] show_registers+0x137/0x1a0 (44)
 [<c0103c3b>] die+0xf3/0x16f (56)
 [<c0111e19>] do_page_fault+0x36f/0x48a (88)
 [<c010357f>] error_code+0x4f/0x54 (76)
 [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
 [<c013321c>] simplify_symbols+0x81/0xf4 (40)
 [<c0133e2d>] load_module+0x637/0x968 (168)
 [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02bd871>] .... _raw_spin_lock_irqsave+0x11/0x33
.....[<c0103b87>] ..   ( <= die+0x3f/0x16f)

------------------------------
| showing all locks held by: |  (insmod/804 [de4f9840, 120]):
------------------------------

#001:             [c0311f24] {module_mutex.lock}
... acquired at:               rt_down_interruptible+0x15/0x32

Code: 00 00 00 00 b8 80 85 2f c0 3d 04 cb 2f c0 c7 45 f0 00 00 00 00 73 4a 89 c2 b9 a4 d6 2f c0 8b 5d f0 8b 7d 08 8b 34 dd 84 85 2f c0 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 11 8b 
 BUG: nonzero lock count 1 at exit time?
          insmod:  804 [de4f9840, 120]
 [<c0103854>] show_trace+0x13/0x15 (20)
 [<c010392e>] dump_stack+0x16/0x18 (20)
 [<c013067f>] rt_mutex_debug_check_no_locks_held+0x60/0x227 (44)
 [<c011c837>] do_exit+0x3e3/0x45b (32)
 [<c0103cb7>] do_trap+0x0/0x97 (52)
 [<c0111e19>] do_page_fault+0x36f/0x48a (88)
 [<c010357f>] error_code+0x4f/0x54 (76)
 [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
 [<c013321c>] simplify_symbols+0x81/0xf4 (40)
 [<c0133e2d>] load_module+0x637/0x968 (168)
 [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (insmod/804 [de4f9840, 120]):
------------------------------

#001:             [c0311f24] {module_mutex.lock}
... acquired at:               rt_down_interruptible+0x15/0x32

BUG: insmod/804, lock held at task exit time!
 [c0311f24] {module_mutex.lock}
.. ->owner: de4f9840
.. held by:            insmod:  804 [de4f9840, 120]
... acquired at:               rt_down_interruptible+0x15/0x32
BUG at kernel/rtmutex.c:674!
------------[ cut here ]------------
kernel BUG at kernel/rtmutex.c:674!
invalid opcode: 0000 [#2]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c02bd019>]    Not tainted VLI
EFLAGS: 00010202   (2.6.16-rc6-rt3 #19) 
EIP is at rt_mutex_slowlock+0xaf/0x262
eax: 00000020   ebx: de78e000   ecx: de4f9840   edx: 00000002
esi: 00000000   edi: c0311f24   ebp: de78ff78   esp: de78fef0
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process insmod (pid: 805, threadinfo=de78e000 task=de4f9840 stack_left=7868 worst_left=-1)
Stack: <0>c02cc5bf c02d2c3d 000002a2 ffffffff 00000000 00000000 00000002 c02bcf49 
       c1d307c8 c1d307a0 de78ff20 c02bd5a5 de78ff2c c0130fd3 00000000 0000008c 
       de78ff30 de78ff30 de78ff38 de78ff38 00000000 0000008c de78ff48 de78ff48 
Call Trace:
 [<c01038fb>] show_stack_log_lvl+0xa5/0xad (44)
 [<c0103a67>] show_registers+0x137/0x1a0 (44)
 [<c0103c3b>] die+0xf3/0x16f (56)
 [<c0103d32>] do_trap+0x7b/0x97 (32)
 [<c0103f89>] do_invalid_op+0x90/0x97 (204)
 [<c010357f>] error_code+0x4f/0x54 (196)
 [<c02bd285>] rt_mutex_lock_interruptible+0x2f/0x39 (28)
 [<c0131142>] rt_down_interruptible+0x15/0x32 (16)
 [<c01341a6>] sys_init_module+0x22/0x1d3 (16)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02bd8a1>] .... _raw_spin_lock_irq+0xe/0x22
.....[<c02bcfa0>] ..   ( <= rt_mutex_slowlock+0x36/0x262)
.. [<c02bd871>] .... _raw_spin_lock_irqsave+0x11/0x33
.....[<c0103b87>] ..   ( <= die+0x3f/0x16f)

------------------------------
| showing all locks held by: |  (insmod/805 [de4f9840, 119]):
------------------------------

Code: c0 e9 d0 01 00 00 8b 47 1c bb 00 e0 ff ff 21 e3 83 e0 fc 3b 03 75 1f 68 a2 02 00 00 68 3d 2c 2d c0 68 bf c5 2c c0 e8 87 d3 e5 ff <0f> 0b a2 02 3d 2c 2d c0 83 c4 0c 8b 03 8b 58 14 85 db 78 2e c7 
 <3>BUG: sleeping function called from invalid context insmod(805) at kernel/rtmutex.c:831
in_atomic():1 [00000001], irqs_disabled():0
 [<c0103854>] show_trace+0x13/0x15 (20)
 [<c010392e>] dump_stack+0x16/0x18 (20)
 [<c0117077>] __might_sleep+0xce/0xd8 (36)
 [<c02bd23a>] rt_mutex_lock+0x15/0x31 (20)
 [<c01310ed>] rt_down_read+0x3c/0x3f (12)
 [<c011abb1>] profile_task_exit+0xd/0x2b (8)
 [<c011c46e>] do_exit+0x1a/0x45b (32)
 [<c0103cb7>] do_trap+0x0/0x97 (52)
 [<c0103d32>] do_trap+0x7b/0x97 (32)
 [<c0103f89>] do_invalid_op+0x90/0x97 (204)
 [<c010357f>] error_code+0x4f/0x54 (196)
 [<c02bd285>] rt_mutex_lock_interruptible+0x2f/0x39 (28)
 [<c0131142>] rt_down_interruptible+0x15/0x32 (16)
 [<c01341a6>] sys_init_module+0x22/0x1d3 (16)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02bd8a1>] .... _raw_spin_lock_irq+0xe/0x22
.....[<c02bcfa0>] ..   ( <= rt_mutex_slowlock+0x36/0x262)

------------------------------
| showing all locks held by: |  (insmod/805 [de4f9840, 119]):
------------------------------

note: insmod[805] exited with preempt_count 1
BUG: scheduling while atomic: insmod/0x00000001/805
caller is do_exit+0x41a/0x45b
 [<c0103854>] show_trace+0x13/0x15 (20)
 [<c010392e>] dump_stack+0x16/0x18 (20)
 [<c02bbab6>] __schedule+0x6c/0x6e0 (76)
 [<c011c86e>] do_exit+0x41a/0x45b (28)
 [<c0103cb7>] do_trap+0x0/0x97 (52)
 [<c0103d32>] do_trap+0x7b/0x97 (32)
 [<c0103f89>] do_invalid_op+0x90/0x97 (204)
 [<c010357f>] error_code+0x4f/0x54 (196)
 [<c02bd285>] rt_mutex_lock_interruptible+0x2f/0x39 (28)
 [<c0131142>] rt_down_interruptible+0x15/0x32 (16)
 [<c01341a6>] sys_init_module+0x22/0x1d3 (16)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02bd8a1>] .... _raw_spin_lock_irq+0xe/0x22
.....[<c02bcfa0>] ..   ( <= rt_mutex_slowlock+0x36/0x262)

------------------------------
| showing all locks held by: |  (insmod/805 [de4f9840, 119]):
------------------------------

NMI watchdog detected lockup on CPU#0 (5000/5000)

Pid: 806, comm:               insmod
EIP: 0060:[<c02bd8ac>] CPU: 0
EIP is at _raw_spin_lock_irq+0x19/0x22
 EFLAGS: 00000086    Not tainted  (2.6.16-rc6-rt3 #19)
EAX: 00000001 EBX: c0311f24 ECX: c02bcfa0 EDX: 00000001
ESI: 00000000 EDI: c0311f24 EBP: de78fef0 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f7b007 CR3: 1fb9b000 CR4: 000006d0
 [<c0103854>] show_trace+0x13/0x15 (20)
 [<c01010c5>] show_regs+0x111/0x118 (44)
 [<c010e415>] nmi_watchdog_tick+0x12c/0x23e (44)
 [<c01045b9>] default_do_nmi+0x6f/0x13d (88)
 [<c01046bc>] do_nmi+0x2e/0x34 (16)
 [<c0103626>] nmi_stack_correct+0x1d/0x22 (64)
 [<c02bcfa0>] rt_mutex_slowlock+0x36/0x262 (136)
 [<c02bd285>] rt_mutex_lock_interruptible+0x2f/0x39 (28)
 [<c0131142>] rt_down_interruptible+0x15/0x32 (16)
 [<c01341a6>] sys_init_module+0x22/0x1d3 (16)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02bd8a1>] .... _raw_spin_lock_irq+0xe/0x22
.....[<c02bcfa0>] ..   ( <= rt_mutex_slowlock+0x36/0x262)
.. [<c02bd9be>] .... _raw_spin_lock+0xd/0x21
.....[<c010e3f1>] ..   ( <= nmi_watchdog_tick+0x108/0x23e)

------------------------------
| showing all locks held by: |  (insmod/806 [de4f9840, 119]):
------------------------------

NMI show regs on CPU#1:
 
--------------060209090608080403080803
Content-Type: application/x-gzip;
 name="config.porky.2.6.16-rc6-rt3.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.porky.2.6.16-rc6-rt3.gz"

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
--------------060209090608080403080803--
