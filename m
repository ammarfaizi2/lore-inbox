Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266044AbRGOKf5>; Sun, 15 Jul 2001 06:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbRGOKfs>; Sun, 15 Jul 2001 06:35:48 -0400
Received: from 24-25-197-107.san.rr.com ([24.25.197.107]:34813 "HELO
	sink.san.rr.com") by vger.kernel.org with SMTP id <S266044AbRGOKfj>;
	Sun, 15 Jul 2001 06:35:39 -0400
Date: Sun, 15 Jul 2001 03:35:41 -0700
From: acmay@acmay.homeip.net
To: "David S. Miller" <davem@redhat.com>
Cc: George Bonser <george@gator.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux default IP ttl
Message-ID: <20010715033541.B5369@sink.san.rr.com>
In-Reply-To: <CHEKKPICCNOGICGMDODJIEEIDKAA.george@gator.com> <15185.27251.356109.500135@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15185.27251.356109.500135@pizda.ninka.net>; from davem@redhat.com on Sun, Jul 15, 2001 at 03:03:31AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 03:03:31AM -0700, David S. Miller wrote:
> 
> George Bonser writes:
>  > This has reduced considerably the number of ICMP messages where a packet has
>  > expired
>  > in transit from my server farms. Looks like there are a lot of clients out
>  > there running
>  > (apparently) modern Microsoft OS versions with networks having a lot of hops
>  > (more than 64).
> 
> Why are there 64 friggin hops between machine in your server farm?
> That is what I want to know.  It makes no sense, even over today's
> internet, to have more than 64 hops between two sites.

I seem to recall seeing an NT box setup as a router and it decided to
decrement the TTL by 128 every time instead of 1. 
