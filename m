Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbTIBSCp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263960AbTIBSCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:02:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18956
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263989AbTIBSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:01:56 -0400
Date: Tue, 2 Sep 2003 11:02:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Slower raid sync (pIII_sse) benchmark on AthlonXP
Message-ID: <20030902180202.GB13684@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are these numbers correct for sse on AthlonXP?  Every time I've seen the
pIII_sse number much closer to pII_mmx...

2.6.0-test4-mm3-1:

raid5: measuring checksumming speed
   8regs     :  2788.000 MB/sec
   8regs_prefetch:  2752.000 MB/sec
   32regs    :  2668.000 MB/sec
   32regs_prefetch:  2252.000 MB/sec
   pIII_sse  :  2792.000 MB/sec
   pII_mmx   :  5556.000 MB/sec
   p5_mmx    :  7360.000 MB/sec
raid5: using function: pIII_sse (2792.000 MB/sec)

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(TM) XP 2600+
stepping	: 1
cpu MHz		: 2083.203
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 4104.19

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Are these numbers correct for sse on AthlonXP?  Every time I've seen the
pIII_sse number much closer to pII_mmx...

2.6.0-test4-mm3-1:

raid5: measuring checksumming speed
   8regs     :  2788.000 MB/sec
   8regs_prefetch:  2752.000 MB/sec
   32regs    :  2668.000 MB/sec
   32regs_prefetch:  2252.000 MB/sec
   pIII_sse  :  2792.000 MB/sec
   pII_mmx   :  5556.000 MB/sec
   p5_mmx    :  7360.000 MB/sec
raid5: using function: pIII_sse (2792.000 MB/sec)

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(TM) XP 2600+
stepping	: 1
cpu MHz		: 2083.203
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 4104.19

