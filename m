Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265933AbTFVVZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbTFVVZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:25:16 -0400
Received: from smtp2k.poczta.onet.pl ([213.180.130.34]:19431 "EHLO
	smtp2k.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S265933AbTFVVYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:24:35 -0400
Message-ID: <3EF621D1.4090000@pt.onet.pl>
Date: Sun, 22 Jun 2003 23:38:25 +0200
From: Rafal Cichosz <rafal.cichosz@pt.onet.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: pl, pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI APIC ERROR KT400 IRQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

ACPI + EPIC is error IRQ.
Is EPIC not usb

Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin A of 
device 00:10.0
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin B of 
device 00:10.1
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin C of 
device 00:10.2
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin D of 
device 00:10.3
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin A of 
device 00:11.1 - using IRQ 255

Jun 21 16:20:56 rafix kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin A of 
device 00:11.1 - using IRQ 255
Jun 21 16:20:56 rafix kernel: VP_IDE: chipset revision 6

Jun 21 16:20:56 rafix kernel: usb.c: registered new driver usbdevfs
Jun 21 16:20:56 rafix kernel: usb.c: registered new driver hub
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin D of 
device 00:10.3


Jun 21 16:47:23 rafix kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 21 16:47:23 rafix kernel: eth0: transmit timed out, tx_status 00 
status e601.
Jun 21 16:47:23 rafix kernel:   diagnostics: net 0cfa media 8880 dma 
0000003a.
Jun 21 16:47:23 rafix kernel: eth0: Interrupt posted but not delivered 
-- IRQ blocked by another device?
Jun 21 16:47:23 rafix kernel:   Flags; bus-master 1, dirty 64(0) current 
64(0)
Jun 21 16:47:23 rafix kernel:   Transmit list 00000000 vs. def79200.
Jun 21 16:47:23 rafix kernel:   0: @def79200  length 800000e7 status

Jun 21 16:47:42 rafix kernel: bridge-eth0: disabling the bridge
Jun 21 16:47:42 rafix kernel: bridge-eth0: down





Is dmesg


Jun 21 16:20:55 rafix syslogd 1.4.1#11: restart.
Jun 21 16:20:56 rafix kernel: klogd 1.4.1#11, log source = /proc/kmsg 
started.
Jun 21 16:20:56 rafix kernel: Inspecting /boot/System.map-2.4.22-pre1
Jun 21 16:20:56 rafix kernel: Loaded 17744 symbols from 
/boot/System.map-2.4.22-pre1.
Jun 21 16:20:56 rafix kernel: Symbols match kernel version 2.4.22.
Jun 21 16:20:56 rafix kernel: Loaded 417 symbols from 22 modules.
Jun 21 16:20:56 rafix kernel: Linux version 2.4.22-pre1 (root@rafix) 
(gcc version 3.3 (Debian)) #13 sob cze 21 16:18:14 CEST 2003
Jun 21 16:20:56 rafix kernel: BIOS-provided physical RAM map:
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 0000000000000000 - 
00000000000a0000 (usable)
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 0000000000100000 - 
000000001fff0000 (usable)
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 000000001fff0000 - 
000000001fff3000 (ACPI NVS)
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 000000001fff3000 - 
0000000020000000 (ACPI data)
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 00000000fec00000 - 
00000000fec01000 (reserved)
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 00000000fee00000 - 
00000000fee01000 (reserved)
Jun 21 16:20:56 rafix kernel:  BIOS-e820: 00000000ffff0000 - 
0000000100000000 (reserved)
Jun 21 16:20:56 rafix kernel: 511MB LOWMEM available.
Jun 21 16:20:56 rafix kernel: ACPI: have wakeup address 0xc0001000
Jun 21 16:20:56 rafix kernel: found SMP MP-table at 000f5a30
Jun 21 16:20:56 rafix kernel: hm, page 000f5000 reserved twice.
Jun 21 16:20:56 rafix kernel: hm, page 000f6000 reserved twice.
Jun 21 16:20:56 rafix kernel: hm, page 000f1000 reserved twice.
Jun 21 16:20:56 rafix kernel: hm, page 000f2000 reserved twice.
Jun 21 16:20:56 rafix kernel: On node 0 totalpages: 131056
Jun 21 16:20:56 rafix kernel: zone(0): 4096 pages.
Jun 21 16:20:56 rafix kernel: zone(1): 126960 pages.
Jun 21 16:20:56 rafix kernel: zone(2): 0 pages.
Jun 21 16:20:56 rafix kernel: ACPI: RSDP (v000 KT400 
   ) @ 0x000f7460
Jun 21 16:20:56 rafix kernel: ACPI: RSDT (v001 KT400  AWRDACPI 
16944.11825) @ 0x1fff3000
Jun 21 16:20:56 rafix kernel: ACPI: FADT (v001 KT400  AWRDACPI 
16944.11825) @ 0x1fff3040
Jun 21 16:20:56 rafix kernel: ACPI: MADT (v001 KT400  AWRDACPI 
16944.11825) @ 0x1fff7000
Jun 21 16:20:56 rafix kernel: ACPI: DSDT (v001 KT400  AWRDACPI 
00000.04096) @ 0x00000000
Jun 21 16:20:56 rafix kernel: ACPI: BIOS passes blacklist
Jun 21 16:20:56 rafix kernel: ACPI: Local APIC address 0xfee00000
Jun 21 16:20:56 rafix kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] 
enabled)
Jun 21 16:20:56 rafix kernel: Processor #0 Pentium(tm) Pro APIC version 16
Jun 21 16:20:56 rafix kernel: ACPI: LAPIC_NMI (acpi_id[0x00] 
polarity[0x1] trigger[0x1] lint[0x1])
Jun 21 16:20:56 rafix kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] 
global_irq_base[0x0])
Jun 21 16:20:56 rafix kernel: IOAPIC[0]: Assigned apic_id 2
Jun 21 16:20:56 rafix kernel: IOAPIC[0]: apic_id 2, version 3, address 
0xfec00000, IRQ 0-23
Jun 21 16:20:56 rafix kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] 
global_irq[0x2] polarity[0x0] trigger[0x0])
Jun 21 16:20:56 rafix kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] 
global_irq[0x9] polarity[0x0] trigger[0x0])
Jun 21 16:20:56 rafix kernel: ACPI: INT_SRC_OVR (bus[0] irq[0xe] 
global_irq[0xe] polarity[0x1] trigger[0x1])
Jun 21 16:20:56 rafix kernel: ACPI: INT_SRC_OVR (bus[0] irq[0xf] 
global_irq[0xf] polarity[0x1] trigger[0x1])
Jun 21 16:20:56 rafix kernel: Using ACPI (MADT) for SMP configuration 
information
Jun 21 16:20:56 rafix kernel: Kernel command line: 
BOOT_IMAGE=Lin-2.4.22.pre1 rw root=302
Jun 21 16:20:56 rafix kernel: Initializing CPU#0
Jun 21 16:20:56 rafix kernel: Detected 1470.050 MHz processor.
Jun 21 16:20:56 rafix kernel: Console: colour VGA+ 80x25
Jun 21 16:20:56 rafix kernel: Calibrating delay loop... 2929.45 BogoMIPS
Jun 21 16:20:56 rafix kernel: Memory: 516048k/524224k available (1347k 
kernel code, 7792k reserved, 451k data, 92k init, 0k highmem)
Jun 21 16:20:56 rafix kernel: Dentry cache hash table entries: 65536 
(order: 7, 524288 bytes)
Jun 21 16:20:56 rafix kernel: Inode cache hash table entries: 32768 
(order: 6, 262144 bytes)
Jun 21 16:20:56 rafix kernel: Mount cache hash table entries: 512 
(order: 0, 4096 bytes)
Jun 21 16:20:56 rafix kernel: Buffer-cache hash table entries: 32768 
(order: 5, 131072 bytes)
Jun 21 16:20:56 rafix kernel: Page-cache hash table entries: 131072 
(order: 7, 524288 bytes)
Jun 21 16:20:56 rafix kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
Jun 21 16:20:56 rafix kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jun 21 16:20:56 rafix kernel: Intel machine check architecture supported.
Jun 21 16:20:56 rafix kernel: Intel machine check reporting enabled on 
CPU#0.
Jun 21 16:20:56 rafix kernel: CPU:     After generic, caps: 0383fbff 
c1c3fbff 00000000 00000000
Jun 21 16:20:56 rafix kernel: CPU:             Common caps: 0383fbff 
c1c3fbff 00000000 00000000
Jun 21 16:20:56 rafix kernel: CPU: AMD Athlon(tm) XP 1700+ stepping 02
Jun 21 16:20:56 rafix kernel: Enabling fast FPU save and restore... done.
Jun 21 16:20:56 rafix kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jun 21 16:20:56 rafix kernel: Checking 'hlt' instruction... OK.
Jun 21 16:20:56 rafix kernel: POSIX conformance testing by UNIFIX
Jun 21 16:20:56 rafix kernel: enabled ExtINT on CPU#0
Jun 21 16:20:56 rafix kernel: ESR value before enabling vector: 00000000
Jun 21 16:20:56 rafix kernel: ESR value after enabling vector: 00000000
Jun 21 16:20:56 rafix kernel: ENABLING IO-APIC IRQs
Jun 21 16:20:56 rafix kernel: init IO_APIC IRQs
Jun 21 16:20:56 rafix kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 
2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jun 21 16:20:56 rafix kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jun 21 16:20:56 rafix kernel: number of MP IRQ sources: 16.
Jun 21 16:20:56 rafix kernel: number of IO-APIC #2 registers: 24.
Jun 21 16:20:56 rafix kernel: testing the IO APIC.......................
Jun 21 16:20:56 rafix kernel:
Jun 21 16:20:56 rafix kernel: IO APIC #2......
Jun 21 16:20:56 rafix kernel: .... register #00: 02000000
Jun 21 16:20:56 rafix kernel: .......    : physical APIC id: 02
Jun 21 16:20:56 rafix kernel: .......    : Delivery Type: 0
Jun 21 16:20:56 rafix kernel: .......    : LTS          : 0
Jun 21 16:20:56 rafix kernel: .... register #01: 00178003
Jun 21 16:20:56 rafix kernel: .......     : max redirection entries: 0017
Jun 21 16:20:56 rafix kernel: .......     : PRQ implemented: 1
Jun 21 16:20:56 rafix kernel: .......     : IO APIC version: 0003
Jun 21 16:20:56 rafix kernel: .... IRQ redirection table:
Jun 21 16:20:56 rafix kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest 
Deli Vect:
Jun 21 16:20:56 rafix kernel:  00 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  01 001 01  0    0    0   0   0    1    1 
    39
