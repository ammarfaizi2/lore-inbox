Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270465AbRHHL57>; Wed, 8 Aug 2001 07:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270468AbRHHL5t>; Wed, 8 Aug 2001 07:57:49 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:42252 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S270465AbRHHL5q>; Wed, 8 Aug 2001 07:57:46 -0400
Date: Wed, 8 Aug 2001 13:57:10 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Ben Greear <greearb@candelatech.com>
cc: Stuart Duncan <sety@perth.wni.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ARP's frustrating behavior
In-Reply-To: <3B70A0DA.DE33CB87@candelatech.com>
Message-ID: <Pine.LNX.4.31.0108081352200.21550-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, 7 Aug 2001, Ben Greear wrote:

> Stuart Duncan wrote:
> >
> > Hi,
> >
> > I'm noticing on a machine with dual NICs that they they all seem to answer
> > ARP queries, even if the request is not directed to their IP.  Here's an
> > example:
> >
>
> Evidently, this is considered a feature.  However, to turn it off:
> echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter

This doesn't work for me, which is quite annoying: the machine answers arp
for 192.168.1.254 (its IP on the private net on eth1) when arping'ed on
the official side (eth0). Networks are physically separated, the official
side is inside a big network which routes 192.168 internally, so this is
really bad. If anyone could fix it I would be pleased...

Ciao,
					Roland

