Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVB1OuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVB1OuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVB1OtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:49:20 -0500
Received: from gprs215-69.eurotel.cz ([160.218.215.69]:25222 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261609AbVB1Orf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:47:35 -0500
Date: Mon, 28 Feb 2005 15:47:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050228144723.GA3384@elf.ucw.cz>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050227174309.GA27265@piper.madduck.net> <20050228135604.GA6364@piper.madduck.net> <200502281533.01621.rjw@sisk.pl> <20050228144506.GA11125@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228144506.GA11125@piper.madduck.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> also sprach Rafael J. Wysocki <rjw@sisk.pl> [2005.02.28.1533 +0100]:
> > Could you, please, verify that you don't need to load any modules
> > from initrd for your swap partition to work?  It won't work if you do.
> 
> this makes perfect sense to me when you talk about resuming. does it
> also apply to suspending?

As kernel is the same for suspend and resume... Yes, it seems it makes
sense.

Of course, it was a mistake, not design, but failed suspend is better
than failed resume.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
