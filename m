Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVKURgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVKURgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVKURgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:36:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7050 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932386AbVKURgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:36:47 -0500
Date: Mon, 21 Nov 2005 18:36:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Message-ID: <20051121173636.GB2642@elf.ucw.cz>
References: <200511170629.42389.rob@landley.net> <Pine.LNX.4.61.0511192338300.1609@scrub.home> <200511210015.21269.rob@landley.net> <200511211006.48289.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511211006.48289.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Signed-off-by: Rob Landley <rob@landley.net>
> 
> Add "make miniconfig", plus documentation, plus the script that creates a
> minimal mini.config from a normal .config file.
> ---
> Blah.  Patch I sent last night was missing 2 lines in scripts/kconfig/conf.c
> (in two case statements around lines 86 and 146 set_no: needed set_mini:
> added).  Fixed and retested so that applying this patch gives the behavior I
> tested, and while I was at it I tweaked the documentation a bit more.
> 
> Here's the extended description again:
> 
> This patch is basically a user interface tweak to the new allno.config
> feature that went into 2.6.15-rc1.  The differences between allnoconfig and
> miniconfig are:
> 
> 1) Documentation.
> 
> 2) More easily understandable names (miniconfig and mini.config).
> 
> 3) More user-friendly output (just show the warnings, not the successes).
> 
> 4) Better error handling (the make exits with an error if mini.config isn't
> found or if parsing mini.config generates any warnings).
> 
> 5) A shell script to automatically create mini.config from a normal .config
> file.  (It's very slow, but it works.  Anybody who wants to make confdata.c
> spit this out by itself, feel free.  I definitely took the "bang two rocks
> together, make fire" approach with this shell script.)

How is it supposed to work with cross-compiling.
								Pavel
-- 
Thanks, Sharp!