Jun 21 16:20:56 rafix kernel:  02 001 01  0    0    0   0   0    1    1 
    31
Jun 21 16:20:56 rafix kernel:  03 001 01  0    0    0   0   0    1    1 
    41
Jun 21 16:20:56 rafix kernel:  04 001 01  0    0    0   0   0    1    1 
    49
Jun 21 16:20:56 rafix kernel:  05 001 01  0    0    0   0   0    1    1 
    51
Jun 21 16:20:56 rafix kernel:  06 001 01  0    0    0   0   0    1    1 
    59
Jun 21 16:20:56 rafix kernel:  07 001 01  0    0    0   0   0    1    1 
    61
Jun 21 16:20:56 rafix kernel:  08 001 01  0    0    0   0   0    1    1 
    69
Jun 21 16:20:56 rafix kernel:  09 001 01  0    0    0   0   0    1    1 
    71
Jun 21 16:20:56 rafix kernel:  0a 001 01  0    0    0   0   0    1    1 
    79
Jun 21 16:20:56 rafix kernel:  0b 001 01  0    0    0   0   0    1    1 
    81
Jun 21 16:20:56 rafix kernel:  0c 001 01  0    0    0   0   0    1    1 
    89
Jun 21 16:20:56 rafix kernel:  0d 001 01  0    0    0   0   0    1    1 
    91
