Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbULTPtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbULTPtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULTPqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:46:14 -0500
Received: from gprs215-150.eurotel.cz ([160.218.215.150]:35972 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261571AbULTPl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:41:56 -0500
Date: Mon, 20 Dec 2004 16:41:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp and available swap space
Message-ID: <20041220154137.GA24978@elf.ucw.cz>
References: <20041220151414.21977.qmail@web88001.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220151414.21977.qmail@web88001.mail.re2.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If say I have 980KB of memory used (of a total of 1GB

980MB?

> physical RAM), and rest currently in swap memory
> giving me 1GB total ram used, and a swap of 1GB, when
> suspending would this fail? Wouldn't the swapped
> partition memory have to be moved somewhere? 

Try without highmem, and try suspending just after boot, when not that
much memory is in use. If too much memory is used after boot, boot
with init=/bin/bash, swapon and trigger swsusp.

> I can't be sure because I cant suspend to disk yet..
> it continues to abort and I wonder if its due to the
> swap size not being big enough for all ram + swapped
> memory to fit on the swap partition?

Messages from suspend would be helpfull.


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
