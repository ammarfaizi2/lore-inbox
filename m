Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUBOXFW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUBOXFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:05:22 -0500
Received: from mail.riseup.net ([216.162.217.191]:12179 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S265242AbUBOXFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:05:08 -0500
Date: Sun, 15 Feb 2004 17:05:01 -0600
From: Micah Anderson <micah@riseup.net>
To: "Matt H." <lkml@lpbproductions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stable/vanilla+(O)1
Message-ID: <20040215230501.GQ14140@riseup.net>
References: <20040215220454.GL14140@riseup.net> <200402151526.31560.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402151526.31560.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I appreciate people pointing out alternatives, however I was asking
for the stock/vanilla kernel patch (although I mistyped stable below).

micah


On Sun, 15 Feb 2004, Matt H. wrote:

> It's recommened you use 2.6.x if you want the O1 scheduler and newer things. 
> You can also use the -aa patchset for 2.4 , that contains the O1 Scheduler 
> and some vm tweaks.
> 
> 
> Matt H.
> 
> 
> On Sunday 15 February 2004 3:04 pm, Micah Anderson wrote:
> > Is there a patch to the stable/vanilla 2.4 kernel tree which provides
> > the O(1) scheduler code from 2.6? The closest thing I can find is:
> >
> > http://people.redhat.com/mingo/O(1)-scheduler/sched-HT-2.4.22-ac1-A0
> >
> > which is for AC (and is also A0), is there a newer 2.4.23/24 patch
> > that works against stock? The above patch fails miserably against a
> > stock 2.4.22 kernel.
> >
> > There is ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/
> > the latest which is sched-O1-rml-2.4.20-rc3-1.patch, but that too
> > fails horribly on a stock 2.4.22.
> >
> > I've been crawling through list archives, but have yet to find
> > anything, so I am reduced to asking. :)
> >
> > micah
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
