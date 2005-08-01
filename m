Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVHAO4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVHAO4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVHAO4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:56:44 -0400
Received: from osten.wh.uni-dortmund.de ([129.217.129.130]:36056 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262096AbVHAO4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:56:43 -0400
Message-ID: <42EE3829.8080307@web.de>
Date: Mon, 01 Aug 2005 16:56:41 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: Alexander Fieroch <fieroch@web.de>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Natalie.Protasevich@unisys.com, Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org> <42EAAFD4.4010303@web.de> <42EAD086.4010904@gmail.com> <200507291905.37339.kernel-stuff@comcast.net> <20050730014237.GA20131@mipter.zuzino.mipt.ru> <42EE33F6.6040606@web.de>
In-Reply-To: <42EE33F6.6040606@web.de>
Content-Type: multipart/mixed;
 boundary="------------040403040405020207070401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040403040405020207070401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

args, I forgot the syslog. Attached..


--------------040403040405020207070401
Content-Type: text/plain;
 name="syslog2613rc4git4"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="syslog2613rc4git4"

Aug  1 15:27:17 orclex syslog-ng[3483]: syslog-ng version 1.6.8 starting
Aug  1 15:27:17 orclex syslog-ng[3483]: Changing permissions on special file /dev/xconsole
Aug  1 15:27:17 orclex kernel: Bootdata ok (command line is root=/dev/sda3 ro vga=792 pci=routeirq apic=debug acpi=debug irqpoll)
Aug  1 15:27:17 orclex kernel: Linux version 2.6.13-rc4 (root@orclex) (gcc version 4.0.2 20050725 (prerelease) (Debian 4.0.1-3)) #3 SMP Mon Aug 1 15:10:22 CEST 2005
Aug  1 15:27:17 orclex kernel: BIOS-provided physical RAM map:
Aug  1 15:27:17 orclex kernel: BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Aug  1 15:27:17 orclex kernel: BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Aug  1 15:27:17 orclex kernel: BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Aug  1 15:27:17 orclex kernel: BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
Aug  1 15:27:17 orclex kernel: BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
Aug  1 15:27:17 orclex kernel: BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
Aug  1 15:27:17 orclex kernel: BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
Aug  1 15:27:17 orclex kernel: BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Aug  1 15:27:17 orclex kernel: ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fb040
Aug  1 15:27:17 orclex kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x05000529 MSFT 0x00000097) @ 0x000000003ffb0100
Aug  1 15:27:17 orclex kernel: ACPI: FADT (v003 A M I  OEMFACP  0x05000529 MSFT 0x00000097) @ 0x000000003ffb0290
Aug  1 15:27:17 orclex kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x05000529 MSFT 0x00000097) @ 0x000000003ffb0390
Aug  1 15:27:17 orclex kernel: ACPI: OEMB (v001 A M I  AMI_OEM  0x05000529 MSFT 0x00000097) @ 0x000000003ffbe040
Aug  1 15:27:17 orclex kernel: ACPI: MCFG (v001 A M I  OEMMCFG  0x05000529 MSFT 0x00000097) @ 0x000000003ffb6c80
Aug  1 15:27:17 orclex kernel: ACPI: DSDT (v001  A0086 A0086003 0x00000003 INTL 0x02002026) @ 0x0000000000000000
Aug  1 15:27:17 orclex kernel: On node 0 totalpages: 262064
Aug  1 15:27:17 orclex kernel: DMA zone: 4096 pages, LIFO batch:1
Aug  1 15:27:17 orclex kernel: Normal zone: 257968 pages, LIFO batch:31
Aug  1 15:27:17 orclex kernel: HighMem zone: 0 pages, LIFO batch:1
Aug  1 15:27:17 orclex kernel: ACPI: PM-Timer IO Port: 0x808
Aug  1 15:27:17 orclex kernel: ACPI: Local APIC address 0xfee00000
Aug  1 15:27:17 orclex kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Aug  1 15:27:17 orclex kernel: Processor #0 15:4 APIC version 16
Aug  1 15:27:17 orclex kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Aug  1 15:27:17 orclex kernel: Processor #1 15:4 APIC version 16
Aug  1 15:27:17 orclex kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Aug  1 15:27:17 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug  1 15:27:17 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Aug  1 15:27:17 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug  1 15:27:17 orclex kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Aug  1 15:27:17 orclex kernel: ACPI: IRQ0 used by override.
Aug  1 15:27:17 orclex kernel: ACPI: IRQ2 used by override.
Aug  1 15:27:17 orclex kernel: ACPI: IRQ9 used by override.
Aug  1 15:27:17 orclex kernel: Setting APIC routing to flat
Aug  1 15:27:17 orclex kernel: Using ACPI (MADT) for SMP configuration information
Aug  1 15:27:17 orclex kernel: Allocating PCI resources starting at 40000000 (gap: 40000000:bfb00000)
Aug  1 15:27:17 orclex kernel: Built 1 zonelists
Aug  1 15:27:17 orclex kernel: Kernel command line: root=/dev/sda3 ro vga=792 pci=routeirq apic=debug acpi=debug irqpoll
Aug  1 15:27:17 orclex kernel: Misrouted IRQ fixup and polling support enabled
Aug  1 15:27:17 orclex kernel: This may significantly impact system performance
Aug  1 15:27:17 orclex kernel: Initializing CPU#0
Aug  1 15:27:17 orclex kernel: PID hash table entries: 4096 (order: 12, 131072 bytes)
Aug  1 15:27:17 orclex kernel: time.c: Using 3.579545 MHz PM timer.
Aug  1 15:27:17 orclex kernel: time.c: Detected 3010.810 MHz processor.
Aug  1 15:27:17 orclex kernel: Console: colour dummy device 80x25
Aug  1 15:27:17 orclex kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Aug  1 15:27:17 orclex kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Aug  1 15:27:17 orclex kernel: Memory: 1023904k/1048256k available (3316k kernel code, 23664k reserved, 1650k data, 228k init)
Aug  1 15:27:17 orclex kernel: Calibrating delay using timer specific routine.. 6045.49 BogoMIPS (lpj=12090991)
Aug  1 15:27:17 orclex kernel: Security Framework v1.0.0 initialized
Aug  1 15:27:17 orclex kernel: Capability LSM initialized
Aug  1 15:27:17 orclex kernel: Mount-cache hash table entries: 256
Aug  1 15:27:17 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Aug  1 15:27:17 orclex kernel: CPU: L2 cache: 2048K
Aug  1 15:27:17 orclex kernel: using mwait in idle threads.
Aug  1 15:27:17 orclex kernel: CPU: Physical Processor ID: 0
Aug  1 15:27:17 orclex kernel: CPU0: Thermal monitoring enabled (TM1)
Aug  1 15:27:17 orclex kernel: mtrr: v2.0 (20020519)
Aug  1 15:27:17 orclex kernel: ACPI-0498: *** Warning: Encountered executable code at module level, [AE_NOT_CONFIGURED]
Aug  1 15:27:17 orclex kernel: ACPI-0498: *** Warning: Encountered executable code at module level, [AE_NOT_CONFIGURED]
Aug  1 15:27:17 orclex kernel: ACPI-0498: *** Warning: Encountered executable code at module level, [AE_NOT_CONFIGURED]
Aug  1 15:27:17 orclex kernel: ACPI-0498: *** Warning: Encountered executable code at module level, [AE_NOT_CONFIGURED]
Aug  1 15:27:17 orclex kernel: enabled ExtINT on CPU#0
Aug  1 15:27:17 orclex kernel: ENABLING IO-APIC IRQs
Aug  1 15:27:17 orclex kernel: init IO_APIC IRQs
Aug  1 15:27:17 orclex kernel: IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Aug  1 15:27:17 orclex kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug  1 15:27:17 orclex kernel: Using local APIC timer interrupts.
Aug  1 15:27:17 orclex kernel: Detected 12.544 MHz APIC timer.
Aug  1 15:27:17 orclex kernel: Booting processor 1/1 rip 6000 rsp ffff810002191f58
Aug  1 15:27:17 orclex kernel: Initializing CPU#1
Aug  1 15:27:17 orclex kernel: masked ExtINT on CPU#1
Aug  1 15:27:17 orclex kernel: Calibrating delay using timer specific routine.. 6021.76 BogoMIPS (lpj=12043535)
Aug  1 15:27:17 orclex kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Aug  1 15:27:17 orclex kernel: CPU: L2 cache: 2048K
Aug  1 15:27:17 orclex kernel: CPU: Physical Processor ID: 0
Aug  1 15:27:17 orclex kernel: CPU1: Thermal monitoring enabled (TM1)
Aug  1 15:27:17 orclex kernel: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Aug  1 15:27:17 orclex kernel: APIC error on CPU1: 00(40)
Aug  1 15:27:17 orclex kernel: CPU 1: Syncing TSC to CPU 0.
Aug  1 15:27:17 orclex kernel: CPU 1: synchronized TSC with CPU 0 (last diff -143 cycles, maxerr 930 cycles)
Aug  1 15:27:17 orclex kernel: Brought up 2 CPUs
Aug  1 15:27:17 orclex kernel: time.c: Using PIT/TSC based timekeeping.
Aug  1 15:27:17 orclex kernel: testing NMI watchdog ... CPU#1: NMI appears to be stuck (1->1)!
Aug  1 15:27:17 orclex kernel: NET: Registered protocol family 16
Aug  1 15:27:17 orclex kernel: ACPI: bus type pci registered
Aug  1 15:27:17 orclex kernel: PCI: Using configuration type 1
Aug  1 15:27:17 orclex kernel: PCI: Using MMCONFIG at e0000000
Aug  1 15:27:17 orclex kernel: ACPI: Subsystem revision 20050408
Aug  1 15:27:17 orclex kernel: ACPI: Interpreter enabled
Aug  1 15:27:17 orclex kernel: ACPI: Using IOAPIC for interrupt routing
Aug  1 15:27:17 orclex kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Aug  1 15:27:17 orclex kernel: PCI: Probing PCI hardware (bus 00)
Aug  1 15:27:17 orclex kernel: ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Aug  1 15:27:17 orclex kernel: Boot video device is 0000:04:00.0
Aug  1 15:27:17 orclex kernel: PCI: Transparent bridge - 0000:00:1e.0
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 *14 15)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 *15)
Aug  1 15:27:17 orclex kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug  1 15:27:17 orclex kernel: pnp: PnP ACPI init
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-8 -> 0x69 -> IRQ 8 Mode:0 Active:0)
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-13 -> 0x91 -> IRQ 13 Mode:0 Active:0)
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-6 -> 0x59 -> IRQ 6 Mode:0 Active:0)
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-7 -> 0x61 -> IRQ 7 Mode:0 Active:0)
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-1 -> 0x39 -> IRQ 1 Mode:0 Active:0)
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10 Mode:0 Active:0)
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-4 -> 0x49 -> IRQ 4 Mode:0 Active:0)
Aug  1 15:27:17 orclex kernel: pnp: PnP ACPI: found 19 devices
Aug  1 15:27:17 orclex kernel: SCSI subsystem initialized
Aug  1 15:27:17 orclex kernel: usbcore: registered new driver usbfs
Aug  1 15:27:17 orclex kernel: usbcore: registered new driver hub
Aug  1 15:27:17 orclex kernel: PCI: Using ACPI for IRQ routing
Aug  1 15:27:17 orclex kernel: PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 185
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 20 Mode:1 Active:1)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 185
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 193
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 177
Aug  1 15:27:17 orclex kernel: IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd1 -> IRQ 21 Mode:1 Active:1)
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 209
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 185
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 177
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 209
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.1[A] -> GSI 21 (level, low) -> IRQ 209
Aug  1 15:27:17 orclex kernel: number of MP IRQ sources: 17.
Aug  1 15:27:17 orclex kernel: number of IO-APIC #2 registers: 24.
Aug  1 15:27:17 orclex kernel: testing the IO APIC.......................
Aug  1 15:27:17 orclex kernel: 
Aug  1 15:27:17 orclex kernel: IO APIC #2......
Aug  1 15:27:17 orclex kernel: .... register #00: 02000000
Aug  1 15:27:17 orclex kernel: .......    : physical APIC id: 02
Aug  1 15:27:17 orclex kernel: .... register #01: 00170020
Aug  1 15:27:17 orclex kernel: .......     : max redirection entries: 0017
Aug  1 15:27:17 orclex kernel: .......     : PRQ implemented: 0
Aug  1 15:27:17 orclex kernel: .......     : IO APIC version: 0020
Aug  1 15:27:17 orclex kernel: .... register #02: 00170020
Aug  1 15:27:17 orclex kernel: .......     : arbitration: 00
Aug  1 15:27:17 orclex kernel: .... IRQ redirection table:
Aug  1 15:27:17 orclex kernel: NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Aug  1 15:27:17 orclex kernel: 00 000 00  1    0    0   0   0    0    0    00
Aug  1 15:27:17 orclex kernel: 01 003 03  1    0    0   0   0    1    1    39
Aug  1 15:27:17 orclex kernel: 02 003 03  0    0    0   0   0    1    1    31
Aug  1 15:27:17 orclex kernel: 03 003 03  0    0    0   0   0    1    1    41
Aug  1 15:27:17 orclex kernel: 04 003 03  1    0    0   0   0    1    1    49
Aug  1 15:27:17 orclex kernel: 05 003 03  0    0    0   0   0    1    1    51
Aug  1 15:27:17 orclex kernel: 06 003 03  1    0    0   0   0    1    1    59
Aug  1 15:27:17 orclex kernel: 07 003 03  1    0    0   0   0    1    1    61
Aug  1 15:27:17 orclex kernel: 08 003 03  1    0    0   0   0    1    1    69
Aug  1 15:27:17 orclex kernel: 09 003 03  0    1    0   0   0    1    1    71
Aug  1 15:27:17 orclex kernel: 0a 003 03  1    0    0   0   0    1    1    79
Aug  1 15:27:17 orclex kernel: 0b 003 03  0    0    0   0   0    1    1    81
Aug  1 15:27:17 orclex kernel: 0c 003 03  0    0    0   0   0    1    1    89
Aug  1 15:27:17 orclex kernel: 0d 003 03  1    0    0   0   0    1    1    91
Aug  1 15:27:17 orclex kernel: 0e 003 03  0    0    0   0   0    1    1    99
Aug  1 15:27:17 orclex kernel: 0f 003 03  0    0    0   0   0    1    1    A1
Aug  1 15:27:17 orclex kernel: 10 003 03  1    1    0   1   0    1    1    A9
Aug  1 15:27:17 orclex kernel: 11 003 03  1    1    0   1   0    1    1    B1
Aug  1 15:27:17 orclex kernel: 12 003 03  1    1    0   1   0    1    1    C9
Aug  1 15:27:17 orclex kernel: 13 003 03  1    1    0   1   0    1    1    C1
Aug  1 15:27:17 orclex kernel: 14 000 00  1    0    0   0   0    0    0    00
Aug  1 15:27:17 orclex kernel: 15 003 03  1    1    0   1   0    1    1    D1
Aug  1 15:27:17 orclex kernel: 16 000 00  1    0    0   0   0    0    0    00
Aug  1 15:27:17 orclex kernel: 17 003 03  1    1    0   1   0    1    1    B9
Aug  1 15:27:17 orclex kernel: Using vector-based indexing
Aug  1 15:27:17 orclex kernel: IRQ to pin mappings:
Aug  1 15:27:17 orclex kernel: IRQ0 -> 0:2
Aug  1 15:27:17 orclex kernel: IRQ1 -> 0:1
Aug  1 15:27:17 orclex kernel: IRQ3 -> 0:3
Aug  1 15:27:17 orclex kernel: IRQ4 -> 0:4
Aug  1 15:27:17 orclex kernel: IRQ5 -> 0:5
Aug  1 15:27:17 orclex kernel: IRQ6 -> 0:6
Aug  1 15:27:17 orclex kernel: IRQ7 -> 0:7
Aug  1 15:27:17 orclex kernel: IRQ8 -> 0:8
Aug  1 15:27:17 orclex kernel: IRQ9 -> 0:9
Aug  1 15:27:17 orclex kernel: IRQ10 -> 0:10
Aug  1 15:27:17 orclex kernel: IRQ11 -> 0:11
Aug  1 15:27:17 orclex kernel: IRQ12 -> 0:12
Aug  1 15:27:17 orclex kernel: IRQ13 -> 0:13
Aug  1 15:27:17 orclex kernel: IRQ14 -> 0:14
Aug  1 15:27:17 orclex kernel: IRQ15 -> 0:15
Aug  1 15:27:17 orclex kernel: IRQ169 -> 0:16
Aug  1 15:27:17 orclex kernel: IRQ177 -> 0:17
Aug  1 15:27:17 orclex kernel: IRQ185 -> 0:23
Aug  1 15:27:17 orclex kernel: IRQ193 -> 0:19
Aug  1 15:27:17 orclex kernel: IRQ201 -> 0:18
Aug  1 15:27:17 orclex kernel: IRQ209 -> 0:21
Aug  1 15:27:17 orclex kernel: .................................... done.
Aug  1 15:27:17 orclex kernel: PCI: Bridge: 0000:00:01.0
Aug  1 15:27:17 orclex kernel: IO window: e000-efff
Aug  1 15:27:17 orclex kernel: MEM window: d0000000-d6ffffff
Aug  1 15:27:17 orclex kernel: PREFETCH window: d8000000-dfffffff
Aug  1 15:27:17 orclex kernel: PCI: Bridge: 0000:00:1c.0
Aug  1 15:27:17 orclex kernel: IO window: d000-dfff
Aug  1 15:27:17 orclex kernel: MEM window: disabled.
Aug  1 15:27:17 orclex kernel: PREFETCH window: disabled.
Aug  1 15:27:17 orclex kernel: PCI: Bridge: 0000:00:1c.1
Aug  1 15:27:17 orclex kernel: IO window: c000-cfff
Aug  1 15:27:17 orclex kernel: MEM window: cff00000-cfffffff
Aug  1 15:27:17 orclex kernel: PREFETCH window: 40000000-400fffff
Aug  1 15:27:17 orclex kernel: PCI: Bridge: 0000:00:1e.0
Aug  1 15:27:17 orclex kernel: IO window: 9000-bfff
Aug  1 15:27:17 orclex kernel: MEM window: cfe00000-cfefffff
Aug  1 15:27:17 orclex kernel: PREFETCH window: d7f00000-d7ffffff
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Aug  1 15:27:17 orclex kernel: TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
Aug  1 15:27:17 orclex kernel: pnp: 00:07: ioport range 0x290-0x297 has been reserved
Aug  1 15:27:17 orclex kernel: pnp: 00:09: ioport range 0x3f6-0x3f6 has been reserved
Aug  1 15:27:17 orclex kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Aug  1 15:27:17 orclex kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Aug  1 15:27:17 orclex kernel: NTFS driver 2.1.23 [Flags: R/O].
Aug  1 15:27:17 orclex kernel: Initializing Cryptographic API
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Aug  1 15:27:17 orclex kernel: assign_interrupt_mode Found MSI capability
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie00]
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie03]
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Aug  1 15:27:17 orclex kernel: assign_interrupt_mode Found MSI capability
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie00]
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie02]
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie03]
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Aug  1 15:27:17 orclex kernel: assign_interrupt_mode Found MSI capability
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie00]
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie02]
Aug  1 15:27:17 orclex kernel: Allocate Port Service[pcie03]
Aug  1 15:27:17 orclex kernel: vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using 6144k, total 131072k
Aug  1 15:27:17 orclex kernel: vesafb: mode is 1024x768x32, linelength=4096, pages=1
Aug  1 15:27:17 orclex kernel: vesafb: scrolling: redraw
Aug  1 15:27:17 orclex kernel: vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Aug  1 15:27:17 orclex kernel: Console: switching to colour frame buffer device 128x48
Aug  1 15:27:17 orclex kernel: fb0: VESA VGA frame buffer device
Aug  1 15:27:17 orclex kernel: vga16fb: initializing
Aug  1 15:27:17 orclex kernel: vga16fb: mapped to 0xffff8100000a0000
Aug  1 15:27:17 orclex kernel: fb1: VGA16 VGA frame buffer device
Aug  1 15:27:17 orclex kernel: ACPI: Power Button (FF) [PWRF]
Aug  1 15:27:17 orclex kernel: ACPI: Power Button (CM) [PWRB]
Aug  1 15:27:17 orclex kernel: ACPI: CPU0 (power states: C1[C1])
Aug  1 15:27:17 orclex kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Aug  1 15:27:17 orclex kernel: ACPI: CPU1 (power states: C1[C1])
Aug  1 15:27:17 orclex kernel: Real Time Clock Driver v1.12
Aug  1 15:27:17 orclex kernel: Linux agpgart interface v0.101 (c) Dave Jones
Aug  1 15:27:17 orclex kernel: [drm] Initialized drm 1.0.0 20040925
Aug  1 15:27:17 orclex kernel: Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Aug  1 15:27:17 orclex kernel: Hangcheck: Using monotonic_clock().
Aug  1 15:27:17 orclex kernel: PNP: PS/2 controller doesn't have AUX irq; using default 0xc
Aug  1 15:27:17 orclex kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 112
Aug  1 15:27:17 orclex kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug  1 15:27:17 orclex kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug  1 15:27:17 orclex kernel: io scheduler noop registered
Aug  1 15:27:17 orclex kernel: io scheduler anticipatory registered
Aug  1 15:27:17 orclex kernel: io scheduler deadline registered
Aug  1 15:27:17 orclex kernel: io scheduler cfq registered
Aug  1 15:27:17 orclex kernel: Floppy drive(s): fd0 is 1.44M
Aug  1 15:27:17 orclex kernel: FDC 0 is a post-1991 82077
Aug  1 15:27:17 orclex kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug  1 15:27:17 orclex kernel: loop: loaded (max 8 devices)
Aug  1 15:27:17 orclex kernel: pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: skge addr 0xcfefc000 irq 169 chip Yukon-Lite rev 7
Aug  1 15:27:17 orclex kernel: skge eth0: addr 00:11:2f:1c:f0:91
Aug  1 15:27:17 orclex kernel: PPP generic driver version 2.4.2
Aug  1 15:27:17 orclex kernel: PPP Deflate Compression module registered
Aug  1 15:27:17 orclex kernel: NET: Registered protocol family 24
Aug  1 15:27:17 orclex kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Aug  1 15:27:17 orclex kernel: netconsole: not configured, aborting
Aug  1 15:27:17 orclex kernel: Linux video capture interface: v1.00
Aug  1 15:27:17 orclex kernel: bttv: driver version 0.9.15 loaded
Aug  1 15:27:17 orclex kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Aug  1 15:27:17 orclex kernel: bttv: Bt8xx card found (0).
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 209
Aug  1 15:27:17 orclex kernel: bttv0: Bt878 (rev 2) at 0000:01:0a.0, irq: 209, latency: 64, mmio: 0xd7ffe000
Aug  1 15:27:17 orclex kernel: bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
Aug  1 15:27:17 orclex kernel: bttv0: using: Hauppauge (bt878) [card=10,autodetected]
Aug  1 15:27:17 orclex kernel: bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
Aug  1 15:27:17 orclex kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
Aug  1 15:27:17 orclex kernel: tveeprom: Hauppauge: model = 61334, rev = B   , serial# = 3026517
Aug  1 15:27:17 orclex kernel: tveeprom: tuner = Philips FM1216 (idx = 21, type = 5)
Aug  1 15:27:17 orclex kernel: tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
Aug  1 15:27:17 orclex kernel: tveeprom: audio_processor = MSP3415 (type = 6)
Aug  1 15:27:17 orclex kernel: bttv0: using tuner=5
Aug  1 15:27:17 orclex kernel: bttv0: registered device video0
Aug  1 15:27:17 orclex kernel: bttv0: registered device vbi0
Aug  1 15:27:17 orclex kernel: bttv0: registered device radio0
Aug  1 15:27:17 orclex kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug  1 15:27:17 orclex kernel: msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
Aug  1 15:27:17 orclex kernel: msp3410: daemon started
Aug  1 15:27:17 orclex kernel: tvaudio: TV audio decoder + audio/video mux driver
Aug  1 15:27:17 orclex kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
Aug  1 15:27:17 orclex kernel: SAA5246A (or compatible) Teletext decoder driver version 1.8
Aug  1 15:27:17 orclex kernel: SAA5249 driver (SAA5249 interface) for VideoText version 1.8
Aug  1 15:27:17 orclex kernel: : chip found @ 0xc2 (bt878 #0 [sw])
Aug  1 15:27:17 orclex kernel: tuner 0-0061: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
Aug  1 15:27:17 orclex kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug  1 15:27:17 orclex kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug  1 15:27:17 orclex kernel: ICH6: IDE controller at PCI slot 0000:00:1f.1
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 201
Aug  1 15:27:17 orclex kernel: ICH6: chipset revision 3
Aug  1 15:27:17 orclex kernel: ICH6: 100% native mode on irq 201
Aug  1 15:27:17 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS settings: hda:DMA, hdb:DMA
Aug  1 15:27:17 orclex kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
Aug  1 15:27:17 orclex kernel: Probing IDE interface ide0...
Aug  1 15:27:17 orclex kernel: hda: IC35L060AVV207-0, ATA DISK drive
Aug  1 15:27:17 orclex kernel: hdb: SONY CD-RW CRX210E1, ATAPI CD/DVD-ROM drive
Aug  1 15:27:17 orclex kernel: ide0 at 0x7000-0x7007,0x6802 on irq 201
Aug  1 15:27:17 orclex kernel: Probing IDE interface ide1...
Aug  1 15:27:17 orclex kernel: IT8212: IDE controller at PCI slot 0000:01:04.0
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 185
Aug  1 15:27:17 orclex kernel: IT8212: chipset revision 19
Aug  1 15:27:17 orclex kernel: it821x: controller in pass through mode.
Aug  1 15:27:17 orclex kernel: IT8212: 100% native mode on irq 185
Aug  1 15:27:17 orclex kernel: ide2: BM-DMA at 0x9800-0x9807, BIOS settings: hde:pio, hdf:pio
Aug  1 15:27:17 orclex kernel: ide3: BM-DMA at 0x9808-0x980f, BIOS settings: hdg:pio, hdh:pio
Aug  1 15:27:17 orclex kernel: Probing IDE interface ide2...
Aug  1 15:27:17 orclex kernel: hde: Pioneer DVD-ROM ATAPIModel DVD-104S 012, ATAPI CD/DVD-ROM drive
Aug  1 15:27:17 orclex kernel: ide2 at 0xb000-0xb007,0xa802 on irq 185
Aug  1 15:27:17 orclex kernel: Probing IDE interface ide3...
Aug  1 15:27:17 orclex kernel: hdh: WDC WD307AA, ATA DISK drive
Aug  1 15:27:17 orclex kernel: ide3 at 0xa400-0xa407,0xa002 on irq 185
Aug  1 15:27:17 orclex kernel: Probing IDE interface ide1...
Aug  1 15:27:17 orclex kernel: hda: max request size: 1024KiB
Aug  1 15:27:17 orclex kernel: hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, UDMA(100)
Aug  1 15:27:17 orclex kernel: hda: cache flushes supported
Aug  1 15:27:17 orclex kernel: hda: hda1 hda2
Aug  1 15:27:17 orclex kernel: hdh: max request size: 128KiB
Aug  1 15:27:17 orclex kernel: irq 201: nobody cared (try booting with the "irqpoll" option)
Aug  1 15:27:17 orclex kernel: 
Aug  1 15:27:17 orclex kernel: Call Trace: <IRQ> <ffffffff801554a0>{__report_bad_irq+48} <ffffffff801556ee>{note_interrupt+510}
Aug  1 15:27:17 orclex kernel: <ffffffff80154fed>{__do_IRQ+242} <ffffffff801102a3>{do_IRQ+67}
Aug  1 15:27:17 orclex kernel: <ffffffff8010e031>{ret_from_intr+0} <ffffffff802b6f2c>{as_queue_empty+0}
Aug  1 15:27:17 orclex kernel: <ffffffff802b6f2c>{as_queue_empty+0} <ffffffff80439f14>{_spin_unlock_irqrestore+5}
Aug  1 15:27:17 orclex kernel: <ffffffff80315a0b>{ide_intr+309} <ffffffff80154ec7>{handle_IRQ_event+41}
Aug  1 15:27:17 orclex kernel: <ffffffff80154fca>{__do_IRQ+207} <ffffffff801102a3>{do_IRQ+67}
Aug  1 15:27:17 orclex kernel: <ffffffff8010e031>{ret_from_intr+0}  <EOI> <ffffffff804393b6>{preempt_schedule_irq+93}
Aug  1 15:27:17 orclex kernel: <ffffffff8010e161>{retint_kernel+38} <ffffffff8010c4a3>{mwait_idle+90}
Aug  1 15:27:17 orclex kernel: <ffffffff8027d2e1>{acpi_processor_idle+299} <ffffffff8010c42d>{cpu_idle+79}
Aug  1 15:27:17 orclex kernel: <ffffffff806707aa>{start_kernel+464} <ffffffff806701fc>{_sinittext+508}
Aug  1 15:27:17 orclex kernel: 
Aug  1 15:27:17 orclex kernel: handlers:
Aug  1 15:27:17 orclex kernel: [<ffffffff803158d6>] (ide_intr+0x0/0x207)
Aug  1 15:27:17 orclex kernel: Disabling IRQ #201
Aug  1 15:27:17 orclex kernel: hdh: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=59598/16/63, UDMA(66)
Aug  1 15:27:17 orclex kernel: hdh: cache flushes not supported
Aug  1 15:27:17 orclex kernel: hdh: hdh1 hdh2
Aug  1 15:27:17 orclex kernel: hdb: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Aug  1 15:27:17 orclex kernel: Uniform CD-ROM driver Revision: 3.20
Aug  1 15:27:17 orclex kernel: hde: ATAPI DVD-ROM drive, 512kB Cache
Aug  1 15:27:17 orclex kernel: libata version 1.11 loaded.
Aug  1 15:27:17 orclex kernel: ahci version 1.01
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Aug  1 15:27:17 orclex kernel: ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
Aug  1 15:27:17 orclex kernel: ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
Aug  1 15:27:17 orclex kernel: ata1: SATA max UDMA/133 cmd 0xFFFFC20000026D00 ctl 0x0 bmdma 0x0 irq 193
Aug  1 15:27:17 orclex kernel: ata2: SATA max UDMA/133 cmd 0xFFFFC20000026D80 ctl 0x0 bmdma 0x0 irq 193
Aug  1 15:27:17 orclex kernel: ata3: SATA max UDMA/133 cmd 0xFFFFC20000026E00 ctl 0x0 bmdma 0x0 irq 193
Aug  1 15:27:17 orclex kernel: ata4: SATA max UDMA/133 cmd 0xFFFFC20000026E80 ctl 0x0 bmdma 0x0 irq 193
Aug  1 15:27:17 orclex kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
Aug  1 15:27:17 orclex kernel: ata1: dev 0 ATA, max UDMA/133, 488397168 sectors: lba48
Aug  1 15:27:17 orclex kernel: ata1: dev 0 configured for UDMA/133
Aug  1 15:27:17 orclex kernel: scsi0 : ahci
Aug  1 15:27:17 orclex kernel: ata2: no device found (phy stat 00000000)
Aug  1 15:27:17 orclex kernel: scsi1 : ahci
Aug  1 15:27:17 orclex kernel: ata3: no device found (phy stat 00000000)
Aug  1 15:27:17 orclex kernel: scsi2 : ahci
Aug  1 15:27:17 orclex kernel: ata4: no device found (phy stat 00000000)
Aug  1 15:27:17 orclex kernel: scsi3 : ahci
Aug  1 15:27:17 orclex kernel: Vendor: ATA       Model: ST3250823AS       Rev: 3.02
Aug  1 15:27:17 orclex kernel: Type:   Direct-Access                      ANSI SCSI revision: 05
Aug  1 15:27:17 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Aug  1 15:27:17 orclex kernel: SCSI device sda: drive cache: write back
Aug  1 15:27:17 orclex kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Aug  1 15:27:17 orclex kernel: SCSI device sda: drive cache: write back
Aug  1 15:27:17 orclex kernel: sda: sda1 sda2 < sda5 > sda3
Aug  1 15:27:17 orclex kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Aug  1 15:27:17 orclex kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Aug  1 15:27:17 orclex kernel: ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 209
Aug  1 15:27:17 orclex kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[cfefb800-cfefbfff]  Max Packet=[4096]
Aug  1 15:27:17 orclex kernel: ieee1394: raw1394: /dev/raw1394 device initialized
Aug  1 15:27:17 orclex kernel: usbmon: debugs is not available
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 185
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Aug  1 15:27:17 orclex kernel: ehci_hcd 0000:00:1d.7: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller
Aug  1 15:27:17 orclex kernel: ehci_hcd 0000:00:1d.7: debug port 1
Aug  1 15:27:17 orclex kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Aug  1 15:27:17 orclex kernel: ehci_hcd 0000:00:1d.7: irq 185, io mem 0xcfdff800
Aug  1 15:27:17 orclex kernel: PCI: cache line size of 128 is not supported by device 0000:00:1d.7
Aug  1 15:27:17 orclex kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Aug  1 15:27:17 orclex kernel: hub 1-0:1.0: USB hub found
Aug  1 15:27:17 orclex kernel: hub 1-0:1.0: 8 ports detected
Aug  1 15:27:17 orclex kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Aug  1 15:27:17 orclex kernel: USB Universal Host Controller Interface driver v2.3
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 185
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.0: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.0: irq 185, io base 0x00004400
Aug  1 15:27:17 orclex kernel: hub 2-0:1.0: USB hub found
Aug  1 15:27:17 orclex kernel: hub 2-0:1.0: 2 ports detected
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.1: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.1: irq 193, io base 0x00004800
Aug  1 15:27:17 orclex kernel: hub 3-0:1.0: USB hub found
Aug  1 15:27:17 orclex kernel: hub 3-0:1.0: 2 ports detected
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 201
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.2: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.2: irq 201, io base 0x00005000
Aug  1 15:27:17 orclex kernel: hub 4-0:1.0: USB hub found
Aug  1 15:27:17 orclex kernel: hub 4-0:1.0: 2 ports detected
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.3: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Aug  1 15:27:17 orclex kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00005400
Aug  1 15:27:17 orclex kernel: hub 5-0:1.0: USB hub found
Aug  1 15:27:17 orclex kernel: hub 5-0:1.0: 2 ports detected
Aug  1 15:27:17 orclex kernel: Initializing USB Mass Storage driver...
Aug  1 15:27:17 orclex kernel: usbcore: registered new driver usb-storage
Aug  1 15:27:17 orclex kernel: USB Mass Storage support registered.
Aug  1 15:27:17 orclex kernel: usb 2-1: new low speed USB device using uhci_hcd and address 2
Aug  1 15:27:17 orclex kernel: usbcore: registered new driver hiddev
Aug  1 15:27:17 orclex kernel: usb 3-1: new low speed USB device using uhci_hcd and address 2
Aug  1 15:27:17 orclex kernel: input: USB HID v1.00 Joystick [Microsoft Microsoft SideWinder game controller] on usb-0000:00:1d.0-1
Aug  1 15:27:17 orclex kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft Wheel Mouse Optical®] on usb-0000:00:1d.1-1
Aug  1 15:27:17 orclex kernel: usbcore: registered new driver usbhid
Aug  1 15:27:17 orclex kernel: drivers/usb/input/hid-core.c: v2.01:USB HID core driver
Aug  1 15:27:17 orclex kernel: mice: PS/2 mouse device common for all mice
Aug  1 15:27:17 orclex kernel: input: PC Speaker
Aug  1 15:27:17 orclex kernel: md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug  1 15:27:17 orclex kernel: md: bitmap version 3.38
Aug  1 15:27:17 orclex kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Aug  1 15:27:17 orclex kernel: GACT probability on
Aug  1 15:27:17 orclex kernel: Mirror/redirect action on
Aug  1 15:27:17 orclex kernel: u32 classifier
Aug  1 15:27:17 orclex kernel: Perfomance counters on
Aug  1 15:27:17 orclex kernel: input device check on 
Aug  1 15:27:17 orclex kernel: Actions configured 
Aug  1 15:27:17 orclex kernel: NET: Registered protocol family 2
Aug  1 15:27:17 orclex kernel: ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800007ef52b]
Aug  1 15:27:17 orclex kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug  1 15:27:17 orclex kernel: IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Aug  1 15:27:17 orclex kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Aug  1 15:27:17 orclex kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Aug  1 15:27:17 orclex kernel: TCP: Hash tables configured (established 262144 bind 65536)
Aug  1 15:27:17 orclex kernel: TCP reno registered
Aug  1 15:27:17 orclex kernel: IPv4 over IPv4 tunneling driver
Aug  1 15:27:17 orclex kernel: ip_conntrack version 2.1 (4094 buckets, 32752 max) - 296 bytes per conntrack
Aug  1 15:27:17 orclex kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug  1 15:27:17 orclex kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Aug  1 15:27:17 orclex kernel: TCP bic registered
Aug  1 15:27:17 orclex kernel: Initializing IPsec netlink socket
Aug  1 15:27:17 orclex kernel: NET: Registered protocol family 1
Aug  1 15:27:17 orclex kernel: NET: Registered protocol family 17
Aug  1 15:27:17 orclex kernel: NET: Registered protocol family 15
Aug  1 15:27:17 orclex kernel: Using IPI Shortcut mode
Aug  1 15:27:17 orclex kernel: swsusp: Suspend partition has wrong signature?
Aug  1 15:27:17 orclex kernel: md: Autodetecting RAID arrays.
Aug  1 15:27:17 orclex kernel: md: autorun ...
Aug  1 15:27:17 orclex kernel: md: ... autorun DONE.
Aug  1 15:27:17 orclex kernel: kjournald starting.  Commit interval 5 seconds
Aug  1 15:27:17 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  1 15:27:17 orclex kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug  1 15:27:17 orclex kernel: Freeing unused kernel memory: 228k freed
Aug  1 15:27:17 orclex kernel: Adding 2658716k swap on /dev/sda5.  Priority:-1 extents:1
Aug  1 15:27:17 orclex kernel: EXT3 FS on sda3, internal journal
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 177
Aug  1 15:27:17 orclex kernel: kjournald starting.  Commit interval 5 seconds
Aug  1 15:27:17 orclex kernel: EXT3 FS on sda1, internal journal
Aug  1 15:27:17 orclex kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:17 orclex kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Aug  1 15:27:17 orclex kernel: ACPI: PCI Interrupt 0000:01:0a.1[A] -> GSI 21 (level, low) -> IRQ 209
Aug  1 15:27:17 orclex kernel: parport: PnPBIOS parport detected.
Aug  1 15:27:17 orclex kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Aug  1 15:27:17 orclex kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Aug  1 15:27:17 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  1 15:27:17 orclex kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  1 15:27:17 orclex kernel: skge eth0: enabling interface
Aug  1 15:27:17 orclex kernel: skge eth0: Link is up at 100 Mbps, full duplex, flow control none
Aug  1 15:27:18 orclex cpufreqd: libsys_init() - no batteries found, not a laptop?
Aug  1 15:27:19 orclex kernel: lp0: using parport0 (interrupt-driven).
Aug  1 15:27:22 orclex /usr/sbin/gpm[3596]: Detected EXPS/2 protocol mouse.
Aug  1 15:27:23 orclex kernel: scsi: unknown opcode 0x85
Aug  1 15:27:23 orclex lpd[3645]: restarted
Aug  1 15:27:23 orclex hddtemp[3640]: /dev/hda: IC35L060AVV207-0: 33 C
Aug  1 15:27:33 orclex kernel: hde: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Aug  1 15:27:43 orclex nmbd[3721]: [2005/08/01 15:27:43, 0, pid=3721] nmbd/asyncdns.c:start_async_dns(149)
Aug  1 15:27:43 orclex nmbd[3721]:   started asyncdns process 3722
Aug  1 15:27:44 orclex nmbd[3721]: [2005/08/01 15:27:44, 0, pid=3721] nmbd/nmbd_nameregister.c:register_name_response(130)
Aug  1 15:27:44 orclex nmbd[3721]:   register_name_response: server at IP 10.6.10.53 rejected our name registration of OSTENBERG<00> IP 10.6.11.37 with error code 6.
Aug  1 15:27:44 orclex nmbd[3721]: [2005/08/01 15:27:44, 0, pid=3721] nmbd/nmbd_workgroupdb.c:fail_register(228)
Aug  1 15:27:44 orclex nmbd[3721]:   fail_register: Failed to register name OSTENBERG<00> on subnet 10.6.11.37.
Aug  1 15:27:44 orclex nmbd[3721]: [2005/08/01 15:27:44, 0, pid=3721] nmbd/nmbd_namelistdb.c:standard_fail_register(283)
Aug  1 15:27:44 orclex nmbd[3721]:   standard_fail_register: Failed to register/refresh name OSTENBERG<00> on subnet 10.6.11.37
Aug  1 15:27:45 orclex smartd[3727]: smartd version 5.32 Copyright (C) 2002-4 Bruce Allen
Aug  1 15:27:45 orclex smartd[3727]: Home page is http://smartmontools.sourceforge.net/
Aug  1 15:27:45 orclex smartd[3727]: Opened configuration file /etc/smartd.conf
Aug  1 15:27:45 orclex smartd[3727]: Drive: DEVICESCAN, implied '-a' Directive on line 23 of file /etc/smartd.conf
Aug  1 15:27:45 orclex smartd[3727]: Configuration file /etc/smartd.conf was parsed, found DEVICESCAN, scanning devices
Aug  1 15:27:45 orclex smartd[3727]: Device: /dev/hda, opened
Aug  1 15:27:45 orclex smartd[3727]: Device: /dev/hda, found in smartd database.
Aug  1 15:27:46 orclex smartd[3727]: Device: /dev/hda, is SMART capable. Adding to "monitor" list.
Aug  1 15:27:46 orclex smartd[3727]: Device: /dev/hdb, opened
Aug  1 15:27:46 orclex smartd[3727]: Device: /dev/hdb, packet devices [this device CD/DVD] not SMART capable
Aug  1 15:27:46 orclex smartd[3727]: Unable to register ATA device /dev/hdb at line 23 of file /etc/smartd.conf
Aug  1 15:27:46 orclex smartd[3727]: Device: /dev/hde, opened
Aug  1 15:27:46 orclex smartd[3727]: Device: /dev/hde, packet devices [this device CD/DVD] not SMART capable
Aug  1 15:27:46 orclex smartd[3727]: Unable to register ATA device /dev/hde at line 23 of file /etc/smartd.conf
Aug  1 15:27:46 orclex smartd[3727]: Device: /dev/hdh, opened
Aug  1 15:27:46 orclex smartd[3727]: Device: /dev/hdh, found in smartd database.
Aug  1 15:27:48 orclex smartd[3727]: Device: /dev/hdh, is SMART capable. Adding to "monitor" list.
Aug  1 15:27:48 orclex kernel: program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
Aug  1 15:27:48 orclex smartd[3727]: Device: /dev/sda, opened
Aug  1 15:27:48 orclex kernel: program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
Aug  1 15:27:48 orclex smartd[3727]: Device: /dev/sda, IE (SMART) not enabled, skip device Try 'smartctl -s on /dev/sda' to turn on SMART features
Aug  1 15:27:48 orclex smartd[3727]: Unable to register SCSI device /dev/sda at line 23 of file /etc/smartd.conf
Aug  1 15:27:48 orclex smartd[3727]: Monitoring 2 ATA and 0 SCSI devices
Aug  1 15:27:49 orclex smartd[3727]: Device: /dev/hdh, 1 Currently unreadable (pending) sectors
Aug  1 15:27:49 orclex smartd[3727]: Device: /dev/hdh, 1 Offline uncorrectable sectors
Aug  1 15:27:50 orclex smartd[3730]: smartd has fork()ed into background mode. New PID=3730.
Aug  1 15:27:50 orclex smartd[3730]: file /var/run/smartd.pid written containing PID 3730
Aug  1 15:27:50 orclex xinetd[3746]: Reading included configuration file: /etc/xinetd.d/chargen [file=/etc/xinetd.conf] [line=11]
Aug  1 15:27:50 orclex xinetd[3746]: Reading included configuration file: /etc/xinetd.d/daytime [file=/etc/xinetd.d/daytime] [line=28]
Aug  1 15:27:50 orclex xinetd[3746]: Reading included configuration file: /etc/xinetd.d/echo [file=/etc/xinetd.d/echo] [line=26]
Aug  1 15:27:50 orclex xinetd[3746]: Reading included configuration file: /etc/xinetd.d/time [file=/etc/xinetd.d/time] [line=26]
Aug  1 15:27:50 orclex xinetd[3746]: removing chargen
Aug  1 15:27:50 orclex xinetd[3746]: removing chargen
Aug  1 15:27:50 orclex xinetd[3746]: removing daytime
Aug  1 15:27:50 orclex xinetd[3746]: removing daytime
Aug  1 15:27:50 orclex xinetd[3746]: removing echo
Aug  1 15:27:50 orclex xinetd[3746]: removing echo
Aug  1 15:27:50 orclex xinetd[3746]: removing time
Aug  1 15:27:50 orclex xinetd[3746]: removing time
Aug  1 15:27:50 orclex xinetd[3746]: xinetd Version 2.3.13 started with libwrap loadavg options compiled in.
Aug  1 15:27:50 orclex xinetd[3746]: Started working: 0 available services
Aug  1 15:27:51 orclex rpc.statd[3844]: Version 1.0.7 Starting
Aug  1 15:27:51 orclex rpc.statd[3844]: statd running as root. chown /var/lib/nfs/sm to choose different user
Aug  1 15:27:51 orclex ntpd[3861]: ntpd 4.2.0a@1:4.2.0a+stable-8-r Mon Mar 21 03:16:19 CET 2005 (1)
Aug  1 15:27:52 orclex ntpd[3861]: signal_no_reset: signal 13 had flags 4000000
Aug  1 15:27:52 orclex ntpd[3861]: precision = 1.000 usec
Aug  1 15:27:52 orclex ntpd[3861]: Listening on interface wildcard, 0.0.0.0#123
Aug  1 15:27:52 orclex ntpd[3861]: Listening on interface eth0, 10.6.11.37#123
Aug  1 15:27:52 orclex ntpd[3861]: Listening on interface lo, 127.0.0.1#123
Aug  1 15:27:52 orclex ntpd[3861]: kernel time sync status 0040
Aug  1 15:27:52 orclex anacron[3869]: Anacron 2.3 started on 2005-08-01
Aug  1 15:27:52 orclex ntpd[3861]: frequency initialized 104.846 PPM from /var/lib/ntp/ntp.drift
Aug  1 15:27:52 orclex anacron[3869]: Normal exit (0 jobs run)
Aug  1 15:27:52 orclex /usr/sbin/cron[3874]: (CRON) INFO (pidfile fd = 3)
Aug  1 15:27:52 orclex /usr/sbin/cron[3875]: (CRON) STARTUP (fork ok)
Aug  1 15:27:52 orclex /usr/sbin/cron[3875]: (CRON) INFO (Running @reboot jobs)
Aug  1 15:27:54 orclex kernel: nvidia: module license 'NVIDIA' taints kernel.
Aug  1 15:27:54 orclex kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:27:54 orclex kernel: PCI: Setting latency timer of device 0000:04:00.0 to 64
Aug  1 15:27:54 orclex kernel: NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:45:40 PST 2005
Aug  1 15:28:15 orclex gdm[3893]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Aug  1 15:28:39 orclex gdm[3995]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Aug  1 15:29:03 orclex gdm[4017]: gdm_slave_xioerror_handler: Schwerwiegender X-Fehler - :0 wird neu gestartet
Aug  1 15:29:03 orclex gdm[3892]: deal_with_x_crashes: Das Skript XKeepsCrashing wird gestartet
Aug  1 15:29:09 orclex gdm[3892]: X-Server konnte nicht in kurzen Zeitabständen gestartet werden; Anzeige :0 wird deaktiviert
Aug  1 15:31:08 orclex ntpd[3861]: synchronized to LOCAL(0), stratum 5
Aug  1 15:31:08 orclex ntpd[3861]: kernel time sync disabled 0041
Aug  1 15:31:31 orclex kernel: ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Aug  1 15:31:31 orclex kernel: PCI: Setting latency timer of device 0000:04:00.0 to 64
Aug  1 15:31:31 orclex kernel: NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:45:40 PST 2005
Aug  1 15:31:46 orclex (alex-5644): starting (version 2.10.1), pid 5644 user 'alex'
Aug  1 15:31:46 orclex (alex-5643): starting (version 2.10.1), pid 5643 user 'alex'
Aug  1 15:31:46 orclex (alex-5646): starting (version 2.10.1), pid 5646 user 'alex'
Aug  1 15:31:46 orclex (alex-5646): Failed to get lock for daemon, exiting: Failed to lock '/tmp/gconfd-alex/lock/ior': probably another process has the lock, or your operating system has NFS file locking misconfigured (Resource temporarily unavailable)
Aug  1 15:31:46 orclex (alex-5643): Failed to get lock for daemon, exiting: Failed to lock '/tmp/gconfd-alex/lock/ior': probably another process has the lock, or your operating system has NFS file locking misconfigured (Resource temporarily unavailable)
Aug  1 15:31:46 orclex (alex-5644): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only configuration source at position 0
Aug  1 15:31:46 orclex (alex-5644): Resolved address "xml:readwrite:/home/alex/.gconf" to a writable configuration source at position 1
Aug  1 15:31:46 orclex (alex-5644): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only configuration source at position 2
Aug  1 15:32:11 orclex ntpd[3861]: synchronized to 68.98.18.98, stratum 2
Aug  1 15:35:25 orclex ntpd[3861]: kernel time sync enabled 0001
Aug  1 15:36:21 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Aug  1 15:37:17 orclex syslog-ng[3483]: STATS: dropped 0
Aug  1 15:39:01 orclex /USR/SBIN/CRON[6023]: (root) CMD (  [ -d /var/lib/php4 ] && find /var/lib/php4/ -type f -cmin +$(/usr/lib/php4/maxlifetime) -print0 | xargs -r -0 rm)
Aug  1 15:46:33 orclex kernel: hde: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Aug  1 15:47:18 orclex syslog-ng[3483]: STATS: dropped 0
Aug  1 15:51:15 orclex kernel: hde: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
Aug  1 15:57:18 orclex syslog-ng[3483]: STATS: dropped 0
Aug  1 15:57:51 orclex smartd[3730]: Device: /dev/hdh, 1 Currently unreadable (pending) sectors
Aug  1 15:57:51 orclex smartd[3730]: Device: /dev/hdh, 1 Offline uncorrectable sectors

--------------040403040405020207070401--
