Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265390AbUEUFFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUEUFFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 01:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbUEUFFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 01:05:38 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:15072 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265390AbUEUFFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 01:05:32 -0400
Date: Fri, 21 May 2004 01:06:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
In-Reply-To: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0405210101200.2864@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sample boot output from an SMP box, i trimmed out the rest, lest i hit
some sort of LKML posting limit...

Linux version 2.6.6-mm4 (zwane@montezuma.fsmlabs.com) (gcc version 3.3.1
20030930 (Red Hat Linux 3.3.1-6)) #7 SMP Thu May 20 23:03:52 EDT 2004
0MB HIGHMEM available.
192MB LOWMEM available.
On node 0 totalpages: 49152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45056 pages, LIFO batch:11
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
Processor #0 5:2 APIC version 16
Processor #3 5:2 APIC version 16
Processor #4 5:2 APIC version 16
Unknown bustype XPRESS - ignoring
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 3
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=linux-2.6 ro root=801
BOOT_FILE=/boot/vmlinuz panic=120 noapic nmi_watchdog=1 profile=2 console=tty1 console=ttyS0,38400 noirqbalance
kernel profiling enabled
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 133.393 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 183056k/196608k available (4402k kernel code, 12892k reserved,
1335k data, 488k init, 0k highmem)
Calibrating delay loop... 254.97 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium 75 - 200 stepping 0c
Calibrating delay loop... 266.24 BogoMIPS
Calibrating delay loop... 265.21 BogoMIPS
Total of 3 processors activated (786.43 BogoMIPS).
Brought up 3 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfca41, last bus=1
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
SCSI subsystem initialized

