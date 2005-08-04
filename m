Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVHDH3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVHDH3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVHDH3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:29:36 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:471 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261949AbVHDH3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 03:29:35 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 4 Aug 2005 00:29:16 -0700
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Jim MacBaine <jmacbaine@gmail.com>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050804072915.GE22000@atomide.com>
References: <200508031559.24704.kernel@kolivas.org> <3afbacad05080323596b39e9eb@mail.gmail.com> <200508041704.37026.kernel@kolivas.org> <200508041712.31972.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508041712.31972.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [050804 00:16]:
> On Thu, 4 Aug 2005 05:04 pm, Con Kolivas wrote:
> > On Thu, 4 Aug 2005 04:59 pm, Jim MacBaine wrote:
> > > I just borrowed a power meter to see (or not to see) real effects of
> > > dyntick. The difference between static 1000 HZ and dynamic HZ is much
> > > less than I expected, only a very little about noise.  With dyntick
> > > disabled at 1000 HZ my laptop needs 31,3 W.  With dyntick enabled I
> > > get 29.8 W, the pmstats-0.2 script shows me that the system is at
> > > 35-45 HZ when it is idle.
> > >
> > > The power consumption difference between 250 HZ static and dyntick is
> > > below the noise, so maybe hardly worth all the struggle.
> >
> > That's not the point. We want the power savings without sacrificing the
> > extra ticks if we need them.
> 
> Oh but thank you very much for confirming the power savings are around the 5% 
> mark. If we don't measure we won't know (and everything else is mental 
> masturbation according to Linus ;)).

Dyntick on it's own does not do much. But it allows adding better PM code
later on.

Tony
