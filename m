Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVBHP65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVBHP65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVBHP65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:58:57 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:64670 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261550AbVBHP6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:58:47 -0500
Date: Tue, 8 Feb 2005 07:58:45 -0800
To: Stelian Pop <stelian@popies.net>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050208155845.GB14505@bitmover.com>
Mail-Followup-To: lm@bitmover.com, Stelian Pop <stelian@popies.net>,
	Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
References: <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr> <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet> <20050204201157.GN27707@bitmover.com> <20050204214015.GF5028@deep-space-9.dsnet> <20050204233153.GA28731@electric-eye.fr.zoreil.com> <20050205193848.GH5028@deep-space-9.dsnet> <20050205233841.GA20875@bitmover.com> <20050208154343.GH3537@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208154343.GH3537@crusoe.alcove-fr>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 04:43:44PM +0100, Stelian Pop wrote:
> On Sat, Feb 05, 2005 at 03:38:41PM -0800, Larry McVoy wrote:
> 
> > On Sat, Feb 05, 2005 at 08:38:48PM +0100, Stelian Pop wrote:
> > > > Nope: he digs the bk-commit mailing list archives.
> > > > 
> > > Interesting, I fergot about those commit mails, thanks for remining
> > > me.
> > > 
> > > I think those emails could provide the missing piece of the puzzle
> > > and we could generate the missing branches based on them. 
> > 
> > Does that mean you don't need anything from us?
> 
> If the kernel development was linear, it could be enough.
> 
> But with the branch'n'merge nature of BK it is hard if not impossible
> to extract enough data from those patches (I looked at the history
> of the last 2 months and I had several patch conflits due to a
> changeset being included on several branches which were merged later,
> several mails whose date was not the same as the changeset[*]).
> 
> What you could make available in the bkcvs export would be, for each
> changeset (both for the changesets and for the merged changesets),
> include three BKRevs:  the changeset's one, the changeset's parent one,
> and the changeset's merge parent one. 
> 
> That information could be used to reconstruct the entire tree,
> using either bk-commit-head (preferred) or bkbits, provided you
> put the BKRev: tag into the bk-commit-head posts too.
> 
> Technicaly speaking this should be very easy for you to implement.
> 
> What do you think ?

I think you are dreaming.  You've gone from wanting enough information
to supposedly debug your source tree to being explicit about wanting to
recreate the entire BK history in a different system.  The former is a
reasonable request, I suppose, but the latter is just a blatent request
for us to help debug and stress test a competing system.  

The answer is no, that's a clear violation of the license.  The deal is
that you get your data and you get *your* metadata.  Not the metadata
created by BitKeeper.  You get what bk export -tpatch gives you, the
diffs and the checkin comments.

I'm quite unhappy you keep asking for this, it forces me into the
position of being the bad guy.  You need to understand that we can
only take on so much risk and giving you BK for free was a huge amount
of risk.  Giving you BK, and the right to use it to create a different
system, and/or the right to use the BK metadata to create a different
system is way too much risk.  I'm sorry but we have to draw the line
somewhere.  Could you please just obey the license and stop this 
thread?  Is that so hard?  I don't come here every month and ask for
the GPL to be removed from some driver, that's essentially what you are
doing and I think pretty much everyone is sick of it.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
