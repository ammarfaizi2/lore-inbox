Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269459AbTGJQCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269455AbTGJQCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:02:52 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:28678 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S266365AbTGJQCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:02:51 -0400
Date: Fri, 11 Jul 2003 01:18:58 +0900 (JST)
Message-Id: <20030711.011858.117900702.yoshfuji@linux-ipv6.org>
To: pekkas@netcore.fi
Cc: cat@zip.com.au, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling broken
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0307101906160.18224-100000@netcore.fi>
References: <20030711.005542.04973601.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.44.0307101906160.18224-100000@netcore.fi>
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

In article <Pine.LNX.4.44.0307101906160.18224-100000@netcore.fi> (at Thu, 10 Jul 2003 19:08:20 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:

> While technically correct, I'm still not sure if this is (pragmatically) 
> the correct approach.  It's OK to set a default route to go to the 
> subnet routers anycast address (so, setting a route to prefix:: should 
> not give you EINVAL).

But, on the other side cannot use prefix::, and
the setting is rather non-sense.

We should educate people not to use /127; use /64 instead.
v6ops? :-)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
