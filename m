Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVEFX5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVEFX5U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVEFX5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:57:10 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:5639 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261313AbVEFXyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:54:10 -0400
Date: Sat, 07 May 2005 08:56:39 +0900 (JST)
Message-Id: <20050507.085639.75977025.yoshfuji@linux-ipv6.org>
To: bunk@stusta.de, davem@davemloft.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [RFC: 2.6 patch] net/ipv6/ipv6_syms.c: unexport fl6_sock_lookup
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20050506232000.GC3590@stusta.de>
References: <20050506232000.GC3590@stusta.de>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050506232000.GC3590@stusta.de> (at Sat, 7 May 2005 01:20:00 +0200), Adrian Bunk <bunk@stusta.de> says:

> There is no usage of this EXPORT_SYMBOL in the kernel.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

> --- linux-2.6.12-rc3-mm3-full/net/ipv6/ipv6_syms.c.old	2005-05-05 22:23:17.000000000 +0200
> +++ linux-2.6.12-rc3-mm3-full/net/ipv6/ipv6_syms.c	2005-05-05 22:23:23.000000000 +0200
> @@ -37,5 +37,4 @@
>  EXPORT_SYMBOL(xfrm6_rcv);
>  #endif
>  EXPORT_SYMBOL(rt6_lookup);
> -EXPORT_SYMBOL(fl6_sock_lookup);
>  EXPORT_SYMBOL(ipv6_push_nfrag_opts);
> 
> 
