Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266912AbRGMBZ0>; Thu, 12 Jul 2001 21:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266913AbRGMBZS>; Thu, 12 Jul 2001 21:25:18 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:63683 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S266912AbRGMBY6>; Thu, 12 Jul 2001 21:24:58 -0400
Date: Thu, 12 Jul 2001 18:28:18 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: <ognen@gene.pbi.nrc.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: strange 2.4.x behavior on a dual-celeron machine
In-Reply-To: <Pine.LNX.4.30.0107121622030.2802-100000@gene.pbi.nrc.ca>
Message-ID: <Pine.LNX.4.33.0107121825110.29497-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it's a celeron 550? is it really a 366? you may be experiencing
overclocking issues... in particular I've never had good luck with a bp6
overclocked....

joelja

 On Thu, 12 Jul 2001 ognen@gene.pbi.nrc.ca wrote:

> Hello,
>
> could someone please take a look at the dmesg output below and tell me if
> they see any problems. The last line is a problem since the machine
> eventually grinds to a halt after a new 2.4.2 (2.4.5 and 2.4.6 also)
> kernel was installed. Worked fine with 2.2.x
>
> Best regards,
> Ognen
>
> --dmesg output---
> Linux version 2.4.2 (root@drmemory) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 SMP Thu Jul 12 14:46:55 CST 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
>  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
>  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
>  BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
>  BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
>  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
>  BIOS-e820: 0000000011f00000 @ 0000000000100000 (usable)
> Scan SMP from c0000000 for 1024 bytes.
> Scan SMP from c009fc00 for 1024 bytes.
> Scan SMP from c00f0000 for 65536 bytes.
> found SMP MP-table at 000f5b90
> hm, page 000f5000 reserved twice.
> hm, page 000f6000 reserved twice.
> hm, page 000f1000 reserved twice.
> hm, page 000f2000 reserved twice.
> On node 0 totalpages: 65536
> zone(0): 4096 pages.
> zone(1): 61440 pages.
> zone(2): 0 pages.
> Intel MultiProcessor Specification v1.1
>     Virtual Wire compatibility mode.
> OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
> Processor #0 Pentium(tm) Pro APIC version 17
>     Floating point unit present.
>     Machine Exception supported.
>     64 bit compare & exchange supported.
>     Internal APIC present.
>     SEP present.
>     MTRR  present.
>     PGE  present.
>     MCA  present.
>     CMOV  present.
>     Bootup CPU
> Processor #1 Pentium(tm) Pro APIC version 17
>     Floating point unit present.
>     Machine Exception supported.
>     64 bit compare & exchange supported.
>     Internal APIC present.
>     SEP present.
>     MTRR  present.
>     PGE  present.
>     MCA  present.
>     CMOV  present.
> Bus #0 is PCI
> Bus #1 is PCI
> Bus #2 is ISA
> I/O APIC #2 Version 17 at 0xFEC00000.
> Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
> Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
> Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
> Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
> Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
> Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05
> Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
> Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
> Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
> Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
> Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
> Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
> Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
> Int: type 0, pol 3, trig 3, bus 0, IRQ 1c, APIC ID 2, APIC INT 13
> Int: type 0, pol 3, trig 3, bus 0, IRQ 34, APIC ID 2, APIC INT 11
> Int: type 0, pol 3, trig 3, bus 0, IRQ 4c, APIC ID 2, APIC INT 12
> Int: type 0, pol 3, trig 3, bus 0, IRQ 4d, APIC ID 2, APIC INT 12
> Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
> Int: type 2, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 17
> Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
> Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
> Processors: 2
> mapped APIC to ffffe000 (fee00000)
> mapped IOAPIC to ffffd000 (fec00000)
> Kernel command line: BOOT_IMAGE=kernel2.4.2 ro root=302 mem=256M
> Initializing CPU#0
> Detected 551.259 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 1101.00 BogoMIPS
> Memory: 255000k/262144k available (1283k kernel code, 6756k reserved, 489k data, 216k init, 0k highmem)
> Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> VFS: Diskquotas version dquot_6.4.0 initialized
> CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 128K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
> CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
> CPU: Common caps: 0183fbff 00000000 00000000 00000000
> Enabling fast FPU save and restore... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 128K
> Intel machine check reporting enabled on CPU#0.
> CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
> CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
> CPU: Common caps: 0183fbff 00000000 00000000 00000000
> CPU0: Intel Celeron (Mendocino) stepping 05
> per-CPU timeslice cutoff: 365.65 usecs.
> Getting VERSION: 40011
> Getting VERSION: 40011
> Getting ID: 0
> Getting ID: f000000
> Getting LVT0: 700
> Getting LVT1: 400
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> CPU present map: 3
> Booting processor 1/1 eip 2000
> Setting warm reset code and vector.
> 1.
> 2.
> 3.
> Asserting INIT.
> Waiting for send to finish...
> +Deasserting INIT.
> Waiting for send to finish...
> +#startup loops: 2.
> Sending STARTUP #1.
> After apic_write.
> Initializing CPU#1
> CPU#1 (phys ID: 1) waiting for CALLOUT
> Startup point 1.
> Waiting for send to finish...
> +Sending STARTUP #2.
> After apic_write.
> Startup point 1.
> Waiting for send to finish...
> +After Startup.
> Before Callout 1.
> After Callout 1.
> CALLIN, before setup_local_APIC().
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 1101.00 BogoMIPS
> Stack at about c15fffbc
> CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 128K
> Intel machine check reporting enabled on CPU#1.
> CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
> CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
> CPU: Common caps: 0183fbff 00000000 00000000 00000000
> OK.
> CPU1: Intel Celeron (Mendocino) stepping 05
> CPU has booted.
> Before bogomips.
> Total of 2 processors activated (2202.00 BogoMIPS).
> Before bogocount - setting activated=1.
> Boot done.
> ENABLING IO-APIC IRQs
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> Synchronizing Arb IDs.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
> ..TIMER: vector=49 pin1=2 pin2=0
> activating NMI Watchdog ... done.
> number of MP IRQ sources: 19.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
>
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .... register #01: 00170011
> .......     : max redirection entries: 0017
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 003 03  0    0    0   0   0    1    1    39
>  02 003 03  0    0    0   0   0    1    1    31
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 003 03  0    0    0   0   0    1    1    51
>  06 003 03  0    0    0   0   0    1    1    59
>  07 003 03  0    0    0   0   0    1    1    61
>  08 003 03  0    0    0   0   0    1    1    69
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 000 00  1    0    0   0   0    0    0    00
>  0b 000 00  1    0    0   0   0    0    0    00
>  0c 003 03  0    0    0   0   0    1    1    71
>  0d 003 03  0    0    0   0   0    1    1    79
>  0e 003 03  0    0    0   0   0    1    1    81
>  0f 003 03  0    0    0   0   0    1    1    89
>  10 003 03  1    1    0   1   0    1    1    91
>  11 003 03  1    1    0   1   0    1    1    99
>  12 003 03  1    1    0   1   0    1    1    A1
>  13 003 03  1    1    0   1   0    1    1    A9
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 2
> IRQ1 -> 1
> IRQ3 -> 3
> IRQ4 -> 4
> IRQ5 -> 5
> IRQ6 -> 6
> IRQ7 -> 7
> IRQ8 -> 8
> IRQ12 -> 12
> IRQ13 -> 13
> IRQ14 -> 14
> IRQ15 -> 15
> IRQ16 -> 16
> IRQ17 -> 17
> IRQ18 -> 18
> IRQ19 -> 19
> .................................... done.
> calibrating APIC timer ...
> ..... CPU clock speed is 551.2507 MHz.
> ..... host bus clock speed is 100.2273 MHz.
> cpu: 0, clocks: 1002273, slice: 334091
> CPU0<T0:1002272,T1:668176,D:5,S:334091,C:1002273>
> cpu: 1, clocks: 1002273, slice: 334091
> CPU1<T0:1002272,T1:334080,D:10,S:334091,C:1002273>
> checking TSC synchronization across CPUs: passed.
> Setting commenced=1, go go go
> PCI: PCI BIOS revision 2.10 entry at 0xfb440, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
> PCI->APIC IRQ transform: (B0,I7,P3) -> 19
> PCI->APIC IRQ transform: (B0,I13,P0) -> 17
> PCI->APIC IRQ transform: (B0,I19,P0) -> 18
> PCI->APIC IRQ transform: (B0,I19,P1) -> 18
> PCI->APIC IRQ transform: (B1,I0,P0) -> 16
> Limiting direct PCI/PCI transfers.
> isapnp: Scanning for Pnp cards...
> isapnp: Calling quirk for 01:00
> isapnp: SB audio device quirk - increasing port range
> isapnp: Card 'Creative ViBRA16X PnP'
> isapnp: 1 Plug & Play card detected total
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> aty128fb: Rage128 BIOS located at segment C00C0000
> aty128fb: Rage128 RL (AGP) [chip rev 0x2] 32M 64-bit SDR SGRAM (2:1)
> Console: switching to colour frame buffer device 80x30
> fb0: ATY Rage128 frame buffer device on PCI
> pty: 256 Unix98 ptys configured
> block: queued sectors max/low 169330kB/56443kB, 512 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> HPT366: onboard version of chipset, pin1=1 pin2=2
> HPT366: IDE controller on PCI bus 00 dev 98
> PCI: Enabling device 00:13.0 (0005 -> 0007)
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
> HPT366: IDE controller on PCI bus 00 dev 99
> HPT366: chipset revision 1
> HPT366: not 100% native mode: will probe irqs later
> hda: Maxtor 93073U6, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=4982/255/63
> Partition check:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Linux Tulip driver version 0.9.13a (January 20, 2001)
> eth0: Lite-On 82c168 PNIC rev 32 at 0xd400, 00:A0:CC:5D:C9:0F, IRQ 17.
> eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 204M
> agpgart: Detected Intel 440BX chipset
> agpgart: AGP aperture is 64M @ 0xe0000000
> [drm] AGP 0.99 on Intel 440BX @ 0xe0000000 64MB
> [drm] Initialized r128 2.1.2 20001215 on minor 63
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> uhci.c: USB UHCI at I/O 0xd000, IRQ 19
> uhci.c: detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> usb.c: kmalloc IF c1449980, numif 1
> usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
> usb.c: USB device number 1 default language ID 0x0
> Product: USB UHCI-alt Root Hub
> SerialNumber: d000
> hub.c: USB hub found
> hub.c: 2 ports detected
> hub.c: standalone hub
> hub.c: ganged power switching
> hub.c: global over-current protection
> hub.c: power on to power good time: 2ms
> hub.c: hub controller current requirement: 0mA
> hub.c: port removable status: RR
> hub.c: local power source is good
> hub.c: no over-current condition exists
> hub.c: enabling power on all ports
> usb.c: hub driver claimed interface c1449980
> usb.c: call_policy add, num 1 -- no FS yet
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 216k freed
> Adding Swap: 136544k swap-space (priority -1)
> APIC error on CPU0: 00(08)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


