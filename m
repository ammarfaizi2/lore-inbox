Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSKCMCb>; Sun, 3 Nov 2002 07:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSKCMCb>; Sun, 3 Nov 2002 07:02:31 -0500
Received: from netcore.fi ([193.94.160.1]:51722 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S261829AbSKCMCa>;
	Sun, 3 Nov 2002 07:02:30 -0500
Date: Sun, 3 Nov 2002 14:08:49 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: Andras Kis-Szabo <kisza@securityaudit.hu>
cc: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>,
       <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>,
       Netfilter Devel <netfilter-devel@lists.netfilter.org>,
       "David S. Miller" <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>,
       <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Functions Clean-up
In-Reply-To: <1036328414.1048.3.camel@arwen>
Message-ID: <Pine.LNX.4.44.0211031407270.27836-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Andras Kis-Szabo wrote:
> >  - export route6_me_harder() as ip6_route_harder() and
> >    use it from net/ipv6/netfilter/ip6_queue.c.
> Opsz!
> At the extension parser code we got that decision that we should use
> our own parser in the Netfilter code! (And we should not to trust in the
> kernel.)
> This patch removes one function from the Netfilter code and forces the
> Netfilter to use a similar function from the kernel's one!

And why is that a problem?

If there is a problem in main kernel code, it should fixed.  If the 
netfilter version is better, the main kernel code should be changed.

Are there specific reasons to keep them separate?

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

