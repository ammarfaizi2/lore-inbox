Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWIUGsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWIUGsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWIUGsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:48:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750738AbWIUGse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:48:34 -0400
Date: Wed, 20 Sep 2006 23:48:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060920234828.a86e095a.akpm@osdl.org>
In-Reply-To: <45123307.8090809@garzik.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<45121382.1090403@garzik.org>
	<20060920220744.0427539d.akpm@osdl.org>
	<45123307.8090809@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 02:36:55 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > If you think that shortening the release cycle will cause people to be more
> > disciplined in their changes, to spend less time going berzerk and to spend
> > more time working with our users and testers on known bugs then I'm all
> > ears.
> 
> Honestly, I do think it would be positive.  It would shorten the 
> feedback loop, and get more changes out to testers.
> 
> It would also decrease the pressure of the 60+ trees trying to get 
> everything in, because they know the next release is 3-4 months away. 
> It would be _much_ easier to say "break the generic device stuff in 
> 2.6.20 not 2.6.19, please" if we knew 2.6.20 wasn't going to be a 2007 
> release.
> 

Well, it might be worth trying.  But there's a practical problem: how do we
get there when there's so much work pending?  If we skip some people's
trees then they'll get sore, and it's not obvious that it'll help much, as
the various trees are fairly unrelated (ie: parallelisable).

I guess the most practical way is to incrementally shorten the cycles.


<rerererepeating self>

I do think that any process change we make should send the signal "slow
down, be more careful, test and review it more carefully".  Or at least,
"try to make sure it compiles".

A compulsory Reviewed-by: would wedge things up nicely ;)
