Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTIYRhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTIYRgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:36:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:4288 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261409AbTIYRbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:31:46 -0400
Date: Thu, 25 Sep 2003 10:30:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: andrea@kernel.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
In-Reply-To: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Sep 2003, Eric W. Biederman wrote:
> > 
> > However, that only explains why you don't use BitKeeper. And everybody
> > accepts that. When I started to use BK, I made it _very_ clear that
> > service for non-BK users will be _at_least_ as good as it ever was before
> > I started using BK.
> 
> And for the core kernel development this is true.  There are subprojects
> that are currently using BK that you can't even get the code without
> BK.  And the only reason they are using BK is they are attempting to
> following how Linux is managed.  So having the Linux kernel
> development use BK does have some down sides.

That's actually a pretty good point. I end up releasing "sparse" only as a
BK archive, simply because I'm too lazy to care and there aren't enough
people involved (and those that _are_ involved do actually end up
re-exporting it as non-BK, but that doesn't invalidate your point).

I don't know what the solution to it might be - but I don't think the 
reason they are using BK is that they are trying to emulate "the great 
kernel project". I know it wasn't for me - it's just that once you get 
used to BK, there's no way you'll ever go back to CVS willingly. 

> In addition there are some major gains to be had in standardizing on a
> distributed version control system that everyone can use, and
> unfortunately BK does not fill that position.

I don't disagree, but I don't see a real way to solve it. As Larry will 
tell you, the technical problems are bigger than you imagine.  So a BK 
killer won't be coming any time soon, methinks.

		Linus

