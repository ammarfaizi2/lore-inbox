Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUCCIYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 03:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUCCIYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 03:24:50 -0500
Received: from c10053.upc-c.chello.nl ([212.187.10.53]:11683 "EHLO
	smurver.fakenet") by vger.kernel.org with ESMTP id S262419AbUCCIYk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 03:24:40 -0500
Message-ID: <4045964F.8090809@vanE.nl>
Date: Wed, 03 Mar 2004 09:24:47 +0100
From: Erik van Engelen <Info@vanE.nl>
User-Agent: Mozilla Thunderbird 0.5b (Windows/20040301)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Errors on 2th ide channel of promise ultra100 tx2
References: <403F2178.70806@vanE.nl> <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271420250.18958@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>>The next thing i tried is to boot from a 2.6.3 kernel but that one ends
>>up in a big kernel panic. When i leave out the smart2 (cpqarray) driver
>>it boot up to the point where it needs a disk to boot from which isn't
>>there naturally.
>>
>>Can anyone help me with this problem? I like to stay on the 2.4 kernel
>>because i want to run debian stable but if thats impossible i want to
>>work on the 2.6. If you need any informatie or if i have to run some
>>tests on the machine just ask. It is here opend up on the floor and i've
>>got my screwdriver ready.
> 
> 
> Can you please save and post the 2.6.3 panic?
> 
----------
KERNEL LOG

LILO 22.2 boot: Linux-2.6.3
Loading Linux-2.6.3.......................
Linux version 2.6.3 (root@smurver) (gcc version 2.95.4 20011002 (Debian 
prerele4
BIOS-provided physical RAM map:
  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
user-defined physical RAM map:
  user: 0000000000000000 - 000000000009f000 (usable)
  user: 0000000000100000 - 0000000001000000 (usable)
16MB LOWMEM available.
found SMP MP-table at 000f4ff0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 4096
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 0 pages, LIFO batch:1
   HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
Processor #1 6:1 APIC version 16
Processor #0 6:1 APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.3 ro root=4802 mem=128M 
smart2=0x40008
Initializing CPU#0
PID hash table entries: 128 (order 7: 1024 bytes)
Detected 199.609 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 12780k/16384k available (1638k kernel code, 3192k reserved, 638k 
data, )
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 388.09 BogoMIPS
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium Pro stepping 09
per-CPU timeslice cutoff: 730.16 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 397.31 BogoMIPS
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium Pro stepping 09
Total of 2 processors activated (785.40 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 199.0422 MHz.
..... host bus clock speed is 66.0474 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Starting migration thread for cpu 1
Brought up 1 CPUs
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0068, last bus=1
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Device 00:00 not found by BIOS
PCI: Device 00:a0 not found by BIOS
Starting balanced_irq
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Compaq SMART2 Driver (v 2.4.5)
Found 1 controller(s)
cpqarray: Finding drives on ida0 (SMART-2/E)
cpqarray ida/c0d0: blksz=512 nr_blks=16755795
Unable to handle kernel NULL pointer dereference at virtual address 00000038
  printing eip:
c0350d85
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c0350d85>]    Not tainted
EFLAGS: 00010282
EIP is at cpqarray_init+0x29d/0x538
eax: 00000000   ebx: c0f48e00   ecx: 00008124   edx: 00000000
esi: c03a5920   edi: c03edf10   ebp: 00000010   esp: c0fe7f94
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c0fe6000 task=c0fe1900)
Stack: 00000000 00000000 00000000 c0386c2c 00000001 00000000 00000000 
00000048
        00000000 c0308120 00000048 00000000 00000000 00000001 00000000 
c033c7d2
        c0fe6000 00000000 c033c841 c01050ef 00000008 c0105094 00000000 
c0106ef1
Call Trace:
  [<c033c7d2>] do_initcalls+0x36/0x8c
  [<c033c841>] do_basic_setup+0x19/0x28
  [<c01050ef>] init+0x5b/0x15c
  [<c0105094>] init+0x0/0x15c
  [<c0106ef1>] kernel_thread_helper+0x5/0xc

Code: 8b 50 38 8b 48 3c 51 52 53 e8 e5 5c ea ff 6a 1f 53 e8 39 5e
  <0>Kernel panic: Attempted to kill init!
