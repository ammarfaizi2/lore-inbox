Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbTCGVDL>; Fri, 7 Mar 2003 16:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbTCGVDL>; Fri, 7 Mar 2003 16:03:11 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:22146 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S261781AbTCGVDJ>;
	Fri, 7 Mar 2003 16:03:09 -0500
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: David Lang <david.lang@digitalinsight.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303071301500.1933-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0303071301500.1933-100000@dlang.diginsite.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047071612.29990.13.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Mar 2003 22:13:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 22:03, David Lang wrote:
> sounds like the code in X that detects a key being held down is running
> into problems. any chance it's doing a busy loop or something silly like
> that that's just not running enough? (probably not, but since you have
> problems in a couple applications that happen when you hold a key down I
> would look there rather then at the scheduling code itself)

Wouldn't surprise me if it's an X problem... I can't say that I feel
like going digging into X sources...

I can get the same problem in sawfish if I press the key a few times
quite rapidly as well, without any background load at all. This problem
has never occured before on 2.4 or 2.5, with or without load. It could
be that the scheduler changes exposes some bug in X but I'm not really
sure how to start investigating...

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
