Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVCCREO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVCCREO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVCCRDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:03:38 -0500
Received: from thunk.org ([69.25.196.29]:7347 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262253AbVCCRAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:00:50 -0500
Date: Thu, 3 Mar 2005 12:00:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303170037.GA10574@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com> <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <20050303164353.GE10761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303164353.GE10761@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 08:43:53AM -0800, Greg KH wrote:
> On Thu, Mar 03, 2005 at 08:23:39AM -0800, Linus Torvalds wrote:
> > 
> > So what's the problem with this approach? It would seem to make everybody
> > happy: it would reduce my load, it would give people the alternate "2.6.x
> > base kernel plus fixes only" parallell track, and it would _not_ have the 
> > testability issue (because I think a lot of people would be happy to test 
> > that tree, and if it was always based on the last 2.6.x release, there 
> > would be no issues.
> > 
> > Anybody?
> 
> Well, I'm one person who has said that this would be a very tough
> problem to solve.  And hey, I like tough problems, so I'll volunteer to
> start this.  If I burn out, I'll take the responsibility of finding
> someone else to take it over.

Ooh, a sucker!

Seriously, I think Linus's plan makes a lot of sense, as a scalable
way of maintaining a 2.6.x.y release strategy.

The other thing which would probably be useful to maintain would be a
list of "known regressions" yet to be fixed in 2.6.x.y, and to address
the somewhat disturbing assertions that sometimes regressions "light
up bugzilla" at distro's like Fedora, but don't get reflected back up
to LKML.  Maybe we could recruit some other sucker to maintain such a
list?  It wouldn't be a complete bug list, and it can be discarded
every time a new 2.6.x is released, which means it should be more
manageable than some previous attempts to maintain LK bug lists.

						- Ted
