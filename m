Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRCHUt2>; Thu, 8 Mar 2001 15:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129643AbRCHUtT>; Thu, 8 Mar 2001 15:49:19 -0500
Received: from athena.intergrafix.net ([206.245.154.69]:1426 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S129624AbRCHUtE>; Thu, 8 Mar 2001 15:49:04 -0500
Date: Thu, 8 Mar 2001 15:48:34 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: NMI messages - 2.4.1-ac13
Message-ID: <Pine.LNX.4.10.10103081540270.1528-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got some NMI messages I have never seen before. In fact i've never seen
a NMI message before.
This is kernel 2.4.1-ac13. Got them while running X (4.0.2) and KDE (2.1).
After 15 mins the system froze hard.
PR440FX mobo, dual ppro 200s, 256MB RAM, aic7xxx, no power management at
all.
I've never had ram problems on this machine (3 1/2 years old).
Kernel messages attached


Mar  8 11:15:52 athena kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue
Mar  8 11:15:52 athena kernel: You probably have a hardware problem with your RAM chips
Mar  8 11:15:52 athena kernel: NMI: IOCK error (debug interrupt?)
Mar  8 11:15:52 athena kernel: CPU:    1
Mar  8 11:15:52 athena kernel: EIP:    0023:[<0824cd1c>]
Mar  8 11:15:52 athena kernel: EFLAGS: 00003296
Mar  8 11:15:52 athena kernel: eax: 0000000f   ebx: 08251f38   ecx: 000003c0   edx: 000073d8
Mar  8 11:15:52 athena kernel: esi: 08264bc0   edi: 000f73d8   ebp: bffff114   esp: bffff0d4
Mar  8 11:15:52 athena kernel: ds: 002b   es: 002b   ss: 002b
Mar  8 11:15:52 athena kernel: Process X (pid: 8832, stackpage=ccf17000)
Mar  8 11:21:17 athena kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue
Mar  8 11:21:17 athena kernel: You probably have a hardware problem with your RAM chips
Mar  8 11:21:17 athena kernel: NMI: IOCK error (debug interrupt?)
Mar  8 11:21:17 athena kernel: CPU:    1
Mar  8 11:21:17 athena kernel: EIP:    0010:[<c010719c>]
Mar  8 11:21:17 athena kernel: EFLAGS: 00003246
Mar  8 11:21:17 athena kernel: eax: 00000000   ebx: c0107170   ecx: c15fe000   edx: c15fe000
Mar  8 11:21:17 athena kernel: esi: c15fe000   edi: c0107170   ebp: 00000000   esp: c15fffb0
Mar  8 11:21:17 athena kernel: ds: 0018   es: 0018   ss: 0018
Mar  8 11:21:17 athena kernel: Process swapper (pid: 0, stackpage=c15ff000)
Mar  8 11:21:17 athena kernel: Stack: c0107202 00000000 00000000 00000000 c027d2ba c1445000 c02e8460 00000000 
Mar  8 11:21:17 athena kernel:        c01c2ac7 00000000 0000000d 00000000 00000000 00000000 c018d60e c1445000 
Mar  8 11:21:17 athena kernel:        00000001 c02e840a 00000000 00000000 
Mar  8 11:21:17 athena kernel: Call Trace: [<c0107202>] [<c01c2ac7>] [<c018d60e>] 
Mar  8 11:21:17 athena kernel: 
Mar  8 11:21:17 athena kernel: Code: c3 8d 76 00 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff 
Mar  8 11:25:19 athena kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue
Mar  8 11:25:19 athena kernel: You probably have a hardware problem with your RAM chips
Mar  8 11:25:19 athena kernel: NMI: IOCK error (debug interrupt?)
Mar  8 11:25:19 athena kernel: CPU:    1
Mar  8 11:25:19 athena kernel: EIP:    0010:[<c010719c>]
Mar  8 11:25:19 athena kernel: EFLAGS: 00003246
Mar  8 11:25:19 athena kernel: eax: 00000000   ebx: c0107170   ecx: c15fe000   edx: c15fe000
Mar  8 11:25:19 athena kernel: esi: c15fe000   edi: c0107170   ebp: 00000000   esp: c15fffb0
Mar  8 11:25:19 athena kernel: ds: 0018   es: 0018   ss: 0018
Mar  8 11:25:19 athena kernel: Process swapper (pid: 0, stackpage=c15ff000)
Mar  8 11:25:19 athena kernel: Stack: c0107202 00000000 00000000 00000000 c027d2ba c1445000 c02e8460 00000000 
Mar  8 11:25:19 athena kernel:        c01c2ac7 00000000 0000000d 00000000 00000000 00000000 c018d60e c1445000 
Mar  8 11:25:19 athena kernel:        00000001 c02e840a 00000000 00000000 
Mar  8 11:25:19 athena kernel: Call Trace: [<c0107202>] [<c01c2ac7>] [<c018d60e>] 
Mar  8 11:25:19 athena kernel: 
Mar  8 11:25:19 athena kernel: Code: c3 8d 76 00 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff 
Mar  8 11:26:56 athena kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue
Mar  8 11:26:56 athena kernel: You probably have a hardware problem with your RAM chips
Mar  8 11:26:56 athena kernel: NMI: IOCK error (debug interrupt?)
Mar  8 11:26:56 athena kernel: CPU:    0
Mar  8 11:26:56 athena kernel: EIP:    0010:[<c010719c>]
Mar  8 11:26:56 athena kernel: EFLAGS: 00003246
Mar  8 11:26:56 athena kernel: eax: 00000000   ebx: c0107170   ecx: c0276000   edx: c0276000
Mar  8 11:26:56 athena kernel: esi: c0276000   edi: c0107170   ebp: 0008e000   esp: c0277fdc
Mar  8 11:26:56 athena kernel: ds: 0018   es: 0018   ss: 0018
Mar  8 11:26:56 athena kernel: Process swapper (pid: 0, stackpage=c0277000)
Mar  8 11:26:56 athena kernel: Stack: c0107202 00010000 c0276000 c0105000 c02788d2 00000000 0009e000 c02ab600 
Mar  8 11:26:56 athena kernel:        c01001cf 
Mar  8 11:26:56 athena kernel: Call Trace: [<c0107202>] [<c0105000>] [<c01001cf>] 
Mar  8 11:26:56 athena kernel: 
Mar  8 11:26:56 athena kernel: Code: c3 8d 76 00 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff 

dmesg:
Mar 08 11:46:59 athena syslog-ng[129]: syslog-ng version 1.4.8 starting
Mar  8 11:46:59 athena kernel: klogd 1.4-0, log source = /proc/kmsg started.
Mar  8 11:47:00 athena kernel: Cannot find map file.
Mar  8 11:47:00 athena kernel: No module symbols loaded.
Mar  8 11:47:00 athena kernel: Linux version 2.4.1-ac13 (root@athena.intergrafix.net) (gcc version 2.95.2 19991024 (release)) #1 SMP Wed Feb 14 11:49:05 EST 2001
Mar  8 11:47:00 athena kernel: BIOS-provided physical RAM map:
Mar  8 11:47:00 athena kernel:  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
Mar  8 11:47:00 athena kernel:  BIOS-e820: 000000000ff00000 @ 0000000000100000 (usable)
Mar  8 11:47:00 athena kernel:  BIOS-e820: 0000000000180000 @ 00000000ffe80000 (reserved)
Mar  8 11:47:00 athena kernel:  BIOS-e820: 0000000000009000 @ 00000000fec00000 (reserved)
Mar  8 11:47:00 athena kernel: Scan SMP from c0000000 for 1024 bytes.
Mar  8 11:47:00 athena kernel: Scan SMP from c009fc00 for 1024 bytes.
Mar  8 11:47:00 athena kernel: Scan SMP from c00f0000 for 65536 bytes.
Mar  8 11:47:00 athena kernel: found SMP MP-table at 000f7ef0
Mar  8 11:47:00 athena kernel: hm, page 000f7000 reserved twice.
Mar  8 11:47:00 athena kernel: hm, page 000f8000 reserved twice.
Mar  8 11:47:00 athena kernel: hm, page 000f7000 reserved twice.
Mar  8 11:47:00 athena kernel: hm, page 000f8000 reserved twice.
Mar  8 11:47:00 athena kernel: On node 0 totalpages: 65536
Mar  8 11:47:00 athena kernel: zone(0): 4096 pages.
Mar  8 11:47:00 athena kernel: zone(1): 61440 pages.
Mar  8 11:47:00 athena kernel: zone(2): 0 pages.
Mar  8 11:47:00 athena kernel: Intel MultiProcessor Specification v1.4
Mar  8 11:47:00 athena kernel:     Virtual Wire compatibility mode.
Mar  8 11:47:00 athena kernel: OEM ID: INTEL    Product ID: PR440FX      APIC at: 0xFEC08000
Mar  8 11:47:00 athena kernel: Processor #0 Pentium(tm) Pro APIC version 17
Mar  8 11:47:00 athena kernel:     Floating point unit present.
Mar  8 11:47:00 athena kernel:     Machine Exception supported.
Mar  8 11:47:00 athena kernel:     64 bit compare & exchange supported.
Mar  8 11:47:00 athena kernel:     Internal APIC present.
Mar  8 11:47:00 athena kernel:     SEP present.
Mar  8 11:47:00 athena kernel:     MTRR  present.
Mar  8 11:47:00 athena kernel:     PGE  present.
Mar  8 11:47:00 athena kernel:     MCA  present.
Mar  8 11:47:00 athena kernel:     CMOV  present.
Mar  8 11:47:00 athena kernel:     Bootup CPU
Mar  8 11:47:00 athena kernel: Processor #12 Pentium(tm) Pro APIC version 17
Mar  8 11:47:00 athena kernel:     Floating point unit present.
Mar  8 11:47:00 athena kernel:     Machine Exception supported.
Mar  8 11:47:00 athena kernel:     64 bit compare & exchange supported.
Mar  8 11:47:00 athena kernel:     Internal APIC present.
Mar  8 11:47:00 athena kernel:     SEP present.
Mar  8 11:47:00 athena kernel:     MTRR  present.
Mar  8 11:47:00 athena kernel:     PGE  present.
Mar  8 11:47:00 athena kernel:     MCA  present.
Mar  8 11:47:00 athena kernel:     CMOV  present.
Mar  8 11:47:00 athena kernel: Bus #0 is PCI   
Mar  8 11:47:00 athena kernel: Bus #18 is ISA   
Mar  8 11:47:00 athena kernel: I/O APIC #13 Version 17 at 0xFEC00000.
Mar  8 11:47:00 athena kernel: Int: type 3, pol 1, trig 1, bus 18, IRQ 00, APIC ID d, APIC INT 00
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 01, APIC ID d, APIC INT 01
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 03, APIC ID d, APIC INT 03
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 04, APIC ID d, APIC INT 04
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 05, APIC ID d, APIC INT 05
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 06, APIC ID d, APIC INT 06
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 07, APIC ID d, APIC INT 07
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 08, APIC ID d, APIC INT 08
Mar  8 11:47:00 athena kernel: Int: type 0, pol 3, trig 3, bus 18, IRQ 09, APIC ID d, APIC INT 09
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 0a, APIC ID d, APIC INT 0a
Mar  8 11:47:00 athena kernel: Int: type 0, pol 3, trig 3, bus 18, IRQ 0b, APIC ID d, APIC INT 0b
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 0c, APIC ID d, APIC INT 0c
Mar  8 11:47:00 athena kernel: Int: type 0, pol 1, trig 1, bus 18, IRQ 0e, APIC ID d, APIC INT 0e
Mar  8 11:47:00 athena kernel: Int: type 0, pol 3, trig 3, bus 18, IRQ 0f, APIC ID d, APIC INT 0f
Mar  8 11:47:00 athena kernel: Processors: 2
Mar  8 11:47:00 athena kernel: mapped APIC to ffffe000 (fec08000)
Mar  8 11:47:00 athena kernel: mapped IOAPIC to ffffd000 (fec00000)
Mar  8 11:47:00 athena kernel: Kernel command line: auto BOOT_IMAGE=linux ro root=801
Mar  8 11:47:00 athena kernel: Initializing CPU#0
Mar  8 11:47:00 athena kernel: Detected 198.669 MHz processor.
Mar  8 11:47:00 athena kernel: Console: colour VGA+ 80x25
Mar  8 11:47:00 athena kernel: Calibrating delay loop... 396.49 BogoMIPS
Mar  8 11:47:00 athena kernel: Memory: 255352k/262144k available (1071k kernel code, 6404k reserved, 422k data, 180k init, 0k highmem)
Mar  8 11:47:00 athena kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mar  8 11:47:00 athena kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mar  8 11:47:00 athena kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar  8 11:47:00 athena kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mar  8 11:47:00 athena kernel: VFS: Diskquotas version dquot_6.5.0 initialized
Mar  8 11:47:00 athena kernel: CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
Mar  8 11:47:00 athena kernel: CPU: L1 I cache: 8K, L1 D cache: 8K
Mar  8 11:47:00 athena kernel: CPU: L2 cache: 256K
Mar  8 11:47:00 athena kernel: Intel machine check architecture supported.
Mar  8 11:47:00 athena kernel: Intel machine check reporting enabled on CPU#0.
Mar  8 11:47:00 athena kernel: CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: CPU: Common caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: Checking 'hlt' instruction... OK.
Mar  8 11:47:00 athena kernel: POSIX conformance testing by UNIFIX
Mar  8 11:47:00 athena kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
Mar  8 11:47:00 athena kernel: mtrr: detected mtrr type: Intel
Mar  8 11:47:00 athena kernel: CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
Mar  8 11:47:00 athena kernel: CPU: L1 I cache: 8K, L1 D cache: 8K
Mar  8 11:47:00 athena kernel: CPU: L2 cache: 256K
Mar  8 11:47:00 athena kernel: Intel machine check reporting enabled on CPU#0.
Mar  8 11:47:00 athena kernel: CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: CPU: Common caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: CPU0: Intel Pentium Pro stepping 09
Mar  8 11:47:00 athena kernel: per-CPU timeslice cutoff: 733.84 usecs.
Mar  8 11:47:00 athena kernel: Getting VERSION: 40011
Mar  8 11:47:00 athena kernel: Getting VERSION: 40011
Mar  8 11:47:00 athena kernel: Getting ID: 0
Mar  8 11:47:00 athena kernel: Getting ID: f000000
Mar  8 11:47:00 athena kernel: Getting LVT0: 700
Mar  8 11:47:00 athena kernel: Getting LVT1: 400
Mar  8 11:47:00 athena kernel: enabled ExtINT on CPU#0
Mar  8 11:47:00 athena kernel: ESR value before enabling vector: 00000040
Mar  8 11:47:00 athena kernel: ESR value after enabling vector: 00000000
Mar  8 11:47:00 athena kernel: CPU present map: 1001
Mar  8 11:47:00 athena kernel: Booting processor 1/12 eip 2000
Mar  8 11:47:00 athena kernel: Setting warm reset code and vector.
Mar  8 11:47:00 athena kernel: 1.
Mar  8 11:47:00 athena kernel: 2.
Mar  8 11:47:00 athena kernel: 3.
Mar  8 11:47:00 athena kernel: Asserting INIT.
Mar  8 11:47:00 athena kernel: Waiting for send to finish...
Mar  8 11:47:00 athena kernel: +Deasserting INIT.
Mar  8 11:47:00 athena kernel: Waiting for send to finish...
Mar  8 11:47:00 athena kernel: +#startup loops: 2.
Mar  8 11:47:00 athena kernel: Sending STARTUP #1.
Mar  8 11:47:00 athena kernel: After apic_write.
Mar  8 11:47:00 athena kernel: Initializing CPU#1
Mar  8 11:47:00 athena kernel: CPU#1 (phys ID: 12) waiting for CALLOUT
Mar  8 11:47:00 athena kernel: Startup point 1.
Mar  8 11:47:00 athena kernel: Waiting for send to finish...
Mar  8 11:47:00 athena kernel: +Sending STARTUP #2.
Mar  8 11:47:00 athena kernel: After apic_write.
Mar  8 11:47:00 athena kernel: Startup point 1.
Mar  8 11:47:00 athena kernel: Waiting for send to finish...
Mar  8 11:47:00 athena kernel: +After Startup.
Mar  8 11:47:00 athena kernel: Before Callout 1.
Mar  8 11:47:00 athena kernel: After Callout 1.
Mar  8 11:47:00 athena kernel: CALLIN, before setup_local_APIC().
Mar  8 11:47:00 athena kernel: masked ExtINT on CPU#1
Mar  8 11:47:00 athena kernel: ESR value before enabling vector: 00000000
Mar  8 11:47:00 athena kernel: ESR value after enabling vector: 00000000
Mar  8 11:47:00 athena kernel: Calibrating delay loop... 396.49 BogoMIPS
Mar  8 11:47:00 athena kernel: Stack at about c15fffbc
Mar  8 11:47:00 athena kernel: CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
Mar  8 11:47:00 athena kernel: CPU: L1 I cache: 8K, L1 D cache: 8K
Mar  8 11:47:00 athena kernel: CPU: L2 cache: 256K
Mar  8 11:47:00 athena kernel: Intel machine check reporting enabled on CPU#1.
Mar  8 11:47:00 athena kernel: CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: CPU: Common caps: 0000fbff 00000000 00000000 00000000
Mar  8 11:47:00 athena kernel: OK.
Mar  8 11:47:00 athena kernel: CPU1: Intel Pentium Pro stepping 09
Mar  8 11:47:00 athena kernel: CPU has booted.
Mar  8 11:47:00 athena kernel: Before bogomips.
Mar  8 11:47:00 athena kernel: Total of 2 processors activated (792.98 BogoMIPS).
Mar  8 11:47:00 athena kernel: Before bogocount - setting activated=1.
Mar  8 11:47:00 athena kernel: Boot done.
Mar  8 11:47:00 athena kernel: ENABLING IO-APIC IRQs
Mar  8 11:47:00 athena kernel: ...changing IO-APIC physical APIC ID to 13 ... ok.
Mar  8 11:47:00 athena kernel: Synchronizing Arb IDs.
Mar  8 11:47:00 athena kernel: ..TIMER: vector=49 pin1=-1 pin2=0
Mar  8 11:47:00 athena kernel: ...trying to set up timer (IRQ0) through the 8259A ... 
Mar  8 11:47:00 athena kernel: ..... (found pin 0) ...works.
Mar  8 11:47:00 athena kernel: activating NMI Watchdog ... done.
Mar  8 11:47:00 athena kernel: testing NMI watchdog ... OK.
Mar  8 11:47:00 athena kernel: testing the IO APIC.......................
Mar  8 11:47:00 athena kernel: 
Mar  8 11:47:00 athena kernel: .................................... done.
Mar  8 11:47:00 athena kernel: calibrating APIC timer ...
Mar  8 11:47:00 athena kernel: ..... CPU clock speed is 198.6689 MHz.
Mar  8 11:47:00 athena kernel: ..... host bus clock speed is 66.2228 MHz.
Mar  8 11:47:00 athena kernel: cpu: 0, clocks: 662228, slice: 220742
Mar  8 11:47:00 athena kernel: CPU0<T0:662224,T1:441472,D:10,S:220742,C:662228>
Mar  8 11:47:00 athena kernel: cpu: 1, clocks: 662228, slice: 220742
Mar  8 11:47:00 athena kernel: CPU1<T0:662224,T1:220736,D:4,S:220742,C:662228>
Mar  8 11:47:00 athena kernel: checking TSC synchronization across CPUs: passed.
Mar  8 11:47:00 athena kernel: Setting commenced=1, go go go
Mar  8 11:47:00 athena kernel: PCI: PCI BIOS revision 2.10 entry at 0xfda11, last bus=0
Mar  8 11:47:00 athena kernel: PCI: Using configuration type 1
Mar  8 11:47:00 athena kernel: PCI: Probing PCI hardware
Mar  8 11:47:00 athena kernel: Limiting direct PCI/PCI transfers.
Mar  8 11:47:00 athena kernel: Activating ISA DMA hang workarounds.
Mar  8 11:47:00 athena kernel: Linux NET4.0 for Linux 2.4
Mar  8 11:47:00 athena kernel: Based upon Swansea University Computer Society NET3.039
Mar  8 11:47:00 athena kernel: Initializing RT netlink socket
Mar  8 11:47:00 athena kernel: Starting kswapd v1.8
Mar  8 11:47:00 athena kernel: pty: 256 Unix98 ptys configured
Mar  8 11:47:00 athena kernel: block: queued sectors max/low 169621kB/56540kB, 512 slots per queue
Mar  8 11:47:00 athena kernel: Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Mar  8 11:47:00 athena kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Mar  8 11:47:00 athena kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Mar  8 11:47:00 athena kernel: Real Time Clock Driver v1.10d
Mar  8 11:47:00 athena kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Mar  8 11:47:00 athena kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Mar  8 11:47:00 athena kernel: eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:60:53:02, IRQ 15.
Mar  8 11:47:00 athena kernel:   Receiver lock-up bug exists -- enabling work-around.
Mar  8 11:47:00 athena kernel:   Board assembly 645520-034, Physical connectors present: RJ45
Mar  8 11:47:00 athena kernel:   Primary interface chip DP83840 PHY #1.
Mar  8 11:47:00 athena kernel:   DP83840 specific setup, setting register 23 to 8462.
Mar  8 11:47:00 athena kernel:   General self-test: passed.
Mar  8 11:47:00 athena kernel:   Serial sub-system self-test: passed.
Mar  8 11:47:00 athena kernel:   Internal registers self-test: passed.
Mar  8 11:47:00 athena kernel:   ROM checksum self-test: passed (0x49caa8d6).
Mar  8 11:47:00 athena kernel:   Receiver lock-up workaround activated.
Mar  8 11:47:00 athena kernel: SCSI subsystem driver Revision: 1.00
Mar  8 11:47:00 athena kernel: (scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 0/9/0
Mar  8 11:47:00 athena kernel: (scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
Mar  8 11:47:00 athena kernel: (scsi0) Downloading sequencer code... 422 instructions downloaded
Mar  8 11:47:00 athena kernel: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.3/5.2.0
Mar  8 11:47:00 athena kernel:        <Adaptec AIC-7880 Ultra SCSI host adapter>
Mar  8 11:47:00 athena kernel:   Vendor: QUANTUM   Model: XP39100W          Rev: LYK8
Mar  8 11:47:00 athena kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar  8 11:47:00 athena kernel:   Vendor: QUANTUM   Model: XP39100W          Rev: LYK8
Mar  8 11:47:00 athena kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar  8 11:47:00 athena kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Mar  8 11:47:00 athena kernel: Attached scsi disk sdb at scsi0, channel 0, id 9, lun 0
Mar  8 11:47:00 athena kernel: (scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
Mar  8 11:47:00 athena kernel: SCSI device sda: 17781520 512-byte hdwr sectors (9104 MB)
Mar  8 11:47:00 athena kernel: Partition check:
Mar  8 11:47:00 athena kernel:  sda: sda1 sda2 < sda5 sda6 > sda3 sda4
Mar  8 11:47:00 athena kernel: (scsi0:0:9:0) Synchronous at 40.0 Mbyte/sec, offset 8.
Mar  8 11:47:00 athena kernel: SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
Mar  8 11:47:00 athena kernel:  sdb: sdb1
Mar  8 11:47:00 athena kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Mar  8 11:47:00 athena kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Mar  8 11:47:00 athena kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Mar  8 11:47:00 athena kernel: TCP: Hash tables configured (established 16384 bind 16384)
Mar  8 11:47:00 athena kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Mar  8 11:47:00 athena kernel: VFS: Mounted root (ext2 filesystem) readonly.
Mar  8 11:47:00 athena kernel: Freeing unused kernel memory: 180k freed
Mar  8 11:47:00 athena kernel: Adding Swap: 104416k swap-space (priority -1)
Mar  8 11:47:00 athena kernel: nfs warning: mount version older than kernel
Mar  8 11:47:01 athena kernel: nfs warning: mount version older than kernel
Mar  8 11:47:01 athena xntpd[165]: xntpd version=3.5f; Wed Feb  5 22:08:33 MET 1997 (1)
Mar  8 11:47:01 athena xntpd[165]: tickadj = 1, tick = 10000, tvu_maxslew = 99
Mar  8 11:47:01 athena xntpd[165]: precision = 6 usec
Mar  8 11:51:51 athena xntpd[165]: synchronized to 128.2.236.71, stratum=3
Mar  8 11:51:53 athena xntpd[165]: time reset (step) 2.349160 s
Mar  8 11:51:53 athena xntpd[165]: synchronisation lost


Any input is appreciated.

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


