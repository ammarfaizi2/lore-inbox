Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWJFM5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWJFM5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 08:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWJFM5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 08:57:13 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:48143 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751353AbWJFM5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 08:57:11 -0400
Date: Fri, 06 Oct 2006 21:59:35 +0900 (JST)
Message-Id: <20061006.215935.92667295.yoshfuji@linux-ipv6.org>
To: joro-lkml@zlug.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 01/02] net/ipv6: seperate sit driver to extra module
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20061006093402.GA12460@zlug.org>
References: <20061006093402.GA12460@zlug.org>
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

In article <20061006093402.GA12460@zlug.org> (at Fri, 6 Oct 2006 11:34:02 +0200), Joerg Roedel <joro-lkml@zlug.org> says:

> this is the submit of the patch discussed yesterday to compile the sit
> driver as a seperate module.
> 
> changes to yesterday:
> - default select changed to y in Kconfig
> - added ifdefs to net/ipv6/addrconf.c
>   (this part is big, to keep the patches around 100 lines the
>    addrconf.c changes are posted in a seperate patch)
> 
> Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

> +         into IPv4 packets. This is usefull if you want to connect two IPv6
                                       ~~~~~~~useful

Otherwise, it seems okay to me.

--yoshfuji
