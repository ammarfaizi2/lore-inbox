Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWAHTbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWAHTbV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWAHTbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:31:21 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:51745 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161113AbWAHTbU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:31:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WULRsW+duCdhiYJzvxbL7Qzl9ClbGOmsqkAWjmZm1UGve4GQ6tbLLXT7rFxlgZC0PJ3nHgpovVoY1T0zVNQWPDtHwalBsdLHLD3l0jcNeIvGIKKroffHZLu6KiWJDDLnlxMGAFvNvtAC6RuU5xBc2KjXEprksFHg4cdDyWFCl+0=
Message-ID: <eaef64fc0601081131i17336398l304038c6dea3e057@mail.gmail.com>
Date: Mon, 9 Jan 2006 01:01:19 +0530
From: Chaitanya Hazarey <cvh.tcs@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Back to the Future ? or some thing sinister ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a problem that does not come along quite frequently.

We have got a machine, lets say X , make is IBM and the CPU is Intel
Pentium 4 2.60 GHz. Its running a 2.6.13.1 Kernel and previously,
2.6.27-4 Kernel the distribution is Debian Sagre.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.60GHz
stepping        : 9
cpu MHz         : 2591.888
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
xtpr
bogomips        : 5188.79




The problem is that, after a some time ( fuzzy , but I think like 2
hours ) of inactivity or because of some esoteric factor which triggers
a state in which the time on the machine starts going around in a loop.
if I do cat /proc/uptime, it goes 4  ticks ahead and again rewinds back
to the starting count ( not zero, but the moment in time when the event
was triggred. )

The problem seems to be specific to the 2.6 series of kernel, not the
2.4 series.

I  would like to know how to go about the debugging of the problem, and
that which specific part of the kernel will be directly interacting with
the rtc / system clock.

Thanks,

Chaitanya
