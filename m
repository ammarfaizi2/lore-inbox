Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268198AbTBXGha>; Mon, 24 Feb 2003 01:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268200AbTBXGha>; Mon, 24 Feb 2003 01:37:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57059 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268198AbTBXGh3>;
	Mon, 24 Feb 2003 01:37:29 -0500
Date: Sun, 23 Feb 2003 22:31:14 -0800 (PST)
Message-Id: <20030223.223114.65976206.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021101.174832.44646503.yoshfuji@linux-ipv6.org>
References: <20021031.164940.672083668.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.44.0210311021560.19356-100000@netcore.fi>
	<20021101.174832.44646503.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Fri, 01 Nov 2002 17:48:32 +0900 (JST)

   Ok, here's revised one.
   
    - sync with linux-2.5.45.
    - change default value for use_tempaddr sysctl to 0 
      (don't generate and use temprary addresses by default)
   
It is applied.

Hmmm, some thinking is needed in order to backport this to
2.4.x due to lack of crypto library.  I guess USAGI 2.4.x
version of this patch uses crypto library from USAGI 2.4.x ipsec?
