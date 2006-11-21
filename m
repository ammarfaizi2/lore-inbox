Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966735AbWKUJTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966735AbWKUJTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966925AbWKUJTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:19:31 -0500
Received: from mail.dgt.com.pl ([195.117.141.2]:48590 "EHLO dgt.com.pl")
	by vger.kernel.org with ESMTP id S966735AbWKUJTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:19:30 -0500
DGT-Virus-Scanned: amavisd-new at dgt.com.pl
Message-ID: <4562C474.9020606@dgt.com.pl>
Date: Tue, 21 Nov 2006 10:18:44 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); pl-PL; rv:1.8.0.8) Gecko/20061029 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: intel 82865G and x.org shutdown on Pentium D using x86_64 arch
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel does oops while shutting down x.org on my system.
It's going bad only using x86_64 arch, with 32bit system it works fine.
Maybe there is a problem with x.org, but kernel should'nt crash ..


Here are some system infos:

$ uname -a
Linux .... 2.6.18.2 #1 SMP Tue Nov 7 10:38:22 CET 2006 
x86_64               Intel(R) Pentium(R) D CPU 3.00GHz GNU/Linux


$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      :               Intel(R) Pentium(R) D CPU 3.00GHz
stepping        : 4
cpu MHz         : 2992.539
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr lahf_lm
bogomips        : 5990.49
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 6
model name      :               Intel(R) Pentium(R) D CPU 3.00GHz
stepping        : 4
cpu MHz         : 2992.539
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall 
lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr lahf_lm
bogomips        : 5985.56
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

$ lspci
00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82865G Integrated 
Graphics Controller (rev 02)
....



