Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbTF1AUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTF1ATl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:19:41 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:53448 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264982AbTF1ASX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:18:23 -0400
Date: Fri, 27 Jun 2003 17:32:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: Andrew Morton <akpm@digeo.com>, davidel@xmailserver.org, davem@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030628003218.GE18676@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
	davidel@xmailserver.org, davem@redhat.com, mbligh@aracnet.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
References: <20030626.224739.88478624.davem@redhat.com> <21740000.1056724453@[10.10.2.4]> <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com> <20030627.143738.41641928.davem@redhat.com> <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com> <20030627213153.GR501@phunnypharm.org> <20030627162527.714091ce.akpm@digeo.com> <20030627223024.GT501@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627223024.GT501@phunnypharm.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 06:30:24PM -0400, Ben Collins wrote:
> > - The bugs which are affecting people the most get reported the most.
> 
> Not to mention the "breeding" affect. A bug that many people have seen
> only once, but can never pinpoint because they can't reproduce it. One
> of those people reports the problem to the mailing list, and suddenly
> half a dozen respond with "me too, but here's some extra info that I
> saw". You can't get that with a bug database.

I can't believe that I'm dumb enough to ask this given the BK experience.
We've built BugDB technology and we're quite interested in trying to make
a system that works for engineers as well as managers.  All that DB crud
is great for managers who want metrics but engineers want an easy way to
deal with the bugs.  For example, an email interface.  Our bugdb already
has that, the emails include a URL so you can go look at that and do stuff
to it but you can also reply to the email and do everything through the 
email interface.  An NNTP interface is in the works.

Is there any interest in having us mirror the bugzilla DB and work on
making an interface that works for people with different needs?  I had
already assumed that I'd get hissed out of the room if I proposed this
so feel free to say no if that's what you want.

On the other hand, this one is maybe easier to swallow than BK because
the interfaces are standard protocols (SMTP, HTTP, NNTP and maybe IMAP or
POP some day) so you don't have to put your fingers on any evil BitMover
software to get at it.

If you do want us to look at this then I'd suggest that you elect someone
to come up with a proposal that the community finds acceptable, i.e., if
you use it then we have to do some stuff like
    - free access for everyone
    - data exported in CSV form so other people can get at it
    - ???

If you say you want it then we have to figure out some way that
the community is happy up front.  I'd suggest that Alan define the
relationship, he has credibility, he doesn't like BK, he's smart enough
to not get talked into something unreasonable, etc.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
