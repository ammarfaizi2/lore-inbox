Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWAVAPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWAVAPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 19:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWAVAPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 19:15:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57511 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964772AbWAVAPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 19:15:47 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Lee Revell <rlrevell@joe-job.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601211909.15559.gene.heskett@verizon.net>
References: <20060119030251.GG19398@stusta.de>
	 <200601211853.56339.gene.heskett@verizon.net>
	 <87bqy5m8u3.fsf@asmodeus.mcnaught.org>
	 <200601211909.15559.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 19:15:45 -0500
Message-Id: <1137888945.11722.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 19:09 -0500, Gene Heskett wrote:
> On Saturday 21 January 2006 18:59, Doug McNaught wrote:
> >Gene Heskett <gene.heskett@verizon.net> writes:
> >>>No, it's a different raw driver, for big databases that basically
> >>> want their own custom filesystem on a disk.
> >>
> >> With the attendent possibility of rendering the whole thing
> >> unrecoverably moot?
> >>
> >> OTOH, if this database actually does have a better way, and its
> >> mature and proven, then I see no reason to cripple the database
> >> people just to remove what is viewed as a potentially dangerous path
> >> to the media surface for the unwashed to abuse.
> >
> >The database people have a newer and supported way to do that, via the
> >O_DIRECT flag to open().  They aren't losing any functionality.
> >
> Good, but what about speed, is that impacted in any way they can 
> measure, or is this flag/method actually faster than the raw driver is?

A loss of speed is a loss of functionality, and would not be accepted.

Lee

