Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274125AbRIXSMq>; Mon, 24 Sep 2001 14:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274123AbRIXSMg>; Mon, 24 Sep 2001 14:12:36 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:60123 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274122AbRIXSM3>;
	Mon, 24 Sep 2001 14:12:29 -0400
Message-ID: <3BAF78F9.EC0F67C1@candelatech.com>
Date: Mon, 24 Sep 2001 11:18:33 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
In-Reply-To: <200109241514.f8OFEL005589@deathstar.prodigy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> 
> In article <3BA8DF59.B9F536B4@candelatech.com> greearb@candelatech.com wrote:
> | Andrew Morton wrote:
> |
> | > nmi_watchdog will force an oops if the machine locks up
> | > with interrupts disabled (as I suspect mine did).  But
> | > it requires an SMP kernel or IO-APIC-on-UP.
> |
> | I just built a 2.4.8 kernel with the APIC enabled.  It locked
> | hard and printed no OOPS.  I had set the boot cmd line as:
> | nmi_watchdog=1
> 
> This only works if you have a lock with no response. If keyboard input
> is echoed or ping still works, that's not the tight lockup. May I
> suggest the software watchdog feature as an alternative. It's much
> better at finding cases where the system is only braindead rather than
> locked up.

The keyboard did not work and ping did not work...

alt-sysreq did not work either.

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
