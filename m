Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbTH2UIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbTH2UGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:06:33 -0400
Received: from zork.zork.net ([64.81.246.102]:37793 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261933AbTH2UDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:03:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
References: <20030829053510.GA12663@mail.jlokier.co.uk>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 29 Aug 2003 21:03:02 +0100
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk> (Jamie Lokier's
 message of "Fri, 29 Aug 2003 06:35:10 +0100")
Message-ID: <6uu180xmdl.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.

2-way Pentium III:

$ time ./va
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
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
VM page alias coherency test: all sizes passed

real    0m0.096s
user    0m0.073s
sys     0m0.023s
$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1133MHz
stepping        : 1
cpu MHz         : 1129.879
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2220.03

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1133MHz
stepping        : 1
cpu MHz         : 1129.879
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2252.80
