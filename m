Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUGIUMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUGIUMR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUGIUKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:10:25 -0400
Received: from [203.178.140.15] ([203.178.140.15]:46084 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S265955AbUGIUI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:08:26 -0400
Date: Sat, 10 Jul 2004 05:08:26 +0900 (JST)
Message-Id: <20040710.050826.118122541.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: bastian@waldi.eu.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040709130553.223bdc6b.davem@redhat.com>
References: <20040709123005.086fdfc5.davem@redhat.com>
	<20040710.045904.106621629.yoshfuji@linux-ipv6.org>
	<20040709130553.223bdc6b.davem@redhat.com>
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

In article <20040709130553.223bdc6b.davem@redhat.com> (at Fri, 9 Jul 2004 13:05:53 -0700), "David S. Miller" <davem@redhat.com> says:

> On Sat, 10 Jul 2004 04:59:04 +0900 (JST)
> YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:
> 
> > David, inet6device area is created when we create first address.
> 
> We could change the ipv6 layer to allocate the private
> layer much earlier.

Okay. Yes, I think we need this anyway.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
