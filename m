Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVBQLJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVBQLJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 06:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVBQLJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 06:09:13 -0500
Received: from gprs214-194.eurotel.cz ([160.218.214.194]:53420 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262272AbVBQLHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 06:07:43 -0500
Date: Thu, 17 Feb 2005 12:07:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp, resume and kernel versions
Message-ID: <20050217110731.GE1353@elf.ucw.cz>
References: <200502162346.26143.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502162346.26143.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> First of all I must say that swsusp has progressed alot and now works
> very reliably, at least for my configuration, and I use it a lot. Great
> job!
> 
> But I think there is one pretty severe issue present - even if swsusp
> is not enabled kernel should check if there is an image in swap and
> erase it. Today I has somewhat unpleasant experience - after suspending
> I accidentially loaded a vendor kernel. I was in hurry and decided that
> resume just failed for some reason so I did couple of things and left
> the box running. In the evening I realized that I am running vendor kernel
> and decided to reboot into my devel. version. What I did not expect is for
> the kernel to find a valid suspend image and restore it. As you might
> imagine messed up my disk somewhat.

When all the vendor's kernels have swsusp, it will magically kill the
signature. Or stick mkswap /dev/XXX in your init scripts.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
