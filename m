Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRKVMWb>; Thu, 22 Nov 2001 07:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRKVMWV>; Thu, 22 Nov 2001 07:22:21 -0500
Received: from ppp65-090.verat.net ([217.26.65.90]:6528 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S277713AbRKVMWS>; Thu, 22 Nov 2001 07:22:18 -0500
Message-Id: <200111230120.fAN1KsK01865@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: Haris Peco <snpe@snpe.co.yu>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.14 & memory
Date: Fri, 23 Nov 2001 02:20:54 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I have Pentium 4 with 1 GB RAM and kernel 2.4.14 (rh 7.2)

	When I set high memory offf then Linux can't see complete memory

This is my /proc/meminfo :

        total:    used:    free:  shared: buffers:  cached:
Mem:  922382336 520028160 402354176        0 42446848 190545920
Swap: 1077469184        0 1077469184
MemTotal:       900764 kB
MemFree:        392924 kB
MemShared:           0 kB
Buffers:         41452 kB
Cached:         186080 kB
SwapCached:          0 kB
Active:         103888 kB
Inactive:       183620 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       900764 kB
LowFree:        392924 kB
SwapTotal:     1052216 kB
SwapFree:      1052216 kB

Where is 147 mb RAM ?

/proc/cpuinfo is :
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 0
model name	: Intel(R) Pentium(R) 4 CPU 1600MHz
stepping	: 10
cpu MHz		: 1614.975
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss tm
bogomips	: 3224.37

If I set high memory on then BIOS see  917000KB, even.

regards,
peco


