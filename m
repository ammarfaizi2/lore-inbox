Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268003AbTBWAen>; Sat, 22 Feb 2003 19:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbTBWAen>; Sat, 22 Feb 2003 19:34:43 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:59400 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S268003AbTBWAem>; Sat, 22 Feb 2003 19:34:42 -0500
Date: Sun, 23 Feb 2003 09:44:42 +0900 (JST)
Message-Id: <20030223.094442.107718872.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: kazunori@miyazawa.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, usagi@linux-ipv6.org, kunihiro@ipinfusion.com
Subject: Re: [PATCH] IPv6 IPSEC support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030222.154753.133994666.davem@redhat.com>
References: <20030222.031326.103246837.davem@redhat.com>
	<20030222.214935.134101784.yoshfuji@linux-ipv6.org>
	<20030222.154753.133994666.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030222.154753.133994666.davem@redhat.com> (at Sat, 22 Feb 2003 15:47:53 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

> One example, xfrm_lookup() gets this xfrm_afinfo pointer, and it can
> use it to learn how to compare addresses.  The xfrm_afinfo pointer
> is also passed to xfrm_bundle_create() which uses it to learn how
> to lookup tunnel routes.
> 
> A small net/ipv6/xfrm_ipv6.c module is created, which registers
> a xfrm_afinfo structure to the generic xfrm engine, it teaches
> how to do these operations for AF_INET6 xfrm objects.
> 
> Do you think this can work?

I suppose so.  We'll try to work on it.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
