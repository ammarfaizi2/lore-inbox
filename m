Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbSLSTwf>; Thu, 19 Dec 2002 14:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbSLSTwf>; Thu, 19 Dec 2002 14:52:35 -0500
Received: from [81.2.122.30] ([81.2.122.30]:54024 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266069AbSLSTwd>;
	Thu, 19 Dec 2002 14:52:33 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212192012.gBJKCGsV002580@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: eli.carter@inet.com (Eli Carter)
Date: Thu, 19 Dec 2002 20:12:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E0222E4.5070104@inet.com> from "Eli Carter" at Dec 19, 2002 01:49:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC list trimmed]

> >  > >It could warn the user if they attach an un-decoded oops that their
> >  > >bug report isn't as useful as it could be, and if they mention a
> >  > >distribution kernel version, that it's not a tree that the developers
> >  > >will necessarily be familiar with
> >  > Perhaps a more generalized hook into bugzilla for 'validating' a bug 
> >  > report, then code specific validators for kernel work?
> > 
> > Its a nice idea, but I think it's a lot of effort to get it right,
> > when a human can look at the dump, realise its not decoded, and
> > send a request back in hardly any time at all.
> > I also don't trust things like this where if something goes wrong,
> > we could lose the bug report. People are also more likely to ping-pong
> > ,argue or "how do I..." with a human than they are with an automated robot.
> 
> Either way, it isn't kernel specific.... which is what I was trying to 
> address.  If it is valuable (which as you demonstrate is debatable,) 
> then it is valuable in bugzilla baseline, not just kernel-bugzilla.

What!?  Parsing an oops isn't kernel specific?  Version tracking over
multiple separate trees as diverse as 2.4 and 2.5 isn't pretty kernel
specific?  In any case, people could take the kernel bug database, and
genericify it, much more easily than somebody could tailor an existing
bug tracking application to the needs of the kernel, (which is
demonstrated by the fact that the developers are not getting Bugzilla
reports).

John.
