Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283892AbRLACOr>; Fri, 30 Nov 2001 21:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283893AbRLACO0>; Fri, 30 Nov 2001 21:14:26 -0500
Received: from bitmover.com ([192.132.92.2]:9404 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S283892AbRLACOQ>;
	Fri, 30 Nov 2001 21:14:16 -0500
Date: Fri, 30 Nov 2001 18:14:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011130181415.C19152@work.bitmover.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>, Andrew Morton <akpm@zip.com.au>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Henning Schmiedehausen <hps@intermeta.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011130171510.B19152@work.bitmover.com> <Pine.LNX.4.40.0111301810400.1600-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.40.0111301810400.1600-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Fri, Nov 30, 2001 at 06:17:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:17:43PM -0800, Davide Libenzi wrote:
> > It's not.  I never said that we should solve the same problems the same
> > way that Sun did, go back and read the posting.
> 
> This is your quote Larry :
> 
> <>
> If you want to try and make Linux people work like Sun people, I think
> that's going to be tough.  First of all, Sun has a pretty small kernel
> group, they work closely with each other, and they are full time,
> highly paid, professionals working with a culture that is intolerant of
> anything but the best.  It's a cool place to be, to learn, but I think
> it is virtually impossible to replicate in a distributed team, with way
> more people, who are not paid the same or working in the same way.
> <>

I'm sorry, I'm lost.  You are quoting what I said, that's what I said
said, so what's the point?  yes, for the third time, that's what I said
and that's what I meant.

> So, if these guys are smart, work hard and are professionals, why did they
> take bad design decisions ?
> Why didn't they implemented different solutions like, let's say "multiple
> independent OSs running on clusters of 4 CPUs" ?

Because, just like the prevailing wisdom in the Linux hackers, they thought
it would be relatively straightforward to get SMP to work.  They started at
2, went to 4, etc., etc.  Noone ever asked them to go from 1 to 100 in one
shot.  It was always incremental.

I recently talked over the approach I have in mind with the architect of
Sun's multithreaded kernel, the guy who started and guided that effort at
Sun.  He agreed that if he had thought of my approach he would have done
it that way.  We both agreed it was unlikely that anyone would think of
that approach without first having done it the hard way.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
