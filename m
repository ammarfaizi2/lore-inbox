Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVKRAqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVKRAqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVKRAqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:46:50 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:63499 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751250AbVKRAqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:46:50 -0500
Date: Fri, 18 Nov 2005 09:47:21 +0900 (JST)
Message-Id: <20051118.094721.49574151.yoshfuji@linux-ipv6.org>
To: yanzheng@21cn.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [DEBUG INFO]IPv6: sleeping function called from invalid
 context.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <437D23EB.4020204@21cn.com>
References: <437D23EB.4020204@21cn.com>
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

In article <437D23EB.4020204@21cn.com> (at Fri, 18 Nov 2005 08:44:27 +0800), Yan Zheng <yanzheng@21cn.com> says:

> I get follow message when switch to single user mode and the kernel version is 2.6.15-rc1-git5.
:
> Nov 18 08:26:23 localhost kernel: Debug: sleeping function called from invalid context at mm/slab.c:2472
> Nov 18 08:26:23 localhost kernel: in_atomic():1, irqs_disabled():0
> Nov 18 08:26:23 localhost kernel:  [<c0149d5a>] kmem_cache_alloc+0x5a/0x70
> Nov 18 08:26:23 localhost kernel:  [<e0f47336>] inet6_dump_fib+0xb6/0x110 [ipv6]

I remember someone replaced GFP_ATOMIC with GFP_KERNEL...

--yoshfuji
