Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWIXQul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWIXQul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWIXQul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:50:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWIXQuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:50:40 -0400
Date: Sun, 24 Sep 2006 09:50:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Weiske <cweiske@cweiske.de>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference at
 virtual address 000,0000a
Message-Id: <20060924095029.0262a2c8.akpm@osdl.org>
In-Reply-To: <451677FE.2070409@cweiske.de>
References: <45155915.7080107@cweiske.de>
	<20060923134244.e7b73826.akpm@osdl.org>
	<451677FE.2070409@cweiske.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 14:20:14 +0200
Christian Weiske <cweiske@cweiske.de> wrote:

> > It would be interesting to find out if enabling CONFIG_4KSTACKS makes this
> > go away (although I'm not sure why).
> So, here are the results from the 4K runs:
> 
> Beside one Oops message, I got a "kernel BUG at mm/slab.c:2747!" in log
> #1. Call traces as usual.
> 
> Further, logs #2 and #3 show funny things; the thing just rebooted. Log
> #2 has some oversized ethernet frames before the reboot.

I assume that you have confirmed that the machine doesn't have hardware
problems?  Does it run some earlier kernel OK?  

And how long does it take to crash?

Thanks.
