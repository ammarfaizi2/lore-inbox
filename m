Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWIVSxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWIVSxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWIVSxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:53:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62991 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932101AbWIVSxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:53:06 -0400
Date: Fri, 22 Sep 2006 13:06:48 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060922130648.GD4055@ucw.cz>
References: <20060920135438.d7dd362b.akpm@osdl.org> <20060921131433.GA4182@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921131433.GA4182@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

dynticks give benefit of 0.3W, or 20minutes (IIRC) from 8hours on thinkpad
x60... and they were around for way too long. (When baseline is
hz=250, it is 0.5W from hz=1000 baseline). It would be cool to
finally merge them.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
