Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136149AbREGQfy>; Mon, 7 May 2001 12:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136284AbREGQfn>; Mon, 7 May 2001 12:35:43 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:26897 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S136149AbREGQfd>; Mon, 7 May 2001 12:35:33 -0400
Date: Mon, 7 May 2001 17:35:15 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: "David S. Miller" <davem@redhat.com>
cc: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <15092.32371.139915.110859@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0105071730090.23021-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 May 2001, David S. Miller wrote:

>  > It adds the ability to run multiple interfaces on the same subnet,
>  > on the same machine, and have the ARPs for each interface be answered
>  > based on whether or not the kernel would route a packet from the ARP'd
>  > IP out that interface.  When used with source-based routing, this
>  > makes things work in an intuitive manner.
>
> How difficult is it to compose netfilter rules that do this?

I want this feature precisely /because/ it interferes with
packet filtering.

I sleep better knowing that my packet filters are bound to
specific interfaces (with default DENY everywhere).  I like
to know that I can ssh in via the second card on my DB
servers, without worrying about them accepting other traffic
(or performance-vital traffic going over a cheap backup
card).

Matthew.

