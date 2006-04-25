Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWDYCtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWDYCtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWDYCtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:49:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751350AbWDYCta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:49:30 -0400
Date: Mon, 24 Apr 2006 19:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: kernel@kolivas.org, mingo@elte.hu, suresh.b.siddha@intel.com,
       efault@gmx.de, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] sched: Fix boolean expression in move_tasks()
Message-Id: <20060424194746.715ddd89.akpm@osdl.org>
In-Reply-To: <444D8B6F.7050601@bigpond.net.au>
References: <444D637F.5040702@bigpond.net.au>
	<20060424191358.08c73e31.akpm@osdl.org>
	<444D8B6F.7050601@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> > What to do?
> 
>  Suresh's patch was wrong and this was intended as an alternative. 

OIC.

>  Unfortunately, it is also in adequate and the setting of 
>  busiest_best_prio_seen needs to be moved to just after skip_for_load is 
>  set.  I have another patch that does that (and adds to the comments). 
>  Should I send that separately or roll the two patches together?

I don't mind, really - rolled together, I guess.
