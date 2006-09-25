Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWIYSfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWIYSfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWIYSfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:35:33 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:2217 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1750936AbWIYSfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:35:33 -0400
Date: Mon, 25 Sep 2006 20:40:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCHES] kbuild.git updates for 2.6.19
Message-ID: <20060925184035.GA2788@uranus.ravnborg.org>
References: <20060924210827.GA26969@uranus.ravnborg.org> <Pine.LNX.4.64.0609241909580.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609241909580.3952@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 07:15:25PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 24 Sep 2006, Sam Ravnborg wrote:
> >
> > kbuild updates for 2.6.19.
> > 
> > Please pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git
> 
> Btw, this shows an irritating bug in your setup: your computer has its 
> clock set wildly incorrectly.
> 
> Git doesn't really _care_, but if you look at gitweb at this time, it will 
> annotate all the commits I pulled from you as being "right now", because 
> your computers clock was set several hours into the future, and thus your 
> timestamps are crap.
> 
> Please fix. The "author" times are correct (they get taken from the emails 
> or from the original commit that got cherry-picked, depending on how you 
> did things), but look for example at commit 5026b38c:
> 
> 	author	Randy Dunlap <rdunlap@xenotime.net>
> 		Fri, 22 Sep 2006 19:37:56 +0000 (12:37 -0700)
> 	committer	Sam Ravnborg <sam@neptun.ravnborg.org>
> 		Mon, 25 Sep 2006 11:33:04 +0000 (13:33 +0200)
> 
> and I can tell you that you sure as hell didn't commit that on Monday, 
> September 25, at 11:33 UTC (or 13:33 in +0200), because right now it's 
> 2:13 AM in UTC, and the date your commit got marked for is still more than 
> nine hours in the future (and was further off when you did it).
> 
> I'd suggest running NTP, or at least checking that your date is even 
> _remotely_ correctly set on your computer ;)

Fixed - thanks!

	Sam
