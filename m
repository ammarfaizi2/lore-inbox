Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSJCWdx>; Thu, 3 Oct 2002 18:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261403AbSJCWdx>; Thu, 3 Oct 2002 18:33:53 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:49418 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261402AbSJCWdx>; Thu, 3 Oct 2002 18:33:53 -0400
Date: Fri, 04 Oct 2002 07:39:25 +0900 (JST)
Message-Id: <20021004.073925.101556969.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Miscellaneous clean-ups
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021004.073642.125593159.yoshfuji@linux-ipv6.org>
References: <20021004.011315.05129566.yoshfuji@linux-ipv6.org>
	<20021003.103617.04446177.davem@redhat.com>
	<20021004.073642.125593159.yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021004.073642.125593159.yoshfuji@linux-ipv6.org> (at Fri, 04 Oct 2002 07:36:42 +0900 (JST)), YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> says:

> I saw many __constant_{hton,ntoh}{s,l}()s, so fixed.
> 
>       1. use s6_addrXX instead of in6_u.s6_addrXX.
>       2. avoid using magic number.
>       3. use 32bit constants.
>  -->  4. avoid __constant_{hton,ntoh}{l,s}() in runtime code.

oops, sorry, not fixed in my fix... :-p
just a moment, please...

--yoshfuji
