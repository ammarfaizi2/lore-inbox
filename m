Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290565AbSARAdm>; Thu, 17 Jan 2002 19:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290566AbSARAdd>; Thu, 17 Jan 2002 19:33:33 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:20957 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290565AbSARAd0>;
	Thu, 17 Jan 2002 19:33:26 -0500
Message-ID: <3C476D51.2070303@candelatech.com>
Date: Thu, 17 Jan 2002 17:33:21 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.40.0201171423050.26448-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're not using a PCI extender/riser card, are you?

What motherboard?

By lockup, how hard is it?  Will the reset button work quickly?
After 5 or so seconds?

You should probably send an lspci -vv and the interesting parts from
dmesg (or /var/log/messages)...


David Lang wrote:

> as I have not received any response directly I am sending this to the full
> list for help.
> 
> David Lang
> 
> ---------- Forwarded message ----------
> Date: Mon, 14 Jan 2002 15:10:42 -0800 (PST)
> From: David Lang <dlang@diginsite.com>
> To: Jeff Garzik <jgarzik@mandrakesoft.com>
> Subject: Tulip driver bug in 2.4.17
> 
> I am running a dlink DFE-570TX quad card that works fine with the 0.9.14
> driver in 2.4.8, but with the 2.4.15-pre9 driver in 2.4.14-2.4.17 I run
> into a bug when trying to use all the interfaces.
> 
> if I use eth3 alone it works
> if I use eth0, eth1, eth2 it works
> if I use eth0, eth1, eth3 it locks up immediatly following the ifconfig,
> locking up to the point that the magic sysreq stuff doesn't work!
> 
> if I work the other direction and ifconfig eth3, eth2, eth1, eth0 I get a
> shell prompt back after the last ifconfig before it locks up.
> 
> I posted this friday on sourceforge, but looking today at the activity
> there it doesn't look like it's in use much now so I'm sending this
> directly to you. If there is any other place I should send it or any
> additional tests I should perform, please let me know (I have 50 of these
> cards either in production or headed there soon :-)
> 
> David Lang
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


