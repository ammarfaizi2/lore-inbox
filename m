Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318314AbSHUOGx>; Wed, 21 Aug 2002 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318325AbSHUOGx>; Wed, 21 Aug 2002 10:06:53 -0400
Received: from goliat.otpbank.hu ([195.228.126.225]:61452 "HELO
	goliat.hazibank.hu") by vger.kernel.org with SMTP
	id <S318314AbSHUOGa>; Wed, 21 Aug 2002 10:06:30 -0400
Message-ID: <3D63A180.C663294E@otpbank.hu>
Date: Wed, 21 Aug 2002 16:19:44 +0200
From: Nagy Tibor <nagyt@otpbank.hu>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem determining number of CPUs
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms2F828F6A57B48DA7CD826D02"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms2F828F6A57B48DA7CD826D02
Content-Type: multipart/mixed;
 boundary="------------845531F495D37E680A5987F5"

This is a multi-part message in MIME format.
--------------845531F495D37E680A5987F5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Linux kernel versions 2.4.18, 2.4.19, 2.4.20pre4 do not determine
correctly the number of CPUs on our system. We see 8 CPUs instead of 4,
however the system works.

Our machine: Dell PowerEdge 6600, 4 Xeon 1400 Mhz, 4GB RAM

I attach /var/log/boot.msg.

------------------------------------------------------------------------
Tibor Nagy
E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------
--------------845531F495D37E680A5987F5
Content-Type: text/plain; charset=us-ascii;
 name="boot.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.msg"

Cannot find map file.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.19 (root@emiir) (gcc version 2.95.3 20010315 (SuSE)) #27 SMP Wed Aug 21 16:10:58 CEST 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
<4> BIOS-e820: 00000000dfff0000 - 00000000dfffec00 (ACPI data)
<4> BIOS-e820: 00000000dfffec00 - 00000000dffff000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<5>2687MB HIGHMEM available.
<5>896MB LOWMEM available.
<4>found SMP MP-table at 000fe710
<4>hm, page 000fe000 reserved twice.
<4>hm, page 000ff000 reserved twice.
<4>hm, page 000f0000 reserved twice.
<4>On node 0 totalpages: 917488
<4>zone(0): 4096 pages.
<4>zone(1): 225280 pages.
<4>zone(2): 688112 pages.
<6>ACPI: Searched entire block, no RSDP was found.
<6>ACPI: RSDP located at physical address c00fdc20
<6>RSD PTR  v0 [DELL  ]
<4>__va_range(0xfdc34, 0x68): idx=8 mapped at ffff6000
<6>ACPI table found: RSDT v1 [DELL   PE6600   0.1]
<4>__va_range(0xfdc64, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xfdc64, 0x74): idx=8 mapped at ffff6000
<6>ACPI table found: FACP v1 [DELL   PE6600   0.1]
<4>__va_range(0xfdcd8, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xfdcd8, 0xc0): idx=8 mapped at ffff6000
<6>ACPI table found: APIC v1 [DELL   PE6600   0.1]
<4>__va_range(0xfdcd8, 0xc0): idx=8 mapped at ffff6000
<6>LAPIC (acpi_id[0x0001] id[0x0] enabled[1])
<6>CPU 0 (0x0000) enabledProcessor #0 Unknown CPU [15:1] APIC version 16
<4>
<6>LAPIC (acpi_id[0x0002] id[0x2] enabled[1])
<6>CPU 1 (0x0200) enabledProcessor #2 Unknown CPU [15:1] APIC version 16
<4>
<6>LAPIC (acpi_id[0x0003] id[0x4] enabled[1])
<6>CPU 2 (0x0400) enabledProcessor #4 Unknown CPU [15:1] APIC version 16
<4>
<6>LAPIC (acpi_id[0x0004] id[0x6] enabled[1])
<6>CPU 3 (0x0600) enabledProcessor #6 Unknown CPU [15:1] APIC version 16
<4>
<6>LAPIC (acpi_id[0x0005] id[0x1] enabled[1])
<6>CPU 4 (0x0100) enabledProcessor #1 Unknown CPU [15:1] APIC version 16
<4>
<6>LAPIC (acpi_id[0x0006] id[0x3] enabled[1])
<6>CPU 5 (0x0300) enabledProcessor #3 Unknown CPU [15:1] APIC version 16
<4>
<6>LAPIC (acpi_id[0x0007] id[0x5] enabled[1])
<6>CPU 6 (0x0500) enabledProcessor #5 Unknown CPU [15:1] APIC version 16
<4>
<6>LAPIC (acpi_id[0x0008] id[0x7] enabled[1])
<6>CPU 7 (0x0700) enabledProcessor #7 Unknown CPU [15:1] APIC version 16
<4>
<6>IOAPIC (id[0x8] address[0xfec00000] global_irq_base[0x0])
<6>IOAPIC (id[0x9] address[0xfec01000] global_irq_base[0x10])
<6>IOAPIC (id[0xa] address[0xfec02000] global_irq_base[0x20])
<6>LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
<6>LAPIC_NMI (acpi_id[0x0002] polarity[0x1] trigger[0x1] lint[0x1])
<6>LAPIC_NMI (acpi_id[0x0003] polarity[0x1] trigger[0x1] lint[0x1])
<6>LAPIC_NMI (acpi_id[0x0004] polarity[0x1] trigger[0x1] lint[0x1])
<6>LAPIC_NMI (acpi_id[0x0005] polarity[0x1] trigger[0x1] lint[0x1])
<6>LAPIC_NMI (acpi_id[0x0006] polarity[0x1] trigger[0x1] lint[0x1])
<6>LAPIC_NMI (acpi_id[0x0007] polarity[0x1] trigger[0x1] lint[0x1])
<6>LAPIC_NMI (acpi_id[0x0008] polarity[0x1] trigger[0x1] lint[0x1])
<6>8 CPUs total
<6>Local APIC address fee00000
<4>__va_range(0xfdd98, 0x24): idx=8 mapped at ffff6000
<4>__va_range(0xfdd98, 0x50): idx=8 mapped at ffff6000
<6>ACPI table found: SPCR v1 [DELL   PE6600   0.1]
<4>Enabling the CPU's according to the ACPI table
<4>Intel MultiProcessor Specification v1.4
<4>    Virtual Wire compatibility mode.
<4>OEM ID: DELL     Product ID: PE 0109      APIC at: 0xFEE00000
<4>I/O APIC #8 Version 17 at 0xFEC00000.
<4>I/O APIC #9 Version 17 at 0xFEC01000.
<4>I/O APIC #10 Version 17 at 0xFEC02000.
<4>Processors: 8
<4>Kernel command line: auto BOOT_IMAGE=linux.2.4.19 ro root=803 reboot=warm
<6>Initializing CPU#0
<4>Detected 1393.503 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 2778.72 BogoMIPS
<6>Memory: 3623840k/3669952k available (1407k kernel code, 45728k reserved, 416k data, 240k init, 2752448k highmem)
<6>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<6>Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
<4>Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
<4>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 0
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 0
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU0: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<4>per-CPU timeslice cutoff: 731.23 usecs.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000040
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/1 eip 2000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 2785.28 BogoMIPS
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 0
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU1: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<4>Booting processor 2/2 eip 2000
<6>Initializing CPU#2
<4>masked ExtINT on CPU#2
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 2785.28 BogoMIPS
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 1
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU2: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<4>Booting processor 3/3 eip 2000
<6>Initializing CPU#3
<4>masked ExtINT on CPU#3
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 2785.28 BogoMIPS
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 1
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU3: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<4>Booting processor 4/4 eip 2000
<6>Initializing CPU#4
<4>masked ExtINT on CPU#4
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 2785.28 BogoMIPS
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 2
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU4: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<4>Booting processor 5/5 eip 2000
<6>Initializing CPU#5
<4>masked ExtINT on CPU#5
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 2785.28 BogoMIPS
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 2
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU5: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<4>Booting processor 6/6 eip 2000
<6>Initializing CPU#6
<4>masked ExtINT on CPU#6
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 2785.28 BogoMIPS
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 3
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU6: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<4>Booting processor 7/7 eip 2000
<6>Initializing CPU#7
<4>masked ExtINT on CPU#7
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 2785.28 BogoMIPS
<7>CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 12K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<6>CPU: L3 cache: 512K
<6>CPU: Physical Processor ID: 3
<7>CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
<7>CPU:             Common caps: 3febfbff 00000000 00000000 00000000
<4>CPU7: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01
<6>Total of 8 processors activated (22275.68 BogoMIPS).
<4>cpu_sibling_map[0] = 1
<4>cpu_sibling_map[1] = 0
<4>cpu_sibling_map[2] = 3
<4>cpu_sibling_map[3] = 2
<4>cpu_sibling_map[4] = 5
<4>cpu_sibling_map[5] = 4
<4>cpu_sibling_map[6] = 7
<4>cpu_sibling_map[7] = 6
<4>ENABLING IO-APIC IRQs
<4>Setting 8 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 8 ... ok.
<4>Setting 9 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 9 ... ok.
<4>Setting 10 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 10 ... ok.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 8-0, 8-3, 8-5, 8-7, 8-11, 8-13, 9-3, 10-10, 10-11, 10-12, 10-13, 10-14, 10-15 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>...trying to set up timer (IRQ0) through the 8259A ... 
<4>..... (found pin 0) ...works.
<7>number of MP IRQ sources: 61.
<7>number of IO-APIC #8 registers: 16.
<7>number of IO-APIC #9 registers: 16.
<7>number of IO-APIC #10 registers: 16.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #8......
<7>.... register #00: 08000000
<7>.......    : physical APIC id: 08
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 08000000
<7>.......     : arbitration: 08
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 0FF 0F  0    0    0   0   0    1    1    31
<7> 01 0FF 0F  0    0    0   0   0    1    1    39
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 0FF 0F  0    0    0   0   0    1    1    41
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 0FF 0F  0    0    0   0   0    1    1    49
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 0FF 0F  0    0    0   0   0    1    1    51
<7> 09 0FF 0F  0    0    0   0   0    1    1    59
<7> 0a 0FF 0F  1    1    0   1   0    1    1    61
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 0FF 0F  0    0    0   0   0    1    1    69
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 0FF 0F  0    0    0   0   0    1    1    71
<7> 0f 0FF 0F  0    0    0   0   0    1    1    79
<4>
<7>IO APIC #9......
<7>.... register #00: 09000000
<7>.......    : physical APIC id: 09
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 09000000
<7>.......     : arbitration: 09
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 0FF 0F  1    1    0   1   0    1    1    81
<7> 01 0FF 0F  1    1    0   1   0    1    1    89
<7> 02 0FF 0F  1    1    0   1   0    1    1    91
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 0FF 0F  1    1    0   1   0    1    1    99
<7> 05 0FF 0F  1    1    0   1   0    1    1    A1
<7> 06 0FF 0F  1    1    0   1   0    1    1    A9
<7> 07 0FF 0F  1    1    0   1   0    1    1    B1
<7> 08 0FF 0F  1    1    0   1   0    1    1    B9
<7> 09 0FF 0F  1    1    0   1   0    1    1    C1
<7> 0a 0FF 0F  1    1    0   1   0    1    1    C9
<7> 0b 0FF 0F  1    1    0   1   0    1    1    D1
<7> 0c 0FF 0F  1    1    0   1   0    1    1    D9
<7> 0d 0FF 0F  1    1    0   1   0    1    1    E1
<7> 0e 0FF 0F  1    1    0   1   0    1    1    E9
<7> 0f 0FF 0F  1    1    0   1   0    1    1    32
<4>
<7>IO APIC #10......
<7>.... register #00: 0A000000
<7>.......    : physical APIC id: 0A
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 0A000000
<7>.......     : arbitration: 0A
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
<7> 00 0FF 0F  1    1    0   1   0    1    1    3A
<7> 01 0FF 0F  1    1    0   1   0    1    1    42
<7> 02 0FF 0F  1    1    0   1   0    1    1    4A
<7> 03 0FF 0F  1    1    0   1   0    1    1    52
<7> 04 0FF 0F  1    1    0   1   0    1    1    5A
<7> 05 0FF 0F  1    1    0   1   0    1    1    62
<7> 06 0FF 0F  1    1    0   1   0    1    1    6A
<7> 07 0FF 0F  1    1    0   1   0    1    1    72
<7> 08 0FF 0F  1    1    0   1   0    1    1    7A
<7> 09 0FF 0F  1    1    0   1   0    1    1    82
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:0
<7>IRQ1 -> 0:1
<7>IRQ4 -> 0:4
<7>IRQ6 -> 0:6
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ12 -> 0:12
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 1:0
<7>IRQ17 -> 1:1
<7>IRQ18 -> 1:2
<7>IRQ20 -> 1:4
<7>IRQ21 -> 1:5
<7>IRQ22 -> 1:6
<7>IRQ23 -> 1:7
<7>IRQ24 -> 1:8
<7>IRQ25 -> 1:9
<7>IRQ26 -> 1:10
<7>IRQ27 -> 1:11
<7>IRQ28 -> 1:12
<7>IRQ29 -> 1:13
<7>IRQ30 -> 1:14
<7>IRQ31 -> 1:15
<7>IRQ32 -> 2:0
<7>IRQ33 -> 2:1
<7>IRQ34 -> 2:2
<7>IRQ35 -> 2:3
<7>IRQ36 -> 2:4
<7>IRQ37 -> 2:5
<7>IRQ38 -> 2:6
<7>IRQ39 -> 2:7
<7>IRQ40 -> 2:8
<7>IRQ41 -> 2:9
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 1393.4195 MHz.
<4>..... host bus clock speed is 99.5297 MHz.
<4>cpu: 0, clocks: 995297, slice: 110588
<4>CPU0<T0:995296,T1:884688,D:20,S:110588,C:995297>
<4>cpu: 7, clocks: 995297, slice: 110588
<4>cpu: 5, clocks: 995297, slice: 110588
<4>cpu: 3, clocks: 995297, slice: 110588
<4>cpu: 1, clocks: 995297, slice: 110588
<4>cpu: 2, clocks: 995297, slice: 110588
<4>cpu: 4, clocks: 995297, slice: 110588
<4>cpu: 6, clocks: 995297, slice: 110588
<4>CPU5<T0:995296,T1:331760,D:8,S:110588,C:995297>
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--------------845531F495D37E680A5987F5--

--------------ms2F828F6A57B48DA7CD826D02
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIH5wYJKoZIhvcNAQcCoIIH2DCCB9QCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BbowggJ6MIIB46ADAgECAgMHn6wwDQYJKoZIhvcNAQEEBQAwgZIxCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhh
d3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwg
RnJlZW1haWwgUlNBIDIwMDAuOC4zMDAeFw0wMjA2MDUxMTE1MzJaFw0wMzA2MDUxMTE1MzJa
MEIxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBNZW1iZXIxHzAdBgkqhkiG9w0BCQEWEG5h
Z3l0QG90cGJhbmsuaHUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMzA1PHsL3+xE06d
23p7BlCJJYSyi1vsfYeVmB4dsc/OSg/y4WxqOILMh+3wxQ35FNs23AjnYfRljhGNtoSm5jRe
ioE19dUKG1FCV0T1RMYTE8tXRzt9YzOAr2koWg/+Wqxt/0Qi9fl1PtgrYliS5cC0kBRND9Yb
aybBEoFNPrSZAgMBAAGjLTArMBsGA1UdEQQUMBKBEG5hZ3l0QG90cGJhbmsuaHUwDAYDVR0T
AQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQBJUxrLMZI2MLY9RnIXFM77knDXEdzyneSa04p6
egw5r6YSzHKnm2seObq5EkDk5vD6n0ZRZaZzbhMu+1QHIJ2v3FUMNqb37ZrROjzJqtLrcOHB
kVr5kNblco2VJUozzGJguLclckzTUsgXWAelq2EjN4TRoJVdwMp1Ld6YqOW3VzCCAzgwggKh
oAMCAQICEGZFcrfMdPXPY3ZFhNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJBgNVBAYTAlpB
MRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMR
VGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2
aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3
DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0w
NDA4MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNh
dGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAw
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40Qp
imM1Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Y
cvm6AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGj
TjBMMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMB
Af8ECDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1
U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXr
okefbKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXdiuT82w0fnQLzWtvKPPZE6iZph39Ins6l
n+eE2MliYq0FxjGCAfUwggHxAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2Vz
dGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UE
CxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJT
QSAyMDAwLjguMzACAwefrDAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTAyMDgyMTE0MTk0NlowIwYJKoZIhvcNAQkEMRYEFDVRHgdV
wMX6xN2chDXiazzhDgctMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcN
AwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3
DQEBAQUABIGANk3rAlDFcf+eeS6ZX/+5VJh9DATVmR24QkLASR9fTJu+DCXoWp7kh0qVJUZr
LgS8ug/zN0jv5zpAFisHR5HLTpJLq2SabLLkOdy85P4G+DGfZP5Qszt7I4ZV2SvyWMXlcN9Z
fcMd6tAGLUqLS1K13PPzX7Nik4zaL5TU/6K2jdk=
--------------ms2F828F6A57B48DA7CD826D02--

