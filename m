Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S263456AbUJ2S04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbUJ2S04 (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 29 Oct 2004 14:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbUJ2SXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:23:01 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:9386 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263466AbUJ2SVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:21:00 -0400
Date: Fri, 29 Oct 2004 11:20:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ram?n Rey Vicente <ramon.rey@hispalinux.es>, Larry McVoy <lm@bitmover.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        James Bruce <bruce@andrew.cmu.edu>, Linus Torvalds <torvalds@osdl.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Andrea Arcangeli <andrea@novell.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
Message-ID: <20041029182009.GB5318@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ram?n Rey Vicente <ramon.rey@hispalinux.es>,
	Larry McVoy <lm@bitmover.com>,
	Xavier Bestel <xavier.bestel@free.fr>,
	James Bruce <bruce@andrew.cmu.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andrea Arcangeli <andrea@novell.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com> <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com> <41827B89.4070809@hispalinux.es> <20041029173642.GA5318@work.bitmover.com> <20041029180625.GB12780@ns.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029180625.GB12780@ns.snowman.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:06:25PM -0400, Stephen Frost wrote:
> * Larry McVoy (lm@bitmover.com) wrote:
> > On Fri, Oct 29, 2004 at 07:19:05PM +0200, Ram?n Rey Vicente wrote:
> > > In Spain, reverse engineering is allowed for interoperability.
> [...]
> > Given that BK isn't hiding anything, the "reverse engineering for
> > interoperability" does not apply.  Hello?  Anyone listening?  Didn't
> > think so.  Sigh.
> 
> (Not actually following the conversation, but this caught my eye)
> 
> If I had a license to run BK and was using it and later that license was
> revoked such that I could no longer run BK, is there sufficient
> documentation provided that I could write code to read my
> data/metadata/etc off of the disk w/o using BK?

We can't reach out and revoke your license arbitrarily.  Even if we put
into the license that we could do that, it's not enforceable.  That's more
or less blackmail "gimme all your money or I'll revoke your license".

While the BK haters love to spread FUD about us having that ability
that's just nonsense, it would never stand up in any court.

So it's a moot point.  We aren't going to revoke your license, you get
to revoke your license by violating the terms.

As for the on disk format, sure, you can dig it out.  It's loosely
derived from the SCCS format, we used to be compatible with SCCS but we
dropped that because it was too restrictive.  But you could go get CSSC
and tweak it enough to get your data out.

If you are worried about this, the easiest way to make sure that you are
safe is park a clone of your tree on bkbits.net.  There is no license
required to get at the data over the web and all the data and metadata
is right there.  If you are worried that we'd drop bkbits.net you could
hire a neutral third party, get them to run their own BK server, park
your data there, and you have the same thing.

We don't do lockins.  Period.  You can get out of BK if that's what you
want to do.  This is a good time to note that we have a >99% renewal 
rate w/ our commercial customers.  But the ones that wanted to get
out, I think there have been 2 or 3, got all their data out and all 
their history out.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
