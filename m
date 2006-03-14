Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWCNM6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWCNM6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWCNM6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:58:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:58019 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751921AbWCNM6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:58:43 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200603142347.19927.kernel@kolivas.org>
References: <1142329861.9710.16.camel@homer>
	 <200603142329.31281.kernel@kolivas.org> <1142340034.11303.20.camel@homer>
	 <200603142347.19927.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 13:59:55 +0100
Message-Id: <1142341195.11303.31.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 23:47 +1100, Con Kolivas wrote:
> On Tuesday 14 March 2006 23:40, Mike Galbraith wrote:
> > On Tue, 2006-03-14 at 23:29 +1100, Con Kolivas wrote:
> > > On Tuesday 14 March 2006 23:24, Mike Galbraith wrote:
> > > > Don't forget, every one of the exploits I test with were posted by
> > > > people who were experiencing scheduler problems in real life.  Try to
> > > > use your box while running those exploits, and then tell me that you
> > > > agree with interbench's assessment.
> > >
> > > Ok you feel interbench is an irrelevant benchmark for your test case and
> > > I'm not going to bother arguing since it doesn't claim to test every
> > > single situation.
> >
> > Yes.  Interbench's opinion is irrelevant to me wrt this problem.
> 
> Ok one last try to explain where I'm coming from and then I'll give up ...
> 
> Interbench's opinion is not irrelevant to me on this because it may help your 
> nfs case but interbench does tell me what happens with X, video, audio etc. 
> It's precisely because it quantifies those other scenarios that I care.

Sure, and I'm not trying to knock interbench.  I used it as yet another
test to my changes as I made them.  I just disagree with it's opinion.

(I didn't misunderstand the code either, I observed it in action,
interpreted the difference between reaction to stock, and reaction to my
changes, and then went straight to the long sleep logic and [tweak] made
the numbers identical to guarantee that I understood)

	-Mike

