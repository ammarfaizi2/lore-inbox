Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTIYT3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTIYT3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:29:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10580 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261853AbTIYT3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:29:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: andrea@kernel.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
References: <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Sep 2003 13:23:40 -0600
In-Reply-To: <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
Message-ID: <m1brt8iseb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On 25 Sep 2003, Eric W. Biederman wrote:
> > > 
> > > However, that only explains why you don't use BitKeeper. And everybody
> > > accepts that. When I started to use BK, I made it _very_ clear that
> > > service for non-BK users will be _at_least_ as good as it ever was before
> > > I started using BK.
> > 
> > And for the core kernel development this is true.  There are subprojects
> > that are currently using BK that you can't even get the code without
> > BK.  And the only reason they are using BK is they are attempting to
> > following how Linux is managed.  So having the Linux kernel
> > development use BK does have some down sides.
> 
> That's actually a pretty good point. I end up releasing "sparse" only as a
> BK archive, simply because I'm too lazy to care and there aren't enough
> people involved (and those that _are_ involved do actually end up
> re-exporting it as non-BK, but that doesn't invalidate your point).
>
> I don't know what the solution to it might be - but I don't think the 
> reason they are using BK is that they are trying to emulate "the great 
> kernel project". I know it wasn't for me - it's just that once you get 
> used to BK, there's no way you'll ever go back to CVS willingly. 

I expressed it badly.  But the kernel using BK both introduces people
to BK, and it validates BK as a useful tool.  Especially as the kernel
tends to embody many of the best practices in the community.

The only sure piece of the solution I have it to keep saying there is
a problem, and to raise the level of the conversation to it's
technical merits.

> > In addition there are some major gains to be had in standardizing on a
> > distributed version control system that everyone can use, and
> > unfortunately BK does not fill that position.
> 
> I don't disagree, but I don't see a real way to solve it. As Larry will 
> tell you, the technical problems are bigger than you imagine.  So a BK 
> killer won't be coming any time soon, methinks.

It does not have to start as a BK killer.  Just something that is
architecturally sound, once all of the basics work adding the polish
can be done by the community.

I am pretty certain I could write up something that got the core of
the repository right in a month or two.  The hard part is avoiding
mistakes in repository architecture.  CVS has never recovered, despite
a lot of good work put into it.  For the few blunders Larry has made
he has worked very hard to correct things.

But of course if I do something I won't be targeting the kernel
developers directly.  I will do it to solve my problems on the
projects I lead.  Which may not map well to kernel development.  But
doing anything else would be an academic exercise because I could
not maintain it.  

Eric
