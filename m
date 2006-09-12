Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWILU5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWILU5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWILU5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:57:54 -0400
Received: from us.cactii.net ([66.160.141.151]:55813 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1030378AbWILTil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:38:41 -0400
Date: Tue, 12 Sep 2006 21:38:10 +0200
From: Ben B <kernel@bb.cactii.net>
To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: speedstep-centrino broke
Message-ID: <20060912193810.GA20226@cactii.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My HP notebook decided that its BIOS upgrade would break
speedstep-centrino, and trying to load the module gives me a "no such
device" error. This is with various combinations of kernel config
relating to cpufreq. Also tried acpi-cpufreq with the same error.

I suspect that the new bios is broken, but perhaps it's correct and the
linux driver is missing something?

Anyway, relevent info below.

Cheers,
Ben

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Genuine Intel(R) CPU           T2400  @ 1.83GHz
stepping	: 8
cpu MHz		: 1829.084
cache size	: 2048 KB
physical id	: 0
siblings	: 1
core id		: 255
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc pni monitor vmx est tm2 xtpr
bogomips	: 3663.73

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 14
model name	: Genuine Intel(R) CPU           T2400  @ 1.83GHz
stepping	: 8
cpu MHz		: 1829.084
cache size	: 2048 KB
physical id	: 1
siblings	: 1
core id		: 255
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc pni monitor vmx est tm2 xtpr
bogomips	: 3657.75

[17179569.184000] Linux version 2.6.17-6-686 (root@rothera) (gcc version 4.1.2 20060715 (prerelease) (Ubuntu 4.1.1-9ubuntu1)) #2 SMP Fri Aug 11 22:09:15 UTC 2006
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000003f7d0000 (usable)
[17179569.184000]  BIOS-e820: 000000003f7d0000 - 000000003f7e5600 (reserved)
[17179569.184000]  BIOS-e820: 000000003f7e5600 - 000000003f7f8000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 000000003f7f8000 - 000000003f800000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)
[17179569.184000]  BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[17179569.184000] 119MB HIGHMEM available.
[17179569.184000] 896MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 260048
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   Normal zone: 225280 pages, LIFO batch:31
[17179569.184000]   HighMem zone: 30672 pages, LIFO batch:7
[17179569.184000] DMI 2.4 present.
[17179569.184000] ACPI: RSDP (v002 HP                                    ) @ 0x000f7c10
[17179569.184000] ACPI: XSDT (v001 HP     30AD     0x10080620 HP   0x00000001) @ 0x3f7e57b8
[17179569.184000] ACPI: FADT (v004 HP     30AD     0x00000003 HP   0x00000001) @ 0x3f7e5684
[17179569.184000] ACPI: MADT (v001 HP     30AD     0x00000001 HP   0x00000001) @ 0x3f7e5814
[17179569.184000] ACPI: MCFG (v001 HP     30AD     0x00000001 HP   0x00000001) @ 0x3f7e587c
[17179569.184000] ACPI: TCPA (v002 HP     30AD     0x00000001 HP   0x00000001) @ 0x3f7e58b8
[17179569.184000] ACPI: SSDT (v001 HP       HPQNLP 0x00000001 MSFT 0x0100000e) @ 0x3f7f4f3d
[17179569.184000] ACPI: SSDT (v001 HP       HPQSAT 0x00000001 MSFT 0x0100000e) @ 0x3f7f4f96
[17179569.184000] ACPI: DSDT (v001 HP       nc6400 0x00010000 MSFT 0x0100000e) @ 0x00000000
[17179569.184000] ACPI: PM-Timer IO Port: 0x1008
[17179569.184000] ACPI: Local APIC address 0xfee00000
[17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:14 APIC version 20
[17179569.184000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[17179569.184000] Processor #1 6:14 APIC version 20
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[17179569.184000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[17179569.184000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[17179569.184000] ACPI: IRQ0 used by override.
[17179569.184000] ACPI: IRQ2 used by override.
[17179569.184000] ACPI: IRQ9 used by override.
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 40000000 (gap: 3f800000:bf400000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/sda1 ro single
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)
[17179569.184000] Enabling fast FPU save and restore... done.
[17179569.184000] Enabling unmasked SIMD FPU exception support... done.
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[17179569.184000] Detected 1829.084 MHz processor.
[17179569.184000] Using pmtmr for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179569.976000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[17179569.976000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[17179569.996000] Memory: 1018444k/1040192k available (1890k kernel code, 21004k reserved, 1031k data, 308k init, 122688k highmem)
[17179569.996000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[17179570.076000] Calibrating delay using timer specific routine.. 3663.73 BogoMIPS (lpj=7327463)
[17179570.076000] Security Framework v1.0.0 initialized
[17179570.076000] SELinux:  Disabled at boot.
[17179570.076000] Mount-cache hash table entries: 512
[17179570.076000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[17179570.076000] CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[17179570.076000] monitor/mwait feature present.
[17179570.076000] using mwait in idle threads.
[17179570.076000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179570.076000] CPU: L2 cache: 2048K
[17179570.076000] CPU: Hyper-Threading is disabled
[17179570.076000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
[17179570.076000] Checking 'hlt' instruction... OK.
[17179570.092000] SMP alternatives: switching to UP code
[17179570.092000] checking if image is initramfs... it is
[17179570.820000] Freeing initrd memory: 8335k freed
[17179570.820000] ACPI: Looking for DSDT ... not found!
[17179570.896000] CPU0: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
[17179570.896000] SMP alternatives: switching to SMP code
[17179570.896000] Booting processor 1/1 eip 3000
[17179570.908000] Initializing CPU#1
[17179570.988000] Calibrating delay using timer specific routine.. 3657.75 BogoMIPS (lpj=7315519)
[17179570.988000] CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[17179570.988000] CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000c1a9 00000000 00000000
[17179570.988000] monitor/mwait feature present.
[17179570.988000] CPU: L1 I cache: 32K, L1 D cache: 32K
[17179570.988000] CPU: L2 cache: 2048K
[17179570.988000] CPU: Hyper-Threading is disabled
[17179570.988000] CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 00000000 00000000
[17179570.988000] CPU1: Intel Genuine Intel(R) CPU           T2400  @ 1.83GHz stepping 08
[17179570.988000] Total of 2 processors activated (7321.49 BogoMIPS).
[17179570.988000] ENABLING IO-APIC IRQs
[17179570.988000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[17179571.132000] checking TSC synchronization across 2 CPUs: passed.
[17179571.136000] Brought up 2 CPUs
[17179571.248000] migration_cost=4000
[17179571.248000] HP Compaq Laptop series board detected. Selecting BIOS-method for reboots.
[17179571.248000] NET: Registered protocol family 16
[17179571.248000] EISA bus registered
[17179571.248000] ACPI: bus type pci registered
[17179571.248000] PCI: BIOS Bug: MCFG area is not E820-reserved
[17179571.248000] PCI: Not using MMCONFIG.
[17179571.248000] PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=32
[17179571.248000] Setting up standard PCI resources
[17179571.248000] ACPI: Subsystem revision 20060127
[17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C341 (name not of form _Lxx or _Exx) [20060127]
[17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C23A (name not of form _Lxx or _Exx) [20060127]
[17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C342 (name not of form _Lxx or _Exx) [20060127]
[17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C343 (name not of form _Lxx or _Exx) [20060127]
[17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C26F (name not of form _Lxx or _Exx) [20060127]
[17179571.304000] ACPI: Interpreter enabled
[17179571.304000] ACPI: Using IOAPIC for interrupt routing
[17179571.304000] ACPI: PCI Root Bridge [C002] (0000:00)
[17179571.304000] PCI: Probing PCI hardware (bus 00)
[17179571.304000] ACPI: Assume root bridge [\_SB_.C002] bus is 0
[17179571.312000] Boot video device is 0000:00:02.0
[17179571.312000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[17179571.316000] PCI: Transparent bridge - 0000:00:1e.0
[17179571.316000] PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
[17179571.316000] Please report the result to linux-kernel to fix this permanently
[17179571.316000] ACPI: PCI Interrupt Routing Table [\_SB_.C002._PRT]
[17179571.348000] ACPI: PCI Interrupt Routing Table [\_SB_.C002.C093._PRT]
[17179571.352000] ACPI: Embedded Controller [C005] (gpe 22) interrupt mode.
[17179571.364000] ACPI: Power Resource [C1E6] (on)
[17179571.364000] ACPI: Power Resource [C1ED] (on)
[17179571.368000] ACPI: Power Resource [C213] (on)
[17179571.368000] ACPI: PCI Interrupt Routing Table [\_SB_.C002.C0F9._PRT]
[17179571.368000] ACPI: PCI Interrupt Routing Table [\_SB_.C002.C109._PRT]
[17179571.368000] ACPI: PCI Interrupt Routing Table [\_SB_.C002.C10F._PRT]
[17179571.372000] ACPI: Power Resource [C21B] (on)
[17179571.372000] ACPI: PCI Interrupt Link [C105] (IRQs *10 11)
[17179571.372000] ACPI: PCI Interrupt Link [C106] (IRQs *10 11)
[17179571.372000] ACPI: PCI Interrupt Link [C107] (IRQs 10 *11)
[17179571.372000] ACPI: PCI Interrupt Link [C108] (IRQs 10 11) *5
[17179571.376000] ACPI: PCI Interrupt Link [C11B] (IRQs *10 11)
[17179571.376000] ACPI: PCI Interrupt Link [C11C] (IRQs *10 11)
[17179571.376000] ACPI: PCI Interrupt Link [C11D] (IRQs 10 *11)
[17179571.380000] ACPI: Power Resource [C31A] (off)
[17179571.380000] ACPI: Power Resource [C31B] (off)
[17179571.380000] ACPI: Power Resource [C31C] (off)
[17179571.380000] ACPI: Power Resource [C31D] (off)
[17179571.380000] Linux Plug and Play Support v0.97 (c) Adam Belay
[17179571.380000] pnp: PnP ACPI init
[17179571.388000] pnp: PnP ACPI: found 15 devices
[17179571.388000] PnPBIOS: Disabled by ACPI PNP
[17179571.388000] PCI: Using ACPI for IRQ routing
[17179571.388000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[17179571.516000] pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
[17179571.516000] pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
[17179571.516000] pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
[17179571.516000] pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
[17179571.516000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[17179571.516000] PCI: Bridge: 0000:00:1c.0
[17179571.520000]   IO window: disabled.
[17179571.520000]   MEM window: f4100000-f41fffff
[17179571.520000]   PREFETCH window: disabled.
[17179571.520000] PCI: Bridge: 0000:00:1c.1
[17179571.520000]   IO window: disabled.
[17179571.520000]   MEM window: f4000000-f40fffff
[17179571.520000]   PREFETCH window: disabled.
[17179571.520000] PCI: Bridge: 0000:00:1c.3
[17179571.520000]   IO window: 2000-3fff
[17179571.520000]   MEM window: f0000000-f3ffffff
[17179571.520000]   PREFETCH window: disabled.
[17179571.520000] PCI: Bus 3, cardbus bridge: 0000:02:06.0
[17179571.520000]   IO window: 00005000-000050ff
[17179571.520000]   IO window: 00005400-000054ff
[17179571.520000]   PREFETCH window: 40000000-41ffffff
[17179571.520000]   MEM window: 42000000-43ffffff
[17179571.520000] PCI: Bridge: 0000:00:1e.0
[17179571.520000]   IO window: 5000-5fff
[17179571.520000]   MEM window: f4200000-f45fffff
[17179571.520000]   PREFETCH window: 40000000-41ffffff
[17179571.520000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179571.520000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179571.520000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 185
[17179571.520000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[17179571.520000] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
[17179571.520000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[17179571.520000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[17179571.520000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 201
[17179571.520000] NET: Registered protocol family 2
[17179571.564000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[17179571.564000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[17179571.564000] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[17179571.564000] TCP: Hash tables configured (established 131072 bind 65536)
[17179571.564000] TCP reno registered
[17179571.564000] audit: initializing netlink socket (disabled)
[17179571.564000] audit(1158088397.564:1): initialized
[17179571.564000] highmem bounce pool size: 64 pages
[17179571.564000] VFS: Disk quotas dquot_6.5.1
[17179571.564000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[17179571.564000] Initializing Cryptographic API
[17179571.564000] io scheduler noop registered
[17179571.564000] io scheduler anticipatory registered
[17179571.564000] io scheduler deadline registered
[17179571.564000] io scheduler cfq registered (default)
[17179571.564000] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179571.568000] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[17179571.568000] assign_interrupt_mode Found MSI capability
[17179571.568000] Allocate Port Service[0000:00:1c.0:pcie00]
[17179571.568000] Allocate Port Service[0000:00:1c.0:pcie02]
[17179571.568000] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 185
[17179571.568000] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[17179571.568000] assign_interrupt_mode Found MSI capability
[17179571.568000] Allocate Port Service[0000:00:1c.1:pcie00]
[17179571.568000] Allocate Port Service[0000:00:1c.1:pcie02]
[17179571.568000] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
[17179571.568000] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[17179571.568000] assign_interrupt_mode Found MSI capability
[17179571.568000] Allocate Port Service[0000:00:1c.3:pcie00]
[17179571.568000] Allocate Port Service[0000:00:1c.3:pcie02]
[17179571.568000] isapnp: Scanning for PnP cards...
[17179571.924000] isapnp: No Plug & Play device found
[17179571.940000] Real Time Clock Driver v1.12ac
[17179571.940000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[17179571.944000] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[17179571.944000] mice: PS/2 mouse device common for all mice
[17179571.944000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[17179571.944000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[17179571.944000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[17179571.944000] PNP: PS/2 Controller [PNP0303:C210,PNP0f13:C211] at 0x60,0x64 irq 1,12
[17179571.944000] i8042.c: Detected active multiplexing controller, rev 1.1.
[17179571.948000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[17179571.948000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[17179571.948000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[17179571.948000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[17179571.948000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.948000] EISA: Probing bus 0 at eisa.0
[17179571.948000] Cannot allocate resource for EISA slot 1
[17179571.948000] Cannot allocate resource for EISA slot 2
[17179571.948000] Cannot allocate resource for EISA slot 3
[17179571.948000] Cannot allocate resource for EISA slot 4
[17179571.948000] Cannot allocate resource for EISA slot 5
[17179571.948000] EISA: Detected 0 cards.
[17179571.948000] TCP bic registered
[17179571.948000] NET: Registered protocol family 1
[17179571.948000] NET: Registered protocol family 8
[17179571.948000] NET: Registered protocol family 20
[17179571.948000] Starting balanced_irq
[17179571.948000] Using IPI No-Shortcut mode
[17179571.948000] ACPI wakeup devices: 
[17179571.948000] C093 C0EF C0F0 C0F1 C0F2 C0F9 C21C C109 C227 C10F C228 
[17179571.948000] ACPI: (supports S0 S3 S4 S5)
[17179571.948000] Freeing unused kernel memory: 308k freed
[17179571.976000] input: AT Translated Set 2 keyboard as /class/input/input0
[17179571.996000] usbcore: registered new driver usbfs
[17179571.996000] usbcore: registered new driver hub
[17179572.000000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 50
[17179572.000000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[17179572.000000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[17179572.000000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[17179572.000000] ehci_hcd 0000:00:1d.7: debug port 1
[17179572.000000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[17179572.000000] ehci_hcd 0000:00:1d.7: irq 50, io mem 0xf4784000
[17179572.004000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[17179572.004000] usb usb1: configuration #1 chosen from 1 choice
[17179572.004000] hub 1-0:1.0: USB hub found
[17179572.004000] hub 1-0:1.0: 8 ports detected
[17179572.672000] usbcore: registered new driver libusual
[17179572.680000] SCSI subsystem initialized
[17179572.680000] Initializing USB Mass Storage driver...
[17179572.680000] usbcore: registered new driver usb-storage
[17179572.680000] USB Mass Storage support registered.
[17179572.684000] Capability LSM initialized
[17179572.712000] ACPI: Fan [C31E] (off)
[17179572.712000] ACPI: Fan [C31F] (off)
[17179572.712000] ACPI: Fan [C320] (off)
[17179572.712000] ACPI: Fan [C321] (off)
[17179572.716000] ACPI: Processor [CPU0] (supports 8 throttling states)
[17179572.716000] ACPI: Processor [CPU1] (supports 8 throttling states)
[17179572.740000] ACPI: Thermal Zone [TZ0] (53 C)
[17179572.756000] ACPI: Thermal Zone [TZ1] (55 C)
[17179572.768000] ACPI: Thermal Zone [TZ2] (50 C)
[17179572.776000] ACPI: Thermal Zone [TZ3] (16 C)
[17179572.780000] ACPI: Thermal Zone [TZ4] (46 C)
[17179573.092000] libata version 1.20 loaded.
[17179573.092000] ahci 0000:00:1f.2: version 1.2
[17179573.092000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 21 (level, low) -> IRQ 58
[17179578.912000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[17179578.912000] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
[17179578.912000] ahci 0000:00:1f.2: flags: 64bit ncq ilck stag pm led clo pmp pio slum part 
[17179578.912000] ata1: SATA max UDMA/133 cmd 0xF88A8100 ctl 0x0 bmdma 0x0 irq 66
[17179578.912000] ata2: SATA max UDMA/133 cmd 0xF88A8180 ctl 0x0 bmdma 0x0 irq 66
[17179578.916000] ata3: SATA max UDMA/133 cmd 0xF88A8200 ctl 0x0 bmdma 0x0 irq 66
[17179578.916000] ata4: SATA max UDMA/133 cmd 0xF88A8280 ctl 0x0 bmdma 0x0 irq 66
[17179580.024000] ata1: SATA link up 1.5 Gbps (SStatus 113)
[17179580.028000] ata1: dev 0 cfg 49:2f00 82:306b 83:7c09 84:6023 85:3069 86:3c09 87:6023 88:203f
[17179580.028000] ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
[17179580.028000] ata1: dev 0 configured for UDMA/100
[17179580.028000] scsi0 : ahci
[17179580.396000] ata2: SATA link down (SStatus 0)
[17179580.396000] scsi1 : ahci
[17179580.764000] ata3: SATA link down (SStatus 0)
[17179580.764000] scsi2 : ahci
[17179581.132000] ata4: SATA link down (SStatus 0)
[17179581.132000] scsi3 : ahci
[17179581.132000]   Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 892C
[17179581.136000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[17179581.140000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[17179581.140000] sda: Write Protect is off
[17179581.140000] sda: Mode Sense: 00 3a 00 00
[17179581.140000] SCSI device sda: drive cache: write back
[17179581.140000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[17179581.140000] sda: Write Protect is off
[17179581.140000] sda: Mode Sense: 00 3a 00 00
[17179581.140000] SCSI device sda: drive cache: write back
[17179581.140000]  sda: sda1 sda2 < sda5 >
[17179581.540000] sd 0:0:0:0: Attached scsi disk sda
[17179581.772000] ICH7: IDE controller at PCI slot 0000:00:1f.1
[17179581.772000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 177
[17179581.772000] ICH7: chipset revision 1
[17179581.772000] ICH7: not 100% native mode: will probe irqs later
[17179581.772000]     ide0: BM-DMA at 0x40a0-0x40a7, BIOS settings: hda:DMA, hdb:pio
[17179581.772000] Probing IDE interface ide0...
[17179582.508000] hda: UJDA775 DVD/CDRW, ATAPI CD/DVD-ROM drive
[17179582.848000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[17179582.856000] hda: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
[17179582.856000] Uniform CD-ROM driver Revision: 3.20
[17179582.888000] Probing IDE interface ide1...
[17179582.904000] USB Universal Host Controller Interface driver v3.0
[17179582.904000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 50
[17179582.904000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[17179582.904000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[17179582.904000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[17179582.904000] uhci_hcd 0000:00:1d.0: irq 50, io base 0x00004020
[17179582.904000] usb usb2: configuration #1 chosen from 1 choice
[17179582.904000] hub 2-0:1.0: USB hub found
[17179582.904000] hub 2-0:1.0: 2 ports detected
[17179583.008000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 74
[17179583.008000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[17179583.008000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[17179583.008000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[17179583.008000] uhci_hcd 0000:00:1d.1: irq 74, io base 0x00004040
[17179583.012000] usb usb3: configuration #1 chosen from 1 choice
[17179583.012000] hub 3-0:1.0: USB hub found
[17179583.012000] hub 3-0:1.0: 2 ports detected
[17179583.116000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
[17179583.116000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[17179583.116000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[17179583.116000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[17179583.116000] uhci_hcd 0000:00:1d.2: irq 201, io base 0x00004060
[17179583.116000] usb usb4: configuration #1 chosen from 1 choice
[17179583.120000] hub 4-0:1.0: USB hub found
[17179583.120000] hub 4-0:1.0: 2 ports detected
[17179583.224000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 193
[17179583.224000] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[17179583.224000] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[17179583.224000] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[17179583.224000] uhci_hcd 0000:00:1d.3: irq 193, io base 0x00004080
[17179583.224000] usb usb5: configuration #1 chosen from 1 choice
[17179583.228000] hub 5-0:1.0: USB hub found
[17179583.228000] hub 5-0:1.0: 2 ports detected
[17179583.248000] usb 2-1: new full speed USB device using uhci_hcd and address 2
[17179583.424000] usb 2-1: configuration #1 chosen from 1 choice
[17179583.476000] Attempting manual resume
[17179583.516000] kjournald starting.  Commit interval 5 seconds
[17179583.516000] EXT3-fs: mounted filesystem with ordered data mode.
[17179583.668000] usb 3-1: new full speed USB device using uhci_hcd and address 2
[17179583.836000] usb 3-1: configuration #1 chosen from 1 choice
[17179584.080000] usb 4-1: new low speed USB device using uhci_hcd and address 2
[17179584.268000] usb 4-1: configuration #1 chosen from 1 choice
[17179592.780000] parport: PnPBIOS parport detected.
[17179592.780000] parport0: PC-style at 0x378 (0x778), irq 0, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
[17179592.780000] setup_irq: irq handler mismatch
[17179592.780000]  <c01487a8> setup_irq+0x128/0x140  <f895cbc0> parport_pc_interrupt+0x0/0x60 [parport_pc]
[17179592.780000]  <c0148859> request_irq+0x99/0xb0  <f895c200> parport_pc_probe_port+0x610/0xee0 [parport_pc]
[17179592.780000]  <f895cb80> parport_pc_pnp_probe+0xb0/0xf0 [parport_pc]  <c0219eaf> pnp_device_probe+0x4f/0xb0
[17179592.780000]  <c0244c14> driver_probe_device+0x44/0xc0  <c0244d92> __driver_attach+0x82/0x90
[17179592.784000]  <c024457a> bus_for_each_dev+0x3a/0x60  <c0244b56> driver_attach+0x16/0x20
[17179592.784000]  <c0244d10> __driver_attach+0x0/0x90  <c02441dc> bus_add_driver+0x8c/0x140
[17179592.784000]  <c0244fb1> driver_register+0x41/0xa0  <f88394d2> parport_pc_init+0x372/0x38b [parport_pc]
[17179592.784000]  <c013bd4a> sys_init_module+0x14a/0x19c0  <c0127330> __request_region+0x0/0x90
[17179592.784000]  <c0102fd3> sysenter_past_esp+0x54/0x75 
[17179592.784000] parport0: irq 0 in use, resorting to polled operation
[17179592.836000] input: PC Speaker as /class/input/input1
[17179592.912000] ieee80211_crypt: registered algorithm 'NULL'
[17179592.916000] ieee80211: 802.11 data/management/control stack, git-1.1.13
[17179592.916000] ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
[17179592.964000] Bluetooth: Core ver 2.8
[17179592.964000] NET: Registered protocol family 31
[17179592.964000] Bluetooth: HCI device and connection manager initialized
[17179592.964000] Bluetooth: HCI socket layer initialized
[17179593.072000] Bluetooth: HCI USB driver ver 2.9
[17179593.072000] usbcore: registered new driver hci_usb
[17179593.100000] sdhci: Secure Digital Host Controller Interface driver, 0.11
[17179593.100000] sdhci: Copyright(c) Pierre Ossman
[17179593.100000] ACPI: PCI Interrupt 0000:02:06.3[C] -> GSI 22 (level, low) -> IRQ 74
[17179593.196000] mmc0: SDHCI at 0xf4202000 irq 74 PIO
[17179593.200000] Linux agpgart interface v0.101 (c) Dave Jones
[17179593.232000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 201
[17179593.232000] Yenta: CardBus bridge found at 0000:02:06.0 [103c:30ad]
[17179593.232000] Yenta: Enabling burst memory read transactions
[17179593.232000] Yenta: Using INTVAL to route CSC interrupts to PCI
[17179593.232000] Yenta: Routing CardBus interrupts to PCI
[17179593.232000] Yenta TI: socket 0000:02:06.0, mfunc 0x01aa1b22, devctl 0x64
[17179593.292000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[17179593.352000] tpm_inf_pnp 00:04: Found C1FC with ID IFX0102
[17179593.352000] tpm_inf_pnp 00:04: TPM found: config base 0x560, io base 0x570, chip version 0x000b, vendor id 0x15d1 (Infineon), product id 0x000b (SLB 9635 TT 1.2)
[17179593.404000] ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.1.0mp
[17179593.404000] ipw3945: Copyright(c) 2003-2006 Intel Corporation
[17179593.456000] irda_init()
[17179593.456000] NET: Registered protocol family 23
[17179593.468000] Yenta: ISA IRQ mask 0x0cf8, PCI irq 201
[17179593.468000] Socket status: 30000006
[17179593.468000] Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
[17179593.472000] pcmcia: parent PCI bridge I/O window: 0x5000 - 0x5fff
[17179593.472000] cs: IO port probe 0x5000-0x5fff: clean.
[17179593.472000] pcmcia: parent PCI bridge Memory window: 0xf4200000 - 0xf45fffff
[17179593.472000] pcmcia: parent PCI bridge Memory window: 0x40000000 - 0x41ffffff
[17179593.472000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[17179593.472000] tg3.c:v3.59 (June 8, 2006)
[17179593.472000] ACPI: PCI Interrupt 0000:08:00.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179593.472000] PCI: Setting latency timer of device 0000:08:00.0 to 64
[17179593.472000] usbcore: registered new driver hiddev
[17179593.516000] eth0: Tigon3 [partno(BCM95751M) rev 4201 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:16:d4:30:29:66
[17179593.516000] eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
[17179593.516000] eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[17179593.520000] input: Microsoft Microsoft USB Wireless Mouse as /class/input/input2
[17179593.520000] input: USB HID v1.11 Mouse [Microsoft Microsoft USB Wireless Mouse] on usb-0000:00:1d.2-1
[17179593.520000] usbcore: registered new driver usbhid
[17179593.520000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[17179593.520000] ACPI: PCI Interrupt 0000:10:00.0[A] -> GSI 17 (level, low) -> IRQ 185
[17179593.520000] PCI: Setting latency timer of device 0000:10:00.0 to 64
[17179593.528000] agpgart: Detected an Intel 945GM Chipset.
[17179593.528000] agpgart: Detected 7932K stolen memory.
[17179593.544000] agpgart: AGP aperture is 256M @ 0xe0000000
[17179593.544000] ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
[17179593.576000] synaptics reset failed
[17179593.580000] synaptics reset failed
[17179593.584000] synaptics reset failed
[17179593.724000] ts: Compaq touchscreen protocol output
[17179593.752000] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04793/0x300000
[17179593.752000] serio: Synaptics pass-through port at isa0060/serio4/input0
[17179593.796000] input: SynPS/2 Synaptics TouchPad as /class/input/input3
[17179593.832000] hw_random hardware driver 1.0.0 loaded
[17179594.020000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[17179594.160000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 177
[17179594.160000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[17179594.360000] PM: Writing back config space on device 0000:08:00.0 at offset 1 (was 100406, writing 100006)
[17179594.440000] cs: IO port probe 0x100-0x3af: clean.
[17179594.448000] cs: IO port probe 0x3e0-0x4ff: clean.
[17179594.448000] cs: IO port probe 0x820-0x8ff: clean.
[17179594.452000] cs: IO port probe 0xc00-0xcf7: clean.
[17179594.452000] cs: IO port probe 0xa00-0xaff: clean.
[17179595.664000] NET: Registered protocol family 17
[17179596.204000] tg3: eth0: Link is up at 100 Mbps, full duplex.
[17179596.204000] tg3: eth0: Flow control is on for TX and on for RX.
[17179597.832000] Adding 1485972k swap on /dev/disk/by-uuid/7f986e62-f6c3-4676-88af-951b600fafce.  Priority:-1 extents:1 across:1485972k
[17179597.900000] EXT3 FS on sda1, internal journal
[17179598.084000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[17179598.084000] md: bitmap version 4.39
[17179598.196000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
[17179598.316000] input: PS/2 Generic Mouse as /class/input/input4
[17179601.388000] pnp: Device 00:02 disabled.
[17179601.388000] pnp: Device 00:02 activated.
[17179601.424000] pnp: Device 00:02 disabled.
[17179601.424000] pnp: Device 00:02 activated.
[17179603.592000] NET: Registered protocol family 10
[17179603.592000] lo: Disabled Privacy Extensions
[17179603.592000] IPv6 over IPv4 tunneling driver

# dmidecode 2.8
SMBIOS 2.4 present.
23 structures occupying 1032 bytes.
Table at 0x000F37CD.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Hewlett-Packard
	Version: 68YCU Ver. F.05
	Release Date: 08/10/2006
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		3.5"/720 KB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		ACPI is supported
		USB legacy is supported
		LS-120 boot is supported
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 15.5
	Firmware Revision: 86.51

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Compaq nc6400 (RA270AA#ABH)
	Version: F.05
	Serial Number: CND6XXXBD8                      
	UUID: A59E1EE0-B61A-DB11-8BA4-66990C26A129
	Wake-up Type: Power Switch
	SKU Number: RA270AA#ABH
	Family: 103C_5336AN

Handle 0x0040, DMI type 126, 11 bytes
Inactive

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Hewlett-Packard
	Product Name: 30AD
	Version: KBC Version 56.33
	Serial Number: Not Specified

Handle 0x0003, DMI type 3, 13 bytes
Chassis Information
	Manufacturer: Hewlett-Packard
	Type: Notebook
	Lock: Not Present
	Version: Not Specified
	Serial Number: CNDXXX4BD8                      
	Asset Tag:                 
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: External Interface Enabled

Handle 0x0041, DMI type 126, 4 bytes
Inactive

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U10
	Type: Central Processor
	Family: Pentium M
	Manufacturer: Intel(R)
	ID: E8 06 00 00 FF FB E9 BF
	Signature: Type 0, Family 6, Model 14, Stepping 8
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Genuine Intel(R) CPU           T2400  @ 1.83GHz
	Voltage: 1.1 V
	External Clock: 166 MHz
	Max Speed: 1833 MHz
	Current Speed: 1833 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 KB
	Maximum Size: 64 KB
	Supported SRAM Types:
		Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: None
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0007, DMI type 9, 13 bytes
System Slot Information
	Designation: PC CARD-Slot 0
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Short
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		PME signal is supported

Handle 0x0008, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description: 8

Handle 0x0009, DMI type 11, 5 bytes
OEM Strings
	String 1: www.hp.com
	String 2: ABS 70/71 79 7A 7B 7C 7D

Handle 0x000A, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: No Error
	Number Of Devices: 2

Handle 0x000B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM #1
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: AD00000000000000
	Serial Number: 00001034
	Asset Tag: Not Specified
	Part Number: HYMP564S64BP6-Y5  

Handle 0x000C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x000A
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM #2
	Bank Locator: Not Specified
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 7F7F9E0000000000
	Serial Number: 00000000
	Asset Tag: Not Specified
	Part Number: VS512SDS667D2     

Handle 0x000D, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x000A
	Partition Width: 0

Handle 0x000E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000B
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 1

Handle 0x000F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000D
	Partition Row Position: 2

Handle 0x0010, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0085, DMI type 133, 34 bytes
OEM-specific Type
	Header and Data:
		85 22 85 00 01 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 02 00 00 00 00 00 00 00 00
		00 00
	Strings:
		                
		No battery        

Handle 0x0086, DMI type 126, 34 bytes
Inactive

Handle 0x0011, DMI type 144, 26 bytes
OEM-specific Type
	Header and Data:
		90 1A 11 00 16 00 1E 00 9D 00 33 00 06 00 80 00
		00 00 02 00 02 00 C7 00 00 00

Handle 0x0012, DMI type 127, 4 bytes
End Of Table

