Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVCYIO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVCYIO4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 03:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVCYIOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 03:14:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65180 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261537AbVCYIOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 03:14:51 -0500
Date: Fri, 25 Mar 2005 09:14:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jim Carter <jimc@math.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <20050325081438.GA17245@elf.ucw.cz>
References: <Pine.LNX.4.61.0503242248530.7785@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503242248530.7785@xena.cft.ca.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Wed, 23 Mar 2005, Pavel Machek wrote: 
> > This is WONTFIX for 2.6.11, but you can be pretty sure it is going to 
> > be fixed for SuSE 9.3, and patch is already in 2.6.12-rc1. Feel free 
> > to betatest SuSE 9.3 ;-). 
> 
> Unfortunately the celebration was premature.  I compiled 2.6.12-rc1,
> noticing the new feature that you can see or alter the swap device 
> number in /sys/power/resume.  So I'm able to suspend... but not to
> resume, since the driver still isn't loaded at the time of resuming.

There's another feature that enables you to start resume manually with
some echo to /sys... Perhaps it needs to be documented better, I'm
looking for a patch ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
