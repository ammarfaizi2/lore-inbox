Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271572AbRHWBCK>; Wed, 22 Aug 2001 21:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271752AbRHWBB7>; Wed, 22 Aug 2001 21:01:59 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:33185 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S271572AbRHWBBt>;
	Wed, 22 Aug 2001 21:01:49 -0400
Message-ID: <3B845605.E9EC1FF1@candelatech.com>
Date: Wed, 22 Aug 2001 18:01:57 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ted Deppner <ted@psyber.com>
CC: Travis Shirk <travis@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Locking Up
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net> <20010822165444.A25085@dondra.ofc.psyber.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Deppner wrote:
> 
> On Wed, Aug 22, 2001 at 09:46:14AM -0600, Travis Shirk wrote:
> > Ever since I upgraded to the 2.4.x (currently running 2.4.8)
> > kernels, my machine has been locking up every other day
> > or so.  Does anyone have any hints/tips for figuring out
> > what is going on.
> 
> As another data point, I've had similar problems with one machine (the
> heaviest utilized), but none others.  I'm running about 20 2.4.x machines,
> in various uses (I work for an ISP).
> 
> Kernels 2.4.6 through 2.4.7, and even a 2.4.7-ac8 I tried for good
> measure.
> 
> The one running on a Dell PowerEdge 2450, dual P3-750s, 512mb ram, Mylex
> ExcelRaid 2000, Intel EEPRO100, running a qmail setup transiting 20 to 40k
> messages per day regularly locks up every 3 to 8 days.  No dmesg, no error
> logs, no oops, nothing on the console.

If the latest kernel still blows up, try using Intel's e100 driver..
The eepro100 driver has been flaky from time to time on certain
chipsets...

Ben

> ifconfig eth0 has shown millions of various errors (carrier, collisions),
> and hundreds of thousands of them between typing the command in twice.
> The Cisco 6000 series switch on the other side of the cable shows no such
> errors.
> 
> --
> Ted Deppner
> http://www.psyber.com/~ted/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
