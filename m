Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262946AbSJFWqs>; Sun, 6 Oct 2002 18:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262947AbSJFWqr>; Sun, 6 Oct 2002 18:46:47 -0400
Received: from bitmover.com ([192.132.92.2]:10386 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262946AbSJFWqp>;
	Sun, 6 Oct 2002 18:46:45 -0400
Date: Sun, 6 Oct 2002 15:52:17 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Ulrich Drepper <drepper@redhat.com>, bcollins@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: BK MetaData License Problem?
Message-ID: <20021006155217.Y29486@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	"David S. Miller" <davem@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Ulrich Drepper <drepper@redhat.com>, bcollins@debian.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210061601040.7386-100000@localhost.localdomain> <Pine.LNX.4.44.0210061236400.10069-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210061236400.10069-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Oct 06, 2002 at 12:39:48PM -0700
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 12:39:48PM -0700, Linus Torvalds wrote:
> 
> [ Different issue, and slightly off-topic ]
> 
> On Sun, 6 Oct 2002, Ingo Molnar wrote:
> > 
> > until now the Linux kernel tree was distributed in a tarball that had a
> > nice COPYING file in a very prominent spot. With BK the situation is
> > different - and like i said in previous mails it's not BK's "fault", but
> > BK's "effect" - and it's a situation that needs to be remedied, right?
> 
> If this is a concern, it actually appears that BK has the capability to
> "enforce" a license, in that I coul dmake BK aware of the GPL and that
> would cause BK to pop up a window saying "Do you agree to this license"  
> before the first check-in by a person (the same way it asked you whether 
> you wanted to allow openlogging).

Yes, but you'd want to make sure that you stated that your license
extended to the BK metadata.  In our opinion, only you as the creator
of the repository gets to make that rule but you certainly can, that's
one of the reasons we put that clause in there.

By the way, the way this code works in bk-3.0 is that it saves a md5sum or
some sort of strong hash of the license in question and it will ask you
only once, assuming you are using the same home directory.  It will ask
you again if the license changes, that's what the hash is for.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
