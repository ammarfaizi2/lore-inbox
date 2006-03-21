Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWCUOes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWCUOes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWCUOer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:34:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:65418 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030410AbWCUOeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:34:46 -0500
Date: Tue, 21 Mar 2006 15:32:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Willy Tarreau <willy@w.ods.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321143240.GA310@elte.hu>
References: <1142592375.7895.43.camel@homer> <200603220119.50331.kernel@kolivas.org> <1142951339.7807.99.camel@homer> <200603220130.34424.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220130.34424.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> On Wednesday 22 March 2006 01:28, Mike Galbraith wrote:
> > On Wed, 2006-03-22 at 01:19 +1100, Con Kolivas wrote:
> > > What you're fixing with unfairness is worth pursuing. The 'ls' issue just
> > > blows my mind though for reasons I've just said. Where are the magic
> > > cycles going when nothing else is running that make it take ten times
> > > longer?
> >
> > What I was talking about when I mentioned scrolling was rendering.
> 
> I'm talking about the long standing report that 'ls' takes 10 times 
> longer on 2.6 90% of the time you run it, and doing 'ls | cat' makes 
> it run as fast as 2.4. This is what Willy has been fighting with.

ah. That's i think a gnome-terminal artifact - it does some really 
stupid dynamic things while rendering, it 'skips' certain portions of 
rendering, depending on the speed of scrolling. Gnome 2.14 ought to have 
that fixed i think.

	Ingo
