Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbULVN0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbULVN0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 08:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbULVN0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 08:26:52 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:56842 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261603AbULVN0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 08:26:50 -0500
Date: Wed, 22 Dec 2004 22:26:54 +0900 (JST)
Message-Id: <20041222.222654.126619836.yoshfuji@linux-ipv6.org>
To: kaber@trash.net
Cc: davem@davemloft.net, 7atbggg02@sneakemail.com,
       linux-kernel@vger.kernel.org, solt2@dns.toxicfilms.tv,
       yoshfuji@linux-ipv6.org
Subject: Re: what/where is ss tool ?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <41C96F24.2050409@trash.net>
References: <012f01c4e81f$f4bddbd0$0e25fe0a@pysiak>
	<20041222122758.GB6627@m.safari.iki.fi>
	<41C96F24.2050409@trash.net>
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

In article <41C96F24.2050409@trash.net> (at Wed, 22 Dec 2004 13:57:08 +0100), Patrick McHardy <kaber@trash.net> says:

> ===== net/ipv4/Kconfig 1.23 vs edited =====
> --- 1.23/net/ipv4/Kconfig	2004-11-03 21:20:02 +01:00
> +++ edited/net/ipv4/Kconfig	2004-12-22 13:52:14 +01:00
> @@ -355,7 +355,10 @@
>  	default y
>  	---help---
>  	  Support for TCP socket monitoring interface used by native Linux
> -	  tools such as ss.
> +	  tools such as ss. ss is included in iproute2, currently downloadable
> +	  at http://developer.osdl.org/dev/iproute2/. If you want IPv6 support
> +	  and have selected IPv6 as a module, you need to built this as a
> +	  module too.
>  	  

would you enclose URL by <>, like <http://...>?

--yoshfuji
