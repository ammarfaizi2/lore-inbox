Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTKJSEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbTKJSEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:04:44 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:35082
	"EHLO muru.com") by vger.kernel.org with ESMTP id S264009AbTKJSEn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:04:43 -0500
Date: Mon, 10 Nov 2003 10:04:39 -0800
To: Peter Gantner <peter.gantner@stud.uni-graz.at>
Cc: linux-kernel@vger.kernel.org, pasi.savolainen@hut.fi,
       Charles Lepple <clepple@ghz.cc>, f.maibaum@web.de
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 more cleanup and clock skew test
Message-ID: <20031110180439.GB1121@atomide.com>
References: <20031110003305.GA2833@atomide.com> <Pine.LNX.4.58.0311100628440.12413@scourge.crownest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311100628440.12413@scourge.crownest.net>
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Gantner <peter.gantner@stud.uni-graz.at> [031109 22:02]:
> Quoting Tony Lindgren from Nov 9
> 
> > On the clock skew problem, it's still there, and to figure out how bad the
> > problem is, I've done a little shell script based on the earlier thread on
> > adjtimex on this mailing list.
> 
> Here are my results from your script.

Thanks!

> I did three runs each, first run idle, two runs under load, i.e. two
> burnK7 processes and a make -j5 kernel compile just to make sure.
> loadavg goes up to ~6.5 during those.
> ntpd was not running during the tests.

Great, I was only expecting results from idle mode, but seeing what happens
under load is interesting to see too.

> System is an A7M266-d w/ two AthlonXPs 1800+ (model 6 stepping 2),
> L5-modded(!) for the MP setup. (I know this is considered tainting,
> if you can tell me the timing issues are related to the modding I
> will shut up immediately, but so far nobody seems to have pinpointed 
> it to this.)

That should not make a difference. I think I'm getting pretty much similar
results with missed ticks. I'll try to take a look at it in early December
when I have access to my Athlon box again.

Tony
