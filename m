Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUJLUyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUJLUyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUJLUyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:54:02 -0400
Received: from gprs212-92.eurotel.cz ([160.218.212.92]:11136 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267804AbUJLUtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:49:50 -0400
Date: Tue, 12 Oct 2004 22:20:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ed Schouten <ed@il.fontys.nl>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 2/5] xbox: disable optimization for kernel decompressor
Message-ID: <20041012202040.GA995@elf.ucw.cz>
References: <59743.217.121.83.210.1097351968.squirrel@217.121.83.210>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59743.217.121.83.210.1097351968.squirrel@217.121.83.210>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When using the kernel decompressor on a Microsoft Xbox, the system hangs
> because of invalid paging requests. When compiling the decompressor with
> -O0, we can safely avoid this problem.

This is probably workaround, not a real bugfix, right? Fix gcc, or
find out what is really wrong and put it in the comment...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
