Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbTFMCcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 22:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbTFMCcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 22:32:05 -0400
Received: from jadzia.bu.edu ([128.197.20.189]:16040 "EHLO jadzia.bu.edu")
	by vger.kernel.org with ESMTP id S265106AbTFMCcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 22:32:02 -0400
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Pentium M
In-Reply-To: <20030612193015$7974@gated-at.bofh.it>
References: <20030612042011$03c0@gated-at.bofh.it> <20030612062010$3dad@gated-at.bofh.it> <20030612193016$6d05@gated-at.bofh.it> <20030612193015$7974@gated-at.bofh.it>
Reply-To: mattdm@mattdm.org
Date: Thu, 12 Jun 2003 22:45:49 -0400
Message-Id: <20030613024549.078A4720B1@jadzia.bu.edu>
From: mattdm@jadzia.bu.edu (Matthew Miller)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, Dave Jones wrote:
> For info folks, I've now had a dozen or so mails with the same cache
> descriptors.  Please don't send me any more centrino based outputs,
> I have plenty now, thanks 8-)

Hi Dave. This is the output from my Celeron 600A system -- it's a tiny bit
different from what others posted to the list (an 0x86 instead of an 0x87).
My understanding is that this CPU has half the L2 cache of the "real"
Pentium M. Hope this is helpful and not annoying. Also, a question: I had
assumed that the lack of info in /proc/cpuinfo was simply that an
informational problem, and that the cache is actually working. Am I
mistaken? (I.e. will having the kernel support this be a huge performance
increase?) Thanks!



/proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 9
model name	: Mobile Intel(R) Celeron(R) processor     600MHz
stepping	: 5
cpu MHz		: 595.408
cache size	: 0 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm
bogomips	: 1186.20


x86info -c:

x86info v1.9.  Dave Jones 2001, 2002
Feedback to <davej@suse.de>.

Found 1 CPU
Family: 6 Model: 9 Stepping: 5 Type: 0 [ Original OEM]
unknown TLB/cache descriptor:
	0xb0
unknown TLB/cache descriptor:
	0xb3
Instruction TLB: 4MB pages, fully associative, 2 entries
unknown TLB/cache descriptor:
	0x86
unknown TLB/cache descriptor:
	0x30
Data TLB: 4MB pages, 4-way associative, 8 entries
unknown TLB/cache descriptor:
	0x2c



-- 
Matthew Miller           mattdm@mattdm.org        <http://www.mattdm.org/>
Boston University Linux      ------>                <http://linux.bu.edu/>
