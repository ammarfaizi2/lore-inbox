Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUHQTHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUHQTHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266610AbUHQTHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:07:23 -0400
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:27265 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268359AbUHQTDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:03:49 -0400
Date: Tue, 17 Aug 2004 21:03:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: swsusp: fix default and merge upstream?
Message-ID: <20040817190330.GG19009@elf.ucw.cz>
References: <20040817111128.GA4164@elf.ucw.cz> <20040817104745.683581dd.akpm@osdl.org> <20040817180313.GD19009@elf.ucw.cz> <20040817112843.1e3dae58.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817112843.1e3dae58.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Are they
> > swsusp-related things in your tree that are not in patrick's bk?
> 
> Just a couple of patches:
> 
> mm-swsusp-make-sure-we-do-not-return-to-userspace-where-image-is-on-disk.patch
> mm-swsusp-copy_page-is-harmfull.patch
> 
> > driver-tree changes (enums etc) are pretty much orthogonal and can go
> > in anytime later.
> > 
> > > What's the testing status of the new code in bk-power.patch?
> > 
> > Works for me, some users reported success (after being advised to use
> > "shutdown" method), and suse pulled it into internal tree and it got
> > basic testing there by Stefan. I guess that counts like "pretty well
> > tested".
> 
> OK.  I'll integrate your most recent patches and will squirt everything at
> Patrick.

Thanks.
									Pavel	
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
