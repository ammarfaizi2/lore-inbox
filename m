Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbUKZTrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUKZTrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUKZTq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:46:56 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65474 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262408AbUKZT1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:27:13 -0500
Date: Thu, 25 Nov 2004 20:34:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 28/51: Suspend memory pool hooks.
Message-ID: <20041125193417.GC1302@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101297022.5805.302.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101297022.5805.302.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We save the image in two pages (LRU and the rest). In order to maintain
> a consistent image, we satisfy all page allocations from our own memory
> pool while saving the image and reloading the LRU. This allows us to
> safely use high level routines which might allocate slab etc and not
> free it again by the time we do our atomic copy. We simply save all of
> the pages in the pool when making our atomic copy of the non-LRU pages,
> without having to worry about exactly how they were or weren't used.

Now you know why two pagesets scare me...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
