Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbUKLVSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUKLVSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbUKLVQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:16:18 -0500
Received: from gprs214-66.eurotel.cz ([160.218.214.66]:22913 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262618AbUKLVPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:15:44 -0500
Date: Fri, 12 Nov 2004 22:15:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Fix sysdev time support
Message-ID: <20041112211531.GC1252@elf.ucw.cz>
References: <1100213485.6031.18.camel@desktop.cunninghams> <1100213867.6031.33.camel@desktop.cunninghams> <20041112080000.GC6307@atrey.karlin.mff.cuni.cz> <1100291593.4090.2.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100291593.4090.2.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Fix type of sleep_start, so as to eliminate clock skew due to math
> > > errors.
> > 
> > Are you sure? I do not think long signed/unsigned problem can skew the
> > clock by 1hour. I could see skewing clock by few years, but not by one
> > hour...
> 
> It seemed small to me, too. Perhaps I just didn't notice the shift in
> the date. I'll look again, if you like.

Yes, I'd like to understand this problem.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
