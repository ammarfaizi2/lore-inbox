Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290688AbSAYOm7>; Fri, 25 Jan 2002 09:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290693AbSAYOmg>; Fri, 25 Jan 2002 09:42:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55459 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290688AbSAYOmY>;
	Fri, 25 Jan 2002 09:42:24 -0500
Date: Fri, 25 Jan 2002 17:39:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, -J7
Message-ID: <Pine.LNX.4.33.0201251731020.9981-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -J7 O(1) scheduler patch for kernels 2.5.3-pre5, 2.4.17-pre7 and
2.4.17 is available at:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-pre5-J7.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J7.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.18-pre7-J7.patch

-J7 includes the fixes and improvements explained in the component patches
sent to lkml earlier today. -J7 is the combination of those 9 patches,
backported to 2.4.17 and 2.4.18-pre as well.

i'd like to ask those people to retest -J7 who had problems booting the
O(1) scheduler on fb-console enabled systems. Also, the shell 'hanging'
problems should be fixed in -J7 as well.

please also report any interactiveness degradation/improvement relative to
any of the previous 'J series' patches: -J2, -J4, -J5 and -J6.

More adventurous people might want to tweak the new tunables in sched.h,
and/or try Jack F. Vogel's runtime tuning patch. Careful though, eg.
setting MAX_TIMESLICE too low can produce unexpected results ...

Bug reports, comments, suggestions welcome,

	Ingo

