Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVAJWzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVAJWzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVAJWvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:51:22 -0500
Received: from gprs214-230.eurotel.cz ([160.218.214.230]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262619AbVAJWum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:50:42 -0500
Date: Mon, 10 Jan 2005 23:26:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kernel versions on Linus bk tree
Message-ID: <20050110222651.GB1343@elf.ucw.cz>
References: <9e473391050108102355c9a714@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050108102355c9a714@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I just came across a problem with the way the kernel is being
> versioned. The DRM driver needs an IFDEF for the four level page table
> change depending on kernel version built against. I used this:
> #if LINUX_VERSION_CODE < 0x02060a
> 
> The problem is that 2.6.10 was released on kernel.org without the four
> level change. But Linus bk which also has version 2.6.10 has the
> change. Is there some way around this problem?
> 
> One solution would be to bump the version in Linus bk to 2.6.11-rc1 on
> the first check in after 2.6.10 is cut. The general case of this would
> be to always bump the Linus bk version number immediately after
> cutting the released version.

2.6.11-rc1 seems wrong, but marking it 2.6.10-bk0 should do the trick.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
