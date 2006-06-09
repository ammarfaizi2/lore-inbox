Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbWFIVpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbWFIVpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWFIVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:45:08 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:19845
	"EHLO sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1030527AbWFIVpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:45:06 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, Gerrit Huizenga <gh@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com>
	<4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org>
	<4489EAFE.6090303@garzik.org>
From: Michael Poole <mdpoole@troilus.org>
Date: 09 Jun 2006 17:45:05 -0400
In-Reply-To: <4489EAFE.6090303@garzik.org>
Message-ID: <87ac8matr2.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:

> Theodore Tso wrote:
> > And I'd also dispute with your "weren't really suited for the original
> > ext2-style design" comment.  Ext2/3 was always designed to be
> > extensible from the start, and we've successfully added features quite
> > successfully for quite a while.
> 
> Although not the only disk format change, extents are a pretty big
> one. Will this be the last major on-disk format change?

You keep making "straw that broke the camel's back" type arguments
without saying why this particular straw (rather than the other
compatibility-breaking features that are already in ext3) is the one
that must not be allowed.  Is it a matter of taste, or is there some
objective threshold that extents cross?

> >> Rather than taking another decade to slowly fix ext2 design
> >> decisions, why not move the process along a bit more rapidly?
> >> Release early, release often...
> > I don't think it will be another decade, but yes, regardless of
> > whether we do a code fork or not, it will take time.  Basically, you
> > and the ext2 developers have a disagreement about whether or not a
> > code fork will actually move the process along more quickly or not.
> > Either way, we will be releasing early and often, so people can test
> > it out and comment on it.  Releasing patches to LKML is just the first
> > step in this process.
> 
> I don't see how a larger filesystem codebase could possibly move more
> quickly than a smaller codebase.  You'd have twice as many code paths
> to worry about.

This is also the case when you cut and paste an entire filesystem's
source code, as has been mentioned several times in this thread.

Michael Poole
