Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272325AbRIEVXY>; Wed, 5 Sep 2001 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272324AbRIEVXP>; Wed, 5 Sep 2001 17:23:15 -0400
Received: from spike.porcupine.org ([168.100.189.2]:4615 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S272322AbRIEVXG>; Wed, 5 Sep 2001 17:23:06 -0400
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
In-Reply-To: <E15ehVC-0006Rx-00@the-village.bc.nu> "from Alan Cox at Sep 5, 2001
 07:34:18 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 5 Sep 2001 17:23:26 -0400 (EDT)
Cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Wietse Venema <wietse@porcupine.org>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010905212326.1B82DBC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a more serious note, what portable primitives does Linux offer
to look up all interface IP addresses and their corresponding
netmasks?

The primitives used in Postfix work on all supported systems, except
for Linux where they work partially.

Portability is a relative thing - it would be wonderful already if
your primitive supports the past three years of kernel releases.

	Wietse

Alan Cox:
> > > the mask for the requested address. This doesn't matter as long as
> > > eth0:0-style aliases are configured with ifconfig, but it does matter as
> > > soon as ip comes into play and both addresses are assigned to eth0
> > > rather than eth0 and eth0:0.
> > 
> > I think the silence you are hearing from the lkml is a bunch of people thinking
> > "Oh, crap!".
> 
> Actually its probably a bunch of people thinking "I wonder if someone else
> forwarded this to netdev@oss.sgi.com"
> 

