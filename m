Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVETEcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVETEcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 00:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVETEcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 00:32:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45459 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261244AbVETEcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 00:32:31 -0400
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
From: Lee Revell <rlrevell@joe-job.com>
To: chen Shang <shangcs@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <855e4e460505192117155577e@mail.gmail.com>
References: <855e4e4605051909561f47351@mail.gmail.com>
	 <428D58E6.8050001@yahoo.com.au>  <855e4e460505192117155577e@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 May 2005 00:32:30 -0400
Message-Id: <1116563550.25721.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 21:17 -0700, chen Shang wrote:
> > Hi Chen,
> > With the added branch and the extra icache footprint, it isn't clear
> > that this would be a win.
> > 
> > Also, you didn't say where your statistics came from (what workload).
> > 
> > So you really need to start by demonstrating some increase on some workload.
> > 
> > Also, minor comments on the patch: please work against mm kernels,
> > please follow
> > kernel coding style, and don't change schedstat output format in the
> > same patch
> > (makes it easier for those with schedstat parsing tools).
> > 
> Hi Nick,
> 
> Thank you very much for your comments. This is the first time of my
> kernel hacking. I will reduce the lines of changes as much as
> possible. As regard to the statistics, there are just count, ie, the
> total number of priority-recalculations vs. the number of priority
> changed from the former recalculation.

A kernel profile (check list archives for oprofile) would easily
demonstrate any performance gain.  On my system the residency of
schedule() is around 1% so this will be easy to spot.

Lee

