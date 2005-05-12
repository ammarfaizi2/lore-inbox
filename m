Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVELULc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVELULc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVELUL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:11:28 -0400
Received: from waste.org ([216.27.176.166]:2965 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262074AbVELULV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:11:21 -0400
Date: Thu, 12 May 2005 13:11:16 -0700
From: Matt Mackall <mpm@selenic.com>
To: Petr Baudis <pasky@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4e vs git network pull
Message-ID: <20050512201116.GC5914@waste.org>
References: <20050512094406.GZ5914@waste.org> <20050512182340.GA324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512182340.GA324@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 08:23:41PM +0200, Petr Baudis wrote:
> Dear diary, on Thu, May 12, 2005 at 11:44:06AM CEST, I got a letter
> where Matt Mackall <mpm@selenic.com> told me that...
> > Mercurial is more than 10 times as bandwidth efficient and
> > considerably more I/O efficient. On the server side, rsync uses about
> > twice as much CPU time as the Mercurial server and has about 10 times
> > the I/O and pagecache footprint as well.
> > 
> > Mercurial is also much smarter than rsync at determining what
> > outstanding changesets exist. Here's an empty pull as a demonstration:
> > 
> >  $ time hg merge hg://selenic.com/linux-hg/
> >  retrieving changegroup
> > 
> >  real    0m0.363s
> >  user    0m0.083s
> >  sys     0m0.007s
> > 
> > That's a single http request and a one line response.
> 
> So, what about comparing it with something comparable, say git pull over
> HTTP? :-)

..because I get a headache every time I try to figure out how to use git? :-P

Seriously, have a pointer to how this works?

-- 
Mathematics is the supreme nostalgia of our time.
