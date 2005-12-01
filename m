Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVLAVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVLAVPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVLAVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:15:49 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:28394 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932473AbVLAVPs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:15:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bNCn41mtnHEfuV739vTaOtSuxVCX49cSohMvnqSaBM7dt+Yd8ZsWp/M4KgtHDhpeSfagXdXGk8iZuENJEGt+zC8PDjgH8HND0ZCEuwDWp9AsjpbIHEIe0OshZbG5cl9tBn+Nqx9lm0F7MIYNqplvx/ZXfhtqTAIg+Mi69MXQZR4=
Message-ID: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
Date: Thu, 1 Dec 2005 16:15:46 -0500
From: Bharath Ramesh <krosswindz@gmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Only one processor detected in 8-Way opteron in 32-bit mode
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an 8-Way Opteron server. The machine has both 32-bit and 64-bit
installations. I find that I am unable to use more than one processor
in the 32-bit mode. Only one processor is detected while the other 7
arent. In 64-bit mode all the processors are detected. I am attaching
the dmesg from the currently running 2.6.11.10 kernel. I tried the
2.615-rc4 and I still see the same problem and dmesg is nearly the
same.

dmesg:

fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
  BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
  BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000440000000 (usable)
16512MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
NX (Execute Disable) protection: active
On node 0 totalpages: 4456448
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 4227072 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f6ca0
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000502 MSFT 0x00000097) @ 0xbfff0100
ACPI: FADT (v003 A M I  OEMFACP  0x02000502 MSFT 0x00000097) @ 0xbfff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x02000502 MSFT 0x00000097) @ 0xbfff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000502 MSFT 0x00000097) @ 0xbffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x02000502 MSFT 0x00000097) @ 0xbfff3cc0
ACPI: DSDT (v001  H805V H805V120 0x00000000 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
Processor #16 15:5 APIC version 16
Processor #16 INVALID. (Max ID: 256).
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
Processor #17 15:5 APIC version 16
Processor #17 INVALID. (Max ID: 256).
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
Processor #18 15:5 APIC version 16
Processor #18 INVALID. (Max ID: 256).
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] enabled)
Processor #19 15:5 APIC version 16
Processor #19 INVALID. (Max ID: 256).
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] enabled)
Processor #20 15:5 APIC version 16
Processor #20 INVALID. (Max ID: 256).
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] enabled)
Processor #21 15:5 APIC version 16
Processor #21 INVALID. (Max ID: 256).
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] enabled)
Processor #22 15:5 APIC version 16
Processor #22 INVALID. (Max ID: 256).
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] enabled)
Processor #23 15:5 APIC version 16
Processor #23 INVALID. (Max ID: 256).
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfcffe000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 17, address 0xfcffe000, GSI 24-27
ACPI: IOAPIC (id[0x03] address[0xfcfff000] gsi_base[28])
IOAPIC[2]: apic_id 3, version 17, address 0xfcfff000, GSI 28-31
ACPI: IOAPIC (id[0x10] address[0xfbffe000] gsi_base[32])
IOAPIC[3]: Invalid apic_id 16, trying 3
IOAPIC[3]: apic_id 3 already used, trying 0
IOAPIC[3]: apic_id 0, version 17, address 0xfbffe000, GSI 32-35
ACPI: IOAPIC (id[0x11] address[0xfbfff000] gsi_base[36])
IOAPIC[4]: Invalid apic_id 17, trying 4
IOAPIC[4]: apic_id 4, version 17, address 0xfbfff000, GSI 36-39
ACPI: IOAPIC (id[0x12] address[0xfacfc000] gsi_base[40])
IOAPIC[5]: Invalid apic_id 18, trying 5
IOAPIC[5]: apic_id 5, version 17, address 0xfacfc000, GSI 40-43
ACPI: IOAPIC (id[0x13] address[0xfacfd000] gsi_base[44])
IOAPIC[6]: Invalid apic_id 19, trying 6
IOAPIC[6]: apic_id 6, version 17, address 0xfacfd000, GSI 44-47
ACPI: IOAPIC (id[0x14] address[0xfacfe000] gsi_base[48])
IOAPIC[7]: Invalid apic_id 20, trying 7
IOAPIC[7]: apic_id 7, version 17, address 0xfacfe000, GSI 48-51
ACPI: [APIC:0x01] ignored 1 entries of 9 found
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 8 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c0000000 (gap: c0000000:3f780000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda3 vga=791 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fcffe000)
mapped IOAPIC to ffffa000 (fcfff000)
mapped IOAPIC to ffff9000 (fbffe000)
mapped IOAPIC to ffff8000 (fbfff000)
mapped IOAPIC to ffff7000 (facfc000)
mapped IOAPIC to ffff6000 (facfd000)
mapped IOAPIC to ffff5000 (facfe000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0409000 soft=c0405000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2005.226 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 16632192k/17825792k available (2064k kernel code, 143976k
reserved, 782k data, 220k init, 15859648k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps: 078bfbff e1d3fbff 00000000 00000010
00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Opteron(tm) Processor 846 stepping 0a
per-CPU timeslice cutoff: 2925.70 usecs.
task migration cache decay timeout: 3 msecs.
weird, boot CPU (#0) not listed by the BIOS.
Total of 1 processors activated (3940.35 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 1
  groups: 1
checking if image is initramfs... it is
