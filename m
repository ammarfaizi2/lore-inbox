Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbTBDMuz>; Tue, 4 Feb 2003 07:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTBDMuz>; Tue, 4 Feb 2003 07:50:55 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:25276 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S267252AbTBDMux>; Tue, 4 Feb 2003 07:50:53 -0500
Date: Tue, 4 Feb 2003 14:00:25 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
In-Reply-To: <20030203085504.GU821@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33.0302031004240.26835-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Matti Aarnio wrote:

> On Mon, Feb 03, 2003 at 09:47:00AM +0100, Tim Schmielau wrote:
> > On Mon, 3 Feb 2003, Matti Aarnio wrote:
> > > I do have a number of machines with 100 to 300 day uptimes, all
> > > with "mere" 32-bit jiffy.  With 1000 Hz clock that means at least
> > > one full wrap-around of jiffy.
> >
> > Are these 2.5 machines? If so I'd really like to know whether or not
> > ps shows old processes as having started in the future.
> > With a simulated uptime it does, but I might have overlooked something.
>
> 300 day uptime with 2.5 ?  Do think again.

Well, 100 days of uptime could be around 2.5.40.

>
> These are 2.4 series kernels.  2.4.17, 2.4.18, 2.4.20
>
> With updated 'ps' tools the processes are definitely in the past,
> although seeing mere "2002" does not tell all that detailed about
> "when".  A "apr17" would be more usefull.  Any date in "future"
> means it is of previous year.

Ok, so on these machines jifies haven't wrapped yet (if you haven't
changed HZ).
Thanks anyways,

Tim



