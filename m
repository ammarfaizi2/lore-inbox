Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVAFXDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVAFXDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbVAFXCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:02:13 -0500
Received: from gprs215-35.eurotel.cz ([160.218.215.35]:22920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263057AbVAFWzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:55:25 -0500
Date: Thu, 6 Jan 2005 23:52:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2: swsusp regression
Message-ID: <20050106225233.GD2766@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501061848.11719.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501061848.11719.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
> > 
> > - Various minorish updates and fixes
> 
> There's an swsusp regression on my box (AMD64) wrt -mm1.  Namely, 2.6.10-mm2 
> does not suspend, but hangs solid right after the critical section, 100% of 
> the time.

can you comment out device_power_{down,up} from
swsusp_{suspend,resume} and see what happens?
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
