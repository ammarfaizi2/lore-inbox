Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbTCGOeq>; Fri, 7 Mar 2003 09:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbTCGOeq>; Fri, 7 Mar 2003 09:34:46 -0500
Received: from mx1.elte.hu ([157.181.1.137]:63169 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261608AbTCGOep>;
	Fri, 7 Mar 2003 09:34:45 -0500
Date: Fri, 7 Mar 2003 15:45:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
In-Reply-To: <Pine.LNX.4.44.0303071049500.7326-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303071543480.12493-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw., could you please revert the kernel/softirq.c change, and re-test
-j25 interactivity with that patch? That way we'll know exactly which
component of -B2 caused the improvement on your box.

	Ingo

