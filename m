Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWDGLJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWDGLJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 07:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWDGLJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 07:09:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:55719 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964775AbWDGLJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 07:09:16 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       pwil3058@bigpond.net.au
In-Reply-To: <200604072100.17900.kernel@kolivas.org>
References: <1144402690.7857.31.camel@homer> <20060407095247.GA2788@elte.hu>
	 <1144407438.8870.5.camel@homer>  <200604072100.17900.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 13:09:45 +0200
Message-Id: <1144408185.8993.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 21:00 +1000, Con Kolivas wrote:
> On Friday 07 April 2006 20:57, Mike Galbraith wrote:
> > On Fri, 2006-04-07 at 11:52 +0200, Ingo Molnar wrote:
> > > i think we should try Mike's patches after smpnice got ironed out. The
> > > extreme-starvation cases should be handled more or less correctly now by
> > > the minimal set of changes from Mike that are upstream (knock on wood),
> > > the singing-dancing add-ons can probably wait a bit and smpnice clearly
> > > has priority.
> >
> > (I'm still trying to find ways to do less singing and dancing.)
> >
> > This patch you may notice wasn't against an mm kernel.  I was more or
> > less separating this one from the others, because I consider this
> > problem to be very severe.  IMHO, this or something like it needs to get
> > upstream soon.
> 
> Which is a fine observation but your code is changing every 2nd day. Which is 
> also fine because code needs to evolve. However that's not really the way we 
> push stuff upstream...

No, it's not changing much at all, though I wish it would.  WRT this
patch, you'll note that the mail subject contains the magical
incantation [rfc] (didn't work).  I care not one whit whether _my_ patch
gets sent upstream or to the bit bucket.  I care only that the problem
gets solved, and preferably sooner than later.

	-Mike

