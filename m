Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264827AbUFLOu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbUFLOu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 10:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUFLOu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 10:50:56 -0400
Received: from mail.aei.ca ([206.123.6.14]:57042 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S264827AbUFLOuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 10:50:55 -0400
Subject: Re: [PATCH][2.6.7-rc3] Single Priority Array CPU Scheduler
From: Shane Shrybman <shrybman@aei.ca>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40CA49DD.5040500@bigpond.net.au>
References: <1086961198.2787.19.camel@mars>
	 <40CA49DD.5040500@bigpond.net.au>
Content-Type: text/plain
Message-Id: <1087051846.2444.4.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 12 Jun 2004 10:50:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-11 at 20:10, Peter Williams wrote:
> Shane Shrybman wrote:
> > Hi Peter,
> > 
> > I just started to try out your SPA scheduler patch and found that it is
> > noticeably sluggish when resizing a mozilla window on the desktop. I
> > have a profile of 2.6.7-rc3-spa and 2.6.7-rc2-mm2 and put them up at:
> > http://zeke.yi.org/linux/spa/ . There is also vmstat output there but it
> > doesn't look too helpful to me.
> > 
[..snip..]
> 
> Thanks for the feedback, I'll add your test to those I perform myself.
> 

Sure, no problem. Hope it helps.

> Some of the control variables for this scheduler have rather arbitrary 
> values at the moment and are likely to be non optimal.  I'm in the 
> process of making some of these variables modifiable at run time via 
> /proc/sys to enable experimentation with different settings.  Hopefully, 
> this will enable settings that improve interactive performance to be 
> established.
> 
> Once again, thanks for the feedback
> Peter

Regards,

Shane

