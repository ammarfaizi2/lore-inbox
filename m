Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWIURfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWIURfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWIURfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:35:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49624 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751382AbWIURfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:35:16 -0400
Date: Thu, 21 Sep 2006 10:35:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060921103503.6e0fa233.akpm@osdl.org>
In-Reply-To: <20060921131433.GA4182@elte.hu>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<20060921131433.GA4182@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 15:14:33 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > ntp-move-all-the-ntp-related-code-to-ntpc.patch
> > ntp-move-all-the-ntp-related-code-to-ntpc-fix.patch
> > ntp-add-ntp_update_frequency.patch
> > ntp-add-ntp_update_frequency-fix.patch
> > ntp-add-time_adj-to-tick-length.patch
> > ntp-add-time_freq-to-tick-length.patch
> > ntp-prescale-time_offset.patch
> > ntp-add-time_adjust-to-tick-length.patch
> > ntp-remove-time_tolerance.patch
> > ntp-convert-time_freq-to-nsec-value.patch
> > ntp-convert-to-the-ntp4-reference-model.patch
> > ntp-cleanup-defines-and-comments.patch
> > kernel-time-ntpc-possible-cleanups.patch
> > kill-wall_jiffies.patch
> > 
> >  Will merge.
> 
> would be nice to merge the -hrt queue that goes right ontop this queue. 
> Even if HIGH_RES_TIMERS is "default n" in the beginning. That gives us 
> high-res timers and dynticks which are both very important features to 
> certain classes of users/devices.
> 
> The current queue is at:
> 
>   http://tglx.de/projects/hrtimers/2.6.18/
> 

I've never even looked at this work.  Just add it to the pipeline I guess. 
We can merge it once it passes review by Roman ;)

But the possible problems with the NTP patches which John has possibly
observed were news to me - it's not clear what the situation is there.
