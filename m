Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268270AbTCFSAu>; Thu, 6 Mar 2003 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268272AbTCFSAu>; Thu, 6 Mar 2003 13:00:50 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:51985 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S268270AbTCFSAt>; Thu, 6 Mar 2003 13:00:49 -0500
Date: Thu, 6 Mar 2003 18:11:20 +0000
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <20030306181120.GA31439@compsoc.man.ac.uk>
References: <20030306175533.GA29400@compsoc.man.ac.uk> <Pine.LNX.4.44.0303061003110.7720-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303061003110.7720-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18qzpx-0007vf-00*uDq4wjvu31A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 10:07:17AM -0800, Linus Torvalds wrote:

> > > But it was definitely there. 3-5 second _pauses_. Not slowdowns.
> > 
> > It's still there. Red Hat 8.0, 2.5.63. The  thing can pause for 15+
> 
> Oh, well. I didn't actually even verify that UNIX domain sockets will
> cause synchronous wakeups, so the patch may literally be doing nothing at
> all. You can try that theory out by just removing the test for 
> "in_interrupt()".

Sorry, I think I misunderstood what you meant in your comment above. I
haven't actually tried these patches yet, worry not.

regards,
john
