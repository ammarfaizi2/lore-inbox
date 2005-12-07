Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbVLGR5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbVLGR5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVLGR5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:57:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19595 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751484AbVLGR5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:57:10 -0500
Date: Wed, 7 Dec 2005 18:57:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-ID: <20051207175708.GA3672@elte.hu>
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512070347450.1609@scrub.home> <20051207165550.GA2426@elte.hu> <Pine.LNX.4.61.0512071813540.1610@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512071813540.1610@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.6 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > (It's also interesting how you do that without giving me any 
> > >  credit for it.)
> >
> > Sorry if it was previously your idea and if we didnt credit you for 
> > it.
> > [...]
> >
> > > A bit later ktime_t looked pretty much like the 64bit part of my 
> > > ktimespec.
> > 
> > and Thomas credited you for that point in his announcement:
> > 
> >  " Roman pointed out that the penalty for some architectures
> >    would be quite big when using the nsec_t (64bit) scalar time
> >    storage format. "
> 
> "pointed out that the penalty" is a bit different from "provided the 
> basic idea of the ktime_t union and half the implementation"...

so ... did you change your position from accusing us of not giving you 
_any_ credit:

   "It's also interesting how you do that without giving me
    any credit for it."

to accusing us of not giving you _enough_ credit? Did i get that right?

And ontop of that, you now want the credit for providing the basic idea 
for half of the ktimer/hrtimer implementation? Sorry that i did not find 
out in advance that you wanted _that_ ;-)

	Ingo
