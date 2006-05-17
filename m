Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWEQPKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWEQPKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWEQPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:10:47 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:47744 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750958AbWEQPKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:10:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 18 May 2006 01:10:21 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com> <200605172246.39444.kernel@kolivas.org> <1147873294.7596.13.camel@homer>
In-Reply-To: <1147873294.7596.13.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605180110.22270.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 23:41, Mike Galbraith wrote:
> On Wed, 2006-05-17 at 22:46 +1000, Con Kolivas wrote:
> > On Wednesday 17 May 2006 21:42, Mike Galbraith wrote:
> > > Fair?  I said interactivity wise.  But what the heck, if we're talking
> > > fairness, I can say the same thing about I/O bound tasks.  Heck, it's
> > > not fair to stop any task from reaching the top, and it's certainly not
> > > fair to let them have (for all practical purposes) all the cpu they
> > > want once they sleep enough.
> >
> > Toss out the I/O bound thing and we turn into a steaming dripping pile of
> > dog doo whenever anything does disk I/O. And damned if there aren't a lot
> > of pcs that have hard disks...
>
> (you should have tried my patch set)

Last one of yours I tried suffered this.

> > Spits and stutters are not starvation. Luckily it gets no worse with this
> > patch.
>
> Ok, I'll accept that.  Spits and stutters _are_ interactivity issues
> though yes?.  Knowing full well that plunking long sleepers into the
> queue you are plunking them into causes spits and stutters, why do you
> insist on doing so?

Because I know of no real world workload that thuds us into spits and 
stutters.

> Oh well, we're well on the way to agreeing to disagree again, so let's
> just get it over with.  I hereby agree to disagree.

Indeed.

-- 
-ck
