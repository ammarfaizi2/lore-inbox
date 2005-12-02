Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932693AbVLBBMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbVLBBMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVLBBMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 20:12:13 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:65222 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932693AbVLBBMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 20:12:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DIgpyEvjL/L1eYcpFfBjftoYh6F0FdwOdDRoeI5Ko00KkQiXXeSBR9BAcTDp3YV1hVZzKVT/rraQyXI4P5/IwhLeOpgQVOerQRweJXOzPhTYv8WpydkfyBmg0nAsW3c+LsGna/L9pZds5BeosUePg0at3iZDME+sRbQRq5V3268=
Message-ID: <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
Date: Thu, 1 Dec 2005 20:12:11 -0500
From: Bharath Ramesh <krosswindz@gmail.com>
To: Keith Mannthey <kmannth@gmail.com>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	 <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could it be possible that AMD64 NUMA support is needed for Opteron
SMPs to work and Intel's APIC-based SMP wouldn't work on some boards.

lspci output:
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:1c.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:1c.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address
Map
00:1c.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:1c.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:1d.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:1d.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:1d.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:1d.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:1e.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:1e.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:1e.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:1e.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:1f.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:1f.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:1f.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:1f.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
01:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
04:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
04:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
04:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
07:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
07:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
07:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
07:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
07:03.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
07:03.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
07:04.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
07:04.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
08:02.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet
Controller (Copper) (rev 01)
08:02.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet
Controller (Copper) (rev 01)
09:01.0 PCI bridge: Mellanox Technologies MT23108 PCI Bridge (rev a1)
09:02.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet
Controller (Copper) (rev 01)
09:02.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Co
pper) (rev 01)
0a:00.0 InfiniBand: Mellanox Technologies MT23108 InfiniHost (rev a1)


Thanks,

Bharath

