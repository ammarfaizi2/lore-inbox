Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUHQSGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUHQSGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268369AbUHQSGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:06:47 -0400
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:8321 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268363AbUHQSGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:06:13 -0400
Date: Tue, 17 Aug 2004 20:03:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: swsusp: fix default and merge upstream?
Message-ID: <20040817180313.GD19009@elf.ucw.cz>
References: <20040817111128.GA4164@elf.ucw.cz> <20040817104745.683581dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817104745.683581dd.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Perhaps now is the right time to merge -mm swsusp up to Linus?
> 
> I suppose so.  The way to do that is for Pat to merge up the various
> patches which are hanging around and then ask Linus to do the bk pull.

-mm plus two patches I sent today works pretty much okay. Are they
swsusp-related things in your tree that are not in patrick's bk?

driver-tree changes (enums etc) are pretty much orthogonal and can go
in anytime later.

> What's the testing status of the new code in bk-power.patch?

Works for me, some users reported success (after being advised to use
"shutdown" method), and suse pulled it into internal tree and it got
basic testing there by Stefan. I guess that counts like "pretty well
tested".

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
