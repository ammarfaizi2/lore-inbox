Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbVI1QhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVI1QhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVI1QhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:37:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21479 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751426AbVI1QhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:37:09 -0400
Date: Wed, 28 Sep 2005 18:36:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tim Bird <tim.bird@am.sony.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <4339978F.2010609@am.sony.com>
Message-ID: <Pine.LNX.4.61.0509281747070.3728@scrub.home>
References: <Pine.LNX.4.61.0509271848040.3728@scrub.home> <4339978F.2010609@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Sep 2005, Tim Bird wrote:

> > That still means it is used and if an application
> > actually depends on it, it would be penalized by
> > your implementation. These timers may open up new
> > application (in kernel or user space), where
> > this conversion may be needed, so _only_ looking
> > at the current numbers is a bit misleading.
> 
> Oh good heavens!  One can always point to real or
> hypothetical cases where a change like this
> will result in worse performance.  Will you only
> be satisfied if there is provably NO performance
> degradation for ANY app on ANY platform?

I want to get the focus at the complete picture, as this is a rather 
critical area and I will be satisfied, as soon as I can see all 
consequences and possibilities have been considered.

>  Even
> if the code is easier to maintain, and allows
> for improvements in functionality and equal or
> better performance for the majority of apps.
> and platforms?

If that's case, you're hopefully not afraid of a few questions? Why do I 
have to take the code as is and just believe the claims about it?
I like improvements as everyone, but I also want to verify them and look 
at the alternatives and I can't see anything wrong with it.

> Unless I missed something, ktimers has not been
> recommended for mainlining yet.  I suspect (without
> having measured it myself yet) that the
> core abstraction that it proposes (timers
> vs. timeouts) is an important one for improving
> the kernel timing system.

I'm not saying that the idea is wrong, the general direction is fine, but 
some course correction should be possible?

bye, Roman
