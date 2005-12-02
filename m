Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVLBPcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVLBPcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 10:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVLBPcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 10:32:16 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:10294 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750786AbVLBPcP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 10:32:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IhEiCKcALEEtvbQkfjo9XBWiufNSM3B1HwKHm0bGA6QWEBRn/zZqkbW8KpeEUJFns1u5ZGaWTZxeDEmyoDPv5+mb82+75iQ3nDmi+mVIXnFRBAbYbI7V2eUTGYqSBXFVzjzRMxtauy0j7JhOcVB1oDjS6Nu+Q+OZty+Sz2LK348=
Message-ID: <c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com>
Date: Fri, 2 Dec 2005 10:32:14 -0500
From: Bharath Ramesh <krosswindz@gmail.com>
To: Keith Mannthey <kmannth@gmail.com>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	 <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
	 <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
	 <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Does booting with acpi=off help?

Booting with acpi=off doesnt help

dmesg with acpi=off:
Linux version 2.6.15-rc4 (root@drones) (gcc version 3.4.3 20050227
(Red Hat 3.4.3-22.1)) #1 SMP PREEMPT Thu Dec 1 19:37:03 EST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
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
  DMA zone: 4096 pages, LIFO batch:2
  DMA32 zone: 0 pages, LIFO batch:2
  Normal zone: 225280 pages, LIFO batch:64
  HighMem zone: 4227072 pages, LIFO batch:64
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IWILL    Product ID: H805         APIC at: 0xFEE00000
Processor #16 15:5 APIC version 16
Processor #16 INVALID. (Max ID: 256).
Processor #17 15:5 APIC version 16
Processor #17 INVALID. (Max ID: 256).
Processor #18 15:5 APIC version 16
Processor #18 INVALID. (Max ID: 256).
Processor #19 15:5 APIC version 16
Processor #19 INVALID. (Max ID: 256).
Processor #20 15:5 APIC version 16
Processor #20 INVALID. (Max ID: 256).
Processor #21 15:5 APIC version 16
Processor #21 INVALID. (Max ID: 256).
Processor #22 15:5 APIC version 16
Processor #22 INVALID. (Max ID: 256).
Processor #23 15:5 APIC version 16
Processor #23 INVALID. (Max ID: 256).
I/O APIC #0 Version 17 at 0xFEC00000.
I/O APIC #1 Version 17 at 0xFCFFE000.
I/O APIC #2 Version 17 at 0xFCFFF000.
I/O APIC #3 Version 17 at 0xFBFFE000.
I/O APIC #4 Version 17 at 0xFBFFF000.
I/O APIC #5 Version 17 at 0xFACFC000.
I/O APIC #6 Version 17 at 0xFACFD000.
I/O APIC #7 Version 17 at 0xFACFE000.
I/O APIC #8 Version 17 at 0xFACFF000.
Enabling APIC mode:  Flat.  Using 9 I/O APICs
SMP mptable: no processors registered!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Allocating PCI resources starting at c4000000 (gap: c0000000:3f780000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda3 vga=791 acpi=off rhgb quiet
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (0a955000)
mapped IOAPIC to ffffb000 (0a956000)
mapped IOAPIC to ffffa000 (0a957000)
mapped IOAPIC to ffff9000 (0a958000)
mapped IOAPIC to ffff8000 (0a959000)
mapped IOAPIC to ffff7000 (0a95a000)
mapped IOAPIC to ffff6000 (0a95b000)
mapped IOAPIC to ffff5000 (0a95c000)
mapped IOAPIC to ffff4000 (0a95d000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2004.813 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 16614040k/17825792k available (2161k kernel code, 161148k
reserved, 598k data, 224k init, 15859648k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4017.40 BogoMIPS (lpj=8034817)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
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
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Opteron(tm) Processor 846 stepping 0a
SMP motherboard not detected.
Brought up 1 CPUs

Thanks,

Bharath
