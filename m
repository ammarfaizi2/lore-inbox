Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbUK0FJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbUK0FJa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbUK0D5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:57:05 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262467AbUKZTbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:10 -0500
Date: Thu, 25 Nov 2004 22:32:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 4/51: Get module list.
Message-ID: <20041125213206.GC2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101293104.5805.203.camel@desktop.cunninghams> <20041125165617.GC476@openzaurus.ucw.cz> <1101417950.27250.9.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101417950.27250.9.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It might be usefull as an add-on patch when people are actually debugging it,
> > but I do not think it is needed for mainline. You can just do lsmod before suspend...
> 
> Yes. It's still pretty helpful, but not as much as it has been in the
> past. We're almost at the point where we can automatically say "Have you
> got USB compiled in? Compile it as modules. Have you got USB modules
> loaded? Unload them and reload after suspending. Have you got DRI
> support loaded? Depending on chipset, do X, Y, or Z." That deals with
> the vast majority of freezes.

Yes, that's big problem. We need to get driver support right.... Hmm,
perhaps we should at least make the "known-problematic" cases block
suspend with helpfull message?

It works for me (tm) with usb with recent kernels.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
