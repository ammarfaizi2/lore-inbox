Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbTAAWGp>; Wed, 1 Jan 2003 17:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbTAAWGp>; Wed, 1 Jan 2003 17:06:45 -0500
Received: from bitmover.com ([192.132.92.2]:8833 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264956AbTAAWGo>;
	Wed, 1 Jan 2003 17:06:44 -0500
Date: Wed, 1 Jan 2003 14:15:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@zip.com.au>, Dave Jones <davej@codemonkey.org.uk>,
       "Timothy D. Witham" <wookie@osdl.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Raw data from dedicated kernel bug database
Message-ID: <20030101221510.GG5607@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@zip.com.au>,
	Dave Jones <davej@codemonkey.org.uk>,
	"Timothy D. Witham" <wookie@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20030101194019.GZ5607@work.bitmover.com> <12310000.1041456646@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12310000.1041456646@titus>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This needs some more thought about how this would work, and exactly what
> we'd achieve by doing it. I think this is only going to work if it's a
> 2-way link, fully automated - I'm not keen on creating a situation
> with two disjoint sets of data. Having access to bug data at checkin
> time sounds useful to me, but not if that data doesn't get fed back up
> to the main database.

That's fine with me, I had assumed that is what you wanted.

> I'm not sure how other people feel about exporting stuff into bitkeeper
> type-licensed products ... if the non-BK people like Alan and Andrew, and
> the other people who've done lots of the work in the DB like Dave and 
> Randy,
> and the OSDL are OK with it, then I'd be willing to help. If they object,
> then probably not. 

This raises the question of who owns the data in the bug database
hosted by OSDL/IBM.  It seems questionable that you would even consider
restricting access to it.  Not even sourceforge does that, you can ftp
the CVS tarballs, they build them nightly.  If you are going to restrict
access to the data for political reasons I find it difficult to believe
that your database is going to gain any real traction.

We're not proposing to replace the OSDL bug database, we're proposing
to mirror it.  Exactly the same way as people mirror the BK trees into
patches, CVS, SVN, whatever.  Doesn't it seem strange to you that the
so-called non-free BK data is freely available but the free bug data
is not freely available?  Sounds pretty unfree to me but I'll leave
it to the community to decide whether they want the data locked up in
politically correct tools.

Some clarification is probably in order.  Does IBM or OSDL think they
have a copyright on the bug data?  I don't remember any discussion of
that and http://www.osdl.org/legal/ip_policy.html seems to suggest that
the bug data is not considered OSDL IP.  If you're not going to make
the data easily available it's not that hard to make a one way bridge
using wget but if you think that data is copyrighted I'm sure that I'm
not the only one who would like to know about that.  

A bug database that only IBM can really use, at the DB level, seems
like a pretty unopen and unfree thing.  If it's supposed to support the
open source developers shouldn't they all be able to get at the data?
In any way they find useful?  What if Red Hat wants access to the SQL
data because it is too big to manage through web forms?  Do they get it?
What about all the other companies?  If the position is that you get to
pick and choose who gets at the real data then I can promise you someone
else will start hosting a database with far more open rules.  I'll do 
it if noone else does.  The data should be freely accessible in the 
most reasonable form.  The GPL was very careful to not allow people to
pretend to conform by providing the source in anything but the most
useful form, it would seem that you should conform to those rules.
If you aren't going to, please tell us.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
