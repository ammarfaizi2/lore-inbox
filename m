Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVDCKoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVDCKoc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 06:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVDCKoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 06:44:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16084 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261654AbVDCKo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 06:44:28 -0400
Date: Sun, 3 Apr 2005 12:44:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: rmk+lkml@arm.linux.org.uk
Subject: Re: Fix u32 vs. pm_message_t in arm
Message-ID: <20050403104414.GE1357@elf.ucw.cz>
References: <20050329191543.GA8309@elf.ucw.cz> <20050403113804.A921@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403113804.A921@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This fixes u32 vs. pm_message_t confusion in arm. I was not able to
> > even compile it, but it should not cause any problems. Please apply,
> 
> On testing this patch, it doesn't build.  You need to include
> linux/pm.h into linux/sysdev.h for starters, and fix sysdev.h
> to also use pm_message_t in it's function pointers.
> 
> Therefore, I'd like the following patch either to be in mainline first,
> or in my ARM tree for Linus to pull so ARM doesn't completely break
> on my next merge.

That patch was recently merged into -mm, so I hope its okay... Thanks
for testing. (And sorry, I did not realize patches depend on each
other this way).

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
