Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266051AbRGOLHW>; Sun, 15 Jul 2001 07:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266058AbRGOLHM>; Sun, 15 Jul 2001 07:07:12 -0400
Received: from beasley.gator.com ([63.197.87.202]:31500 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266051AbRGOLHE>; Sun, 15 Jul 2001 07:07:04 -0400
From: "George Bonser" <george@gator.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 04:11:33 -0700
Message-ID: <CHEKKPICCNOGICGMDODJOEEMDKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <15185.27251.356109.500135@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While it is still the wee hours ... 4am here ... the change in TTL has
resulted in a 10% increase in bandwidth to my server farms so far. It
appears to be a substantial improvement.


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of David S. Miller
> Sent: Sunday, July 15, 2001 3:04 AM
> To: George Bonser
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Linux default IP ttl
>
>
>
> George Bonser writes:
>  > This has reduced considerably the number of ICMP messages
> where a packet has
>  > expired
>  > in transit from my server farms. Looks like there are a lot of
> clients out
>  > there running
>  > (apparently) modern Microsoft OS versions with networks having
> a lot of hops
>  > (more than 64).
>
> Why are there 64 friggin hops between machine in your server farm?
> That is what I want to know.  It makes no sense, even over today's
> internet, to have more than 64 hops between two sites.
>
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