Jun 21 16:20:56 rafix kernel:  0e 001 01  0    0    0   0   0    1    1 
    99
Jun 21 16:20:56 rafix kernel:  0f 001 01  0    0    0   0   0    1    1 
    A1
Jun 21 16:20:56 rafix kernel:  10 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  11 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  12 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  13 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  14 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  15 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  16 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel:  17 000 00  1    0    0   0   0    0    0 
    00
Jun 21 16:20:56 rafix kernel: IRQ to pin mappings:
Jun 21 16:20:56 rafix kernel: IRQ0 -> 0:2
Jun 21 16:20:56 rafix kernel: IRQ1 -> 0:1
Jun 21 16:20:56 rafix kernel: IRQ3 -> 0:3
Jun 21 16:20:56 rafix kernel: IRQ4 -> 0:4
Jun 21 16:20:56 rafix kernel: IRQ5 -> 0:5
Jun 21 16:20:56 rafix kernel: IRQ6 -> 0:6
Jun 21 16:20:56 rafix kernel: IRQ7 -> 0:7
Jun 21 16:20:56 rafix kernel: IRQ8 -> 0:8
Jun 21 16:20:56 rafix kernel: IRQ9 -> 0:9
Jun 21 16:20:56 rafix kernel: IRQ10 -> 0:10
Jun 21 16:20:56 rafix kernel: IRQ11 -> 0:11
Jun 21 16:20:56 rafix kernel: IRQ12 -> 0:12
Jun 21 16:20:56 rafix kernel: IRQ13 -> 0:13
Jun 21 16:20:56 rafix kernel: IRQ14 -> 0:14
Jun 21 16:20:56 rafix kernel: IRQ15 -> 0:15
Jun 21 16:20:56 rafix kernel: .................................... done.
Jun 21 16:20:56 rafix kernel: Using local APIC timer interrupts.
Jun 21 16:20:56 rafix kernel: calibrating APIC timer ...
Jun 21 16:20:56 rafix kernel: ..... CPU clock speed is 1469.9471 MHz.
Jun 21 16:20:56 rafix kernel: ..... host bus clock speed is 267.2630 MHz.
Jun 21 16:20:56 rafix kernel: cpu: 0, clocks: 2672630, slice: 1336315
Jun 21 16:20:56 rafix kernel: 
CPU0<T0:2672624,T1:1336304,D:5,S:1336315,C:2672630>
Jun 21 16:20:56 rafix kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Jun 21 16:20:56 rafix kernel: mtrr: detected mtrr type: Intel
Jun 21 16:20:56 rafix kernel: ACPI: Subsystem revision 20030619
Jun 21 16:20:56 rafix kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfb3b0, last bus=1
Jun 21 16:20:56 rafix kernel: PCI: Using configuration type 1
Jun 21 16:20:56 rafix kernel: ACPI: Interpreter enabled
Jun 21 16:20:56 rafix kernel: ACPI: Using IOAPIC for interrupt routing
Jun 21 16:20:56 rafix kernel: ACPI: System [ACPI] (supports S0 S1 S3 S4 S5)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jun 21 16:20:56 rafix kernel: PCI: Probing PCI hardware (bus 00)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 
4 5 6 7 10 11 *12 14 15)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 
4 5 6 7 10 *11 12 14 15)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 
4 5 6 7 *10 11 12 14 15)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 
4 *5 6 7 10 11 12 14 15)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKA] (IRQs 20, 
disabled)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKB] (IRQs 21, 
disabled)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKC] (IRQs 22, 
disabled)
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKD] (IRQs 23, 
disabled)
Jun 21 16:20:56 rafix kernel: PCI: Probing PCI hardware
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKA] enabled at 
IRQ 0
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKB] enabled at 
IRQ 0
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKC] enabled at 
IRQ 0
Jun 21 16:20:56 rafix kernel: ACPI: PCI Interrupt Link [ALKD] enabled at 
IRQ 0
Jun 21 16:20:56 rafix kernel: IOAPIC[0]: Set PCI routing entry (2-16 -> 
0xa9 -> IRQ 16)
Jun 21 16:20:56 rafix kernel: 00:00:08[A] -> 2-16 -> IRQ 16
Jun 21 16:20:56 rafix kernel: IOAPIC[0]: Set PCI routing entry (2-17 -> 
0xb1 -> IRQ 17)
Jun 21 16:20:56 rafix kernel: 00:00:08[B] -> 2-17 -> IRQ 17
Jun 21 16:20:56 rafix kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 
0xb9 -> IRQ 18)
Jun 21 16:20:56 rafix kernel: 00:00:08[C] -> 2-18 -> IRQ 18
Jun 21 16:20:56 rafix kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 
0xc1 -> IRQ 19)
Jun 21 16:20:56 rafix kernel: 00:00:08[D] -> 2-19 -> IRQ 19
Jun 21 16:20:56 rafix kernel: Pin 2-17 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-18 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-19 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-16 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-18 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-19 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-16 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-17 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-19 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-16 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-17 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-18 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-18 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-19 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-16 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-17 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-16 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-17 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-18 already programmed
Jun 21 16:20:56 rafix kernel: Pin 2-19 already programmed
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin A of 
device 00:10.0
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin B of 
device 00:10.1
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin C of 
device 00:10.2
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin D of 
device 00:10.3
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin A of 
device 00:11.1 - using IRQ 255
Jun 21 16:20:56 rafix kernel: PCI: Using ACPI for IRQ routing
Jun 21 16:20:56 rafix kernel: PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi=off'
Jun 21 16:20:56 rafix kernel: Linux NET4.0 for Linux 2.4
Jun 21 16:20:56 rafix kernel: Based upon Swansea University Computer 
Society NET3.039
Jun 21 16:20:56 rafix kernel: Initializing RT netlink socket
Jun 21 16:20:56 rafix kernel: Starting kswapd
Jun 21 16:20:56 rafix kernel: VFS: Diskquotas version dquot_6.4.0 
initialized
Jun 21 16:20:56 rafix kernel: ACPI: Power Button (FF) [PWRF]
Jun 21 16:20:56 rafix kernel: Detected PS/2 Mouse Port.
Jun 21 16:20:56 rafix kernel: pty: 256 Unix98 ptys configured
Jun 21 16:20:56 rafix kernel: Serial driver version 5.05c (2001-07-08) 
with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jun 21 16:20:56 rafix kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jun 21 16:20:56 rafix kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Jun 21 16:20:56 rafix kernel: agpgart: Maximum main memory to use for 
agp memory: 439M
Jun 21 16:20:56 rafix kernel: agpgart: Detected Via Apollo Pro KT400 chipset
Jun 21 16:20:56 rafix kernel: agpgart: AGP aperture is 4M @ 0xe3000000
Jun 21 16:20:56 rafix kernel: Uniform Multi-Platform E-IDE driver 
Revision: 7.00beta4-2.4
Jun 21 16:20:56 rafix kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Jun 21 16:20:56 rafix kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin A of 
device 00:11.1 - using IRQ 255
Jun 21 16:20:56 rafix kernel: VP_IDE: chipset revision 6
Jun 21 16:20:56 rafix kernel: VP_IDE: not 100%% native mode: will probe 
irqs later
Jun 21 16:20:56 rafix kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Jun 21 16:20:56 rafix kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 
controller on pci00:11.1
Jun 21 16:20:56 rafix kernel:     ide0: BM-DMA at 0xec00-0xec07, BIOS 
settings: hda:DMA, hdb:pio
Jun 21 16:20:56 rafix kernel:     ide1: BM-DMA at 0xec08-0xec0f, BIOS 
settings: hdc:DMA, hdd:pio
Jun 21 16:20:56 rafix kernel: hda: ST360015A, ATA DISK drive
Jun 21 16:20:56 rafix kernel: blk: queue c0306e20, I/O limit 4095Mb 
(mask 0xffffffff)
Jun 21 16:20:56 rafix kernel: hdc: CD-RW BCE1610IM, ATAPI CD/DVD-ROM drive
Jun 21 16:20:56 rafix kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 21 16:20:56 rafix kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 21 16:20:56 rafix kernel: hda: attached ide-disk driver.
Jun 21 16:20:56 rafix kernel: hda: host protected area => 1
Jun 21 16:20:56 rafix kernel: hda: 117231408 sectors (60022 MB) 
w/2048KiB Cache, CHS=7753/240/63, UDMA(100)
Jun 21 16:20:56 rafix kernel: Partition check:
Jun 21 16:20:56 rafix kernel:  hda: hda1 hda2 hda3 < hda5 >
Jun 21 16:20:56 rafix kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jun 21 16:20:56 rafix kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jun 21 16:20:56 rafix kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Jun 21 16:20:56 rafix kernel: TCP: Hash tables configured (established 
32768 bind 65536)
Jun 21 16:20:56 rafix kernel: Linux IP multicast router 0.06 plus PIM-SM
Jun 21 16:20:56 rafix kernel: NET4: Unix domain sockets 1.0/SMP for 
Linux NET4.0.
Jun 21 16:20:56 rafix kernel: reiserfs: checking transaction log (device 
03:02) ...
Jun 21 16:20:56 rafix kernel: Using r5 hash to sort names
Jun 21 16:20:56 rafix kernel: ReiserFS version 3.6.25
Jun 21 16:20:56 rafix kernel: VFS: Mounted root (reiserfs filesystem).
Jun 21 16:20:56 rafix kernel: Freeing unused kernel memory: 92k freed
Jun 21 16:20:56 rafix kernel: Real Time Clock Driver v1.10e
Jun 21 16:20:56 rafix kernel: MSDOS FS: Using codepage 852
Jun 21 16:20:56 rafix kernel: MSDOS FS: IO charset iso8859-2
Jun 21 16:20:56 rafix kernel: MSDOS FS: Using codepage 852
Jun 21 16:20:56 rafix kernel: MSDOS FS: IO charset iso8859-2
Jun 21 16:20:56 rafix kernel: NTFS driver v1.1.22 [Flags: R/O MODULE]
Jun 21 16:20:56 rafix kernel: usb.c: registered new driver usbdevfs
Jun 21 16:20:56 rafix kernel: usb.c: registered new driver hub
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin D of 
device 00:10.3
Jun 21 16:20:56 rafix kernel: ehci_hcd 00:10.3: VIA Technologies, Inc. 
USB 2.0
Jun 21 16:20:56 rafix kernel: ehci_hcd 00:10.3: irq 5, pci mem e08fa000
Jun 21 16:20:56 rafix kernel: usb.c: new USB bus registered, assigned 
bus number 1
Jun 21 16:20:56 rafix kernel: PCI: 00:10.3 PCI cache line size set 
incorrectly (32 bytes) by BIOS/FW.
Jun 21 16:20:56 rafix kernel: PCI: 00:10.3 PCI cache line size corrected 
to 64.
Jun 21 16:20:56 rafix kernel: ehci_hcd 00:10.3: USB 2.0 enabled, EHCI 
1.00, driver 2003-Jun-19/2.4
Jun 21 16:20:56 rafix kernel: hub.c: USB hub found
Jun 21 16:20:56 rafix kernel: hub.c: 6 ports detected
Jun 21 16:20:56 rafix kernel: uhci.c: USB Universal Host Controller 
Interface driver v1.1
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin A of 
device 00:10.0
Jun 21 16:20:56 rafix kernel: uhci.c: USB UHCI at I/O 0xe000, IRQ 12
Jun 21 16:20:56 rafix kernel: usb.c: new USB bus registered, assigned 
bus number 2
Jun 21 16:20:56 rafix kernel: hub.c: USB hub found
Jun 21 16:20:56 rafix kernel: hub.c: 2 ports detected
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin B of 
device 00:10.1
Jun 21 16:20:56 rafix kernel: uhci.c: USB UHCI at I/O 0xe400, IRQ 11
Jun 21 16:20:56 rafix kernel: usb.c: new USB bus registered, assigned 
bus number 3
Jun 21 16:20:56 rafix kernel: hub.c: USB hub found
Jun 21 16:20:56 rafix kernel: hub.c: 2 ports detected
Jun 21 16:20:56 rafix kernel: PCI: No IRQ known for interrupt pin C of 
device 00:10.2
Jun 21 16:20:56 rafix kernel: uhci.c: USB UHCI at I/O 0xe800, IRQ 10
Jun 21 16:20:56 rafix kernel: usb.c: new USB bus registered, assigned 
bus number 4
Jun 21 16:20:56 rafix kernel: hub.c: USB hub found
Jun 21 16:20:56 rafix kernel: hub.c: 2 ports detected
Jun 21 16:20:56 rafix kernel: 3c59x: Donald Becker and others. 
www.scyld.com/network/vortex.html
Jun 21 16:20:56 rafix kernel: See Documentation/networking/vortex.txt
Jun 21 16:20:56 rafix kernel: 00:09.0: 3Com PCI 3c905C Tornado at 
0xd000. Vers LK1.1.16
Jun 21 16:20:56 rafix kernel:  00:01:02:f9:b6:d3, IRQ 17
Jun 21 16:20:56 rafix kernel:   product code 4552 rev 00.13 date 11-29-00
Jun 21 16:20:56 rafix kernel: Full duplex capable
Jun 21 16:20:56 rafix kernel:   Internal config register is 1800000, 
transceivers 0xa.
Jun 21 16:20:56 rafix kernel:   8K byte-wide RAM 5:3 Rx:Tx split, 
autoselect/Autonegotiate interface.
Jun 21 16:20:56 rafix kernel: 00:09.0:  Media override to transceiver 
type 4 (100baseTX).
Jun 21 16:20:56 rafix kernel:   Enabling bus-master transmits and 
whole-frame receives.
Jun 21 16:20:56 rafix kernel: 00:09.0: scatter/gather enabled. h/w 
checksums enabled
Jun 21 16:20:56 rafix kernel: eth0: Media override to transceiver 4 
(100baseTX).
Jun 21 16:20:56 rafix kernel: GSTWLAN0: AP TI acx100_pci.o: Ver 0.9.0.1c 
-- 2003/04/25 08:06:42 CST Loaded
Jun 21 16:20:56 rafix kernel: 2003/04/25 08:06:42 CST driver loaded
Jun 21 16:20:56 rafix kernel: GSTWLAN0: The wireless card initial 
successful!
Jun 21 16:20:56 rafix kernel: GSTWLAN0: The wireless driver starts ok!
Jun 21 16:20:56 rafix kernel: ttyS1: LSR safety check engaged!
Jun 21 16:20:56 rafix kernel: ttyS1: LSR safety check engaged!
Jun 21 16:20:56 rafix kernel: hub.c: new USB device 00:10.0-1, assigned 
address 2
Jun 21 16:20:56 rafix kernel: usb_control/bulk_msg: timeout
Jun 21 16:20:56 rafix kernel: usb.c: USB device not accepting new 
address=2 (error=-110)
Jun 21 16:20:56 rafix kernel: hub.c: new USB device 00:10.0-1, assigned 
address 3
Jun 21 16:20:56 rafix kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jun 21 16:20:56 rafix kernel: ip_conntrack version 2.1 (4095 buckets, 
32760 max) - 292 bytes per conntrack


