Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWEQNkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWEQNkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWEQNkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:40:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:60039 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932288AbWEQNky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:40:54 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200605172246.39444.kernel@kolivas.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
	 <200605172025.22626.kernel@kolivas.org> <1147866161.7676.31.camel@homer>
	 <200605172246.39444.kernel@kolivas.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 15:41:34 +0200
Message-Id: <1147873294.7596.13.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 22:46 +1000, Con Kolivas wrote:
> On Wednesday 17 May 2006 21:42, Mike Galbraith wrote:
> > Fair?  I said interactivity wise.  But what the heck, if we're talking
> > fairness, I can say the same thing about I/O bound tasks.  Heck, it's
> > not fair to stop any task from reaching the top, and it's certainly not
> > fair to let them have (for all practical purposes) all the cpu they want
> > once they sleep enough.
> 
> Toss out the I/O bound thing and we turn into a steaming dripping pile of dog 
> doo whenever anything does disk I/O. And damned if there aren't a lot of pcs 
> that have hard disks...

(you should have tried my patch set)

> Spits and stutters are not starvation. Luckily it gets no worse with this 
> patch.

Ok, I'll accept that.  Spits and stutters _are_ interactivity issues
though yes?.  Knowing full well that plunking long sleepers into the
queue you are plunking them into causes spits and stutters, why do you
insist on doing so?

Oh well, we're well on the way to agreeing to disagree again, so let's
just get it over with.  I hereby agree to disagree.

	Cheers,

	-Mike

