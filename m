Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945912AbWGOVoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbWGOVoe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWGOVod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 17:44:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11535 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161048AbWGOVod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 17:44:33 -0400
Date: Sat, 15 Jul 2006 23:44:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Albert Cahalan <acahalan@gmail.com>
Cc: dwmw2@infradead.org, arjan@infradead.org, maillist@jg555.com,
       ralf@linux-mips.org, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060715214431.GU3633@stusta.de>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 05:09:28PM -0400, Albert Cahalan wrote:
> David Woodhouse writes:
> 
> >Kernel headers are _not_ a library of random crap for userspace to use.
> 
> The attraction is that the kernel abstractions are very nice.
> Much of the POSIX API sucks ass. The kernel stuff is NOT crap.
> 
> Here we have a full-featured set of atomic ops, byte swapping
> with readable names and a distinction for pointers, nice macros
> for efficient data structure manipulation...
>...

These are _kernel_ headers.

Sure, applications are abusing the kernel headers as userspace library.

But this is wrong, that's not what they are designed for.
Look at the code MySQL uses for including atomic.h and you understand 
what I'm saying.

If stuff from the headers is generally considered useful for userspace, 
someone should simply start a new project containing the small subset of 
the headers containing such stuff cleaned up for userspace.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

