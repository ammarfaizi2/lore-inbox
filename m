Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVC0XtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVC0XtI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVC0XtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:49:07 -0500
Received: from mail.dif.dk ([193.138.115.101]:57265 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261622AbVC0XtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:49:04 -0500
Date: Mon, 28 Mar 2005 01:51:06 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Robert Love <rml@tech9.net>
Subject: Re: [RFC] spinlock_t & rwlock_t break_lock member initialization
 (patch seeking comments included)
In-Reply-To: <Pine.LNX.4.61.0503271132470.11848@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.62.0503280148430.2459@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503202205480.2508@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.62.0503271108140.2388@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503271132470.11848@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2005, Zwane Mwaikambo wrote:

> On Sun, 27 Mar 2005, Jesper Juhl wrote:
> 
> > I've now been running kernels (both PREEMPT, SMP, both and without both) 
> > with the patch below applied for a few days and I see no ill effects. I'm 
> > still interrested in comments about wether or not something like this 
> > makes sense and is acceptable ?
> 
> The concept seems fine to me, although i think you should be using named 
> initialisers instead.
> 
I wrote it the way I did to keep it similar to how the other members were 
initialized, I wouldn't mind a different approach, but doing it this way 
seemed to be what would "fit in" best, and it did the trick for me 
(silenced the annoying warnings) and seemed safe.

Thank you for taking the time to comment on this trivial issue.

-- 
Jesper

