Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUI2Wvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUI2Wvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUI2Wvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:51:39 -0400
Received: from gprs214-94.eurotel.cz ([160.218.214.94]:43906 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269129AbUI2WvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:51:07 -0400
Date: Thu, 30 Sep 2004 00:50:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: 2.6.9-rc2-mm[2-4]: zaphod-scheduler.patch makes swsusp incredibly slow (was: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64)
Message-ID: <20040929225054.GC30751@elf.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <20040926132036.GG826@openzaurus.ucw.cz> <200409280123.54857.rjw@sisk.pl> <200409292358.54609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409292358.54609.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have verified that the odd symptoms described previously in this thread 
> result from the zaphod-scheduler.patch.
> 
> To show this, I took the 2.6.9-rc2-mm2 kernel, reverted the 
> zaphod-scheduler.patch and applied the following changes to
> swsusp.c:

Hmm, similar behaviour was observed when we had missing unplug in
-suse kernels (IIRC; Andrea debugged it, he might know more).
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
