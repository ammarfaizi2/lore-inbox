Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUKBWCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUKBWCO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUKBV6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:58:24 -0500
Received: from gprs214-95.eurotel.cz ([160.218.214.95]:16257 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261693AbUKBVyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:54:04 -0500
Date: Tue, 2 Nov 2004 22:53:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SWsuspend in 2.6.9 - sound card does not work
Message-ID: <20041102215349.GC1407@elf.ucw.cz>
References: <20041027111830.GD4724@fi.muni.cz> <20041102212539.GC996@openzaurus.ucw.cz> <20041102213844.GA13012@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102213844.GA13012@fi.muni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> : > I have an Asus M6R laptop (http://www.fi.muni.cz/~kas/m6r/) with ATI IXP
> : > integrated sound card. Under 2.6.8.1 I was able to use the sound card
> : > after software suspend (just had to restore mixer settings using alsactl).
> : > With 2.6.9 the sound card does not work after suspend/restore: No output no
> : > matter how I change mixer settings, and the playback is not timed properly
> : > (e.g. when mplayer tries to synchronize audio and video stream, the video
> : > goes too fast using all CPU time and no output to speakers/phones.
> : > 
> : > 	I will do a binary search over 2.6.9-pre patches, but I want to ask
> : > whether this problem looks familiar to anybody.
> : > 
> : 
> : Are there any changes in the sound module?
> 
> 	Yes, the difference is between 2.6.9-rc1 (works) and -rc2 (does not
> work). Removing the snd-atiixp module after resume and inserting it

Is there any difference between -rc1 and -rc2 snd-atiixp?
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
