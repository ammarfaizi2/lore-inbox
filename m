Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbTIKX3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTIKX3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:29:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:46256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261600AbTIKX3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 19:29:38 -0400
Message-Id: <200309112329.h8BNTPD24967@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>, cliffw@osdl.org
Subject: Re: Nick's scheduler policy v15 
In-Reply-To: Message from Nick Piggin <piggin@cyberone.com.au> 
   of "Fri, 12 Sep 2003 00:34:47 +1000." <3F608807.9090705@cyberone.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Sep 2003 16:29:24 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> http://www.kerneltrap.org/~npiggin/v15/
> 
> This was going to get high res timers, but instead fixed a bug that might
> be causing a few people oopses. Also very small interactivity tweaks.
> 
> I'm starting to work on SMP and NUMA ideas now, so if any interactivity
> things are bothering you, please tell me soon. I should be getting access
> to a 32-way NUMA soon, so I'm sort of holding off chaning too much until
> then.
> 
> Enjoy.
> 
Are these against 2.6.0-test5-mm1? We're not getting a clean apply over here. 
cliffw


sched-nopolicy:
---------------------
patching file kernel/fork.c
Hunk #1 FAILED at 912.
1 out of 1 hunk FAILED -- saving rejects to file kernel/fork.c.rej
patching file kernel/sched.c
Hunk #1 succeeded at 186 (offset 38 lines).
Hunk #3 succeeded at 241 (offset 37 lines).
Hunk #5 succeeded at 663 (offset 117 lines).
Hunk #6 succeeded at 847 (offset 7 lines).
Hunk #7 succeeded at 1013 (offset 117 lines).
Hunk #8 succeeded at 912 (offset 7 lines).
Hunk #9 succeeded at 1047 (offset 117 lines).
Hunk #10 succeeded at 986 (offset 7 lines).
Hunk #11 succeeded at 1114 (offset 117 lines).
Hunk #12 succeeded at 1029 (offset 7 lines).
Hunk #13 FAILED at 1056.
Hunk #14 succeeded at 1230 (offset 135 lines).
Hunk #15 succeeded at 1146 (offset 7 lines).
Hunk #16 FAILED at 1189.
Hunk #17 succeeded at 1343 (offset 136 lines).
Hunk #18 succeeded at 1233 (offset 7 lines).
Hunk #19 FAILED at 1249.
Hunk #20 succeeded at 2380 with fuzz 2 (offset -112 lines).
Hunk #21 FAILED at 2395.
Hunk #22 FAILED at 2445.
Hunk #23 succeeded at 3010 (offset 351 lines).
5 out of 23 hunks FAILED -- saving rejects to file kernel/sched.c.rej
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


