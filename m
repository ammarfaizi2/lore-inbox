Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287995AbSAMG7n>; Sun, 13 Jan 2002 01:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287996AbSAMG7X>; Sun, 13 Jan 2002 01:59:23 -0500
Received: from [202.135.142.196] ([202.135.142.196]:39945 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S287995AbSAMG7W>; Sun, 13 Jan 2002 01:59:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: timothy.covell@ashavan.org,
        =?ISO-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>,
        Ingo Molnar <mingo@elte.hu>, Mike Kravetz <kravetz@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd) 
In-Reply-To: Your message of "Sat, 12 Jan 2002 12:44:30 -0800."
             <Pine.LNX.4.40.0201121237110.1559-100000@blue1.dev.mcafeelabs.com> 
Date: Sun, 13 Jan 2002 17:59:33 +1100
Message-Id: <E16Pec9-0004jY-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.40.0201121237110.1559-100000@blue1.dev.mcafeelabs.com> y
ou write:
> > Aside from the cache utilization, this is not really "fair" -- the
> > problem is, the current design of load_balance (which is quite good)
> > just won't throw the tasks around so readily.  What could be done --
> > cleanly -- to make this better?
> 
> My opinion is: if it can be solved with no more than 20 lines of code
> let's do it, otherwise let's see what kind of catastrophe will happen by
> allowing such behavior.

Agree.  Anyone who really has 3 CPU hogs on a 2 CPU machine, *and*
never runs two more tasks to perturb the system, *and* notices that
one runs twice the speed of the other two, *and* cares about fairness
(ie. not RC5 etc), feel free to Email abuse to me.  Not Ingo, he has
real work to do 8)

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
