Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVDJVwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVDJVwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 17:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVDJVwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 17:52:14 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:2535 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261614AbVDJVwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 17:52:09 -0400
Date: Sun, 10 Apr 2005 14:42:53 -0400
From: Christopher Li <lkml@chrisli.org>
To: Paul Jackson <pj@engr.sgi.com>
Cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050410184253.GF13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410065307.GC13853@64m.dyndns.org> <20050410122352.19890f6d.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410122352.19890f6d.pj@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I totally agree that odds is really really small.
That is why it is not worthy to handle the case. People hit that
can just add a new line or some thing to avoid it, if
it happen after all.

It is the little peace of mind to know for sure that did
not happen. I am just paranoid. 

Chris

On Sun, Apr 10, 2005 at 12:23:52PM -0700, Paul Jackson wrote:
> > Some thing like the following patch, may be turn off able.
> 
> Take out an old envelope and compute on it the odds of this
> happening.
> 
> Say we have 10,000 kernel hackers, each producing one
> new file every minute, for 100 hours a week.  And we've
> cloned a small army of Andrew Morton's to integrate
> the resulting tsunamai of patches.  And Linus is well
> cared for in the state funny farm.
> 
> What is the probability that this check will fire even
> once, between now and 10 billion years from now, when
> the Sun has become a red giant destroying all life on
> planet Earth?
> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
