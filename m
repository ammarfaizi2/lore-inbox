Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSJIXrT>; Wed, 9 Oct 2002 19:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSJIXqh>; Wed, 9 Oct 2002 19:46:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2229 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262312AbSJIXqf>;
	Wed, 9 Oct 2002 19:46:35 -0400
Date: Wed, 09 Oct 2002 16:45:04 -0700 (PDT)
Message-Id: <20021009.164504.28085695.davem@redhat.com>
To: sekiya@sfc.wide.ad.jp
Cc: dfawcus@cisco.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Fix Prefix Length of Link-local Addresses
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <uu1jv9o3j.wl@sfc.wide.ad.jp>
References: <20021010002902.A3803@edi-view1.cisco.com>
	<20021009.162438.82081593.davem@redhat.com>
	<uu1jv9o3j.wl@sfc.wide.ad.jp>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Yuji Sekiya <sekiya@sfc.wide.ad.jp>
   Date: Thu, 10 Oct 2002 08:41:52 +0900
   
   The reason we change the prefix length  from /10 to /64 is
   following spec and adapting other imprementations.

I think Derek's explanation shows that the specification
allows the /10 behavior.

Also, I suspect that since Derek works for Cisco, some "other
implementations" behave how he describes. :-)
