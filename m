Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTH2Ktb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTH2Ktb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:49:31 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:47266 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264526AbTH2Kt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:49:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16207.12213.252438.929875@gargle.gargle.HOWL>
Date: Fri, 29 Aug 2003 12:49:25 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
 > Dear All,
 > 
 > I'd appreciate if folks would run the program below on various
 > machines, especially those whose caches aren't automatically coherent
 > at the hardware level.

>From a dual Opteron 244 box:

Test separation: 4096 bytes: FAIL - too slow
Test separation: 8192 bytes: FAIL - too slow
Test separation: 16384 bytes: FAIL - too slow
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: minimum fast spacing: 32768 (8 pages)
0.08user 0.01system 0:00.08elapsed 101%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (131major+38minor)pagefaults 0swaps

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 5
model name	: AMD Opteron(tm) Processor 244
stepping	: 1
cpu MHz		: 1791.569
cache size	: 1024 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 3565.15
TLB size	: 1088 4K pages
clflush size	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 5
model name	: AMD Opteron(tm) Processor 244
stepping	: 1
cpu MHz		: 1791.569
cache size	: 1024 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 3578.26
TLB size	: 1088 4K pages
clflush size	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp
