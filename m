Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264427AbTEJQJe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTEJQJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:09:33 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:56991 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264427AbTEJQJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:09:32 -0400
Date: Sat, 10 May 2003 09:22:07 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net and BK->CVS gateway
Message-ID: <20030510162207.GB24686@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030510140455.GA23475@work.bitmover.com> <20030510153416.GJ679@phunnypharm.org> <20030510160651.GA24686@work.bitmover.com> <20030510154352.GK679@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510154352.GK679@phunnypharm.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 11:43:52AM -0400, Ben Collins wrote:
> On Sat, May 10, 2003 at 09:06:51AM -0700, Larry McVoy wrote:
> > On Sat, May 10, 2003 at 11:34:16AM -0400, Ben Collins wrote:
> > > > This bad disk is the cause of the CVS gateway being screwed up, we should
> > > > have that back online tonight or tomorrow.  Sorry about the downtime.
> > > 
> > > Any idea if the new repo will be revision compatible with the old bkcvs?
> > > IOW, will checkouts have to be redone?
> > 
> > It should be 100% compatible, I build the CVS repo here and mirror it to
> > kernel.bkbits.net.  You should be all set.
> 
> Ah, so bkbits wasn't the primary source. Thanks again Larry.

I'm not sure that I follow that, but

    a) kernel.bkbits.net is fully backed up nightly so we wouldn't lose it
       there
    b) the CVS tree is generated on my desktop so we have a mirror of it
       there
    c) HPA mirrors the CVS tree to kernel.org so we have a third copy there
    d) Regenerating the the CVS tree from scratch will generate the same
       revs.

In other words, I think you're safe.  Famous last words, we'll now discover
that our friends in .cz have written the world's first BK virus and it 
corrupts the CVS tree.  Or something.  Regardless, we've taken steps to
make sure the CVS data is safe and restorable.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
