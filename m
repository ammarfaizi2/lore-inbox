Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbSKMPzh>; Wed, 13 Nov 2002 10:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbSKMPzh>; Wed, 13 Nov 2002 10:55:37 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:12257 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262062AbSKMPza> convert rfc822-to-8bit; Wed, 13 Nov 2002 10:55:30 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
To: "J.A.=?iso-8859-1?q?Magall=F3n?=" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.20-rc1-jam2
Date: Wed, 13 Nov 2002 17:02:15 +0100
User-Agent: KMail/1.4.3
References: <20021113014120.GC1806@werewolf.able.es>
In-Reply-To: <20021113014120.GC1806@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211131702.15609.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 November 2002 02:41, J.A. Magallón wrote:
> Hi all...
>
> Just to public a new relase ;).

Hi J.A.,

just tried to apply on top of pristine 2.4.20-rc1.

for i in 2.4.20-rc1-jam2/*.bz2; do echo $i; bzcat $i | drypatch -p1; done | 
grep -2 FAIL

2.4.20-rc1-jam2/00-rc1aa1.bz2 is fine
[...]
2.4.20-rc1-jam2/33-task_cpu.bz2
patching file arch/i386/kernel/smpboot.c
Hunk #1 FAILED at 1027.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/i386/kernel/smpboot.c.rej
patching file arch/s390/kernel/smp.c
Hunk #1 FAILED at 469.
1 out of 1 hunk FAILED -- saving rejects to file arch/s390/kernel/smp.c.rej
patching file arch/s390x/kernel/smp.c
Hunk #1 FAILED at 456.
1 out of 1 hunk FAILED -- saving rejects to file arch/s390x/kernel/smp.c.rej
can't find file to patch at input line 40
Perhaps you used the wrong -p or --strip option?
--
2 out of 2 hunks ignored
patching file fs/proc/array.c
Hunk #1 FAILED at 389.
1 out of 1 hunk FAILED -- saving rejects to file fs/proc/array.c.rej
patching file include/linux/sched.h
Hunk #1 succeeded at 948 (offset -44 lines).
--
1 out of 1 hunk ignored
patching file kernel/sched.c
Hunk #1 FAILED at 236.
Hunk #2 FAILED at 280.
Hunk #3 FAILED at 321.
Hunk #4 FAILED at 412.
Hunk #5 FAILED at 537.
Hunk #6 FAILED at 561.
Hunk #7 FAILED at 575.
Hunk #8 FAILED at 1731.
Hunk #9 FAILED at 1743.
Hunk #10 FAILED at 1786.
Hunk #11 FAILED at 1849.
Hunk #12 FAILED at 1859.
Hunk #13 FAILED at 1926.
13 out of 13 hunks FAILED -- saving rejects to file kernel/sched.c.rej
patching file kernel/signal.c
Hunk #1 FAILED at 509.
1 out of 1 hunk FAILED -- saving rejects to file kernel/signal.c.rej
[...]

This is just to scary for me...

Sorry,
Hans-Peter
