Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQLSSIZ>; Tue, 19 Dec 2000 13:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLSSIO>; Tue, 19 Dec 2000 13:08:14 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:33179 "EHLO
	shookay.e-steel.com") by vger.kernel.org with ESMTP
	id <S129431AbQLSSIC>; Tue, 19 Dec 2000 13:08:02 -0500
Date: Tue, 19 Dec 2000 12:37:30 -0500
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-smp@vger.kernel.org
Subject: unexpected IO-APIC
Message-ID: <20001219123730.A23357@shookay.e-steel.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@shookay.e-steel.com>,
	linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	  Hello!

I have a Dell Precision 220 at work and got this message every time I boot
up linux. I use kernel 2.4.0-test12.
I have included lspci output (the chipset is a i820) and dmesg output.

If I can provide any help, please let me know.

Regards, Mathieu.

Dmesg output
==============================================================================
Dec 14 17:13:20 shookay kernel: klogd 1.3-3, log source = /proc/kmsg started.
Dec 14 17:13:20 shookay kernel: Inspecting /boot/System.map-2.4.0-test12
Dec 14 17:13:21 shookay kernel: Loaded 13435 symbols from /boot/System.map-2.4.0-test12.
Dec 14 17:13:21 shookay kernel: Symbols match kernel version 2.4.0.
Dec 14 17:13:21 shookay kernel: Loaded 26 symbols from 3 modules.
Dec 14 17:13:21 shookay kernel: Linux version 2.4.0-test12 (mchouque@shookay) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Dec 12 13:34:08 EST 2000
Dec 14 17:13:21 shookay kernel: BIOS-provided physical RAM map:
Dec 14 17:13:21 shookay kernel:  BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
Dec 14 17:13:21 shookay kernel:  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
Dec 14 17:13:21 shookay kernel:  BIOS-e820: 000000000fe9e000 @ 0000000000100000 (usable)
Dec 14 17:13:21 shookay kernel:  BIOS-e820: 0000000000062000 @ 000000000ff9e000 (reserved)
Dec 14 17:13:21 shookay kernel:  BIOS-e820: 0000000000500000 @ 00000000ffb00000 (reserved)
Dec 14 17:13:21 shookay kernel:  BIOS-e820: 0000000000010000 @ 00000000fec00000 (reserved)
Dec 14 17:13:21 shookay kernel:  BIOS-e820: 0000000000010000 @ 00000000fee00000 (reserved)
Dec 14 17:13:21 shookay kernel: Scan SMP from c0000000 for 1024 bytes.
Dec 14 17:13:21 shookay kernel: Scan SMP from c009fc00 for 1024 bytes.
Dec 14 17:13:21 shookay kernel: Scan SMP from c00f0000 for 65536 bytes.
Dec 14 17:13:21 shookay kernel: found SMP MP-table at 000fe710
Dec 14 17:13:21 shookay kernel: hm, page 000fe000 reserved twice.
Dec 14 17:13:21 shookay kernel: hm, page 000ff000 reserved twice.
Dec 14 17:13:21 shookay kernel: hm, page 000f0000 reserved twice.
Dec 14 17:13:21 shookay kernel: On node 0 totalpages: 65438
Dec 14 17:13:21 shookay kernel: zone(0): 4096 pages.
Dec 14 17:13:21 shookay kernel: zone(1): 61342 pages.
Dec 14 17:13:21 shookay kernel: zone(2): 0 pages.
Dec 14 17:13:21 shookay kernel: Intel MultiProcessor Specification v1.4
Dec 14 17:13:21 shookay kernel:     Virtual Wire compatibility mode.
Dec 14 17:13:21 shookay kernel: OEM ID: DELL     Product ID: Opti GX300   APIC at: 0xFEE00000
Dec 14 17:13:21 shookay kernel: Processor #0 Pentium(tm) Pro APIC version 17
Dec 14 17:13:21 shookay kernel:     Floating point unit present.
Dec 14 17:13:21 shookay kernel:     Machine Exception supported.
Dec 14 17:13:21 shookay kernel:     64 bit compare & exchange supported.
Dec 14 17:13:21 shookay kernel:     Internal APIC present.
Dec 14 17:13:21 shookay kernel:     SEP present.
Dec 14 17:13:21 shookay kernel:     MTRR  present.
Dec 14 17:13:21 shookay kernel:     PGE  present.
Dec 14 17:13:21 shookay kernel:     MCA  present.
Dec 14 17:13:21 shookay kernel:     CMOV  present.
Dec 14 17:13:21 shookay kernel:     PAT  present.
Dec 14 17:13:21 shookay kernel:     PSE  present.
Dec 14 17:13:21 shookay kernel:     MMX  present.
Dec 14 17:13:21 shookay kernel:     FXSR  present.
Dec 14 17:13:21 shookay kernel:     XMM  present.
Dec 14 17:13:21 shookay kernel:     Bootup CPU
Dec 14 17:13:21 shookay kernel: Bus #0 is PCI   
Dec 14 17:13:21 shookay kernel: Bus #1 is PCI   
Dec 14 17:13:21 shookay kernel: Bus #2 is PCI   
Dec 14 17:13:21 shookay kernel: Bus #3 is ISA   
Dec 14 17:13:21 shookay kernel: I/O APIC #1 Version 32 at 0xFEC00000.
Dec 14 17:13:21 shookay kernel: Int: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID 1, APIC INT 00
Dec 14 17:13:21 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 01, APIC ID 1, APIC INT 01
Dec 14 17:13:21 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 00, APIC ID 1, APIC INT 02
Dec 14 17:13:21 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 03, APIC ID 1, APIC INT 03
Dec 14 17:13:21 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 04, APIC ID 1, APIC INT 04
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 05, APIC ID 1, APIC INT 05
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 06, APIC ID 1, APIC INT 06
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 07, APIC ID 1, APIC INT 07
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 08, APIC ID 1, APIC INT 08
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 09, APIC ID 1, APIC INT 09
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 0a, APIC ID 1, APIC INT 0a
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 0b, APIC ID 1, APIC INT 0b
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 0c, APIC ID 1, APIC INT 0c
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 0e, APIC ID 1, APIC INT 0e
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 3, IRQ 0f, APIC ID 1, APIC INT 0f
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 1, IRQ 00, APIC ID 1, APIC INT 10
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 1c, APIC ID 1, APIC INT 10
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 23, APIC ID 1, APIC INT 10
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 26, APIC ID 1, APIC INT 10
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 29, APIC ID 1, APIC INT 10
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 2c, APIC ID 1, APIC INT 10
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 0, IRQ 7c, APIC ID 1, APIC INT 10
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 0, IRQ 7d, APIC ID 1, APIC INT 11
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 1, IRQ 01, APIC ID 1, APIC INT 11
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 1d, APIC ID 1, APIC INT 11
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 20, APIC ID 1, APIC INT 11
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 27, APIC ID 1, APIC INT 11
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 2a, APIC ID 1, APIC INT 11
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 2d, APIC ID 1, APIC INT 11
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 1e, APIC ID 1, APIC INT 12
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 21, APIC ID 1, APIC INT 12
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 24, APIC ID 1, APIC INT 12
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 2b, APIC ID 1, APIC INT 12
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 2e, APIC ID 1, APIC INT 12
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 30, APIC ID 1, APIC INT 12
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 0, IRQ 7e, APIC ID 1, APIC INT 12
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 0, IRQ 7f, APIC ID 1, APIC INT 13
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 1f, APIC ID 1, APIC INT 13
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 22, APIC ID 1, APIC INT 13
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 25, APIC ID 1, APIC INT 13
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 28, APIC ID 1, APIC INT 13
Dec 14 17:13:22 shookay kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 2f, APIC ID 1, APIC INT 13
Dec 14 17:13:22 shookay kernel: Lint: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID ff, APIC LINT 00
Dec 14 17:13:22 shookay kernel: Lint: type 1, pol 1, trig 1, bus 3, IRQ 00, APIC ID ff, APIC LINT 01
Dec 14 17:13:22 shookay kernel: Processors: 1
Dec 14 17:13:22 shookay kernel: mapped APIC to ffffe000 (fee00000)
Dec 14 17:13:22 shookay kernel: mapped IOAPIC to ffffd000 (fec00000)
Dec 14 17:13:23 shookay kernel: Kernel command line: root=/dev/sda2 nousb vga=1 mem=261752K
Dec 14 17:13:23 shookay kernel: Initializing CPU#0
Dec 14 17:13:23 shookay kernel: Detected 529.786 MHz processor.
Dec 14 17:13:23 shookay kernel: Console: colour VGA+ 80x50
Dec 14 17:13:23 shookay kernel: Calibrating delay loop... 1055.13 BogoMIPS
Dec 14 17:13:23 shookay kernel: Memory: 255200k/261752k available (1300k kernel code, 6164k reserved, 83k data, 200k init, 0k highmem)
Dec 14 17:13:23 shookay kernel: Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Dec 14 17:13:23 shookay kernel: Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Dec 14 17:13:23 shookay kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 14 17:13:23 shookay kernel: Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Dec 14 17:13:23 shookay kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Dec 14 17:13:23 shookay kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Dec 14 17:13:23 shookay kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Dec 14 17:13:23 shookay kernel: CPU: L2 cache: 256K
Dec 14 17:13:23 shookay kernel: Intel machine check architecture supported.
Dec 14 17:13:23 shookay kernel: Intel machine check reporting enabled on CPU#0.
Dec 14 17:13:23 shookay kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Dec 14 17:13:23 shookay kernel: CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
Dec 14 17:13:23 shookay kernel: CPU: Common caps: 0383fbff 00000000 00000000 00000000
Dec 14 17:13:23 shookay kernel: CPU: Intel Pentium III (Coppermine) stepping 01
Dec 14 17:13:23 shookay kernel: Enabling fast FPU save and restore... done.
Dec 14 17:13:23 shookay kernel: Enabling unmasked SIMD FPU exception support... done.
Dec 14 17:13:23 shookay kernel: Checking 'hlt' instruction... OK.
Dec 14 17:13:23 shookay kernel: POSIX conformance testing by UNIFIX
Dec 14 17:13:23 shookay kernel: enabled ExtINT on CPU#0
Dec 14 17:13:23 shookay kernel: ESR value before enabling vector: 00000000
Dec 14 17:13:23 shookay kernel: ESR value after enabling vector: 00000000
Dec 14 17:13:23 shookay kernel: ENABLING IO-APIC IRQs
Dec 14 17:13:23 shookay kernel: ...changing IO-APIC physical APIC ID to 1 ... ok.
Dec 14 17:13:23 shookay kernel: Synchronizing Arb IDs.
Dec 14 17:13:23 shookay kernel: init IO_APIC IRQs
Dec 14 17:13:23 shookay kernel:  IO-APIC (apicid-pin) 1-0, 1-13, 1-20, 1-21, 1-22, 1-23 not connected.
Dec 14 17:13:23 shookay kernel: ..TIMER: vector=49 pin1=2 pin2=0
Dec 14 17:13:23 shookay kernel: activating NMI Watchdog ... done.
Dec 14 17:13:23 shookay kernel: number of MP IRQ sources: 42.
Dec 14 17:13:23 shookay kernel: number of IO-APIC #1 registers: 24.
Dec 14 17:13:23 shookay kernel: testing the IO APIC.......................
Dec 14 17:13:23 shookay kernel: 
Dec 14 17:13:23 shookay kernel: IO APIC #1......
Dec 14 17:13:23 shookay kernel: .... register #00: 01000000
Dec 14 17:13:23 shookay kernel: .......    : physical APIC id: 01
Dec 14 17:13:23 shookay kernel: .... register #01: 00170020
Dec 14 17:13:23 shookay kernel: .......     : max redirection entries: 0017
Dec 14 17:13:23 shookay kernel: .......     : IO APIC version: 0020
Dec 14 17:13:23 shookay kernel:  WARNING: unexpected IO-APIC, please mail
Dec 14 17:13:24 shookay kernel:           to linux-smp@vger.kernel.org
Dec 14 17:13:24 shookay kernel: .... register #02: 00000000
Dec 14 17:13:24 shookay kernel: .......     : arbitration: 00
Dec 14 17:13:24 shookay kernel: .... IRQ redirection table:
Dec 14 17:13:24 shookay kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Dec 14 17:13:24 shookay kernel:  00 000 00  1    0    0   0   0    0    0    00
Dec 14 17:13:24 shookay kernel:  01 001 01  0    0    0   0   0    1    1    39
Dec 14 17:13:24 shookay kernel:  02 001 01  0    0    0   0   0    1    1    31
Dec 14 17:13:24 shookay kernel:  03 001 01  0    0    0   0   0    1    1    41
Dec 14 17:13:24 shookay kernel:  04 001 01  0    0    0   0   0    1    1    49
Dec 14 17:13:24 shookay kernel:  05 001 01  0    0    0   0   0    1    1    51
Dec 14 17:13:24 shookay kernel:  06 001 01  0    0    0   0   0    1    1    59
Dec 14 17:13:24 shookay kernel:  07 001 01  0    0    0   0   0    1    1    61
Dec 14 17:13:24 shookay kernel:  08 001 01  0    0    0   0   0    1    1    69
Dec 14 17:13:24 shookay kernel:  09 001 01  0    0    0   0   0    1    1    71
Dec 14 17:13:24 shookay kernel:  0a 001 01  0    0    0   0   0    1    1    79
Dec 14 17:13:24 shookay kernel:  0b 001 01  0    0    0   0   0    1    1    81
Dec 14 17:13:24 shookay kernel:  0c 001 01  0    0    0   0   0    1    1    89
Dec 14 17:13:24 shookay kernel:  0d 000 00  1    0    0   0   0    0    0    00
Dec 14 17:13:24 shookay kernel:  0e 001 01  0    0    0   0   0    1    1    91
Dec 14 17:13:24 shookay kernel:  0f 001 01  0    0    0   0   0    1    1    99
Dec 14 17:13:24 shookay kernel:  10 001 01  1    1    0   1   0    1    1    A1
Dec 14 17:13:24 shookay kernel:  11 001 01  1    1    0   1   0    1    1    A9
Dec 14 17:13:24 shookay kernel:  12 001 01  1    1    0   1   0    1    1    B1
Dec 14 17:13:24 shookay kernel:  13 001 01  1    1    0   1   0    1    1    B9
Dec 14 17:13:24 shookay kernel:  14 000 00  1    0    0   0   0    0    0    00
Dec 14 17:13:24 shookay kernel:  15 000 00  1    0    0   0   0    0    0    00
Dec 14 17:13:24 shookay kernel:  16 000 00  1    0    0   0   0    0    0    00
Dec 14 17:13:24 shookay kernel:  17 000 00  1    0    0   0   0    0    0    00
Dec 14 17:13:24 shookay kernel: IRQ to pin mappings:
Dec 14 17:13:24 shookay kernel: IRQ0 -> 2
Dec 14 17:13:24 shookay kernel: IRQ1 -> 1
Dec 14 17:13:24 shookay kernel: IRQ3 -> 3
Dec 14 17:13:24 shookay kernel: IRQ4 -> 4
Dec 14 17:13:24 shookay kernel: IRQ5 -> 5
Dec 14 17:13:24 shookay kernel: IRQ6 -> 6
Dec 14 17:13:24 shookay kernel: IRQ7 -> 7
Dec 14 17:13:24 shookay kernel: IRQ8 -> 8
Dec 14 17:13:24 shookay kernel: IRQ9 -> 9
Dec 14 17:13:24 shookay kernel: IRQ10 -> 10
Dec 14 17:13:24 shookay kernel: IRQ11 -> 11
Dec 14 17:13:24 shookay kernel: IRQ12 -> 12
Dec 14 17:13:24 shookay kernel: IRQ14 -> 14
Dec 14 17:13:24 shookay kernel: IRQ15 -> 15
Dec 14 17:13:24 shookay kernel: IRQ16 -> 16
Dec 14 17:13:24 shookay kernel: IRQ17 -> 17
Dec 14 17:13:24 shookay kernel: IRQ18 -> 18
Dec 14 17:13:24 shookay kernel: IRQ19 -> 19
Dec 14 17:13:24 shookay kernel: .................................... done.
Dec 14 17:13:24 shookay kernel: calibrating APIC timer ...
Dec 14 17:13:24 shookay kernel: ..... CPU clock speed is 529.7984 MHz.
Dec 14 17:13:24 shookay kernel: ..... host bus clock speed is 132.4494 MHz.
Dec 14 17:13:24 shookay kernel: cpu: 0, clocks: 1324494, slice: 662247
Dec 14 17:13:24 shookay kernel: CPU0<T0:1324480,T1:662224,D:9,S:662247,C:1324494>
Dec 14 17:13:24 shookay kernel: mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
Dec 14 17:13:24 shookay kernel: mtrr: detected mtrr type: Intel
Dec 14 17:13:24 shookay kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc05e, last bus=2
Dec 14 17:13:24 shookay kernel: PCI: Using configuration type 1
Dec 14 17:13:24 shookay kernel: PCI: Probing PCI hardware
Dec 14 17:13:24 shookay kernel: Unknown bridge resource 0: assuming transparent
Dec 14 17:13:24 shookay kernel: Unknown bridge resource 2: assuming transparent
Dec 14 17:13:24 shookay kernel: PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
Dec 14 17:13:24 shookay kernel: PCI->APIC IRQ transform: (B0,I31,P3) -> 19
Dec 14 17:13:24 shookay kernel: PCI->APIC IRQ transform: (B0,I31,P1) -> 17
Dec 14 17:13:24 shookay kernel: PCI->APIC IRQ transform: (B0,I31,P1) -> 17
Dec 14 17:13:24 shookay kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Dec 14 17:13:25 shookay kernel: PCI->APIC IRQ transform: (B2,I7,P0) -> 16
Dec 14 17:13:25 shookay kernel: PCI->APIC IRQ transform: (B2,I12,P0) -> 18

