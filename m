Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVCSAPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVCSAPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 19:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVCSANj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 19:13:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11414 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262296AbVCSADe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 19:03:34 -0500
Date: Sat, 19 Mar 2005 01:02:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SUSPEND_PD_PAGES-fix
Message-ID: <20050319000239.GH24449@elf.ucw.cz>
References: <20050316202800.GA22750@everest.sosdg.org> <20050318113957.GC32253@elf.ucw.cz> <200503181434.59214.rjw@sisk.pl> <200503181956.46089.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503181956.46089.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > This fixes SUSPEND_PD_PAGES, which wastes one page under most cases.
> > > 
> > > Ok, applied to my tree, will eventually propagate it. (I hope it looks
> > > okay to you, rafael).
> > 
> > SUSPEND_PD_PAGES is not necessary in swsusp any more. :-)  We can just
> > drop it, together with the pagedir_order variable, which is not used.  I'll
> > send a patch later today.
> 
> The patch follows.

Applied to my tree, will propagate.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
