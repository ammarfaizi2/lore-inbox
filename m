Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266013AbRGOKaS>; Sun, 15 Jul 2001 06:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGOKaH>; Sun, 15 Jul 2001 06:30:07 -0400
Received: from beasley.gator.com ([63.197.87.202]:1036 "EHLO beasley.gator.com")
	by vger.kernel.org with ESMTP id <S266013AbRGOKaA>;
	Sun, 15 Jul 2001 06:30:00 -0400
From: "George Bonser" <george@gator.com>
To: "Mikael Abrahamsson" <swmike@swm.pp.se>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 03:34:28 -0700
Message-ID: <CHEKKPICCNOGICGMDODJIEELDKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.33.0107151209290.2352-100000@uplift.swm.pp.se>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What problems could occur from raising it to 128? I'd imagine routing
> loops might mean a bit more traffic, but if other major OSes are at TTL
> 128 and someone is actually having trouble with 64, then why not raise it?

I just did a traceroute to one of the IP addresses that fails with a TTL of
64 ... it is in India but the traceroute ends with a different IP address in
less than 16 hops ... proxy arp ???

Anyway ... with the  address in question is able to access my server farm
with a TTL of 128 but not with 64.  I have NO IDEA what those people are
doing inside their net ... and really do not care. The bottom line as far as
I am concerned is that if they can reach me, I should be able to reach them
... and with a TTL of 128, it appears that I can.

