Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264567AbTKNRnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTKNRnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:43:10 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:4004 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264567AbTKNRnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:43:05 -0500
Date: Fri, 14 Nov 2003 09:43:03 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031114174303.GC32466@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Walrond <andrew@walrond.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311141624.32108.andrew@walrond.org> <20031114164640.GA1618@work.bitmover.com> <200311141734.57122.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311141734.57122.andrew@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 05:34:57PM +0000, Andrew Walrond wrote:
> On Friday 14 Nov 2003 4:46 pm, Larry McVoy wrote:
> 
> > And you of course realize that you as a BK user could code up this system
> > with zero changes needed from us, right?
> 
> A client only solution that would talk to bkd? In a flash mate. But I don't 
> think you'd like that ;)

I think that might be harder than you think but you're right, we wouldn't be
too thrilled with that.  If for no other reason than the amount of cursing
you'd do as you figured out that our protocol is pretty ad-hoc and should be
rewritten.

> You I'm sure mean a server side wrapper which calls on bk to extract sources 
> and diffs and handles transport to the client. Not exactly hastle free and 
> encouraging people to host their o/s projects with bk, is it? Probably of 
> dubious legality as well (for scm developers).

You're already a BK user and I'd happily make it clear that it is OK for you
to do this work, we can have that discussion offline.  As for hassle free, 
I don't get that comment at all.  What you describe is exactly what we would
do anyway.  The only difference is that we could extend the bkd itself to
answer these requests and you couldn't without a lot of headaches.  But if 
you built this and wanted us to included it in the bkd, we'd look at doing 
that.

The points are
    a) I'm not at all convinced this is going to make anyone other than you
       happy.  They all want a BK replacement, not a tarball+patch replacement.
    b) If I'm wrong, there isn't anything preventing you from building this.

Convince me that (a) is all wrong and I'll see about building it.
So far, all the other people have made it clear they want all the
functionality of BK, the transport, the diffs, the history, etc.
Giving them a tarball/patch transport isn't like to make them happy and
I'll be in another one of these conversations after having wasted a pile
of engineering (which is not free, nor cheap).
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
