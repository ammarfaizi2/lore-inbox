Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTGAIp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 04:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTGAIp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 04:45:26 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:32271 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261265AbTGAIpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 04:45:25 -0400
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200307010754.35804.kernel@kolivas.org>
References: <200307010029.19423.kernel@kolivas.org>
	 <1057008095.598.1.camel@teapot.felipe-alfaro.com>
	 <200307010754.35804.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1057049984.587.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 01 Jul 2003 10:59:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 23:54, Con Kolivas wrote:
> On Tue, 1 Jul 2003 07:21, Felipe Alfaro Solana wrote:
> > On Mon, 2003-06-30 at 16:29, Con Kolivas wrote:
> > > Buried deep in another mail thread was the latest implementation of my
> > > O1int patch so I've brought it to the surface to make it clear this one
> > > is significantly different from past iterations.
> > >
> > > Summary:
> > > Decreases audio skipping with loads.
> > > Smooths out X performance with load.
> > >
> > > I've also made it available here:
> > > http://kernel.kolivas.org/2.5
> > >
> > > along with a patch called granularity that is a modified version of
> > > Ingo's timeslice_granularity patch. It is no longer necessary and may
> > > slightly decrease throughput in non-desktop settings but put on top of my
> > > O1int patch makes X even smoother.
> >
> > Damn! XMMS audio skips are back... To reproduce them, I start up my KDE
> > session, launch Konqueror, launch XMMS and make it play sound. Then, I
> > drag the Konqueror window like crazy over my desktop and XMMS skips,
> > altough not too much.
> >
> > The previous version of this patch is the one that worked best for me.
> 
> A little bit more of this.. a little bit less of that... Use 100 or 1000Hz for 
> this one? And did you notice any change in X?

I'm using 1000HZ. With respect to X, I haven't noticed any major
difference. Should I? I haven't tested it under very heavy loads, but
under normal workloads, it behaves a little better than its predecesors.

