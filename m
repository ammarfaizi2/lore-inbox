Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTL2VpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTL2VpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:45:22 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:14528 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264284AbTL2VpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:45:13 -0500
Date: Mon, 29 Dec 2003 22:45:09 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 and hyperthreading
Message-ID: <20031229214508.GG916@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is it possible to use Hyperthreading on the processor that supports
hypperthreading but motherboard has no idea about SMP?

I have in dmesg:
238MB LOWMEM available.
found SMP MP-table at 000f63f0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 61152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57056 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6420
ACPI: RSDT (v001 PTLTD  Montara  0x06040000  LTP 0x00000000) @ 0x0eee5e05
ACPI: FADT (v001 Acer   Yuhina   0x06040000 PTL  0x00000001) @ 0x0eeeaed2
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0eeeafd8
ACPI: DSDT (v001   ANNI   Yuhina 0x06040000 MSFT 0x0100000e) @ 0x00000000
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
SMP mptable: bad signature [0x0]!
BIOS bug, MP table errors detected!...
... disabling SMP support. (tell your hw vendor)
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda1 noapic vga=0x318 
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 2398.193 MHz processor.
Console: colour VGA+ 80x25
Memory: 237880k/244608k available (2134k kernel code, 6016k reserved, 829k data,
 160k init, 0k highmem)
Calibrating delay loop... 4734.97 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: Hyper-Threading is disabled
CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Celeron(R) CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 365.58 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Starting migration thread for cpu 0
CPUS done 8


Could be Hyper-Threading enabled in some way? (I use noapic otherwise kernel
hangs during boot after uncompressing kernel message)

-- 
Luká¹ Hejtmánek
