Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWCWTkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWCWTkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWCWTkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:40:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:10411 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751405AbWCWTkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:40:53 -0500
Subject: Re: [PATCHSET 0/10] Time: Generic Timekeeping (v.C1)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0603231209380.17704@scrub.home>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0603231209380.17704@scrub.home>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 11:40:34 -0800
Message-Id: <1143142835.2661.7.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 13:48 +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 22 Mar 2006, john stultz wrote:
> 
> > Andrew, All,
> > 	Here is an updated version of the smaller, reworked and 
> > improved patchset I mailed out monday. Please consider for inclusion 
> > into your tree.
> 
> It looks pretty good already. :)

</me rubs his eyes and reads that again>

> Give me a bit of time to rework the middle part a bit and if we can agree 
> to make the new gettimeofday functions optional for an arch, IMO it would 
> be ok for 2.6.17. 

? The new gettimeofday functions are optional. Don't enable
CONFIG_GENERIC_TIME and you're good to go. Could you clarify what you
mean?

> I think the important part is to get the generic clock 
> infrastructure merged, so it can be used by other kernel parts, the 
> unification of performance sensitive parts can still be done on top of it 
> a bit later.

Ok, I'm still not sure how you intend to you the clocksource bits
outside of timekeeping, but I'm interested in hearing about it.

thanks
-john

