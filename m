Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268828AbUIZKOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268828AbUIZKOn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 06:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUIZKOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 06:14:43 -0400
Received: from gprs214-184.eurotel.cz ([160.218.214.184]:11138 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268828AbUIZKOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 06:14:33 -0400
Date: Sun, 26 Sep 2004 12:10:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Stefan Seyfried <seife@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040926101058.GJ10435@elf.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <4155E40D.2020709@suse.de> <200409261202.34138.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409261202.34138.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have seen this, too but i cannot nail it down to some specific
> > pattern, it just "sometimes" is slow. Sysrq-p shows me it's almost
> > always in "pccardd" (where it shouldn't be during suspend, iiuc).
> > Unfortunately Pavel does not see this so we have to convince him that
> > this is really a problem ;-)
> > So if you can reproduce this, it would be a step in the right direction.
> 
> It seems that I can. ;-)
> 
> Could it be possible to printk time along with the percentage info (for 
> debugging purposes only, of course)?

Sure, feel free to printk("%d", jiffies/HZ).
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
