Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276666AbRJDQJm>; Thu, 4 Oct 2001 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276793AbRJDQJc>; Thu, 4 Oct 2001 12:09:32 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:57023 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S276666AbRJDQJW>;
	Thu, 4 Oct 2001 12:09:22 -0400
Message-ID: <3BBC89CC.D791C8FA@candelatech.com>
Date: Thu, 04 Oct 2001 09:09:48 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca> <3BBC05EC.AA9BFB4F@candelatech.com> <9ph3qu$g9b$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" wrote:
> 
> Ben Greear <greearb@candelatech.com> writes:
> 
> >jamal wrote:
> >>
> >> I think you can save yourself a lot of pain today by going to a "better
> >> driver"/hardware. Switch to a tulip based board; in particular one which
> >> is based on the 21143 chipset. Compile in hardware traffic control and
> >> save yourself some pain.
> 
> >The tulip driver only started working for my DLINK 4-port NIC
> >after about 2.4.8, and last I checked the ZYNX 4-port still refuses
> >to work, so I wouldn't consider it a paradigm of
> >stability and grace quite yet.  Regardless of that, it is often
> >impossible to trade NICS (think built-in 1U servers), and claiming
> >to only work correctly on certain hardware (and potentially lock up
> >hard on other hardware) is a pretty sorry state of affairs...
> 
> Does it finally do speed and duplex auto negotiation with Cisco
> Catalyst Switches? Something I never ever got to work with various 2.0
> and 2.2 drivers, mode settings, Catalyst settings, IOS versions and
> almost anything else that I ever tried.

Check the latest driver, it works with my IBM switch, and with other
EEPRO and Tulip NICs now, so it may work for you.  The DLINK 4-port
is actually the only one I know of that I have ever gotten to fully
function.  The ZYNX would kind of work at half-duplex for a while,
and an ancient Adaptec I tried locks the whole computer on insmod
of it's driver (IRQ routing issues someone guessed...)  There are
several 2-port EEPRO based NICs out there that work really well
too, but they are expensive...

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
