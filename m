Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUHFTi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUHFTi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268245AbUHFTh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:37:27 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:42112 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268247AbUHFTcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:32:07 -0400
Date: Fri, 6 Aug 2004 21:31:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [14/25] Merge pmdisk and swsusp
Message-ID: <20040806193148.GH3048@elf.ucw.cz>
References: <Pine.LNX.4.50.0407171530410.22290-100000@monsoon.he.net> <20040718221802.GE31958@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408012131490.25060-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0408012131490.25060-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Moving #ifdef inside function will result with a little less code...
> 
> Actually, we should change them to pr_debug(), like below. And, how about
> makin it a config option, so one does not have to go around editing source
> files to turn on the extra messages?

Looks okay, but I'm not sure if Andrew/Linus will like new config
option. pr_debug() change is nice.

> BTW, many of those printk()s could use some editing to make them
> meaningful to average user. ;)

Hmm, yes, that will have to happen... There's one more problem: it
usually flashes for so short period that its impossible to read. Do
you use serial console or high-speed camera :-)?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
