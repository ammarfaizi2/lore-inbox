Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274129AbRISSJb>; Wed, 19 Sep 2001 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274130AbRISSJV>; Wed, 19 Sep 2001 14:09:21 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:5008 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274129AbRISSJH>;
	Wed, 19 Sep 2001 14:09:07 -0400
Message-ID: <3BA8DF59.B9F536B4@candelatech.com>
Date: Wed, 19 Sep 2001 11:09:29 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
In-Reply-To: <3BA84088.27698798@candelatech.com> <3BA8CCF1.CA2933B3@zip.com.au> <3BA8D351.F57BE70D@candelatech.com> <3BA8D619.9A607219@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> nmi_watchdog will force an oops if the machine locks up
> with interrupts disabled (as I suspect mine did).  But
> it requires an SMP kernel or IO-APIC-on-UP.

I just built a 2.4.8 kernel with the APIC enabled.  It locked
hard and printed no OOPS.  I had set the boot cmd line as:
nmi_watchdog=1

> 
> > Could bad hardware do this..and if so, any idea of what to look for??
> >
> 
> Yes, bad hardware could do it.  It'll eother be a lockup
> with interrupts disabled or a double/triple fault.

When I opened the machine the first time (before I powered it up),
I noticed that the CPU fan's wires were tangled in the fan such that
it couldn't move..  I fixed that, but it could have been run before
I received the machine...  Could that cause this problem you think??

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
