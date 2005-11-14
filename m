Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVKNMAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVKNMAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVKNMAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:00:23 -0500
Received: from [85.8.13.51] ([85.8.13.51]:49050 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751095AbVKNMAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:00:22 -0500
Message-ID: <43787C46.30707@drzeus.cx>
Date: Mon, 14 Nov 2005 13:00:06 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.6a1 (X11/20051022)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jens Axboe <axboe@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx>	 <1131964282.2821.11.camel@laptopd505.fenrus.org>	 <20051114111108.GR3699@suse.de>	 <1131967167.2821.14.camel@laptopd505.fenrus.org>	 <20051114112402.GT3699@suse.de>	 <1131967678.2821.21.camel@laptopd505.fenrus.org>	 <20051114113442.GU3699@suse.de> <1131969212.2821.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1131969212.2821.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> The experience with Fedora so far is exceptionally good; in early 2.6
> there were some reports with XFS stacked on top of DM, but since then
> XFS has gone on a stack diet... also the -mm patches to do non-recursive
> IO submission will bury this (mostly theoretical) monster for good.
>
>   

Fedora with their 2.6.12 and raid+xfs+nfs still causes occasional 
problems for me. Haven't tried their 2.6.14. But until the block layer 
modifications are mainline I'm sticking with 8 KiB. My heart momentarily 
stops every time the file server decides to have a kernel panic, so 
better safe than sorry.

Rgds
Pierre


