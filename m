Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275839AbRJJOme>; Wed, 10 Oct 2001 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275832AbRJJOmZ>; Wed, 10 Oct 2001 10:42:25 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:32691 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275818AbRJJOmG>; Wed, 10 Oct 2001 10:42:06 -0400
Subject: 2.4.11 APIC problems
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 10 Oct 2001 09:46:56 +0000
Message-Id: <1002707216.29151.4.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hadware is a Netvista PIII-850, single processor
I have priviously (2.4.10 and below) been able to use this machine with
IO-APIC turned on.  I turned on Local APIC and IO-APIC in 2.4.11 and all
I got on boot was an endless stream of error messages that look like
this:
APIC error on CPU0: 08(08)

Here is the output from the serial console. I didn't see the previously
mention error message in the serial console though.  Where I would have
expected to see it, all I got was random garbage.

Linux version 2.4.11 (root@avalon) (gcc version 2.95.3 20010315 (SuSE)) #1 Wed Oct 10 09:12:46 CDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fee06c0 (usable)
 BIOS-e820: 000000000fee06c0 - 000000000fee66c0 (ACPI data)
 BIOS-e820: 000000000fee66c0 - 000000000feee700 (ACPI NVS)
 BIOS-e820: 000000000feee700 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
found SMP MP-table at 0009fe00
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
hm, page 000ec000 reserved twice.
hm, page 000ed000 reserved twice.
On node 0 totalpages: 65248
zone(0): 4096 pages.
zone(1): 61152 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: IBM-PCCO Product ID: CDT-BIOS  MP APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 32 at 0xFEC00000.
Processors: 1
Kernel command line: auto BOOT_IMAGE=new ro root=301 BOOT_FILE=/boot/bzImage console=ttyS0,9600
Initializing CPU#0
Detected 863.880 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1723.59 BogoMIPS
Memory: 254340k/260992k available (1288k kernel code, 6264k reserved, 435k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..T08 oe
Po>: r8n>CC
e(oIr:  rI  <: (o 8CCCP3<o)U) )C<8one(P(<nrI :0U nr >r Ue
<ArC>n8n)oPI0 ProA0 <0r:C


---------------------
Thanks,
Paul Larson

