Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVCQAH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVCQAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVCQAEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:04:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39831 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262902AbVCQAEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:04:31 -0500
Date: Thu, 17 Mar 2005 01:04:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nathan Lynch <ntl@pobox.com>, kernel list <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
Subject: Re: CPU hotplug on i386
Message-ID: <20050317000410.GA3210@elf.ucw.cz>
References: <20050316132151.GA2227@elf.ucw.cz> <20050316170945.GK21853@otto> <200503170051.58579.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503170051.58579.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I tried to solve long-standing uglyness in swsusp cmp code by calling
> > > cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> > > available on i386. Is there way to enable CPU_HOTPLUG on i386?
> > 
> > i386 cpu hotplug has been in -mm for a while.  Don't know when (if
> > ever) it will get merged.
> 
> Thanks a lot for this hint! ;-)
> 
> Pavel, I've ported the basic i386 CPU hotplug stuff, without the sysfs
> interface, to x86-64 (a cut'n'paste kind of work, mostly).  For now, I've
> made HOTPLUG_CPU on x86-64 depend on SMP and SOFTWARE_SUSPEND and be set
> automatically.
> 
> I'm going to test it together with your patch tomorrow.

Hey, don't count on my patch. It is first shot, never tested.

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
