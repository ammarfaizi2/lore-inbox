Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVDPDUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVDPDUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 23:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVDPDUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 23:20:12 -0400
Received: from smtpout3.uol.com.br ([200.221.4.194]:7849 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S262606AbVDPDSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 23:18:37 -0400
Date: Sat, 16 Apr 2005 00:18:24 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Subject: Ooops with kernel 2.6.12-rc2 and rsync in "D" state
Message-ID: <20050416031822.GA7396@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi there.

Today, I was copying the contents of some CDs of mine (with rsync) to my HD
and suddenly rsync stalled. I went to see the cause and it was in D state.

Then, I discovered that it had generated an Ooops and I am sending it with
this message.

The box in question is a Duron 600MHz with 256MB of RAM and with an Asus
A7V motherboard. It has an uptime of 6 days and it seems fine otherwise
(well, apart from the stack trace that I get saying that irq 10 is
ignored), but the messages surely seem to be scary.

If my .config is needed, please let me know.


Thanks in advance, Rogério.

-- 
Learn to quote e-mails decently at:
http://pub.tsn.dk/how-to-quote.php
http://learn.to/quote
http://www.xs4all.nl/~sbpoley/toppost.htm

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="ooops.txt"

[4294667.296000] Linux version 2.6.12-rc2-1 (root@dumont) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #1 Tue Apr 5 02:13:31 BRT 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[4294667.296000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
[4294667.296000]  BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
[4294667.296000]  BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[4294667.296000] 255MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 65516
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 61420 pages, LIFO batch:14
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6a90
[4294667.296000] ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec000
[4294667.296000] ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec080
[4294667.296000] ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x0ffec040
[4294667.296000] ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 0x0100000b) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0xe408
[4294667.296000] Allocating PCI resources starting at 10000000 (gap: 10000000:efff0000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: auto BOOT_IMAGE=Linux root=2103
[4294667.296000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[4294667.296000] mapped APIC to ffffd000 (01201000)
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 1024 (order: 10, 16384 bytes)
[4294667.296000] Detected 605.450 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294670.344000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294670.346000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[4294670.363000] Memory: 255996k/262064k available (1803k kernel code, 5508k reserved, 791k data, 144k init, 0k highmem)
[4294670.363000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294670.364000] Calibrating delay loop... 1196.03 BogoMIPS (lpj=598016)
[4294670.387000] Mount-cache hash table entries: 512
[4294670.387000] CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
[4294670.387000] CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
[4294670.387000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[4294670.387000] CPU: L2 Cache: 64K (64 bytes/line)
[4294670.387000] CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000
[4294670.387000] Intel machine check architecture supported.
[4294670.387000] Intel machine check reporting enabled on CPU#0.
[4294670.387000] CPU: AMD Duron(tm) Processor stepping 00
[4294670.387000] Enabling fast FPU save and restore... done.
[4294670.387000] Checking 'hlt' instruction... OK.
[4294670.392000]  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
[4294670.433000] Parsing all Control Methods:...................................................................................................................
[4294670.522000] Table [DSDT](id F004) - 356 Objects with 38 Devices 115 Methods 24 Regions
[4294670.522000] ACPI Namespace successfully loaded at root c03dd6c0
[4294670.522000] ACPI: setting ELCR to 0200 (from 0e20)
[4294670.522000] evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
[4294670.523000] NET: Registered protocol family 16
[4294670.525000] PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
[4294670.525000] PCI: Using configuration type 1
[4294670.525000] mtrr: v2.0 (20020519)
[4294670.526000] ACPI: Subsystem revision 20050309
[4294670.567000] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
[4294670.567000] evgpeblk-0987 [06] ev_create_gpe_block   : Found 4 Wake, Enabled 0 Runtime GPEs in this block
[4294670.570000] Completing Region/Field/Buffer/Package initialization:.......................................................
[4294670.828000] Initialized 23/24 Regions 2/2 Fields 19/19 Buffers 11/14 Packages (365 nodes)
[4294670.828000] Executing all Device _STA and_INI methods:.........................................
[4294671.187000] 41 Devices found containing: 41 _STA, 0 _INI methods
[4294671.187000] ACPI: Interpreter enabled
[4294671.187000] ACPI: Using PIC for interrupt routing
[4294671.264000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[4294671.320000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[4294671.376000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[4294671.432000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[4294672.102000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294672.102000] PCI: Probing PCI hardware (bus 00)
[4294672.103000] PCI: Scanning bus 0000:00
[4294672.103000] PCI: Found 0000:00:00.0 [1106/0305] 000600 00
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:00.0
[4294672.103000] PCI: Calling quirk c0195201 for 0000:00:00.0
[4294672.103000] PCI: Via IRQ fixup
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:00.0
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:00.0
[4294672.103000] PCI: Calling quirk c0271d47 for 0000:00:00.0
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:00.0
[4294672.103000] PCI: Found 0000:00:01.0 [1106/8305] 000604 01
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:01.0
[4294672.103000] PCI: Calling quirk c0195201 for 0000:00:01.0
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:01.0
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:01.0
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:01.0
[4294672.103000] PCI: Found 0000:00:04.0 [1106/0686] 000601 00
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:04.0
[4294672.103000] PCI: Calling quirk c0195201 for 0000:00:04.0
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:04.0
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:04.0
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:04.0
[4294672.103000] PCI: Found 0000:00:04.1 [1106/0571] 000101 00
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:04.1
[4294672.103000] PCI: Calling quirk c0195201 for 0000:00:04.1
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:04.1
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:04.1
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:04.1
[4294672.103000] PCI: Found 0000:00:04.2 [1106/3038] 000c03 00
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:04.2
[4294672.103000] PCI: Calling quirk c0195201 for 0000:00:04.2
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:04.2
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:04.2
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:04.2
[4294672.103000] PCI: Found 0000:00:04.3 [1106/3038] 000c03 00
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:04.3
[4294672.103000] PCI: Calling quirk c0195201 for 0000:00:04.3
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:04.3
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:04.3
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:04.3
[4294672.103000] PCI: Found 0000:00:04.4 [1106/3057] 000680 00
[4294672.103000] PCI: Calling quirk c0194ed7 for 0000:00:04.4
[4294672.103000] PCI: Calling quirk c0194fc8 for 0000:00:04.4
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:04.4
[4294672.103000] PCI: Calling quirk c0195201 for 0000:00:04.4
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:04.4
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:04.4
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:04.4
[4294672.103000] PCI: Found 0000:00:09.0 [10ec/8139] 000200 00
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:09.0
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:09.0
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:09.0
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:09.0
[4294672.103000] PCI: Found 0000:00:0a.0 [12b9/1008] 000700 00
[4294672.103000] PCI: Calling quirk c019513b for 0000:00:0a.0
[4294672.103000] PCI: Calling quirk c0195568 for 0000:00:0a.0
[4294672.103000] PCI: Calling quirk c0271caf for 0000:00:0a.0
[4294672.103000] PCI: Calling quirk c0271f64 for 0000:00:0a.0
[4294672.104000] PCI: Found 0000:00:0b.0 [1106/3044] 000c00 00
[4294672.104000] PCI: Calling quirk c019513b for 0000:00:0b.0
[4294672.104000] PCI: Calling quirk c0195201 for 0000:00:0b.0
[4294672.104000] PCI: Calling quirk c0195568 for 0000:00:0b.0
[4294672.104000] PCI: Calling quirk c0271caf for 0000:00:0b.0
[4294672.104000] PCI: Calling quirk c0271f64 for 0000:00:0b.0
[4294672.104000] PCI: Found 0000:00:0c.0 [1274/5880] 000401 00
[4294672.104000] PCI: Calling quirk c019513b for 0000:00:0c.0
[4294672.104000] PCI: Calling quirk c0195568 for 0000:00:0c.0
[4294672.104000] PCI: Calling quirk c0271caf for 0000:00:0c.0
[4294672.104000] PCI: Calling quirk c0271f64 for 0000:00:0c.0
[4294672.104000] PCI: Found 0000:00:0d.0 [10ec/8139] 000200 00
[4294672.104000] PCI: Calling quirk c019513b for 0000:00:0d.0
[4294672.104000] PCI: Calling quirk c0195568 for 0000:00:0d.0
[4294672.104000] PCI: Calling quirk c0271caf for 0000:00:0d.0
[4294672.104000] PCI: Calling quirk c0271f64 for 0000:00:0d.0
[4294672.104000] PCI: Found 0000:00:11.0 [105a/0d30] 000180 00
[4294672.104000] PCI: Calling quirk c019513b for 0000:00:11.0
[4294672.104000] PCI: Calling quirk c0195568 for 0000:00:11.0
[4294672.104000] PCI: Calling quirk c0271caf for 0000:00:11.0
[4294672.104000] PCI: Calling quirk c0271f64 for 0000:00:11.0
[4294672.104000] PCI: Fixups for bus 0000:00
[4294672.104000] PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
[4294672.104000] PCI: Scanning bus 0000:01
[4294672.104000] PCI: Found 0000:01:00.0 [102b/0525] 000300 00
[4294672.104000] PCI: Calling quirk c019513b for 0000:01:00.0
[4294672.104000] PCI: Calling quirk c0195568 for 0000:01:00.0
[4294672.104000] PCI: Calling quirk c0271caf for 0000:01:00.0
[4294672.104000] PCI: Calling quirk c0271f64 for 0000:01:00.0
[4294672.104000] Boot video device is 0000:01:00.0
[4294672.104000] PCI: Fixups for bus 0000:01
[4294672.104000] PCI: Bus scan for 0000:01 returning with max=01
[4294672.104000] PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
[4294672.104000] PCI: Bus scan for 0000:00 returning with max=01
[4294672.106000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294674.409000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294674.409000] pnp: PnP ACPI init
[4294675.192000] pnp: PnP ACPI: found 13 devices
[4294675.192000] PCI: Using ACPI for IRQ routing
[4294675.192000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294675.204000] TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
[4294675.241000] pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
[4294675.241000] pnp: 00:02: ioport range 0xe800-0xe80f has been reserved
[4294675.242000] Simple Boot Flag at 0x3a set to 0x1
[4294675.242000] Machine check exception polling timer started.
[4294675.242000] IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
[4294675.242000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[4294675.242000] apm: overridden by ACPI.
[4294675.245000] Initializing Cryptographic API
[4294675.245000] PCI: Calling quirk c0194b97 for 0000:00:00.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:00.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:01.0
[4294675.245000] PCI: Calling quirk c0194f4c for 0000:00:04.0
[4294675.245000] PCI: Disabling Via external APIC routing
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:04.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:04.1
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:04.2
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:04.3
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:04.4
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:09.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:0d.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:0a.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:0b.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:0c.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:00:11.0
[4294675.245000] PCI: Calling quirk c0195075 for 0000:01:00.0
[4294675.245000] ACPI: Power Button (FF) [PWRF]
[4294675.260000] ACPI: CPU0 (power states: C1[C1] C2[C2])
[4294675.260000] ACPI: Processor [CPU0] (supports 16 throttling states)
[4294675.292000] lp: driver loaded but no devices found
[4294675.292000] Real Time Clock Driver v1.12
[4294675.292000] Linux agpgart interface v0.101 (c) Dave Jones
[4294675.292000] agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
[4294675.294000] agpgart: AGP aperture is 16M @ 0xe7000000
[4294675.294000] [drm] Initialized drm 1.0.0 20040925
[4294675.463000] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[4294675.463000] PCI: setting IRQ 11 as level-triggered
[4294675.463000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[4294675.463000] [drm] Initialized mga 3.1.0 20021029 on minor 0: 
[4294675.463000] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[4294675.467000] serio: i8042 AUX port at 0x60,0x64 irq 12
[4294675.467000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294675.467000] Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
[4294675.468000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294675.468000] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294675.472000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294675.472000] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294675.586000] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
[4294675.586000] PCI: setting IRQ 5 as level-triggered
[4294675.586000] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
[4294675.586000] ttyS14 at I/O 0xa000 (irq = 5) is a 16550A
[4294675.586000] parport_pc: VIA 686A/8231 detected
[4294675.586000] parport_pc: probing current configuration
[4294675.586000] parport_pc: Current parallel port base: 0x378
[4294675.586000] parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
[4294675.669000] lp0: using parport0 (interrupt-driven).
[4294675.669000] parport_pc: VIA parallel port: io=0x378, irq=7
[4294675.669000] io scheduler noop registered
[4294675.669000] io scheduler anticipatory registered
[4294675.669000] Floppy drive(s): fd0 is 1.44M
[4294675.683000] FDC 0 is a post-1991 82077
[4294675.684000] 8139too Fast Ethernet driver 0.9.27
[4294675.831000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[4294675.831000] PCI: setting IRQ 9 as level-triggered
[4294675.831000] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
[4294675.832000] eth0: RealTek RTL8139 at 0xd0816000, 00:e0:7d:96:28:8f, IRQ 9
[4294675.832000] eth0:  Identified 8139 chip type 'RTL-8139C'
[4294675.832000] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
[4294675.832000] eth1: RealTek RTL8139 at 0xd0818000, 00:e0:7d:95:c9:9c, IRQ 9
[4294675.832000] eth1:  Identified 8139 chip type 'RTL-8139C'
[4294675.832000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294675.832000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294675.832000] VP_IDE: IDE controller at PCI slot 0000:00:04.1
[4294675.833000] VP_IDE: chipset revision 16
[4294675.833000] VP_IDE: not 100% native mode: will probe irqs later
[4294675.833000] VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
[4294675.833000]     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
[4294675.833000]     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
[4294675.833000] Probing IDE interface ide0...
[4294676.625000] hda: HL-DT-ST DVDRAM GSA-4160B, ATAPI CD/DVD-ROM drive
[4294676.932000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294676.932000] Probing IDE interface ide1...
[4294677.724000] hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
[4294678.336000] ide1 at 0x170-0x177,0x376 on irq 15
[4294678.337000] PDC20265: IDE controller at PCI slot 0000:00:11.0
[4294678.494000] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
[4294678.494000] PCI: setting IRQ 10 as level-triggered
[4294678.494000] ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
[4294678.494000] PDC20265: chipset revision 2
[4294678.494000] PDC20265: 100% native mode on irq 10
[4294678.494000] PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
[4294678.494000]     ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
[4294678.494000]     ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
[4294678.494000] Probing IDE interface ide2...
[4294678.758000] hde: QUANTUM FIREBALL CX13.0A, ATA DISK drive
[4294679.370000] ide2 at 0x8800-0x8807,0x8402 on irq 10
[4294679.370000] Probing IDE interface ide3...
[4294679.634000] hdg: QUANTUM FIREBALLlct15 30, ATA DISK drive
[4294681.162000] irq 10: nobody cared!
[4294681.162000]  [<c012b4cd>] __report_bad_irq+0x31/0x77
[4294681.162000]  [<c012b577>] note_interrupt+0x4c/0x71
[4294681.162000]  [<c012b192>] __do_IRQ+0x93/0xbd
[4294681.162000]  [<c01047f5>] do_IRQ+0x19/0x24
[4294681.162000]  [<c0103406>] common_interrupt+0x1a/0x20
[4294681.162000]  [<c0119724>] __do_softirq+0x2c/0x7d
[4294681.162000]  [<c0119797>] do_softirq+0x22/0x26
[4294681.162000]  [<c01047fa>] do_IRQ+0x1e/0x24
[4294681.162000]  [<c0103406>] common_interrupt+0x1a/0x20
[4294681.162000]  [<c012b295>] enable_irq+0x88/0x8d
[4294681.162000]  [<c0220cd4>] probe_hwif+0x2f7/0x38a
[4294681.162000]  [<c0220d77>] probe_hwif_init_with_fixup+0x10/0x74
[4294681.162000]  [<c0223437>] ide_setup_pci_device+0x72/0x7f
[4294681.162000]  [<c0218e8e>] pdc202xx_init_one+0x15/0x18
[4294681.162000]  [<c03a0fbd>] ide_scan_pcidev+0x34/0x59
[4294681.162000]  [<c03a0ffe>] ide_scan_pcibus+0x1c/0x88
[4294681.162000]  [<c03a0f2e>] probe_for_hwifs+0xb/0xd
[4294681.162000]  [<c03a0f74>] ide_init+0x44/0x59
[4294681.162000]  [<c038c6f0>] do_initcalls+0x4b/0x99
[4294681.162000]  [<c0100272>] init+0x0/0xce
[4294681.162000]  [<c0100299>] init+0x27/0xce
[4294681.162000]  [<c010126d>] kernel_thread_helper+0x5/0xb
[4294681.162000] handlers:
[4294681.162000] [<c021e040>] (ide_intr+0x0/0xea)
[4294681.162000] Disabling IRQ #10
[4294682.080000] irq 10: nobody cared!
[4294682.080000]  [<c012b4cd>] __report_bad_irq+0x31/0x77
[4294682.080000]  [<c012b577>] note_interrupt+0x4c/0x71
[4294682.080000]  [<c012b192>] __do_IRQ+0x93/0xbd
[4294682.080000]  [<c01047f5>] do_IRQ+0x19/0x24
[4294682.080000]  [<c0103406>] common_interrupt+0x1a/0x20
[4294682.080000]  [<c0119724>] __do_softirq+0x2c/0x7d
[4294682.080000]  [<c0119797>] do_softirq+0x22/0x26
[4294682.080000]  [<c01047fa>] do_IRQ+0x1e/0x24
[4294682.080000]  [<c0103406>] common_interrupt+0x1a/0x20
[4294682.080000]  [<c012b295>] enable_irq+0x88/0x8d
[4294682.080000]  [<c021ed43>] ide_config_drive_speed+0x168/0x30d
[4294682.080000]  [<c02184ce>] pdc202xx_tune_chipset+0x38c/0x396
[4294682.080000]  [<c0220d1e>] probe_hwif+0x341/0x38a
[4294682.080000]  [<c0220d77>] probe_hwif_init_with_fixup+0x10/0x74
[4294682.080000]  [<c0223437>] ide_setup_pci_device+0x72/0x7f
[4294682.080000]  [<c0218e8e>] pdc202xx_init_one+0x15/0x18
[4294682.080000]  [<c03a0fbd>] ide_scan_pcidev+0x34/0x59
[4294682.080000]  [<c03a0ffe>] ide_scan_pcibus+0x1c/0x88
[4294682.080000]  [<c03a0f2e>] probe_for_hwifs+0xb/0xd
[4294682.080000]  [<c03a0f74>] ide_init+0x44/0x59
[4294682.080000]  [<c038c6f0>] do_initcalls+0x4b/0x99
[4294682.080000]  [<c0100272>] init+0x0/0xce
[4294682.080000]  [<c0100299>] init+0x27/0xce
[4294682.080000]  [<c010126d>] kernel_thread_helper+0x5/0xb
[4294682.080000] handlers:
[4294682.080000] [<c021e040>] (ide_intr+0x0/0xea)
[4294682.080000] Disabling IRQ #10
[4294682.997000] irq 10: nobody cared!
[4294682.997000]  [<c012b4cd>] __report_bad_irq+0x31/0x77
[4294682.997000]  [<c012b577>] note_interrupt+0x4c/0x71
[4294682.997000]  [<c012b192>] __do_IRQ+0x93/0xbd
[4294682.997000]  [<c01047f5>] do_IRQ+0x19/0x24
[4294682.997000]  [<c0103406>] common_interrupt+0x1a/0x20
[4294682.997000]  [<c0119724>] __do_softirq+0x2c/0x7d
[4294682.997000]  [<c0119797>] do_softirq+0x22/0x26
[4294682.997000]  [<c01047fa>] do_IRQ+0x1e/0x24
[4294682.997000]  [<c0103406>] common_interrupt+0x1a/0x20
[4294682.997000]  [<c012b295>] enable_irq+0x88/0x8d
[4294682.997000]  [<c021ed43>] ide_config_drive_speed+0x168/0x30d
[4294682.997000]  [<c02184ce>] pdc202xx_tune_chipset+0x38c/0x396
[4294682.997000]  [<c02187e6>] config_chipset_for_dma+0x216/0x227
[4294682.997000]  [<c021882e>] pdc202xx_config_drive_xfer_rate+0x37/0x6c
[4294682.997000]  [<c0220d4c>] probe_hwif+0x36f/0x38a
[4294682.997000]  [<c0220d77>] probe_hwif_init_with_fixup+0x10/0x74
[4294682.997000]  [<c0223437>] ide_setup_pci_device+0x72/0x7f
[4294682.997000]  [<c0218e8e>] pdc202xx_init_one+0x15/0x18
[4294682.997000]  [<c03a0fbd>] ide_scan_pcidev+0x34/0x59
[4294682.997000]  [<c03a0ffe>] ide_scan_pcibus+0x1c/0x88
[4294682.997000]  [<c03a0f2e>] probe_for_hwifs+0xb/0xd
[4294682.997000]  [<c03a0f74>] ide_init+0x44/0x59
[4294682.997000]  [<c038c6f0>] do_initcalls+0x4b/0x99
[4294682.997000]  [<c0100272>] init+0x0/0xce
[4294682.997000]  [<c0100299>] init+0x27/0xce
[4294682.997000]  [<c010126d>] kernel_thread_helper+0x5/0xb
[4294682.997000] handlers:
[4294682.997000] [<c021e040>] (ide_intr+0x0/0xea)
[4294682.997000] Disabling IRQ #10
[4294682.998000] ide3 at 0x8000-0x8007,0x7802 on irq 10
[4294682.999000] hde: max request size: 128KiB
[4294712.999000] hde: lost interrupt
[4294713.000000] hde: 25429824 sectors (13020 MB) w/418KiB Cache, CHS=25228/16/63, UDMA(33)
[4294713.000000] hde: cache flushes not supported
[4294713.000000]  hde: hde1 hde2 hde3 hde4
[4294713.003000] hdg: max request size: 128KiB
[4294713.005000] hdg: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=58168/16/63, UDMA(66)
[4294713.005000] hdg: cache flushes not supported
[4294713.005000]  hdg: hdg1
[4294713.018000] hda: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[4294713.018000] Uniform CD-ROM driver Revision: 3.20
[4294713.026000] hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
[4294713.030000] mice: PS/2 mouse device common for all mice
[4294713.031000] input: PC Speaker
[4294713.031000] i2c /dev entries driver
[4294713.125000] input: AT Translated Set 2 keyboard on isa0060/serio0
[4294713.198000] i2c_adapter i2c-0: enabling sensors
[4294713.199000] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
[4294713.200000] ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[4294713.552000] ALSA device list:
[4294713.552000]   #0: Ensoniq AudioPCI ENS1371 at 0x9400, irq 11
[4294713.552000] NET: Registered protocol family 2
[4294713.561000] IP: routing cache hash table of 2048 buckets, 16Kbytes
[4294713.561000] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[4294713.562000] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[4294713.562000] TCP: Hash tables configured (established 16384 bind 16384)
[4294713.562000] NET: Registered protocol family 1
[4294713.562000] NET: Registered protocol family 17
[4294713.564000] ACPI wakeup devices: 
[4294713.564000] PWRB PCI0 UAR1 UAR2 USB0 USB1 
[4294713.564000] ACPI: (supports S0 S1 S3 S4 S5)
[4294713.597000] kjournald starting.  Commit interval 5 seconds
[4294713.597000] EXT3-fs: mounted filesystem with ordered data mode.
[4294713.597000] VFS: Mounted root (ext3 filesystem) readonly.
[4294713.597000] Freeing unused kernel memory: 144k freed
[4294713.818000] input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
[4294723.583000] Adding 240964k swap on /dev/hde4.  Priority:-1 extents:1
[4294723.739000] EXT3 FS on hde3, internal journal
[4294727.480000] kjournald starting.  Commit interval 5 seconds
[4294727.480000] EXT3 FS on hde1, internal journal
[4294727.480000] EXT3-fs: mounted filesystem with ordered data mode.
[4294729.583000] usbcore: registered new driver usbfs
[4294729.607000] usbcore: registered new driver hub
[4294729.660000] USB Universal Host Controller Interface driver v2.2
[4294729.670000] ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
[4294729.670000] uhci_hcd 0000:00:04.2: UHCI Host Controller
[4294729.742000] uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
[4294729.742000] uhci_hcd 0000:00:04.2: irq 9, io base 0x0000d400
[4294729.748000] hub 1-0:1.0: USB hub found
[4294729.748000] hub 1-0:1.0: 2 ports detected
[4294729.768000] ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
[4294729.769000] uhci_hcd 0000:00:04.3: UHCI Host Controller
[4294729.846000] uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
[4294729.846000] uhci_hcd 0000:00:04.3: irq 9, io base 0x0000d000
[4294729.959000] hub 2-0:1.0: USB hub found
[4294729.959000] hub 2-0:1.0: 2 ports detected
[4294730.049000] usb 1-1: new full speed USB device using uhci_hcd and address 2
[4294730.262000] hub 1-1:1.0: USB hub found
[4294730.264000] hub 1-1:1.0: 2 ports detected
[4294730.665000] usb 2-1: new full speed USB device using uhci_hcd and address 2
[4294730.956000] usb 2-2: new full speed USB device using uhci_hcd and address 3
[4294731.055000] hub 2-2:1.0: USB hub found
[4294731.057000] hub 2-2:1.0: 4 ports detected
[4294731.249000] usb 1-1.1: new full speed USB device using uhci_hcd and address 3
[4294731.736000] drivers/usb/class/usblp.c: Disabling reads from problem bidirectional printer on usblp0
[4294732.036000] drivers/usb/class/usblp.c: usblp0: USB Unidirectional printer dev 2 if 0 alt 1 proto 2 vid 0x03F0 pid 0x0604
[4294732.037000] usbcore: registered new driver usblp
[4294732.037000] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
[4294732.082000] usbcore: registered new driver hiddev
[4294732.234000] input: USB HID v1.00 Keyboard [Silitek  Silitek USB Keyboard] on usb-0000:00:04.2-1.1
[4294732.234000] usbcore: registered new driver usbhid
[4294732.234000] drivers/usb/input/hid-core.c: v2.01:USB HID core driver
[4294732.920000] ieee1394: Initialized config rom entry `ip1394'
[4294733.218000] ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
[4294733.218000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
[4294733.277000] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[e1800000-e18007ff]  Max Packet=[2048]
[4294734.545000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011066645555ead]
[4294734.853000] eth1394: $Rev: 1247 $ Ben Collins <bcollins@debian.org>
[4294734.857000] eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[4294737.004000] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[4294737.039000] eth1: link up, 10Mbps, half-duplex, lpa 0x0000
[4295182.373000] ip_tables: (C) 2000-2002 Netfilter core team
[4295182.386000] ip_conntrack version 2.1 (2047 buckets, 16376 max) - 248 bytes per conntrack
[4305425.981000] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[4305425.981000] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
[4305425.981000] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[4365130.161000] u32 classifier
[4365130.161000]     Perfomance counters on
[4365130.161000]     input device check on 
[4365130.161000]     Actions configured 
[4365130.367000] tcf_action_init_1: successfull police
[4365137.804000] ing_filter:  fixed  eth1 out eth1
[4365197.817000] ing_filter:  fixed  eth1 out eth1
[4365257.830000] ing_filter:  fixed  eth1 out eth1
[4365265.167000] tcf_action_destroy destroying cbc43b40 next 00000000
[4365274.867000] tcf_action_init_1: successfull police
[4365317.843000] ing_filter:  fixed  eth1 out eth1
[4365377.857000] ing_filter:  fixed  eth1 out eth1
[4365437.870000] ing_filter:  fixed  eth1 out eth1
[4365497.883000] ing_filter:  fixed  eth1 out eth1
[4365557.897000] ing_filter:  fixed  eth1 out eth1
[4365617.910000] ing_filter:  fixed  eth1 out eth1
[4365677.923000] ing_filter:  fixed  eth1 out eth1
[4365737.936000] ing_filter:  fixed  eth1 out eth1
[4365797.949000] ing_filter:  fixed  eth1 out eth1
[4365857.963000] ing_filter:  fixed  eth1 out eth1
[4365917.977000] ing_filter:  fixed  eth1 out eth1
[4365977.991000] ing_filter:  fixed  eth1 out eth1
[4366038.004000] ing_filter:  fixed  eth1 out eth1
[4366098.018000] ing_filter:  fixed  eth1 out eth1
[4366158.113000] ing_filter:  fixed  eth1 out eth1
[4366218.127000] ing_filter:  fixed  eth1 out eth1
[4366278.142000] ing_filter:  fixed  eth1 out eth1
[4366338.159000] ing_filter:  fixed  eth1 out eth1
[4366398.171000] ing_filter:  fixed  eth1 out eth1
[4366458.184000] ing_filter:  fixed  eth1 out eth1
[4366518.197000] ing_filter:  fixed  eth1 out eth1
[4366578.210000] ing_filter:  fixed  eth1 out eth1
[4366638.223000] ing_filter:  fixed  eth1 out eth1
[4366698.236000] ing_filter:  fixed  eth1 out eth1
[4366758.256000] ing_filter:  fixed  eth1 out eth1
[4366818.272000] ing_filter:  fixed  eth1 out eth1
[4366878.291000] ing_filter:  fixed  eth1 out eth1
[4366938.304000] ing_filter:  fixed  eth1 out eth1
[4366998.320000] ing_filter:  fixed  eth1 out eth1
[4367058.591000] ing_filter:  fixed  eth1 out eth1
[4367118.605000] ing_filter:  fixed  eth1 out eth1
[4367178.618000] ing_filter:  fixed  eth1 out eth1
[4367238.631000] ing_filter:  fixed  eth1 out eth1
[4367298.644000] ing_filter:  fixed  eth1 out eth1
[4367358.659000] ing_filter:  fixed  eth1 out eth1
[4367418.680000] ing_filter:  fixed  eth1 out eth1
[4367478.692000] ing_filter:  fixed  eth1 out eth1
[4367538.795000] ing_filter:  fixed  eth1 out eth1
[4367598.808000] ing_filter:  fixed  eth1 out eth1
[4367658.837000] ing_filter:  fixed  eth1 out eth1
[4367718.897000] ing_filter:  fixed  eth1 out eth1
[4367778.991000] ing_filter:  fixed  eth1 out eth1
[4367839.031000] ing_filter:  fixed  eth1 out eth1
[4367899.144000] ing_filter:  fixed  eth1 out eth1
[4367959.222000] ing_filter:  fixed  eth1 out eth1
[4368019.259000] ing_filter:  fixed  eth1 out eth1
[4368079.272000] ing_filter:  fixed  eth1 out eth1
[4368139.285000] ing_filter:  fixed  eth1 out eth1
[4368199.299000] ing_filter:  fixed  eth1 out eth1
[4368259.313000] ing_filter:  fixed  eth1 out eth1
[4368319.327000] ing_filter:  fixed  eth1 out eth1
[4368379.340000] ing_filter:  fixed  eth1 out eth1
[4368439.356000] ing_filter:  fixed  eth1 out eth1
[4368499.369000] ing_filter:  fixed  eth1 out eth1
[4368559.459000] ing_filter:  fixed  eth1 out eth1
[4368619.483000] ing_filter:  fixed  eth1 out eth1
[4368679.496000] ing_filter:  fixed  eth1 out eth1
[4368739.509000] ing_filter:  fixed  eth1 out eth1
[4368799.522000] ing_filter:  fixed  eth1 out eth1
[4368859.536000] ing_filter:  fixed  eth1 out eth1
[4368919.548000] ing_filter:  fixed  eth1 out eth1
[4368979.561000] ing_filter:  fixed  eth1 out eth1
[4369039.576000] ing_filter:  fixed  eth1 out eth1
[4369099.594000] ing_filter:  fixed  eth1 out eth1
[4369159.608000] ing_filter:  fixed  eth1 out eth1
[4369219.621000] ing_filter:  fixed  eth1 out eth1
[4369279.634000] ing_filter:  fixed  eth1 out eth1
[4369339.647000] ing_filter:  fixed  eth1 out eth1
[4369399.661000] ing_filter:  fixed  eth1 out eth1
[4369459.675000] ing_filter:  fixed  eth1 out eth1
[4369519.691000] ing_filter:  fixed  eth1 out eth1
[4369579.844000] ing_filter:  fixed  eth1 out eth1
[4369639.857000] ing_filter:  fixed  eth1 out eth1
[4369699.872000] ing_filter:  fixed  eth1 out eth1
[4369759.887000] ing_filter:  fixed  eth1 out eth1
[4369819.903000] ing_filter:  fixed  eth1 out eth1
[4369879.917000] ing_filter:  fixed  eth1 out eth1
[4369939.956000] ing_filter:  fixed  eth1 out eth1
[4369999.970000] ing_filter:  fixed  eth1 out eth1
[4370060.913000] ing_filter:  fixed  eth1 out eth1
[4370120.926000] ing_filter:  fixed  eth1 out eth1
[4370180.941000] ing_filter:  fixed  eth1 out eth1
[4370241.238000] ing_filter:  fixed  eth1 out eth1
[4370301.256000] ing_filter:  fixed  eth1 out eth1
[4370361.274000] ing_filter:  fixed  eth1 out eth1
[4370421.287000] ing_filter:  fixed  eth1 out eth1
[4370481.300000] ing_filter:  fixed  eth1 out eth1
[4370541.313000] ing_filter:  fixed  eth1 out eth1
[4370601.326000] ing_filter:  fixed  eth1 out eth1
[4370661.340000] ing_filter:  fixed  eth1 out eth1
[4370721.354000] ing_filter:  fixed  eth1 out eth1
[4370781.471000] ing_filter:  fixed  eth1 out eth1
[4370842.280000] ing_filter:  fixed  eth1 out eth1
[4370902.293000] ing_filter:  fixed  eth1 out eth1
[4370962.307000] ing_filter:  fixed  eth1 out eth1
[4371022.320000] ing_filter:  fixed  eth1 out eth1
[4371082.334000] ing_filter:  fixed  eth1 out eth1
[4371142.347000] ing_filter:  fixed  eth1 out eth1
[4371202.360000] ing_filter:  fixed  eth1 out eth1
[4371262.373000] ing_filter:  fixed  eth1 out eth1
[4371322.386000] ing_filter:  fixed  eth1 out eth1
[4371382.399000] ing_filter:  fixed  eth1 out eth1
[4371442.415000] ing_filter:  fixed  eth1 out eth1
[4371502.470000] ing_filter:  fixed  eth1 out eth1
[4371562.494000] ing_filter:  fixed  eth1 out eth1
[4371622.509000] ing_filter:  fixed  eth1 out eth1
[4371682.703000] ing_filter:  fixed  eth1 out eth1
[4371742.716000] ing_filter:  fixed  eth1 out eth1
[4371802.729000] ing_filter:  fixed  eth1 out eth1
[4371862.884000] ing_filter:  fixed  eth1 out eth1
[4371922.897000] ing_filter:  fixed  eth1 out eth1
[4371982.910000] ing_filter:  fixed  eth1 out eth1
[4372042.931000] ing_filter:  fixed  eth1 out eth1
[4372102.953000] ing_filter:  fixed  eth1 out eth1
[4372162.970000] ing_filter:  fixed  eth1 out eth1
[4372222.983000] ing_filter:  fixed  eth1 out eth1
[4372282.997000] ing_filter:  fixed  eth1 out eth1
[4372343.015000] ing_filter:  fixed  eth1 out eth1
[4372404.913000] ing_filter:  fixed  eth1 out eth1
[4372464.926000] ing_filter:  fixed  eth1 out eth1
[4372524.939000] ing_filter:  fixed  eth1 out eth1
[4372585.666000] ing_filter:  fixed  eth1 out eth1
[4372645.686000] ing_filter:  fixed  eth1 out eth1
[4372705.699000] ing_filter:  fixed  eth1 out eth1
[4372765.713000] ing_filter:  fixed  eth1 out eth1
[4372825.727000] ing_filter:  fixed  eth1 out eth1
[4372885.740000] ing_filter:  fixed  eth1 out eth1
[4372945.753000] ing_filter:  fixed  eth1 out eth1
[4373005.803000] ing_filter:  fixed  eth1 out eth1
[4373065.836000] ing_filter:  fixed  eth1 out eth1
[4373125.931000] ing_filter:  fixed  eth1 out eth1
[4373185.984000] ing_filter:  fixed  eth1 out eth1
[4373245.997000] ing_filter:  fixed  eth1 out eth1
[4373306.010000] ing_filter:  fixed  eth1 out eth1
[4373366.030000] ing_filter:  fixed  eth1 out eth1
[4373426.043000] ing_filter:  fixed  eth1 out eth1
[4373486.056000] ing_filter:  fixed  eth1 out eth1
[4373546.072000] ing_filter:  fixed  eth1 out eth1
[4373606.088000] ing_filter:  fixed  eth1 out eth1
[4373666.103000] ing_filter:  fixed  eth1 out eth1
[4373726.117000] ing_filter:  fixed  eth1 out eth1
[4373786.130000] ing_filter:  fixed  eth1 out eth1
[4373846.146000] ing_filter:  fixed  eth1 out eth1
[4373906.159000] ing_filter:  fixed  eth1 out eth1
[4373966.174000] ing_filter:  fixed  eth1 out eth1
[4374026.187000] ing_filter:  fixed  eth1 out eth1
[4374086.200000] ing_filter:  fixed  eth1 out eth1
[4374146.213000] ing_filter:  fixed  eth1 out eth1
[4374206.226000] ing_filter:  fixed  eth1 out eth1
[4374266.240000] ing_filter:  fixed  eth1 out eth1
[4374326.253000] ing_filter:  fixed  eth1 out eth1
[4374386.268000] ing_filter:  fixed  eth1 out eth1
[4374446.281000] ing_filter:  fixed  eth1 out eth1
[4374506.295000] ing_filter:  fixed  eth1 out eth1
[4374566.309000] ing_filter:  fixed  eth1 out eth1
[4374626.323000] ing_filter:  fixed  eth1 out eth1
[4374686.337000] ing_filter:  fixed  eth1 out eth1
[4374746.351000] ing_filter:  fixed  eth1 out eth1
[4374806.365000] ing_filter:  fixed  eth1 out eth1
[4374866.379000] ing_filter:  fixed  eth1 out eth1
[4374926.393000] ing_filter:  fixed  eth1 out eth1
[4374986.409000] ing_filter:  fixed  eth1 out eth1
[4375046.422000] ing_filter:  fixed  eth1 out eth1
[4375106.435000] ing_filter:  fixed  eth1 out eth1
[4375166.449000] ing_filter:  fixed  eth1 out eth1
[4375226.462000] ing_filter:  fixed  eth1 out eth1
[4375286.475000] ing_filter:  fixed  eth1 out eth1
[4375346.488000] ing_filter:  fixed  eth1 out eth1
[4375406.505000] ing_filter:  fixed  eth1 out eth1
[4375466.518000] ing_filter:  fixed  eth1 out eth1
[4375526.531000] ing_filter:  fixed  eth1 out eth1
[4375586.544000] ing_filter:  fixed  eth1 out eth1
[4375646.557000] ing_filter:  fixed  eth1 out eth1
[4375706.570000] ing_filter:  fixed  eth1 out eth1
[4375766.587000] ing_filter:  fixed  eth1 out eth1
[4375826.602000] ing_filter:  fixed  eth1 out eth1
[4375886.618000] ing_filter:  fixed  eth1 out eth1
[4375946.632000] ing_filter:  fixed  eth1 out eth1
[4376006.649000] ing_filter:  fixed  eth1 out eth1
[4376066.662000] ing_filter:  fixed  eth1 out eth1
[4376126.677000] ing_filter:  fixed  eth1 out eth1
[4376186.691000] ing_filter:  fixed  eth1 out eth1
[4376246.704000] ing_filter:  fixed  eth1 out eth1
[4376306.717000] ing_filter:  fixed  eth1 out eth1
[4376366.731000] ing_filter:  fixed  eth1 out eth1
[4376426.744000] ing_filter:  fixed  eth1 out eth1
[4376486.758000] ing_filter:  fixed  eth1 out eth1
[4376546.771000] ing_filter:  fixed  eth1 out eth1
[4376606.785000] ing_filter:  fixed  eth1 out eth1
[4376666.799000] ing_filter:  fixed  eth1 out eth1
[4376726.813000] ing_filter:  fixed  eth1 out eth1
[4376786.826000] ing_filter:  fixed  eth1 out eth1
[4376846.839000] ing_filter:  fixed  eth1 out eth1
[4376906.853000] ing_filter:  fixed  eth1 out eth1
[4376966.868000] ing_filter:  fixed  eth1 out eth1
[4377026.881000] ing_filter:  fixed  eth1 out eth1
[4377086.894000] ing_filter:  fixed  eth1 out eth1
[4377146.907000] ing_filter:  fixed  eth1 out eth1
[4377206.920000] ing_filter:  fixed  eth1 out eth1
[4377266.935000] ing_filter:  fixed  eth1 out eth1
[4377326.949000] ing_filter:  fixed  eth1 out eth1
[4377386.963000] ing_filter:  fixed  eth1 out eth1
[4377446.976000] ing_filter:  fixed  eth1 out eth1
[4377506.989000] ing_filter:  fixed  eth1 out eth1
[4377567.003000] ing_filter:  fixed  eth1 out eth1
[4377627.016000] ing_filter:  fixed  eth1 out eth1
[4377687.030000] ing_filter:  fixed  eth1 out eth1
[4377747.043000] ing_filter:  fixed  eth1 out eth1
[4377807.056000] ing_filter:  fixed  eth1 out eth1
[4377867.069000] ing_filter:  fixed  eth1 out eth1
[4377927.083000] ing_filter:  fixed  eth1 out eth1
[4377987.096000] ing_filter:  fixed  eth1 out eth1
[4378047.112000] ing_filter:  fixed  eth1 out eth1
[4378107.126000] ing_filter:  fixed  eth1 out eth1
[4378167.141000] ing_filter:  fixed  eth1 out eth1
[4378227.154000] ing_filter:  fixed  eth1 out eth1
[4378287.167000] ing_filter:  fixed  eth1 out eth1
[4378347.180000] ing_filter:  fixed  eth1 out eth1
[4378407.193000] ing_filter:  fixed  eth1 out eth1
[4378467.208000] ing_filter:  fixed  eth1 out eth1
[4378527.221000] ing_filter:  fixed  eth1 out eth1
[4378587.235000] ing_filter:  fixed  eth1 out eth1
[4378647.248000] ing_filter:  fixed  eth1 out eth1
[4378707.261000] ing_filter:  fixed  eth1 out eth1
[4378767.275000] ing_filter:  fixed  eth1 out eth1
[4378827.288000] ing_filter:  fixed  eth1 out eth1
[4378887.301000] ing_filter:  fixed  eth1 out eth1
[4378947.314000] ing_filter:  fixed  eth1 out eth1
[4379007.327000] ing_filter:  fixed  eth1 out eth1
[4379067.341000] ing_filter:  fixed  eth1 out eth1
[4379127.355000] ing_filter:  fixed  eth1 out eth1
[4379187.369000] ing_filter:  fixed  eth1 out eth1
[4379247.383000] ing_filter:  fixed  eth1 out eth1
[4379307.396000] ing_filter:  fixed  eth1 out eth1
[4379367.410000] ing_filter:  fixed  eth1 out eth1
[4379427.423000] ing_filter:  fixed  eth1 out eth1
[4379487.437000] ing_filter:  fixed  eth1 out eth1
[4379547.451000] ing_filter:  fixed  eth1 out eth1
[4379607.464000] ing_filter:  fixed  eth1 out eth1
[4379667.481000] ing_filter:  fixed  eth1 out eth1
[4379727.494000] ing_filter:  fixed  eth1 out eth1
[4379787.507000] ing_filter:  fixed  eth1 out eth1
[4379847.520000] ing_filter:  fixed  eth1 out eth1
[4379907.533000] ing_filter:  fixed  eth1 out eth1
[4379967.547000] ing_filter:  fixed  eth1 out eth1
[4380027.561000] ing_filter:  fixed  eth1 out eth1
[4380087.574000] ing_filter:  fixed  eth1 out eth1
[4380147.587000] ing_filter:  fixed  eth1 out eth1
[4380207.602000] ing_filter:  fixed  eth1 out eth1
[4380267.616000] ing_filter:  fixed  eth1 out eth1
[4380327.630000] ing_filter:  fixed  eth1 out eth1
[4380387.643000] ing_filter:  fixed  eth1 out eth1
[4380447.657000] ing_filter:  fixed  eth1 out eth1
[4380507.670000] ing_filter:  fixed  eth1 out eth1
[4380567.683000] ing_filter:  fixed  eth1 out eth1
[4380627.696000] ing_filter:  fixed  eth1 out eth1
[4380687.709000] ing_filter:  fixed  eth1 out eth1
[4380747.727000] ing_filter:  fixed  eth1 out eth1
[4380807.740000] ing_filter:  fixed  eth1 out eth1
[4380867.757000] ing_filter:  fixed  eth1 out eth1
[4380927.771000] ing_filter:  fixed  eth1 out eth1
[4380987.784000] ing_filter:  fixed  eth1 out eth1
[4381047.798000] ing_filter:  fixed  eth1 out eth1
[4381107.811000] ing_filter:  fixed  eth1 out eth1
[4381167.825000] ing_filter:  fixed  eth1 out eth1
[4381227.838000] ing_filter:  fixed  eth1 out eth1
[4381287.852000] ing_filter:  fixed  eth1 out eth1
[4381347.865000] ing_filter:  fixed  eth1 out eth1
[4381407.881000] ing_filter:  fixed  eth1 out eth1
[4381467.895000] ing_filter:  fixed  eth1 out eth1
[4381527.911000] ing_filter:  fixed  eth1 out eth1
[4381587.926000] ing_filter:  fixed  eth1 out eth1
[4381647.939000] ing_filter:  fixed  eth1 out eth1
[4381707.953000] ing_filter:  fixed  eth1 out eth1
[4381767.967000] ing_filter:  fixed  eth1 out eth1
[4381827.982000] ing_filter:  fixed  eth1 out eth1
[4381887.996000] ing_filter:  fixed  eth1 out eth1
[4381948.009000] ing_filter:  fixed  eth1 out eth1
[4382008.022000] ing_filter:  fixed  eth1 out eth1
[4382068.036000] ing_filter:  fixed  eth1 out eth1
[4382128.049000] ing_filter:  fixed  eth1 out eth1
[4382188.062000] ing_filter:  fixed  eth1 out eth1
[4382248.077000] ing_filter:  fixed  eth1 out eth1
[4382308.090000] ing_filter:  fixed  eth1 out eth1
[4382368.105000] ing_filter:  fixed  eth1 out eth1
[4382428.120000] ing_filter:  fixed  eth1 out eth1
[4382488.133000] ing_filter:  fixed  eth1 out eth1
[4382548.148000] ing_filter:  fixed  eth1 out eth1
[4382608.161000] ing_filter:  fixed  eth1 out eth1
[4382668.175000] ing_filter:  fixed  eth1 out eth1
[4382728.189000] ing_filter:  fixed  eth1 out eth1
[4382788.203000] ing_filter:  fixed  eth1 out eth1
[4382848.216000] ing_filter:  fixed  eth1 out eth1
[4382908.229000] ing_filter:  fixed  eth1 out eth1
[4382968.254000] ing_filter:  fixed  eth1 out eth1
[4383028.296000] ing_filter:  fixed  eth1 out eth1
[4383088.335000] ing_filter:  fixed  eth1 out eth1
[4383148.389000] ing_filter:  fixed  eth1 out eth1
[4383208.402000] ing_filter:  fixed  eth1 out eth1
[4383268.416000] ing_filter:  fixed  eth1 out eth1
[4383314.394000] tcf_action_destroy destroying c69eed40 next 00000000
[4383948.252000] tcf_action_init_1: successfull police
[4383988.580000] ing_filter:  fixed  eth1 out eth1
[4384048.593000] ing_filter:  fixed  eth1 out eth1
[4384108.608000] ing_filter:  fixed  eth1 out eth1
[4384168.621000] ing_filter:  fixed  eth1 out eth1
[4384228.634000] ing_filter:  fixed  eth1 out eth1
[4384288.647000] ing_filter:  fixed  eth1 out eth1
[4384348.660000] ing_filter:  fixed  eth1 out eth1
[4384408.673000] ing_filter:  fixed  eth1 out eth1
[4384468.689000] ing_filter:  fixed  eth1 out eth1
[4384528.702000] ing_filter:  fixed  eth1 out eth1
[4384588.716000] ing_filter:  fixed  eth1 out eth1
[4384648.729000] ing_filter:  fixed  eth1 out eth1
[4384708.743000] ing_filter:  fixed  eth1 out eth1
[4384768.756000] ing_filter:  fixed  eth1 out eth1
[4384828.769000] ing_filter:  fixed  eth1 out eth1
[4384888.782000] ing_filter:  fixed  eth1 out eth1
[4384948.796000] ing_filter:  fixed  eth1 out eth1
[4385008.809000] ing_filter:  fixed  eth1 out eth1
[4385068.823000] ing_filter:  fixed  eth1 out eth1
[4385128.837000] ing_filter:  fixed  eth1 out eth1
[4385188.850000] ing_filter:  fixed  eth1 out eth1
[4385248.863000] ing_filter:  fixed  eth1 out eth1
[4385308.878000] ing_filter:  fixed  eth1 out eth1
[4385368.891000] ing_filter:  fixed  eth1 out eth1
[4385428.905000] ing_filter:  fixed  eth1 out eth1
[4385488.918000] ing_filter:  fixed  eth1 out eth1
[4385548.931000] ing_filter:  fixed  eth1 out eth1
[4385608.944000] ing_filter:  fixed  eth1 out eth1
[4385668.958000] ing_filter:  fixed  eth1 out eth1
[4385728.974000] ing_filter:  fixed  eth1 out eth1
[4385788.987000] ing_filter:  fixed  eth1 out eth1
[4385849.001000] ing_filter:  fixed  eth1 out eth1
[4385909.014000] ing_filter:  fixed  eth1 out eth1
[4385969.032000] ing_filter:  fixed  eth1 out eth1
[4386029.045000] ing_filter:  fixed  eth1 out eth1
[4386089.062000] ing_filter:  fixed  eth1 out eth1
[4386149.075000] ing_filter:  fixed  eth1 out eth1
[4386209.088000] ing_filter:  fixed  eth1 out eth1
[4386269.103000] ing_filter:  fixed  eth1 out eth1
[4386329.117000] ing_filter:  fixed  eth1 out eth1
[4386389.130000] ing_filter:  fixed  eth1 out eth1
[4386449.144000] ing_filter:  fixed  eth1 out eth1
[4386509.157000] ing_filter:  fixed  eth1 out eth1
[4386569.171000] ing_filter:  fixed  eth1 out eth1
[4386629.184000] ing_filter:  fixed  eth1 out eth1
[4386689.197000] ing_filter:  fixed  eth1 out eth1
[4386749.210000] ing_filter:  fixed  eth1 out eth1
[4386809.224000] ing_filter:  fixed  eth1 out eth1
[4386866.621000] tcf_action_destroy destroying c5404d60 next 00000000
[4473765.783000] scsi: unknown opcode 0x01
[4476403.557000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4476403.559000] ISO 9660 Extensions: IEEE_P1282
[4476990.656000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4476990.658000] ISO 9660 Extensions: IEEE_P1282
[4477151.827000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4477151.829000] ISO 9660 Extensions: IEEE_P1282
[4477695.782000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4477695.784000] ISO 9660 Extensions: IEEE_P1282
[4555914.718000] eth1: link down
[4556468.036000] eth1: link up, 10Mbps, half-duplex, lpa 0x0000
[4744045.434000] usb 1-2: new full speed USB device using uhci_hcd and address 4
[4744045.574000] hub 1-2:1.0: USB hub found
[4744045.576000] hub 1-2:1.0: 2 ports detected
[4744045.815000] usb 1-2.1: new full speed USB device using uhci_hcd and address 5
[4744046.016000] usb 1-2.2: new full speed USB device using uhci_hcd and address 6
[4744047.102000] SCSI subsystem initialized
[4744047.240000] Initializing USB Mass Storage driver...
[4744047.277000] scsi0 : SCSI emulation for USB Mass Storage devices
[4744047.284000] usb-storage: device found at 5
[4744047.284000] usb-storage: waiting for device to settle before scanning
[4744047.284000] usbcore: registered new driver usb-storage
[4744047.284000] USB Mass Storage support registered.
[4744052.288000]   Vendor: Prolific  Model: USB Flash Disk    Rev: 1.00
[4744052.288000]   Type:   Direct-Access                      ANSI SCSI revision: 00
[4744052.298000] usb-storage: device scan complete
[4744052.546000] SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
[4744052.549000] sda: Write Protect is off
[4744052.550000] sda: Mode Sense: 23 00 00 00
[4744052.550000] sda: assuming drive cache: write through
[4744052.560000] ioctl_internal_command: <0 0 0 0> return code = 8000002
[4744052.560000]    : Current: sense key=0x0
[4744052.560000]     ASC=0x0 ASCQ=0x0
[4744052.565000] SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
[4744052.568000] sda: Write Protect is off
[4744052.568000] sda: Mode Sense: 23 00 00 00
[4744052.568000] sda: assuming drive cache: write through
[4744052.568000]  sda: sda1
[4744052.625000] ioctl_internal_command: <0 0 0 0> return code = 8000002
[4744052.625000]    : Current: sense key=0x0
[4744052.625000]     ASC=0x0 ASCQ=0x0
[4744052.625000] Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
[4744077.637000] ioctl_internal_command: <0 0 0 0> return code = 8000002
[4744077.637000]    : Current: sense key=0x0
[4744077.637000]     ASC=0x0 ASCQ=0x0
[4744201.802000] ioctl_internal_command: <0 0 0 0> return code = 8000002
[4744201.802000]    : Current: sense key=0x0
[4744201.802000]     ASC=0x0 ASCQ=0x0
[4744210.268000] usb 1-2: USB disconnect, address 4
[4744210.268000] usb 1-2.1: USB disconnect, address 5
[4744210.305000] usb 1-2.2: USB disconnect, address 6
[4814354.010000] ISO 9660 Extensions: Microsoft Joliet Level 3
[4814354.025000] ISO 9660 Extensions: RRIP_1991A
[4814697.105000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4814697.107000] ISO 9660 Extensions: IEEE_P1282
[4818287.082000] ISO 9660 Extensions: Microsoft Joliet Level 3
[4818287.104000] ISO 9660 Extensions: RRIP_1991A
[4818373.390000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4818373.392000] ISO 9660 Extensions: IEEE_P1282
[4850528.559000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4850528.560000] ISO 9660 Extensions: IEEE_P1282
[4851838.102000] ISO 9660 Extensions: Microsoft Joliet Level 1
[4851838.103000] ISO 9660 Extensions: IEEE_P1282
[4851985.839000] hfs_fs: unable to locate alternate MDB
[4851985.839000] hfs_fs: continuing without an alternate MDB
[4851986.352000] HFS-fs: Filesystem is marked locked, mounting read-only.
[4852071.617000] hdc: command error: status=0x51 { DriveReady SeekComplete Error }
[4852071.617000] hdc: command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
[4852071.617000] ide: failed opcode was: unknown
[4852071.617000] end_request: I/O error, dev hdc, sector 1412776
[4852071.617000] Buffer I/O error on device hdc, logical block 176597
[4852071.617000] lost page write due to I/O error on hdc
[4852084.277000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[4852084.277000]  printing eip:
[4852084.277000] c0132e1b
[4852084.277000] *pde = 00000000
[4852084.277000] Oops: 0000 [#1]
[4852084.277000] Modules linked in: hfs sd_mod usb_storage scsi_mod isofs zlib_inflate police sch_ingress cls_u32 sch_sfq sch_cbq nls_iso8859_1 nls_cp437 vfat fat nls_base ip_nat_ftp ip_conntrack_ftp ipt_MASQUERADE iptable_nat ip_conntrack ip_tables eth1394 ohci1394 ieee1394 usbhid usblp uhci_hcd usbcore
[4852084.277000] CPU:    0
[4852084.277000] EIP:    0060:[<c0132e1b>]    Not tainted VLI
[4852084.277000] EFLAGS: 00010203   (2.6.12-rc2-1) 
[4852084.277000] EIP is at mark_page_accessed+0x3/0x2e
[4852084.277000] eax: 00000000   ebx: 00000000   ecx: 00000001   edx: ca1b5e40
[4852084.277000] esi: 00000001   edi: cf7ce000   ebp: 00000070   esp: cea11d08
[4852084.277000] ds: 007b   es: 007b   ss: 0068
[4852084.277000] Process pdflush (pid: 32666, threadinfo=cea10000 task=c9ad90a0)
[4852084.277000] Stack: ca1b5e20 d0aae110 ca1b5e20 00000070 cf7ce000 d0aadfb6 ca1b5e20 00000000 
[4852084.277000]        00000040 cbb15c07 00000002 00000003 d0aad45d c0ed8d20 cbb15c07 00000062 
[4852084.277000]        00000026 c0ed8d20 00000002 c0ed8d20 00000002 cea11d6e fffffffe 00000003 
[4852084.277000] Call Trace:
[4852084.277000]  [<d0aae110>] hfs_bnode_put+0x31/0x5d [hfs]
[4852084.277000]  [<d0aadfb6>] hfs_bnode_find+0x239/0x24a [hfs]
[4852084.277000]  [<d0aad45d>] __hfs_brec_find+0xd9/0x10d [hfs]
[4852084.277000]  [<d0aad4eb>] hfs_brec_find+0x5a/0xfb [hfs]
[4852084.277000]  [<d0ab190a>] hfs_write_inode+0xde/0x235 [hfs]
[4852084.277000]  [<c015c767>] __mpage_writepages+0x2a0/0x2ff
[4852084.277000]  [<d0ab08b2>] hfs_get_block+0x0/0x12a [hfs]
[4852084.277000]  [<c015b2e1>] write_inode+0x30/0x38
[4852084.277000]  [<c015b34a>] __sync_single_inode+0x61/0x19e
[4852084.277000]  [<c015b575>] __writeback_single_inode+0xee/0xf8
[4852084.277000]  [<c011c8c9>] process_timeout+0x0/0x9
[4852084.277000]  [<c020a9ec>] blk_congestion_wait+0x70/0x7a
[4852084.277000]  [<c015b707>] sync_sb_inodes+0x188/0x22f
[4852084.277000]  [<c0130df8>] pdflush+0x0/0x21
[4852084.277000]  [<c015b800>] writeback_inodes+0x52/0x82
[4852084.277000]  [<c013064d>] background_writeout+0x65/0x94
[4852084.277000]  [<c0130d75>] __pdflush+0xc1/0x144
[4852084.277000]  [<c0130e15>] pdflush+0x1d/0x21
[4852084.277000]  [<c01305e8>] background_writeout+0x0/0x94
[4852084.277000]  [<c01246f6>] kthread+0x6d/0x97
[4852084.277000]  [<c0124689>] kthread+0x0/0x97
[4852084.277000]  [<c010126d>] kernel_thread_helper+0x5/0xb
[4852084.277000] Code: d0 00 00 00 89 48 04 89 43 18 89 51 04 ff 86 e8 00 00 00 89 8e d0 00 00 00 6a 01 6a 38 e8 18 ce ff ff 58 5a fb 5b 5e c3 53 89 c3 <8b> 00 a8 40 75 19 8b 03 a8 04 74 13 8b 03 a8 20 74 0d 89 d8 e8 
[4852084.277000]  

--mP3DRpeJDSE+ciuQ--
