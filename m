Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275493AbTHJJUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275494AbTHJJUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:20:08 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:2579 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S275493AbTHJJUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:20:00 -0400
Date: Sun, 10 Aug 2003 02:19:56 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy ...
Message-ID: <20030810091956.GB12746@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <5.2.1.1.2.20030810091640.01a0fe40@pop.gmx.net> <200308100405.52858.roger.larsson@skelleftea.mail.telia.com> <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net> <200308100405.52858.roger.larsson@skelleftea.mail.telia.com> <5.2.1.1.2.20030810091640.01a0fe40@pop.gmx.net> <5.2.1.1.2.20030810101700.019bc528@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030810101700.019bc528@pop.gmx.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause confusion and disorientation to persons think they know everything.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 10:18:43AM +0200, Mike Galbraith wrote:
> At 05:56 PM 8/10/2003 +1000, Nick Piggin wrote:
> 
> 
> >Mike Galbraith wrote:
> >
> >>At 03:43 PM 8/10/2003 +1000, Nick Piggin wrote:
> >>
> >>
> >>>Roger Larsson wrote:
> >>>
> >>>>*       SCHED_FIFO requests from non root should also be treated as 
> >>>>SCHED_SOFTRR
> >>>
> >>>I hope computers don't one day become so fast that SCHED_SOFTRR is
> >>>required for skipless mp3 decoding, but if they do, then I think
> >>>SCHED_SOFTRR should drop its weird polymorphing semantics ;)
> >>
> >>
> >>:)  My box is slow enough to handle them just fine, as long as I make 
> >>sure that oinkers don't share the same queue with the light weight player.
> >
> >
> >Just my (unsuccessful) attempt at humor!
> 
> (was successful here... made for wide grin:)

Here too.

You know, that SCHED_SOFTRR is almost sounding like it
should be a SCHED_RESERVED where you could specify a
quantity of CPU time reserved for each task in
SCHED_RESERVED individually rather like isochronous which
was brought up earlier by Con.  Of course you'd have to make
sure some time was unreservable.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