lscpi output
==============================================================================
00:00.0 Host bridge: Intel Corporation 82820 820 (Camino) Chipset Host Bridge (MCH) (rev 03)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corporation 82820 820 (Camino) Chipset PCI to AGP Bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: f0000000-f1ffffff

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fa000000-fbffffff

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation 82801AA IDE
	Flags: bus master, medium devsel, latency 0
	I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation 82801AA USB
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
	Subsystem: Intel Corporation 82801AA SMBus
	Flags: medium devsel, IRQ 17
	I/O ports at dcd0 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97 Audio (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at d800 [size=256]
	I/O ports at dc80 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 11) (prog-if 00 [VGA])
	Subsystem: Diamond Multimedia Systems: Unknown device 5a40
	Flags: 66Mhz, medium devsel, IRQ 16
	Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at 80000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
	Capabilities: [44] AGP version 2.0

02:07.0 SCSI storage controller: Adaptec AHA-2940U2/W
	Subsystem: Adaptec: Unknown device 2180
	Flags: bus master, medium devsel, latency 64, IRQ 16
	BIST result: 00
	I/O ports at ec00 [size=256]
	Memory at fafff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1

02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 0095
	Flags: bus master, medium devsel, latency 64, IRQ 18
	I/O ports at e880 [size=128]
	Memory at faffec00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fb000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
