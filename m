Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbULNC3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbULNC3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbULNC3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:29:01 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:23056 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261369AbULNC27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:28:59 -0500
Date: Tue, 14 Dec 2004 11:30:23 +0900 (JST)
Message-Id: <20041214.113023.65866789.yoshfuji@linux-ipv6.org>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH][v3][16/21] IPoIB IPv6 support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20041213109.iziHvQZqtmP83gmx@topspin.com>
References: <20041213109.5NKezuGE9PMejMSM@topspin.com>
	<20041213109.iziHvQZqtmP83gmx@topspin.com>
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

In article <20041213109.iziHvQZqtmP83gmx@topspin.com> (at Mon, 13 Dec 2004 10:09:46 -0800), Roland Dreier <roland@topspin.com> says:

>  }
> @@ -1794,6 +1801,7 @@
>  	if ((dev->type != ARPHRD_ETHER) && 
>  	    (dev->type != ARPHRD_FDDI) &&
>  	    (dev->type != ARPHRD_IEEE802_TR) &&
> +	    (dev->type != ARPHRD_INFINIBAND) &&
>  	    (dev->type != ARPHRD_ARCNET)) {
>  		/* Alas, we support only Ethernet autoconfiguration. */
>  		return;

Please put ARPHRD_INFINIBAND after ARPHRD_ARCNET like other places.

--yoshfuji
