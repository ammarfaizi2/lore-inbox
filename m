Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWCDQBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWCDQBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 11:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWCDQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 11:01:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25362 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751821AbWCDQBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 11:01:13 -0500
Date: Sat, 4 Mar 2006 17:01:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: oops during boot of 2.6.16-rc3-git7 on AMD64
Message-ID: <20060304160112.GA9295@stusta.de>
References: <43F6678C.5080001@gmx.net> <p734q2w5nck.fsf@verdi.suse.de> <43FA1B90.2070505@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA1B90.2070505@gmx.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:42:08PM +0100, Carl-Daniel Hailfinger wrote:
> Andi Kleen schrieb:
> > Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> writes:
> > 
> > 
> >>Hi,
> >>
> >>vanilla 2.6.16-rc3-git7 gives me the following oops during boot (most
> >>of the time while mounting all filesystems) on my amd64 machine:
> >>
> >>(hand-written, no serial interface available)
> >>Unable to handle kernel NULL pointer dereference at 00000008
> >>rip: run_timer_softirq+322
> >>process udev
> >>Call trace:
> >>__do_softirq+68
> > 
> > 
> > Looks like someone is corrupting the timer list. Nasty. Can you do
> > a binary search?
> > 
> > Or alternatively remove as many drivers as possible and narrow down
> > which one is to blame.
> 
> Yes, will do that.

What is the status of this problem?

> Regards,
> Carl-Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

