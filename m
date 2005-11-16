Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVKPBKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVKPBKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVKPBKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:10:24 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:32779 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965145AbVKPBKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:10:23 -0500
Date: Wed, 16 Nov 2005 10:10:57 +0900 (JST)
Message-Id: <20051116.101057.23968406.yoshfuji@linux-ipv6.org>
To: vladislav.yasevich@hp.com
Cc: yanzheng@21cn.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH]small fix for __ipv6_addr_type(...)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <437A5F42.3080100@hp.com>
References: <4376F2CE.4050003@21cn.com>
	<437A5F42.3080100@hp.com>
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

In article <437A5F42.3080100@hp.com> (at Tue, 15 Nov 2005 17:20:50 -0500), Vlad Yasevich <vladislav.yasevich@hp.com> says:

> No, according to RFC 4007, loopback is considered a link-local
> address.

Agreed. RFC3484 also explicitly says that loopback is treated as link-local.

--yoshfuji
