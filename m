Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbTEET5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTEET5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:57:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28544 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261254AbTEET5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:57:36 -0400
Date: Mon, 5 May 2003 16:25:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Steven Cole <elenstev@mesatop.com>
cc: Valdis.Kletnieks@vt.edu, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
In-Reply-To: <1052164261.2166.129.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.53.0305051615530.2042@chaos>
References: <1052140733.2163.93.camel@spc9.esa.lanl.gov> 
 <m1d6ixb8m7.fsf@frodo.biederman.org>  <1052157615.2163.113.camel@spc9.esa.lanl.gov>
  <200305051817.h45IHwJC003355@turing-police.cc.vt.edu>
 <1052164261.2166.129.camel@spc9.esa.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Steven Cole wrote:

> On Mon, 2003-05-05 at 12:17, Valdis.Kletnieks@vt.edu wrote:
> > On Mon, 05 May 2003 12:00:15 MDT, Steven Cole said:
> >
> > > Perhaps two uptimes could be kept. The current concept of uptime would
> > > remain as is, analogous to the reign of a king (the current kernel), and
> > > a new integrated uptime would be analogous to the life of a dynasty. The
> > > dynasty uptime would be one of the many things the new kernel learned
> > > about on booting. This new dynasty uptime could become quite long if
> > > everything keeps on ticking.
> >
> > Make sure you handle the case of a dynasty that starts on a 2.7.13 kernel
> > and is finally deposed by a power failure in 2.7.39.
> >
> 2.7.13 eh?  Wow, that's optimistic.  I guess Karim and others better get
> busy.  Unless Linus throws in about 50 kernels with the -preX naming
> scheme like this last time. ;)
>
> Here's nice long uptime:
>
> tstad% uptime
>  12:58pm  up 503 days,  1:30,  3 users,  load average: 0.23, 0.04, 0.00
> tstad% uname -a
> ULTRIX tstad 4.3 1 RISC
>
> I guess Ultrix didn't have a jiffie wraparound problem at 497 days.
> That DEC 5000/200 has run almost continuously for 12 years, except for
> the occasional palace revolution/forest fire fiasco.
>
> Steven

VAXen including Ultrix start a clock at zero when booted. They
set boottime to the hwclock with the hard-to-find batteries behind
the rear door or under the board in the VAX/Station 3000. So, you
don't have a time that started in 1970 like other Unix machines
altough a conversion takes place when you actually read the time.

Raw time is in a quadword, in microfortnights (14 days / 1,000,000) =
24 * 14 = 336 hrs/* 60 = 2,160 seconds / 1,000,000 = 0.02 seconds.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

