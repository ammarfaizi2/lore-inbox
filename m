Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSFFNWt>; Thu, 6 Jun 2002 09:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316965AbSFFNWs>; Thu, 6 Jun 2002 09:22:48 -0400
Received: from et-gw.etinc.com ([207.252.1.2]:21254 "EHLO et-gw.etinc.com")
	by vger.kernel.org with ESMTP id <S316959AbSFFNWp>;
	Thu, 6 Jun 2002 09:22:45 -0400
Message-Id: <5.1.0.14.0.20020606091713.021f0730@mail.etinc.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 06 Jun 2002 09:21:50 -0400
To: nick@snowman.net
From: ET Sales <sales@etinc.com>
Subject: Re: Loosing packets with Dlink DFE-580TX and SMC 9462TX
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0206031956150.8643-100000@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:56 PM 6/3/02 -0400, you wrote:

Uh..aren't those 32-bit cards? There isn't enough bus bandwidth on a 32bit 
PCI bus to do gigabit, so its more likely that the cards are overrunning 
their buffers....

Dennis

>There are at least some gigabit ethernet hubs on the market.  How badly
>does it handle collisions?
>         Nick
>
>On 3 Jun 2002, Marcus Sundberg wrote:
>
> > Benjamin LaHaise <bcrl@redhat.com> writes:
> >
> > > What version of ns83820.c are you using?  Version 0.17 of ns83820.c
> > > made significant improvements under load.  Other possibilities include
> > > cabling problems (watch the kernel logs for changes in link state).
> > > Try to find out where the packets are getting dropped by looking
> > > through /proc/net/snmp and other statistics counters in the kernel.
> >
> > 0.17, but some more testing showed that the ns83820 actually works
> > just fine during this test when using just crossover cables and
> > running at gigabit speed. The original testing was done using
> > 100Mbit hubs, so my guess would be that the 83820 chips (and/or
> > driver) doesn't handle collisions too well (which I don't have a
> > problem with, as afaik GE is always switched).
> >
> > However the DFE-580TX problems remain regardless of using a hubbed
> > or switched network.
> >
> > (As booth eepro100 and tulip-based cards works fine with the hubs
> > I'm quite certain there's nothing wrong with them.)
> >
> > //Marcud
> > --
> > ---------------------------------------+--------------------------
> >   Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
> >  Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-net" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

