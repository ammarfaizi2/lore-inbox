Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTIYRWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTIYRVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:21:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38995 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261346AbTIYRRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:17:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: andrea@kernel.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
References: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Sep 2003 11:15:33 -0600
In-Reply-To: <Pine.LNX.4.44.0309231924540.27467-100000@home.osdl.org>
Message-ID: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 24 Sep 2003 andrea@kernel.org wrote:
> > 
> > It's because I grow up that I can actually better understand the deals
> > it's in my own (again speaking only for myself and not for anybody else)
> > interest to avoid.
> 
> You've claimed this now twice. 
> 
> However, that only explains why you don't use BitKeeper. And everybody
> accepts that. When I started to use BK, I made it _very_ clear that
> service for non-BK users will be _at_least_ as good as it ever was before
> I started using BK.

And for the core kernel development this is true.  There are subprojects
that are currently using BK that you can't even get the code without
BK.  And the only reason they are using BK is they are attempting to
following how Linux is managed.  So having the Linux kernel
development use BK does have some down sides.

In addition there are some major gains to be had in standardizing on a
distributed version control system that everyone can use, and
unfortunately BK does not fill that position.  So I think it is good
that there is enough general discontent it the air that people
continue to look for alternatives. 

The current situation with version control is painful.  CVS branches
poorly and is not distributed.  SVN is not distributed.  ARCH is
barely distributed and architecturally it makes distributed merging
hard.  BK requires open logging which makes it unsuitable for working
on prerelease hardware.  BK does not scale to the low end because
to use it successfully you need to make non-BK releases which is
an extra burden.  Unless I missed something big all of the BK->foo
gateways are specific to a few source trees.  And of course BK won't
let you hack on a replacement.

I don't think the flame wars should stop.  The current situation is
not half as good as it could be.  And discussion is needed to get us
there.  Even pure flames which accomplish nothing technical accomplish
something socially by reminding people that there is the potential to
do much better, and that the current situation is painful. 

It is clearly not a solution to simply drop BK, that is even more
painful.  To reduce the pain will take a combination of frustration,
time, talent, and a bit of luck that has not happened yet.

Eric
