Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSGDUSQ>; Thu, 4 Jul 2002 16:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSGDUSQ>; Thu, 4 Jul 2002 16:18:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17562 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S313638AbSGDUSO>;
	Thu, 4 Jul 2002 16:18:14 -0400
Date: Thu, 4 Jul 2002 22:17:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] O(1) scheduler for 2.4.19-rc1 and 2.4.18
Message-ID: <Pine.LNX.4.44.0207042130330.9571-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


due to popular demand i've backported my current 2.5 scheduler tree to
2.4.19-rc1 and 2.4.18-vanilla. The patches include all recent scheduler
fixes and enhancements that went into 2.5.24, plus the SCHED_BATCH
(SCHED_IDLE replacement) feature i implemented since 2.5.24.

the 2.4.19-rc1 patch can be found at:

	http://redhat.com/~mingo/O(1)-scheduler/sched-2.4.19-rc1-A1

the 2.4.18 patch can be downloaded from:

	http://redhat.com/~mingo/O(1)-scheduler/sched-2.4.18-A1

both patches implement the very same scheduler codebase. The setbatch
utility (set-idle replacement) can be found at:

        http://redhat.com/~mingo/O(1)-scheduler/setbatch.c

the patch was tested on x86 UP and SMP boxes, but it should work on other
architectures as well.

as usual, bug reports, success reports, comments, suggestions and feature
requests are welcome,

	Ingo


