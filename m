Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbRFFXjl>; Wed, 6 Jun 2001 19:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbRFFXja>; Wed, 6 Jun 2001 19:39:30 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:16798 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264260AbRFFXjZ>;
	Wed, 6 Jun 2001 19:39:25 -0400
Message-ID: <3B1EC74D.6C720537@candelatech.com>
Date: Wed, 06 Jun 2001 17:14:05 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        "Matt D. Robinson" <yakker@alacritech.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
		<3B1E5CC1.553B4EF1@alacritech.com>
		<15134.42714.3365.32233@theor.em.cig.mot.com> <15134.43914.98253.998655@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> La Monte H.P. Yarroll writes:
>  > Matt D. Robinson writes:
>  >  > Is there any way to add in the capability to _replace_ TCP with
>  >  > your own, so you can use your own layer?
> 
> ABSOLUTELY NOT!
> 
> And I will never in my lifetime allow such a facility to be added to
> the Linux kernel.
> 
> This allows people to make proprietary implementations of TCP under
> Linux.  And we don't want this just as we don't want to add a way to
> allow someone to do a proprietary Linux VM.

Then again, maybe someone has a reason to use a different
TCP stack, ie to support something like a high-availiblity stack
between two different machines...

Why would you be scared of a proprietary  TCP stack?  If Open Source
is so much better (and I believe it is), then there would be nothing
to lose.  And if the new stack helped a small subset of people who would
otherwise have an even sorrier life implementing it on some other
platform, then that is better, right?


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
