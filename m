Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271829AbRH0SYB>; Mon, 27 Aug 2001 14:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271827AbRH0SXw>; Mon, 27 Aug 2001 14:23:52 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:58436 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S271828AbRH0SXp>; Mon, 27 Aug 2001 14:23:45 -0400
Date: Mon, 27 Aug 2001 21:23:45 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Kurt Roeckx <Q@ping.be>
cc: Jan Niehusmann <jan@gondor.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
In-Reply-To: <20010827170304.A226@ping.be>
Message-ID: <Pine.GSO.4.21.0108272108430.14459-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Kurt Roeckx wrote:

> On Mon, Aug 27, 2001 at 02:48:24PM +0300, Liakakis Kostas wrote:
> > On Mon, 27 Aug 2001, Jan Niehusmann wrote:
> > 
> > > (asus writes that one of the problems that can happen with this power
> > > saving mode are the huge changes in power dissipation, from 60W to 5W
> > > and back - therefore I assume the power saving mode can save up to 55W)
> > 
> > The problem they are describing is not the change in power dissipation,
> > but the change in current draw from the regulated 1.75V (difference of
> > about 30A or more).
> 
> And what do you think power is?
> Maybe it's the voltage times the current?

Your point being? This is power yeah. However I can get 50W with 1V@50A
and with 50V@1A ... tell me which will be easier for a regulator when
going from 10 to 50W while trying to keep the voltage steady.

So to rephrase myself the condition of less power dissipation (and that is
thermal output, not power consumption which isvoltage times current... )
is the result of less current draw of ~30A. This is a huge difference. And
this is the problem. There are regulators on certain motherboards which
can't cope with this. And they increase (not that bad unless you fry a 
chip) when current drops, or decrease voltage when there is current need
(crash) of the tolerance limmits.

Sorry for the OT.

-K.


