Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUF1Wqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUF1Wqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUF1Wql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:46:41 -0400
Received: from gprs214-172.eurotel.cz ([160.218.214.172]:53634 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265263AbUF1Wqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:46:38 -0400
Date: Tue, 29 Jun 2004 00:46:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-ck1
Message-ID: <20040628224623.GA11333@elf.ucw.cz>
References: <200406162122.51430.kernel@kolivas.org> <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Patchset update. The focus of this patchset is on system responsiveness with
> > emphasis on desktops, but the scope of scheduler changes now makes this patch 
> > suitable to servers as well.
> 
> I've found some interaction problems between, what I think it's, the
> staircase scheduler and swsusp. With vanilla 2.6.7, swsusp is able to
> save ~9000 pages to disk in less than 5 seconds, where as 2.6.7-ck1
> takes more than 1 minute to save the same amount of pages when
> suspending to disk.

That's probably bug in io subsystem. That happened few times in suse
kernel. Missing unplug?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
