Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbRGOKPZ>; Sun, 15 Jul 2001 06:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGOKPP>; Sun, 15 Jul 2001 06:15:15 -0400
Received: from swm.pp.se ([195.54.133.5]:31243 "EHLO uplift.swm.pp.se")
	by vger.kernel.org with ESMTP id <S266040AbRGOKPB>;
	Sun, 15 Jul 2001 06:15:01 -0400
Date: Sun, 15 Jul 2001 12:15:03 +0200 (CEST)
From: Mikael Abrahamsson <swmike@swm.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux default IP ttl
In-Reply-To: <15185.27251.356109.500135@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0107151209290.2352-100000@uplift.swm.pp.se>
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jul 2001, David S. Miller wrote:

> Why are there 64 friggin hops between machine in your server farm?

I think he is referring to the amount of hops between him and clients
accessing his servers.

> That is what I want to know.  It makes no sense, even over today's
> internet, to have more than 64 hops between two sites.

I have seen sites that are 35 hops away. I'd say it's unlikely
to have more than 64 hops between you and any machine on the internet, but
if this guy is seeing ICMP Unreachables and it lessened when changing TTL,
then I guess there actually ARE machine out there with a lot of IP hops.

What problems could occur from raising it to 128? I'd imagine routing
loops might mean a bit more traffic, but if other major OSes are at TTL
128 and someone is actually having trouble with 64, then why not raise it?

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se


