Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWBKRJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWBKRJm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 12:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWBKRJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 12:09:42 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:5382 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932341AbWBKRJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 12:09:41 -0500
Date: Sun, 12 Feb 2006 02:11:03 +0900 (JST)
Message-Id: <20060212.021103.76157181.yoshfuji@linux-ipv6.org>
To: davem@davemloft.net
Cc: ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Cleanups for net/ipv6/addrconf.c (kzalloc, early
 exit) v2
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200602111737.20010.ioe-lkml@rameria.de>
References: <200602091736.18000.ioe-lkml@rameria.de>
	<20060210.014853.13643277.yoshfuji@linux-ipv6.org>
	<200602111737.20010.ioe-lkml@rameria.de>
Organization: USAGI/WIDE Project
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

Hello.

In article <200602111737.20010.ioe-lkml@rameria.de> (at Sat, 11 Feb 2006 17:37:18 +0100), Ingo Oeser <ioe-lkml@rameria.de> says:

> From: Ingo Oeser <ioe-lkml@rameria.de>
> 
> Here are some possible (and trivial) cleanups.
> - use kzalloc() where possible
> - remove unused label
> - invert allocation failure test like
:
> Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>
Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

--yoshfuji
