Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVBJSbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVBJSbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVBJSbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:31:34 -0500
Received: from gprs214-161.eurotel.cz ([160.218.214.161]:60814 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262190AbVBJSb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:31:29 -0500
Date: Thu, 10 Feb 2005 19:31:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: Thinkpad R40 freezes after swsusp resume
Message-ID: <20050210183114.GB1577@elf.ucw.cz>
References: <20050210124636.GA10677@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210124636.GA10677@butterfly.hjsoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I can suspend my R40 with swsusp, then boot it and resume fine most of
> the time.
> 
> I'd say nearly 50$ of the time though, the machine will freeze within 5
> minutes of resuming.
> 
> SysRq doesn't work, no oops when in console mode, no network, no disk 
> activity, just frozen.  Occassionally, I've seen a line or 2 of 
> pixels on my X screen get corrupted.
> 
> Here are some of the things I've tried adjusting:
> pci=routeirq.
> pci=noacpi (or whatever it is).
> shutting down hotplug over suspend to disable USB.
> disabling cpudynd and CPU frequency scaling.
> ...and probably a few other things i'm forgetting.
> enabling lapic seemed to almost make it worse.

Try also acpi=off.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
