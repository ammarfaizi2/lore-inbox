Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTA3VNQ>; Thu, 30 Jan 2003 16:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTA3VNQ>; Thu, 30 Jan 2003 16:13:16 -0500
Received: from ns.suse.de ([213.95.15.193]:1030 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267636AbTA3VNQ>;
	Thu, 30 Jan 2003 16:13:16 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make lost-tick detection more informative
References: <3E39756F.6080400@us.ibm.com.suse.lists.linux.kernel> <3E3995A9.E44AD77A@digeo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Jan 2003 22:22:40 +0100
In-Reply-To: Andrew Morton's message of "30 Jan 2003 22:17:06 +0100"
Message-ID: <p737kcmz61r.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:


> I've actually disabled it in -mmnext, because I get too
> much mail already.
> 
> If you want to slap this on top of that and some new
> kernel-hacking debug config option, that would be neat.

On x86-64/2.4 it is a kernel option "report_lost_ticks"

The overhead is low (single if check in the timer handler), so this is fine.

If you suspect something goes wrong due to bad latency you can just tell
the user to turn it on.

-Andi
