Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbREXXVh>; Thu, 24 May 2001 19:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262518AbREXXV1>; Thu, 24 May 2001 19:21:27 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:52163 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S262517AbREXXVH>;
	Thu, 24 May 2001 19:21:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel freeze
In-Reply-To: <Pine.LNX.4.10.10105231215280.11617-100000@coffee.psychology.mcmaster.ca>
	<3B0BFD7F.B32695C8@bluewin.ch> <8766erwsm0.fsf@maniac.gecius.de>
From: Jens Gecius <jens@gecius.de>
Date: 24 May 2001 19:21:06 -0400
In-Reply-To: <8766erwsm0.fsf@maniac.gecius.de> (Jens Gecius's message of "23 May 2001 19:30:47 -0400")
Message-ID: <87eltewcyl.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Jens Gecius <jens@gecius.de> writes:

> > > what do you mean by freeze?  in theory, the fact that the irq
> > I cannot ping the machine anymore, no Ooops, no kernel messages, the
> > attached screen is freezed (which implies that no more interrupts
> > are handled, right?)
> 
> Excuse me hopping in.
> 
> I have that situation here, too. Screen frozen, no pings from the
> local network, sysrq doesn't work (keyboard dead).
> 
> maniac kernel: NETDEV WATCHDOG: eth1: transmit timed out
> maniac kernel: eth1: Tx timed out, lost interrupt? TSR=0x3, ISR=0x3,
> t=21.
> 
> All this happened on 2.4.3 and 2.4.4 (don't excactly remember on
> earlier 2.4).
> 
> I followed your suggestion regarding PCI-slots. Both my nics used to
> use PCI 4 and 5 (on a gigabyte vxd7, dual 1GHz). Only the one in slot
> 4 had the problems. I switched the card to slot 1 and will monitor the
> situation. I'll mail the list in case it doesn't change my situation.

OK - now it even got worse. After just a couple hours slot5 was dead
(that was the one working just fine with the other card in
slot4). Three minutes later slot1 was dead, too. Both cards share
irq12.

Fortunately, the box wasn't frozen this time. X was up and running
fine and I was able to reboot in a sound manner.

I'll try another change in slots, but unfortunately, my nics are the
ones with the lowest traffic: one other is SCSI, the other one
firewire... (even though the latter one is hardly used).
 
> Any other hints are welcome (other than the noapic, which didn't help).

I have to reiterate this one. Any hints are very welcome.

-- 
Tschoe,                    Get my gpg-public-key here
 Jens                     http://gecius.de/gpg-key.txt
