Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUBHD5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUBHD5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:57:47 -0500
Received: from dp.samba.org ([66.70.73.150]:61875 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262050AbUBHD5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:57:45 -0500
Date: Sun, 8 Feb 2004 14:57:21 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <20040208035721.GY19011@krispykreme>
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com> <20040208011221.GV19011@krispykreme> <40258F21.30209@cyberone.com.au> <20040208014141.GX19011@krispykreme> <4025AB00.3030601@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4025AB00.3030601@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Yeah its because you have a lot of cpus, so the average is still
> small. You also need something like
> 
> if (*imbalance == 0 && max_load - this_load > SCHED_LOAD_SCALE)
>    *imbalance = 1;

OK I'll give that a try.

> I don't have a >= 4 CPU box to test on, so I hate to be feeding
> you lots of little unproven patches.

I dont have a problem with that. Id be chasing this myself but Ive got
to get a few other things done first. I can however reboot and test
things at the same time :)

Anton
