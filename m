Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUJaSwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUJaSwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 13:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUJaSwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 13:52:40 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:61572 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261186AbUJaSwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 13:52:39 -0500
Date: Sun, 31 Oct 2004 19:52:22 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041031185222.GB5578@elf.ucw.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   I know about a few people who would like to use some functionality of
> the Magic Sysrq but don't want to enable all the functions it provides.
> So I wrote a patch which should allow them to do so. It allows to
> configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
> interface is backward compatible). If you think it's useful then use it :)
> Andrew, do you think it can go into mainline or it's just an overdesign?

Actually, there's one more thing that wories me... Original choice of
PC hotkey (alt-sysrq-key) works *very* badly on many laptop
keyboards. Like sysrq is only recognized with fn, but key is not
recognized when you hold fn => you have no chance to use magic sysrq.

Perphaps sysrq could be made prefix notation? Like alt-sysrq, release,
press s is sync?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
