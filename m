Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRISTqF>; Wed, 19 Sep 2001 15:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRISTp4>; Wed, 19 Sep 2001 15:45:56 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:40848 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S270229AbRISTpn>;
	Wed, 19 Sep 2001 15:45:43 -0400
Message-ID: <3BA8F5FC.BFDF5126@candelatech.com>
Date: Wed, 19 Sep 2001 12:46:04 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bruce Harada <bruce@ask.ne.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
In-Reply-To: <3BA84088.27698798@candelatech.com>
		<3BA8CCF1.CA2933B3@zip.com.au>
		<3BA8D351.F57BE70D@candelatech.com>
		<3BA8D619.9A607219@zip.com.au>
		<3BA8DF59.B9F536B4@candelatech.com> <20010920033841.2079e414.bruce@ask.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Harada wrote:
> 
> On Wed, 19 Sep 2001 11:09:29 -0700
> Ben Greear <greearb@candelatech.com> wrote:
> >
> > When I opened the machine the first time (before I powered it up),
> > I noticed that the CPU fan's wires were tangled in the fan such that
> > it couldn't move..  I fixed that, but it could have been run before
> > I received the machine...  Could that cause this problem you think??
> 
> Doubtful. Since it's an 815, I presume you're running a PIII (correct me if
> I'm wrong) - newish PIIIs have reasonable overheating cutout features, and
> if overheating had damaged the CPU, I'd be very surprised if it worked at
> all, rather than just locking up on certain sizes of network packets.

Yes, it's a PIII 1Ghz.  I'm not sure how important the packet sizes
are:  I can lock it with 64 byte and 128 byte packets, with the commonality
being that the CPU is maxed out and there are a massive number of little
packets all over the place.

Also, the traffic I'm running is raw packets sent straight to the
driver, not IP....

I took out the 4-port Tulip NIC and I haven't locked it up yet, though
I'm getting really sorry performance out of the sketchy machine for
some reason or another.  Still, the problem definately seems related
to the DLINK 4-port NIC at this point...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
