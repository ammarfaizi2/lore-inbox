Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSATLVE>; Sun, 20 Jan 2002 06:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288245AbSATLUo>; Sun, 20 Jan 2002 06:20:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36016 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288238AbSATLUc>;
	Sun, 20 Jan 2002 06:20:32 -0500
Date: Sun, 20 Jan 2002 14:17:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [sched] [patch] fork-cleanup-2.5.3-pre2-A0
Message-ID: <Pine.LNX.4.33.0201201415530.7972-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch against 2.5.3-pre2 removes the child-runs-first ifdefs
from kernel/fork.c. Very few of the bugreports were related to
child-runs-first, and for 2.5 i think it's acceptable to introduce
unconditional child-runs-first.

	Ingo

