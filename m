Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVDDWdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVDDWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVDDWdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:33:16 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:34445 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261444AbVDDW2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:28:20 -0400
Date: Mon, 4 Apr 2005 16:30:23 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Robert Love <rml@tech9.net>
Subject: Re: [RFC] spinlock_t & rwlock_t break_lock member initialization
 (patch seeking comments included)
In-Reply-To: <Pine.LNX.4.62.0503280148430.2459@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0504041629210.31810@montezuma.fsmlabs.com>
References: <Pine.LNX.4.62.0503202205480.2508@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.62.0503271108140.2388@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503271132470.11848@montezuma.fsmlabs.com>
 <Pine.LNX.4.62.0503280148430.2459@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005, Jesper Juhl wrote:

> On Sun, 27 Mar 2005, Zwane Mwaikambo wrote:
> 
> > On Sun, 27 Mar 2005, Jesper Juhl wrote:
> > 
> > > I've now been running kernels (both PREEMPT, SMP, both and without both) 
> > > with the patch below applied for a few days and I see no ill effects. I'm 
> > > still interrested in comments about wether or not something like this 
> > > makes sense and is acceptable ?
> > 
> > The concept seems fine to me, although i think you should be using named 
> > initialisers instead.
> > 
> I wrote it the way I did to keep it similar to how the other members were 
> initialized, I wouldn't mind a different approach, but doing it this way 
> seemed to be what would "fit in" best, and it did the trick for me 
> (silenced the annoying warnings) and seemed safe.
> 
> Thank you for taking the time to comment on this trivial issue.

Well your original patch would probably cause the least noise amongst the 
other patches changing code in that area, perhaps try pushing it.
