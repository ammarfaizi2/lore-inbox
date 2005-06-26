Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVFZRCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVFZRCQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFZRCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:02:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57219 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261436AbVFZRCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:02:11 -0400
Date: Sun, 26 Jun 2005 18:02:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Masover <ninja@slaphack.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050626170203.GC18942@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Masover <ninja@slaphack.com>, Jeff Garzik <jgarzik@pobox.com>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com> <42B8F4BC.5060100@pobox.com> <42B92AA1.3010107@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B92AA1.3010107@slaphack.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 04:08:49AM -0500, David Masover wrote:
> I've been reading a bit of history, and the reason Linux got so popular
> in the first place was the tendency to include stuff that worked and
> provided a feature people wanted, even if it was ugly.  The philosophy
> would be:  choose a good implementation over an ugly one, but choose an
> ugly one over nothing at all.

And things change over time.  Back in those days the linux codebase was
small and it was easy to change things all over the place.  These times
our codebase is huge, and people that know enough parts of the kernel to
do big changes are overloaded with work.  Thus we have to set our
acceptance criteria a lot higher now - else we'd be totally lost with
the current size of the project already.

> > We have to maintain said ugly code for decades.  Maintainability is a
> > big deal when you deal with the timeframes we deal with.
> 
> Maintainability is like optimization.  The maintainability of a
> non-working program is irrelevant.  You'd be right if we already had
> plugins-in-the-VFS.  We don't.  The most maintainable solution for
> plugins-in-the-FS that actually exists is Reiser4, exactly as it is now
> - -- because it is the _only_ one that actually exists right now.

We do have plugins in the VFS, every filesystem is a set of a few of them
and some gluecode.

<skipping a lot stuff>

David and Hans, I've read through my backlog a lot now, and I must say
it's pretty pointless - you're discussing lots of highlevel what if and
don't actually care about something as boring as actual technical details.

Hans has lots of very skillfull technical people like zam and vs, and maybe
he should give them some freedom to sort out technical issues for a basic
reiser4 merge, and one that is done we can turn back to discussion of
advanced features and their implementation, hopefully with a few more
arguments on both sides and a real technical discussion.
