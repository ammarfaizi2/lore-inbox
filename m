Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUC3Tmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbUC3Tmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:42:53 -0500
Received: from pop.gmx.de ([213.165.64.20]:63130 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263885AbUC3Tki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:40:38 -0500
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.5-rc3 - ALI15X3, irq 15: nobody cared! / Disabling IRQ #15
Date: Tue, 30 Mar 2004 21:40:23 +0200
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403302140.23791.deller@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IBM R30 Laptop, ALI15X3 IDE onboard chip, internal IDE harddisk & CDROM gives
 irq 15: nobody cared!
 ....
 Disabling IRQ #15

Message repeats ~ 1/min.

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if fa)
        Subsystem: IBM: Unknown device 050f
        Flags: bus master, medium devsel, latency 32, IRQ 15
        I/O ports at 7050 [size=16]
        Capabilities: [60] Power Management version 2

Any ideas ?

<4>Linux version 2.6.5-rc3 (root@halden) (gcc version 3.3.1 (SuSE Linux)) #2 Tue Mar 30 10:28:34 CEST 2004
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000000f7e0000 (usable)
<4> BIOS-e820: 000000000f7e0000 - 000000000f7f0000 (reserved)
<4> BIOS-e820: 000000000f7f0000 - 000000000f7f8000 (ACPI data)
<4> BIOS-e820: 000000000f7f8000 - 000000000f800000 (ACPI NVS)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>247MB LOWMEM available.
<4>On node 0 totalpages: 63456
<4>  DMA zone: 4096 pages, LIFO batch:1
<4>  Normal zone: 59360 pages, LIFO batch:14
<4>  HighMem zone: 0 pages, LIFO batch:1
<6>DMI 2.3 present.
<6>IBM machine detected. Enabling interrupts during APM calls.
<6>IBM machine detected. Disabling SMBus accesses.
<6>ACPI: RSDP (v000 IBM                                       ) @ 0x000fe030
<6>ACPI: RSDT (v001 IBM    TP-1C    0x00001320 IBM  0x00000000) @ 0x0f7f0000
<6>ACPI: FADT (v001 IBM    TP-1C    0x00001320 IBM  0x00000000) @ 0x0f7f0054
<6>ACPI: BOOT (v001 IBM    TP-1C    0x00001320 IBM  0x00000000) @ 0x0f7f002c
<6>ACPI: DSDT (v001    IBM TP-1C    0x00001320 MSFT 0x0100000d) @ 0x00000000
<6>ACPI: PM-Timer IO Port: 0xf108
<4>Built 1 zonelists
<4>Kernel command line: root=/dev/hda2 pmdisk=/dev/hda3
<4>Local APIC disabled by BIOS -- reenabling.
<4>Could not enable APIC!
<6>Initializing CPU#0
<4>PID hash table entries: 1024 (order 10: 8192 bytes)
<4>Detected 697.812 MHz processor.
<6>Using pmtmr for high-res timesource
<4>Console: colour VGA+ 80x25
<6>Memory: 247704k/253824k available (1687k kernel code, 5388k reserved, 720k data, 168k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
<4>Calibrating delay loop... 1384.44 BogoMIPS
<6>Security Scaffold v1.0.0 initialized
<6>Capability LSM initialized
<6>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<7>CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
<7>CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<7>CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<4>CPU: Intel Pentium III (Coppermine) stepping 0a
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xf0200, last bus=1
<6>PCI: Using configuration type 1
<6>mtrr: v2.0 (20020519)
<6>ACPI: Subsystem revision 20040326
<4>ACPI: IRQ9 SCI: Edge Trigger.
<6>ACPI: Interpreter enabled
<6>ACPI: Using PIC for interrupt routing
<4>ACPI: PCI Interrupt Link [PILA] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILD] (IRQs 10 *11)
<4>ACPI: PCI Interrupt Link [PILE] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILF] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILG] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILH] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
<4>ACPI: PCI Interrupt Link [PILI] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
<6>ACPI: PCI Root Bridge [PCI0] (00:00)
<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<6>ACPI: Embedded Controller [EC0] (gpe 34)
<6>Linux Plug and Play Support v0.97 (c) Adam Belay
<6>PnPBIOS: Scanning system for PnP BIOS support...
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00f6f40
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xfa000:0x0, dseg 0xf0000
<3>PnPBIOS: dev_node_info: function not supported on this system
<3>PnPBIOS: Unable to get node info.  Aborting.
<4>ACPI: PCI Interrupt Link [PILH] enabled at IRQ 11
<4>ACPI: PCI Interrupt Link [PILB] enabled at IRQ 11
<4>ACPI: PCI Interrupt Link [PILD] enabled at IRQ 11
<4>ACPI: PCI Interrupt Link [PILI] enabled at IRQ 10
<6>PCI: Using ACPI for IRQ routing
<6>PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
<6>Simple Boot Flag at 0x41 set to 0x1
<6>Machine check exception polling timer started.
<6>cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
<6>ikconfig 0.7 with /proc/config*
<6>Initializing Cryptographic API
<6>Activating ISA DMA hang workarounds.
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<6>Real Time Clock Driver v1.12
<6>loop: loaded (max 8 devices)
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<6>ALI15X3: IDE controller at PCI slot 0000:00:10.0
<6>ALI15X3: chipset revision 195
<6>ALI15X3: not 100%% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0x7050-0x7057, BIOS settings: hda:DMA, hdb:pio
<6>    ide1: BM-DMA at 0x7058-0x705f, BIOS settings: hdc:DMA, hdd:pio
<4>hda: HITACHI_DK23CA-30, ATA DISK drive
<4>Using anticipatory io scheduler
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>hdc: MATSHITADVD-ROM SR-8176, ATAPI CD/DVD-ROM drive
<3>irq 15: nobody cared!
<4>Call Trace:
<4> [<c0109c74>] __report_bad_irq+0x24/0x90
<4> [<c0109fd7>] do_IRQ+0x177/0x1f0
<4> [<c0107cc8>] common_interrupt+0x18/0x20
<4> [<c0123cbd>] do_softirq+0x3d/0xa0
<4> [<c0109fca>] do_IRQ+0x16a/0x1f0
<4> [<c0107cc8>] common_interrupt+0x18/0x20
<4> [<c010961e>] setup_irq+0x7e/0xe0
<4> [<c021e830>] ide_intr+0x0/0x260
<4> [<c0109bff>] request_irq+0x8f/0xe0
<4> [<c02217b2>] init_irq+0x1c2/0x5a0
<4> [<c021e830>] ide_intr+0x0/0x260
<4> [<c01bf3a7>] vsprintf+0x27/0x30
<4> [<c0221cd5>] hwif_init+0x145/0x380
<4> [<c0223029>] probe_hwif_init+0x19/0x66
<4> [<c0226768>] ide_setup_pci_device+0x68/0x80
<4> [<c021437b>] alim15x3_init_one+0x4b/0x80
<4> [<c0374d84>] ide_scan_pcidev+0x54/0x80
<4> [<c0374dce>] ide_scan_pcibus+0x1e/0xb0
<4> [<c0374d1a>] ide_init+0x5a/0x70
<4> [<c01030e8>] init+0x58/0x1d0
<4> [<c0103090>] init+0x0/0x1d0
<4> [<c0105005>] kernel_thread_helper+0x5/0x10
<4>
<3>handlers:
<3>[<c021e830>] (ide_intr+0x0/0x260)
<0>Disabling IRQ #15
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>hda: max request size: 128KiB
<6>hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, UDMA(33)
<6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
<6>mice: PS/2 mouse device common for all mice
