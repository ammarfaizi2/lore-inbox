Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWFSXlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWFSXlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWFSXlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:41:04 -0400
Received: from mail.polish-dvd.com ([69.222.0.225]:11984 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S964989AbWFSXlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:41:03 -0400
Message-ID: <20060619183134.ow8kexp0jd6o0wck@69.222.0.225>
Date: Mon, 19 Jun 2006 18:31:34 -0500
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Subject: kernel-x64-smp-multiprocessor-speed & bogomips problem in
	/proc/cpuinfo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-x64-smp-multiprocessor-speed & bogomips problem in /proc/cpuinfo

$cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 43
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
stepping        : 1
cpu MHz         : 1000.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge  
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext  
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 2005.64
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 43
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4200+
stepping        : 1
cpu MHz         : 1000.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge  
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext  
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 2005.64
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp
-----------------------

dmesg

....
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2204.635 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2052156k/2096064k available (2297k kernel code, 43520k  
reserved, 1131k data, 200k init)
Calibrating delay using timer specific routine.. 4412.42 BogoMIPS (lpj=2206214


xboom

art@usfltd.com

