Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290113AbSBKSwT>; Mon, 11 Feb 2002 13:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290075AbSBKSwJ>; Mon, 11 Feb 2002 13:52:09 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:53682 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S290118AbSBKSv5>; Mon, 11 Feb 2002 13:51:57 -0500
Date: Mon, 11 Feb 2002 12:51:35 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200202111851.MAA93949@tomcat.admin.navo.hpc.mil>
To: pavel@suse.cz, Rob Landley <landley@trommello.org>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Cc: Andreas Dilger <adilger@turbolabs.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Hi!
> 
> > > I don't see why everyone who is using BK is expecting Linus to do a pull.
> > > In the non-BK case, wasn't it always a "push" model, and Linus would not
> > > "pull" from URLs and such?
> > 
> > I'm all for it.  I think it's a good thing.
> > 
> > In the absence of significant latency issues, pull scales better than push.  
> > It always has.  Push is better in low bandwidth situations with lots of idle 
> > capacity, but it breaks down when the system approaches saturation.
> > 
> > Pull data is naturally supplied when you're ready for it (assuming no 
> > significant latency to access it).  Push either scrolls by unread or piles up 
> > in your inbox and gets buried until it goes stale.  Web pages work on a pull 
> > model, "push" was an internet fad a few years ago that failed for a reason.  
> > When push models hit saturation it breaks down and you wind up with the old 
> > "I love lucy" episode with the chocolate factory.  Back in the days where 
> 
> What's "i love lucy" episode?

It is an old TV show showing a queue overflow - The chocolate machine was
producing candy faster than the personnell could handle and dispose of it.

I think it was being boxed - the skit starts out with the machine on slow,
and a brief training session by a supervisor. The supervisor verifies that
the candy was handled properly at the slow speed. Then she leaves. The
machine makes a sudden jump in production, close to the limit of the
personnel (Lucy and Vivian) who just manage to keep up.

Then the machine gradually increases the production rate. At first, they
toss exess in to another box, then start trying to eat it, then dropping
on the floor .... until the supervisor returns to turn off the maching.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
