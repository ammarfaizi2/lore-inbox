Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbSKCLyC>; Sun, 3 Nov 2002 06:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSKCLyC>; Sun, 3 Nov 2002 06:54:02 -0500
Received: from mail02.axelero.hu ([195.228.240.77]:3741 "EHLO addu.axelero.hu")
	by vger.kernel.org with ESMTP id <S261749AbSKCLyB>;
	Sun, 3 Nov 2002 06:54:01 -0500
Date: Sun, 03 Nov 2002 14:00:14 +0100
From: Andras Kis-Szabo <kisza@securityaudit.hu>
Subject: Re: [PATCH] IPv6: Functions Clean-up
In-reply-to: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
To: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>,
       Netfilter Devel <netfilter-devel@lists.netfilter.org>,
       "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Message-id: <1036328414.1048.3.camel@arwen>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>  - export route6_me_harder() as ip6_route_harder() and
>    use it from net/ipv6/netfilter/ip6_queue.c.
Opsz!
At the extension parser code we got that decision that we should use
our own parser in the Netfilter code! (And we should not to trust in the
kernel.)
This patch removes one function from the Netfilter code and forces the
Netfilter to use a similar function from the kernel's one!

Regards,

	kisza
 
-- 
    Andras Kis-Szabo       Security Development, Design and Audit
-------------------------/        Zorp, NetFilter and IPv6
 kisza@SecurityAudit.hu /------------------------------------------->

