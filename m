Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTFYN1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 09:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTFYN1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 09:27:10 -0400
Received: from [62.67.222.139] ([62.67.222.139]:32736 "EHLO kermit")
	by vger.kernel.org with ESMTP id S264235AbTFYN1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 09:27:05 -0400
Date: Wed, 25 Jun 2003 15:41:12 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Success stories, disappearing Oopses and ps/2 keyboard
Message-ID: <20030625134112.GA1489@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030624164026.GA2934@sexmachine.doom> <1056493814.1032.253.camel@w-jstultz2.beaverton.ibm.com> <20030625081313.GA1747@sexmachine.doom> <200306251127.37944.lkml@kcore.org> <20030625132336.GA1579@sexmachine.doom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625132336.GA1579@sexmachine.doom>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Konstantin Kletschke <konsti@ludenkalle.de> [Wed, Jun 25, 2003 at 03:23:36PM +0200]:

> wait, I can capture it at serial console :-) 

Linux version 2.5.73-mm1 (root@sexmachine.doom) (gcc version 3.2.3
20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #2 Tue Jun 24 22:24:45
CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
 BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
767MB LOWMEM available.
found SMP MP-table at 000fba20
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 196592
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192496 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AMI                        ) @ 0x000fa160
ACPI: RSDT (v001 AMIINT INTEL845 00000.00016) @ 0x2fff0000
ACPI: FADT (v001 AMIINT INTEL845 00000.00017) @ 0x2fff0030
ACPI: MADT (v001 AMIINT INTEL845 00000.00009) @ 0x2fff00c0
ACPI: DSDT (v001  INTEL BROKDLEG 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0]
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1]
trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: console=ttyS0,115200 console=tty0 root=/dev/hda1
clock=pit
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Console: colour VGA+ 80x25
Calibrating delay loop... 1199.30 BogoMIPS
Memory: 773944k/786368k available (1988k kernel code, 11656k reserved,
537k data, 312k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... failed :(.
Kernel panic: IO-APIC + timer doesn't work! pester mingo@redhat.com

-- 
2.5.73-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 3 min, 
