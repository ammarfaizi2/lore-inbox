Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUCRTtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbUCRTtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:49:00 -0500
Received: from lanshark.nersc.gov ([128.55.16.114]:42389 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S262905AbUCRTrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:47:07 -0500
Message-ID: <4059FCB9.4070204@lbl.gov>
Date: Thu, 18 Mar 2004 11:47:05 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Dual Athlon CPU detection..
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this in my /proc/cpuinfo:

[tdavis@lanshark tdavis]$ more /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2200+
stepping        : 0
cpu MHz         : 1800.902
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
 pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3547.13

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) Processor
stepping        : 0
cpu MHz         : 1800.902
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
 pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3596.28
[tdavis@lanshark tdavis]$ uname -a
Linux lanshark.nersc.gov 2.6.4-rc1-mm1 #1 SMP Tue Mar 2 14:09:44 PST 2004 i686 athlon i386 GNU/Linux


Is this a bad CPU, or a kernel bug?
