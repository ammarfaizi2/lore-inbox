Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274151AbRISTxf>; Wed, 19 Sep 2001 15:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274154AbRISTxZ>; Wed, 19 Sep 2001 15:53:25 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:44176 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274151AbRISTxP>;
	Wed, 19 Sep 2001 15:53:15 -0400
Message-ID: <3BA8F7BB.273734EA@candelatech.com>
Date: Wed, 19 Sep 2001 12:53:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Bruce Harada <bruce@ask.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
In-Reply-To: <E15jmpB-0003Zn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Doubtful. Since it's an 815, I presume you're running a PIII (correct me if
> > I'm wrong) - newish PIIIs have reasonable overheating cutout features, and
> > if overheating had damaged the CPU, I'd be very surprised if it worked at
> > all, rather than just locking up on certain sizes of network packets.
> 
> The 815 chipsets have known (and documented) problems with out of spec
> memory signals. Board vendors are supposed to have used workarounds but I
> have so far sent back 2 out of the 3 A/Open i815 boards with problems where
> they locked up occasionally under high load (in any OS) and also failed
> memtest86 (with known good tested ram) when placed in an electrically noisy
> environment.
> 
> I've seen lockups on high network load as part of that - but not packet size
> dependant ones.

Damn..someone has to make good stable motherboards...anyone got any
suggestions for one that will fit into a 1U server, with built-in
Video and preferably a NIC?  I had ok luck with an Intel board based
on the 815 chipset, so long as I used the e100 driver...maybe I'll
have to go back to it...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
