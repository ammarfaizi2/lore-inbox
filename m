Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWBYDb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWBYDb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 22:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWBYDb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 22:31:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:36543 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932583AbWBYDb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 22:31:28 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
From: MIke Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <43FFCA30.9040008@yahoo.com.au>
References: <1140183903.14128.77.camel@homer>
	 <43FFAFE9.8000206@bigpond.net.au> <43FFC411.8010106@yahoo.com.au>
	 <200602251357.24665.kernel@kolivas.org>  <43FFCA30.9040008@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 04:35:07 +0100
Message-Id: <1140838507.8559.2.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 14:08 +1100, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Saturday 25 February 2006 13:42, Nick Piggin wrote:
> 
> >>I tried this angle years ago and it didn't work :)
> > 
> > 
> > Our "2.6 forever" policy is why we're stuck with this approach. We tried 
> > alternative implementations in -mm for a while but like all alternatives they 
> > need truckloads more testing to see if they provide a real advantage and 
> > don't cause any regressions. This made it impossible to seriously consider 
> > any alternatives.
> > 
> > I hacked on and pushed plugsched in an attempt to make it possible to work on 
> > an alternative implementation that would make the transition possible in a 
> > stable series. This was vetoed by Linus and Ingo and yourself for the reason 
> > it dilutes developer effort on the current scheduler. Which leaves us with 
> > only continually polishing what is already in place.
> > 
> 
> Yes. Hence my one-liner.
> 
> I still don't think plugsched is that good of an idea for mainline.
> Not too many people seem to be unhappy with the scheduler we have,
> so just because this little problem comes up I don't think that
> means it's time to give up and merge plugsched and 10 other policies.

Agreed.  The problem is small.  Annoying, because it refuses to go away,
but it is a small problem.

	-Mike

