Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTFBMfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTFBMfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:35:38 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:58377 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262269AbTFBMfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:35:37 -0400
Date: Mon, 02 Jun 2003 21:48:13 +0900 (JST)
Message-Id: <20030602.214813.38441799.yoshfuji@linux-ipv6.org>
To: herbert@gondor.apana.org.au
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Include missing headers
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030602123438.GA13415@gondor.apana.org.au>
References: <20030602123438.GA13415@gondor.apana.org.au>
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

In article <20030602123438.GA13415@gondor.apana.org.au> (at Mon, 2 Jun 2003 22:34:38 +1000), Herbert Xu <herbert@gondor.apana.org.au> says:

>  #define _LINUX_IN_H
>  
> +#include <linux/socket.h>
>  #include <linux/types.h>
>  
>  /* Standard well-defined IP protocols.  */

It is much natural to include linux/types.h before linux/socket.h.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
