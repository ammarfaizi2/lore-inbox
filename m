Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbTH2Kef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTH2Kef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:34:35 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:17891 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264502AbTH2Ked (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:34:33 -0400
Date: Fri, 29 Aug 2003 20:34:48 +1000
From: CaT <cat@zip.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829103447.GA568@zip.com.au>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 06:35:10AM +0100, Jamie Lokier wrote:
> 	gcc -o test test.c -O2
> 	time ./test
> 	cat /proc/cpuinfo

16 [20:33:33] hogarth@theirongiant:/home/hogarth>> time ./coherencytest
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

real    0m0.206s
user    0m0.135s
sys     0m0.027s
16 [20:33:44] hogarth@theirongiant:/home/hogarth>> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 701.641
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1388.54


-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
