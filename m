Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290012AbSBKSXS>; Mon, 11 Feb 2002 13:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290017AbSBKSXL>; Mon, 11 Feb 2002 13:23:11 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:3850 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290012AbSBKSWy>;
	Mon, 11 Feb 2002 13:22:54 -0500
Date: Mon, 11 Feb 2002 11:51:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <landley@trommello.org>
Cc: Andreas Dilger <adilger@turbolabs.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Message-ID: <20020211115104.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <20020209092607.UHF12059.femail26.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020209092607.UHF12059.femail26.sdc1.sfba.home.com@there>; from landley@trommello.org on Sat, Feb 09, 2002 at 04:27:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't see why everyone who is using BK is expecting Linus to do a pull.
> > In the non-BK case, wasn't it always a "push" model, and Linus would not
> > "pull" from URLs and such?
> 
> I'm all for it.  I think it's a good thing.
> 
> In the absence of significant latency issues, pull scales better than push.  
> It always has.  Push is better in low bandwidth situations with lots of idle 
> capacity, but it breaks down when the system approaches saturation.
> 
> Pull data is naturally supplied when you're ready for it (assuming no 
> significant latency to access it).  Push either scrolls by unread or piles up 
> in your inbox and gets buried until it goes stale.  Web pages work on a pull 
> model, "push" was an internet fad a few years ago that failed for a reason.  
> When push models hit saturation it breaks down and you wind up with the old 
> "I love lucy" episode with the chocolate factory.  Back in the days where 

What's "i love lucy" episode?
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