On 12/1/05, Bharath Ramesh <krosswindz@gmail.com> wrote:
> Patched 2.6.15-rc4 with the patch. It still is the same.
>
> dmesg:
> Linux version 2.6.15-rc4 (root@drones) (gcc version 3.4.3 20050227
> (Red Hat 3.4.3-22.1)) #1 SMP PREEMPT Thu Dec 1 19:37:03 EST 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
>  BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
>  BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
>  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 0000000440000000 (usable)
> 16512MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000ff780
> NX (Execute Disable) protection: active
> On node 0 totalpages: 4456448
>   DMA zone: 4096 pages, LIFO batch:2
>   DMA32 zone: 0 pages, LIFO batch:2
>   Normal zone: 225280 pages, LIFO batch:64
>   HighMem zone: 4227072 pages, LIFO batch:64
> DMI 2.3 present.
> ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f6ca0
> ACPI: XSDT (v001 A M I  OEMXSDT  0x02000502 MSFT 0x00000097) @ 0xbfff0100
> ACPI: FADT (v003 A M I  OEMFACP  0x02000502 MSFT 0x00000097) @ 0xbfff0281
> ACPI: MADT (v001 A M I  OEMAPIC  0x02000502 MSFT 0x00000097) @ 0xbfff0380
> ACPI: OEMB (v001 A M I  OEMBIOS  0x02000502 MSFT 0x00000097) @ 0xbffff040
> ACPI: SRAT (v001 A M I  OEMSRAT  0x02000502 MSFT 0x00000097) @ 0xbfff3cc0
> ACPI: DSDT (v001  H805V H805V120 0x00000000 INTL 0x02002026) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
> Processor #16 15:5 APIC version 16
> Processor #16 INVALID. (Max ID: 256).
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
> Processor #17 15:5 APIC version 16
> Processor #17 INVALID. (Max ID: 256).
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
> Processor #18 15:5 APIC version 16
> Processor #18 INVALID. (Max ID: 256).
> ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] enabled)
> Processor #19 15:5 APIC version 16
> Processor #19 INVALID. (Max ID: 256).
> ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] enabled)
> Processor #20 15:5 APIC version 16
> Processor #20 INVALID. (Max ID: 256).
> ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] enabled)
> Processor #21 15:5 APIC version 16
> Processor #21 INVALID. (Max ID: 256).
> ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] enabled)
> Processor #22 15:5 APIC version 16
> Processor #22 INVALID. (Max ID: 256).
> ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] enabled)
> Processor #23 15:5 APIC version 16
> Processor #23 INVALID. (Max ID: 256).
> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x02] address[0xfcffe000] gsi_base[24])
> IOAPIC[1]: apic_id 2, version 17, address 0xfcffe000, GSI 24-27
> ACPI: IOAPIC (id[0x03] address[0xfcfff000] gsi_base[28])
> IOAPIC[2]: apic_id 3, version 17, address 0xfcfff000, GSI 28-31
> ACPI: IOAPIC (id[0x10] address[0xfbffe000] gsi_base[32])
> IOAPIC[3]: apic_id 16, version 17, address 0xfbffe000, GSI 32-35
> ACPI: IOAPIC (id[0x11] address[0xfbfff000] gsi_base[36])
> IOAPIC[4]: apic_id 17, version 17, address 0xfbfff000, GSI 36-39
> ACPI: IOAPIC (id[0x12] address[0xfacfc000] gsi_base[40])
> IOAPIC[5]: apic_id 18, version 17, address 0xfacfc000, GSI 40-43
> ACPI: IOAPIC (id[0x13] address[0xfacfd000] gsi_base[44])
> IOAPIC[6]: apic_id 19, version 17, address 0xfacfd000, GSI 44-47
> ACPI: IOAPIC (id[0x14] address[0xfacfe000] gsi_base[48])
> IOAPIC[7]: apic_id 20, version 17, address 0xfacfe000, GSI 48-51
> ACPI: IOAPIC (id[0x15] address[0xfacff000] gsi_base[52])
> IOAPIC[8]: apic_id 21, version 17, address 0xfacff000, GSI 52-55
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Enabling APIC mode:  Flat.  Using 9 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Allocating PCI resources starting at c4000000 (gap: c0000000:3f780000)
> Built 1 zonelists
> Kernel command line: ro root=/dev/hda3 vga=791 rhgb quiet
> mapped APIC to ffffd000 (fee00000)
> mapped IOAPIC to ffffc000 (fec00000)
> mapped IOAPIC to ffffb000 (fcffe000)
> mapped IOAPIC to ffffa000 (fcfff000)
> mapped IOAPIC to ffff9000 (fbffe000)
> mapped IOAPIC to ffff8000 (fbfff000)
> mapped IOAPIC to ffff7000 (facfc000)
> mapped IOAPIC to ffff6000 (facfd000)
> mapped IOAPIC to ffff5000 (facfe000)
> mapped IOAPIC to ffff4000 (facff000)
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 65536 bytes)
> Detected 2004.700 MHz processor.
> Using tsc for high-res timesource
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 16614040k/17825792k available (2161k kernel code, 161112k
> reserved, 598k data, 224k init, 15859648k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 4017.36 BogoMIPS (lpj=8034729)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
> 00000000 00000000 00000000
> CPU: After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
> 00000000 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU: After all inits, caps: 078bfbff e1d3fbff 00000000 00000010
> 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> mtrr: v2.0 (20020519)
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> CPU0: AMD Opteron(tm) Processor 846 stepping 0a
> weird, boot CPU (#0) not listed by the BIOS.
> Total of 1 processors activated (4017.36 BogoMIPS).
> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
> Brought up 1 CPUs
>
> Thanks,
>
> Bharath
>
> On 12/1/05, Keith Mannthey <kmannth@gmail.com> wrote:
> > Looks like something odd is going on with your processor apic id's.
> >
> > Lines like
> > Processor #20 INVALID. (Max ID: 256)
> > are bad...
> >
> > Could you try the following patch with i386?  It seems suspect to me
> > and could help identify the problem.
> >
> > Your box has high processor apic ids and looks to be in flat apic mode
> > (versus clustered).  I think the code is assuming the box is in
> > clustered apic mode?
> >
> > Thanks,
> > Keith
> >
> >
> >
>
