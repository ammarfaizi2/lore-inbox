Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276348AbRI1WZn>; Fri, 28 Sep 2001 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276322AbRI1WZe>; Fri, 28 Sep 2001 18:25:34 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:11970 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S276048AbRI1WZR>;
	Fri, 28 Sep 2001 18:25:17 -0400
Message-ID: <3BB4FA5A.C30C1AA6@candelatech.com>
Date: Fri, 28 Sep 2001 15:31:54 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel changes
In-Reply-To: <20010928143205.B3669@md5.ca> <20010928180452.A6093@somanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Frazer wrote:
> 
> The answer is to treat all linus/ac/aa/... kernels as development
> kernels.  Don't treat anything as stable until it's been through
> a real QA cycle.  I've heard Suse, RedHat and the like don't do a
> bad job at this.

I agree, except that the earlier 2.4.0 kernels they are using
are also buggy to one degree or another (for instance, the Tulip
driver didn't start working for my cards untill about 2.4.8, and
by then the VM seems to have gone berserk...)  Hell, many of the
official kernels won't even compile with certain options turned
on, which is really frightening, and makes it hard to run regression
tests...

It's almost like we need to fork off a 2.5 kernel just to let the
pressure for massive change off, and let less panic'ed changes go
into the 2.4 series...

The fact that there's a 20MB patch to get from Linus to AC is also
disconcerting!!

Ben

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
