Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVABUQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVABUQp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVABUQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:16:45 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:63107 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261322AbVABUPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:15:39 -0500
Date: Sun, 2 Jan 2005 21:15:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: luto@myrealbox.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050102201522.GE18136@elf.ucw.cz>
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102201147.GB4183@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, umount -l can be handy, but it does not allow you to get your CD
> > back from the drive.
> > 
> > umount --kill that kills whoever is responsible for filesystem being
> > busy would solve part of the problem (that can be done in userspace,
> > today).
> >...
> 
> What's wrong with
> 
>   fuser -k /mnt && umount /mnt

Okay, probably nothing (I knew about fuser, but did not know about -k
option...). fuser followed by ps and kill is not nice.

[Perhaps umount could tell user about fuser -k ?]
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
