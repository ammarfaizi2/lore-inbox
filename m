Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbTH2QdA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbTH2Qc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:32:58 -0400
Received: from 25.mdrx.com ([65.67.58.25]:15030 "EHLO duallie.mdrx.com")
	by vger.kernel.org with ESMTP id S261504AbTH2Qbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:31:50 -0400
From: Brian Jackson <brian@brianandsara.net>
To: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Date: Fri, 29 Aug 2003 11:31:46 -0500
User-Agent: KMail/1.5.3
References: <20030829053510.GA12663@mail.jlokier.co.uk>
In-Reply-To: <20030829053510.GA12663@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308291131.46895.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 August 2003 12:35 am, Jamie Lokier wrote:
> Dear All,
>
> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.
>
<snip>

Didn't see a 512k cache athlon-xp yet

skyline:/share/linux/projects/cachetest # sh go
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2800+
stepping        : 0
cpu MHz         : 2088.111
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4168.08

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

real    0m0.110s
user    0m0.070s
sys     0m0.030s

--Brian Jackson

-- 
OpenGFS -- http://opengfs.sourceforge.net
Gentoo -- http://gentoo.brianandsara.net
Home -- http://www.brianandsara.net