Is /proc/interrups

            CPU0
   0:     822760          XT-PIC  timer
   1:      20917          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:     378501          XT-PIC  ehci_hcd, EMU10K1
   8:          4          XT-PIC  rtc
  10:      84527          XT-PIC  usb-uhci, eth1
  11:      34039          XT-PIC  usb-uhci, eth0
  12:     502826          XT-PIC  usb-uhci, nvidia
  14:      46753          XT-PIC  ide0
  15:         38          XT-PIC  ide1
NMI:          0
ERR:          0

EMU10K1  - SB Live 5.1
Etho is 3c905c
eth0 is DWL520+
nvidia is 440SE AGP x4
Mainboard is Epox  EP-8K9A   ( KT400)  USB20
AMD XP1700+


Is ERROR (BUG) syslog

Jun 21 16:47:23 rafix kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 21 16:47:23 rafix kernel: eth0: transmit timed out, tx_status 00 
status e601.
Jun 21 16:47:23 rafix kernel:   diagnostics: net 0cfa media 8880 dma 
0000003a.
Jun 21 16:47:23 rafix kernel: eth0: Interrupt posted but not delivered 
-- IRQ blocked by another device?
Jun 21 16:47:23 rafix kernel:   Flags; bus-master 1, dirty 64(0) current 
64(0)
Jun 21 16:47:23 rafix kernel:   Transmit list 00000000 vs. def79200.
Jun 21 16:47:23 rafix kernel:   0: @def79200  length 800000e7 status 
000100e7
Jun 21 16:47:23 rafix kernel:   1: @def79240  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   2: @def79280  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   3: @def792c0  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   4: @def79300  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   5: @def79340  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   6: @def79380  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   7: @def793c0  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   8: @def79400  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   9: @def79440  length 800000db status 
000100db
Jun 21 16:47:23 rafix kernel:   10: @def79480  length 800000fb status 
000100fb
Jun 21 16:47:23 rafix kernel:   11: @def794c0  length 800000f9 status 
000100f9
Jun 21 16:47:23 rafix kernel:   12: @def79500  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   13: @def79540  length 8000006e status 
0001006e
Jun 21 16:47:23 rafix kernel:   14: @def79580  length 8000006e status 
8001006e
Jun 21 16:47:23 rafix kernel:   15: @def795c0  length 8000006e status 
8001006e
Jun 21 16:47:23 rafix kernel: eth0: Resetting the Tx ring pointer.
Jun 21 16:47:33 rafix kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jun 21 16:47:33 rafix kernel: eth0: transmit timed out, tx_status 00 
status e201.
Jun 21 16:47:33 rafix kernel:   diagnostics: net 0cfa media 8880 dma 
00000032.
Jun 21 16:47:33 rafix kernel: eth0: Interrupt posted but not delivered 
-- IRQ blocked by another device?
Jun 21 16:47:33 rafix kernel:   Flags; bus-master 1, dirty 80(0) current 
80(0)
Jun 21 16:47:33 rafix kernel:   Transmit list 00000000 vs. def79200.
Jun 21 16:47:33 rafix kernel:   0: @def79200  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   1: @def79240  length 800000fb status 
000100fb
Jun 21 16:47:33 rafix kernel:   2: @def79280  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   3: @def792c0  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   4: @def79300  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   5: @def79340  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   6: @def79380  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   7: @def793c0  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   8: @def79400  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   9: @def79440  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   10: @def79480  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   11: @def794c0  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   12: @def79500  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   13: @def79540  length 8000006e status 
0001006e
Jun 21 16:47:33 rafix kernel:   14: @def79580  length 8000006e status 
8001006e
Jun 21 16:47:33 rafix kernel:   15: @def795c0  length 8000006e status 
8001006e
Jun 21 16:47:33 rafix kernel: eth0: Resetting the Tx ring pointer.
Jun 21 16:47:42 rafix kernel: bridge-eth0: disabling the bridge
Jun 21 16:47:42 rafix kernel: bridge-eth0: down


R

