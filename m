Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTLBSVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTLBSVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:21:10 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:5863 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262817AbTLBSU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:20:57 -0500
Date: Tue, 2 Dec 2003 10:20:37 -0800
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@infradead.org>,
       Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
Message-ID: <20031202182037.GD17045@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Murthy Kambhampaty <murthy.kambhampaty@goeci.com>,
	'Marcelo Tosatti' <marcelo.tosatti@cyclades.com>,
	Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	Andrew Morton <akpm@osdl.org>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com> <20031202180251.GB17045@work.bitmover.com> <20031202181146.A27567@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202181146.A27567@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 06:11:46PM +0000, Christoph Hellwig wrote:
> On Tue, Dec 02, 2003 at 10:02:51AM -0800, Larry McVoy wrote:
> > Not your call, it's Marcelo's call.  And I and he have both suggested
> > that the way to get XFS in is to have someone with some clout in the file
> > system area agree that it is fine.  It's a perfectly reasonable request
> > and the longer it goes unanswered the less likely it is that XFS will get
> > integrated.  The fact that $XFS_USER wants it in is $XFS_USER's problem.
> > $VFS_MAINTAINER needs to say "hey, this looks good, what's the fuss about?"
> > and I suspect that Marcelo would be more interested.
> 
> I think you're missing the point.  The patches have been review many
> times, they've been posted to lkml many time with the request for comment
> and they've been merged into 2.5 in almost exactly that form. 

So what's wrong with asking $VFS_MAINTAINER to refresh Marcelo's memory
about that?

This is a process.  The process is supposed to screen out bad change.
Maybe XFS got into 2.5/2.6 inspite of the process rather than because
of it.  Maybe not.  Whatever the answer is, it's perfectly reasonable
for the maintainer of the 2.4 tree to want someone he trusts to step
forward and say "yeah, it's fine".  The fact that other VFS people
aren't jumping up and down and saying this should go in is troublesome.
If I were Marcelo the more the XFS people push without visible backing
from someone with a clear vision of the VFS layer the more I'd push back.

Don't get me wrong, I have not looked at or used XFS in years.  I have
no opinion about it at this point.  But I do have an opinion about process
and what is going on here, in my opinion, violates the Linux development
process.  Patches shouldn't go in just because you want them in, they go
in because the maintainer chooses to bless them or someone he trusts chooses
to bless them.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
