Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268898AbTBZS1h>; Wed, 26 Feb 2003 13:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268899AbTBZS1h>; Wed, 26 Feb 2003 13:27:37 -0500
Received: from kestrel.vispa.uk.net ([62.24.228.12]:65035 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id <S268898AbTBZS1f>; Wed, 26 Feb 2003 13:27:35 -0500
Message-ID: <3E5D096F.9020308@walrond.org>
Date: Wed, 26 Feb 2003 18:37:35 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo shows only 2 processors on dual P4-Xeon system
References: <F760B14C9561B941B89469F59BA3A8471380CF@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
>
> Enable the ACPI "CPU enumeration only" option.
> 

Ok - just tried that, but I still see only two processors in cpuinfo

Any ideas?

Relevant part of dmesg:

Using ACPI for processor (LAPIC) configuration information
KERN_INFO Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC01000.
I/O APIC #10 Version 17 at 0xFEC02000.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 4
Building zonelist for node : 0
Kernel command line: ro root=/dev/nfs ip=dhcp console=ttyS0,115200n8 
console=tty0 init=/boot/boot.sh
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2591.629 MHz processor.
Calibrating delay loop... 5111.80 BogoMIPS
Memory: 3100936k/4194304k available (1348k kernel code, 43644k reserved, 
310k data, 304k init, 2228200k highmem)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Total of 2 processors activated (10289.15 BogoMIPS).

