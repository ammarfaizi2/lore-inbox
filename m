Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTDRB7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 21:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbTDRB7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 21:59:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21471 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262706AbTDRB7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 21:59:08 -0400
Message-ID: <3E9F5EAD.2070006@pobox.com>
Date: Thu, 17 Apr 2003 22:10:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: My P3 runs at.... zero Mhz (bug rpt)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just booted into 2.5.67-BK-latest (plus my __builtin_memcpy patch). 
Everything seems to be running just fine, so naturally one must nitpick 
little things like being told my CPU is running at 0.000 Mhz.  :)

2.4.x reports the Mhz correctly.  I don't recall if 2.5.x did in the 
past, but can check if needed.



sh-2.05b$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 0.000
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 494.59


Selected dmesg bits:
Calibrating delay loop... 494.59 BogoMIPS
Memory: 644596k/655296k available (2192k kernel code, 9960k reserved, 
694k data, 296k init, 0k highmem)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0

