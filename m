Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRBEEeQ>; Sun, 4 Feb 2001 23:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132695AbRBEEeG>; Sun, 4 Feb 2001 23:34:06 -0500
Received: from nwcst276.netaddress.usa.net ([204.68.23.21]:59097 "HELO
	nwcst276.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S132680AbRBEEd4> convert rfc822-to-8bit; Sun, 4 Feb 2001 23:33:56 -0500
Message-ID: <20010205043355.12353.qmail@nwcst276.netaddress.usa.net>
Date: 4 Feb 2001 21:33:55 MST
From: Robert Guerra <rob_guerra@usa.net>
To: davids@webmaster.com
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
CC: linux-kernel@vger.kernel.org
X-Mailer: USANET web-mailer (34FM.0700.15B.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,
    please try to reply courteously to queries by other people. And specially
when you're the one who's wrong. Mohit is right - Linux had a 
long standing problem where sched_yield() system call didn't work. It 
was only fixed in Linux 2.4. 

> > Also, it is NOT unrealistic to expect perfect alternation.
>
>	Find one pthreads expert who agrees with this claim. Post it to
> comp.programming.threads and let the guys who created the standard 
> laugh at you. Scheduling is not a substitute for synchronization, ever.

I don't claim mastery over threads. But I have been programming with threads
for a very long time and am well aware of the way OS schedulers
work. In the example that Mohit posted, it is reasonable to expect 
perfect alternation once both threads have started. And it certainly isn't
something to laugh at (even if it were wrong).


- Robert Guerra




____________________________________________________________________
Get free email and a permanent address at http://www.netaddress.com/?N=1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
