Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbSJGGCU>; Mon, 7 Oct 2002 02:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSJGGCU>; Mon, 7 Oct 2002 02:02:20 -0400
Received: from bitmover.com ([192.132.92.2]:10392 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262883AbSJGGCT>;
	Mon, 7 Oct 2002 02:02:19 -0400
Date: Sun, 6 Oct 2002 23:07:54 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ulrich Drepper <drepper@redhat.com>, bcollins@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: BK MetaData License Problem?
Message-ID: <20021006230754.A9976@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ingo Molnar <mingo@elte.hu>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Russell King <rmk@arm.linux.org.uk>,
	"David S. Miller" <davem@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ulrich Drepper <drepper@redhat.com>, bcollins@debian.org,
	linux-kernel@vger.kernel.org
References: <20021006155217.Y29486@work.bitmover.com> <Pine.LNX.4.44.0210070758490.2557-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210070758490.2557-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Oct 07, 2002 at 08:08:40AM +0200
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> so in theory it's perfectly possible to 'link' the data's and metadata's
> license via BKL.txt - after all you already added licensing rules for the
> metadata into the BK license, for the purposes of OpenLogging.

It is our position and we believe that it is supported by the BKL license
that it is the right and authority of the original creator of the project
to enforce any license they so wish.  If Linus wants to make it clear
that if you make changesets using BK that the checkin comments are also
GPLed, that's his right.  That's our intent and that's what we believe
the license says.  See clause 3(b).

> > By the way, the way this code works in bk-3.0 is that it saves a md5sum
> > or some sort of strong hash of the license in question and it will ask
> > you only once, assuming you are using the same home directory.  It will
> > ask you again if the license changes, that's what the hash is for.
> 
> this sounds really nice and unintrusive, how does one enable it? Is this
> BK_FORCE, or something else? I cannot find any reference to this in 'bk
> helptool'.

That's because we haven't shipped bk-3.0 yet, we expect to do so this
week.  The license clause has been there for a long time, these rules are
part of the BKL.  However, we only recently added the "click to accept"
stuff for the extra license and the lawyers tell us that is required to
be enforceable.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
