Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTLIVsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTLIVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:48:36 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:62876 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261733AbTLIVsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:48:32 -0500
Date: Tue, 9 Dec 2003 13:48:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, cliff white <cliffw@osdl.org>,
       hannal@us.ibm.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Amy Graf <amy@work.bitmover.com>
Subject: Re: [Lse-tech] Re: Minutes from OSDL talk at LSE call today
Message-ID: <20031209214815.GA32633@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Larry McVoy <lm@bitmover.com>, cliff white <cliffw@osdl.org>,
	hannal@us.ibm.com, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Amy Graf <amy@work.bitmover.com>
References: <189470000.1070500829@w-hlinder> <20031204033535.GA2370@work.bitmover.com> <20031204134517.0c7a4ec4.cliffw@osdl.org> <20031204234454.GA15799@work.bitmover.com> <Pine.LNX.4.58.0312091625560.2313@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312091625560.2313@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 04:26:45PM -0500, Zwane Mwaikambo wrote:
> On Thu, 4 Dec 2003, Larry McVoy wrote:
> 
> > > The first is triggers. The Mozilla tinderbox is driven by triggers from
> > > CVS commits.  I believe that triggers are resevered for the commercial
> > > version of BK.
> >
> > That's not true.  Trigger support is identical in both versions.
> 
> Perhaps the FAQ may need updating then;
> 
> http://www.bitkeeper.com/Documentation.FAQS.Event.html

Indeed.

It's worth pointing out that triggers in open source trees are quite a bit
more dangerous than in controlled environment.  Carl-Daniel's boss made
quite a fuss over the fact that triggers are just programs that are run
and can be used to cause all sorts of problems if people were malicious.

I've toyed with the idea of disabling triggers in openlogging trees
because of this.  I'm neutral on the topic, it's not like triggers
are some huge money maker that we need to reserve for the commercial
version.  If the general feeling is that triggers are useful and people
will take responsibility for policing their own repos then we'll leave
them in.  On the other hand, if someone putting a nasty trigger into
your tree somehow becomes the fault of BitMover because we provided the
infrastructure then out they go in the next release.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
