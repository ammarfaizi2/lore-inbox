Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRAGQNg>; Sun, 7 Jan 2001 11:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131245AbRAGQN0>; Sun, 7 Jan 2001 11:13:26 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:35236 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S131233AbRAGQNS>;
	Sun, 7 Jan 2001 11:13:18 -0500
Date: Sun, 7 Jan 2001 11:12:23 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <ak@suse.de>,
        <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <E14FGAx-0002es-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.30.0101071102140.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Alan Cox wrote:

> Why. Its bad enough that the networking layer doesnt let you configure out
> stuff like SACK and the big routing hashes. Please don't make it even worse
> for the embedded world. 99.9% of Linux boxes probably have less than 5 routing
> table entries

Ok. Good point.
But remember that parsing /proc for an embedded system is also not the
most healthy thing.

>
> > I could almost, but not quite, justify it right now just because "ip"
> > is becomming standard and needs it.
>
> ip is also not the smallest and simplest of binaries. You can fit an ifconfig
> for ip in about 24K
>

ip is also a replacement of many nettools: ifconfig, route, arp config,
tunneling setup etc. You can also do many funky things with it using
small scripts (ip dup-address detection is documented).
Seems like Alexey already has a wrapper "ifcfg" which is a ifconfig
replacement. It does not format display the same way as ifconfig; however,
that would only be necessary if some app is dependent on ifconfig output.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
