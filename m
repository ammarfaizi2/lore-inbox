Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268085AbTBWJYa>; Sun, 23 Feb 2003 04:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268086AbTBWJY3>; Sun, 23 Feb 2003 04:24:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45533 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268085AbTBWJY3>;
	Sun, 23 Feb 2003 04:24:29 -0500
Date: Sun, 23 Feb 2003 01:18:16 -0800 (PST)
Message-Id: <20030223.011816.108201183.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Functions Clean-up
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
References: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Sun, 03 Nov 2002 11:54:27 +0900 (JST)
   
   This patch cleans up functions in ipv6 stack:
   
    - export route6_me_harder() as ip6_route_harder() and
      use it from net/ipv6/netfilter/ip6_queue.c.
    - make ip6_addr_prefix() to generate prefix of given address and
      prefix length, instead of doing "ipv6_copy_addr() then
      ipv6_wash_prefix()."
   
Please change new name to ip6_route_me_harder().  When one
says "something me harder" is has amusing implications when
heard by most english speakers and I'd like to keep this :-)

I will apply this patch once you make the change.  Would you
like me to add it to 2.4.x as well?

We really need to revisit USAGI patch backlog.  I have and will apply
privacy extension 2.5.x patch you sent.  For all the others please
feel free to "patch bomb" me :-) Please indicate with each patch
whether the it is desired in 2.4.x as well.

If you wish to concentrate on ipv6 ipsec first, that is ok too. :-)

