Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVCTTgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVCTTgb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 14:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVCTTga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 14:36:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65236 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261249AbVCTTgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 14:36:11 -0500
Date: Sun, 20 Mar 2005 20:35:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: Remove arch-specific references from generic code
Message-ID: <20050320193554.GD1401@elf.ucw.cz>
References: <20050316001207.GI21292@elf.ucw.cz> <20050319132815.4f51a7e5.akpm@osdl.org> <20050319220735.GC1835@elf.ucw.cz> <200503200129.35739.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503200129.35739.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do you think you could just send me diff between 2.6.12-rc1 and your
> > tree? I'll merge it here.
> 
> Sure, no problem, the diff follows. :-)  It contains the following changes:
> 
> - remove swsusp_restore() (with the fix to return 0 from swsusp_arch_resume() on x86*)
> - drop SUSPEND_PD_PAGES and pagedir_order
> - fix possible memory leaks in swsusp_suspend()
> 
> The original patches are also attached in case you need them (they all apply to
> 2.6.12-rc1).
> 
> Please let me know if that's ok.

Thanks, applied to my tree. (Actually I applied 3 attachments, but
that should be okay).
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
