Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269189AbUJFKM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269189AbUJFKM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269188AbUJFKMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:12:55 -0400
Received: from gprs214-1.eurotel.cz ([160.218.214.1]:55424 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269187AbUJFKMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:12:52 -0400
Date: Wed, 6 Oct 2004 12:12:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3[+recent swsusp patches]: swsusp kernel-preemption-unfriendly?
Message-ID: <20041006101238.GD1255@elf.ucw.cz>
References: <200410052314.25253.rjw@sisk.pl> <200410061055.39698.rjw@sisk.pl> <20041006085458.GC1255@elf.ucw.cz> <200410061206.56025.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410061206.56025.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > It looks like there's a probel with the kernel preemption vs swsusp:
> > > > 
> > > > It is not in kernel preemption, see that NULL pointer dereference? Try
> > > > this one...
> > > [-- snip --]
> > > 
> > > Is it against -mm?  It does not apply cleanly to -rc3, so I've applied it 
> > > manually.
> > 
> > It was against -suse... Did it help?
> 
> I just can't say it didn't right now.  The Oops was not readily reproducible 
> anyway, so I need to do some more suspend/resume testing.  I'll let you 
> know. ;-)

Ahha, thats likely another problem, then. The one this fixes is 100%
reproducible...

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
