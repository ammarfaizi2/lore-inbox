Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289314AbSA1S3U>; Mon, 28 Jan 2002 13:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289313AbSA1S3K>; Mon, 28 Jan 2002 13:29:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:219 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289312AbSA1S27>;
	Mon, 28 Jan 2002 13:28:59 -0500
Date: Mon, 28 Jan 2002 21:26:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] O(1) scheduler, -J9
Message-ID: <Pine.LNX.4.33.0201282122580.18440-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -J9 O(1) scheduler patch for kernels 2.5.3-pre5, 2.4.18-pre7 and
2.4.17 is available at:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-pre5-J9.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J9.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.18-pre7-J9.patch

the main changes in -J9 is the improved SMP load-balancer, generic
context-switch speedups, plus fixes. [ -J9 includes the fixes and
improvements explained in the component patches sent to lkml earlier today
(and yesterday).]

Bug reports, comments, suggestions welcome,

	Ingo

