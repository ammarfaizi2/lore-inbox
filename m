Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVB0RyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVB0RyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVB0RxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:53:20 -0500
Received: from gprs215-59.eurotel.cz ([160.218.215.59]:47515 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261483AbVB0Ru5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:50:57 -0500
Date: Sun, 27 Feb 2005 18:50:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050227175039.GL1441@elf.ucw.cz>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050226153905.GA8108@localhost.localdomain> <20050227170428.GI1441@elf.ucw.cz> <20050227174309.GA27265@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227174309.GA27265@piper.madduck.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ugh, too late, I already forgot what went wrong for you. Anyway
> > try reading Documentation/power/swsusp.txt and/or going to
> > 2.6.11-rc4. If that does not help, debug with printk :-).
> 
> I already did the first two. I will try 2.6.11-rc4 now.
> 
> Please check my first post, if you have the time:
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=110789536921510&w=2

Ok, this one.

I do not know what is going wrong. swsusp seems to work for
people... or at least it works for me. Here's my .config, perhaps you
have something unusual?

I do have CONFIG_PM_STD_PARTITION="/dev/hda1", perhaps that's
neccessary?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
