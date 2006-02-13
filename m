Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWBMG37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWBMG37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 01:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWBMG37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 01:29:59 -0500
Received: from mail.gmx.net ([213.165.64.21]:65239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750894AbWBMG37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 01:29:59 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200602131708.52342.kernel@kolivas.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131637.43335.kernel@kolivas.org> <1139810224.7935.9.camel@homer>
	 <200602131708.52342.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 07:35:38 +0100
Message-Id: <1139812538.7744.8.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 17:08 +1100, Con Kolivas wrote:
> On Monday 13 February 2006 16:57, MIke Galbraith wrote:
> > On Mon, 2006-02-13 at 16:37 +1100, Con Kolivas wrote:
> > > On Monday 13 February 2006 16:32, MIke Galbraith wrote:
> > > > On Mon, 2006-02-13 at 16:05 +1100, Con Kolivas wrote:
> > > > > On Monday 13 February 2006 15:59, MIke Galbraith wrote:
> > > > > > Now, let's see if we can get your problem fixed with something that
> > > > > > can possibly go into 2.6.16 as a bugfix.  Can you please try the
> > > > > > below?
> > > > >
> > > > > These sorts of changes definitely need to pass through -mm first...
> > > > > and don't forget -mm looks quite different to mainline.
> > > >
> > > > I'll leave that up to Ingo of course, and certainly have no problem
> > > > with them burning in mm.  However, I must say that I personally
> > > > classify these two changes as being trivial and obviously correct
> > > > enough to be included in 2.6.16.
> > >
> > > This part I agree with:
> > > -               } else
> > > -                       requeue_task(next, array);
> > > +               }
> > >
> > > The rest changes behaviour; it's not a "bug" so needs testing, should be
> > > a separate patch from this part, and modified to suit -mm.
> >
> > Well, both change behavior, and I heartily disagree.  
> 
> The first change was the previous behaviour for some time. Your latter change 
> while it makes sense has never been in the kernel. Either way I don't 
> disagree with your reasoning but most things that change behaviour should go 
> through -mm. The first as I said was the behaviour in mainline for some time 
> till my silly requeue change.

Ok, we're basically in agreement on these changes, it's just a matter of
when.  As maintainer, Ingo has to weigh the benefit, danger, etc etc.

	-Mike

