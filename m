Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbTCGIS5>; Fri, 7 Mar 2003 03:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbTCGIS5>; Fri, 7 Mar 2003 03:18:57 -0500
Received: from pop.gmx.net ([213.165.65.60]:65296 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261435AbTCGIS4>;
	Fri, 7 Mar 2003 03:18:56 -0500
Message-Id: <5.2.0.9.2.20030307092747.00cf64b0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Mar 2003 09:34:02 +0100
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <rml@tech9.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303070913370.5173-100000@localhost.localdom
 ain>
References: <5.2.0.9.2.20030307085949.00ce8008@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:15 AM 3/7/2003 +0100, Ingo Molnar wrote:

>On Fri, 7 Mar 2003, Mike Galbraith wrote:
>
> > I can (could with your earlier patches anyway) eliminate the X stalls by
> > setting X junk to SCHED_FIFO.  I don't have ram to plug in, but I'm as
> > certain as I can be without actually doing so that it's not ram
> > shortage.
>
>okay. Can you eliminate the X stalls with setting X priority to -10 or so
>(or SCHED_FIFO - although SCHED_FIFO is much more dangerous). And how does
>interactivity under the same load look like with vanilla .64, as compared
>to .64+combo? First step is to ensure that the new changes did not
>actually hurt interactivity.

Oh, it's definitely _much_ better than .virgin.  I didn't mean to imply 
that damage was done ;-)  With .virgin, I have a _heck_ of a time grabbing 
the build window to kill it.  With combo, rodent jerkiness makes it hard to 
find/grab, and multisecond stalls are still there, but much improved.

         -Mike 

