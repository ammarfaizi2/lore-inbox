Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266870AbRGOTkh>; Sun, 15 Jul 2001 15:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbRGOTk2>; Sun, 15 Jul 2001 15:40:28 -0400
Received: from beasley.gator.com ([63.197.87.202]:37898 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266870AbRGOTkI>; Sun, 15 Jul 2001 15:40:08 -0400
From: "George Bonser" <george@gator.com>
To: "Steve VanDevender" <stevev@efn.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 12:40:09 -0700
Message-ID: <CHEKKPICCNOGICGMDODJGEFNDKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <15185.57310.203036.847687@tzadkiel.efn.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> To the extent that the Internet works today, it's because people have
> chosen to do the right thing instead of just the thing that works.
> Encouraging (not "bullying") other people to do the right thing is
> always a good idea.

I have not evidence to say that their network is not configured properly.
For all I know they have ethernet cable strung from one computer to the next
and it takes 64 hops just to get out of the village. I did a traceroute, it
stopped at an address that would lead me to think, based on experiance and
intuition, that it is a gateway or firewall of some sort ( a .1 IP
address ). The traceroute actually terminated properly at that address so it
might be some kind of a virt IP that it is handling. I could not see what
was beyond it.

The fact that it seemed to work after increasing the TTL told me that they
did not have a hard loop somewhere, that there really did seem to either be
a large number of hops or something was decrementing the hop count by more
than one along the way.

Had the number of the ICMP messages not decreased, I would have written it
off as misconfigured nets, routing loops, or whatever and not bothered to
change the TTL. The bottom line is that 85% of the client software now
shipping ( I think I saw recently that Microsoft has 85% of the desktops )
has a default TTL of 128. Having Linux client and server server software not
work in the same net where another popular OS does would give someone in
that situation the idea that Linux is somehow inferior both as a client and
as a server. They might not immediately draw the conclusion that their
network is inferior. Or, if they DO, they might think that MS is more
"robust" in being able to tolerate their rickety net.

Regardless of who is "right", if there is a substantial population of
software out there that can reach me but I can not reply to, then adapting
my software to the situation is much easier than trying to get them to
change their network design, software, or equipment.  They probably have the
"wrong" religion, wear the "wrong" clothes, eat the "wrong" food, and a
whole bunch of other "wrong" stuff too besides using the "wrong" OS but I
would still like to engage in communications with them.

Probably the only reason I noticed it was that the farm in question gets
about 25 million requests a day last time I checked so it has a pretty good
chance of seeing any problems that might exist out there in the world.

