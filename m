Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVBELkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVBELkK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVBELkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:40:09 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:7694 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S264912AbVBELiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 06:38:02 -0500
Date: Sat, 05 Feb 2005 20:39:00 +0900 (JST)
Message-Id: <20050205.203900.66065862.yoshfuji@linux-ipv6.org>
To: andre@tomt.net
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, shemminger@osdl.org, yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <4204AA7C.9010509@tomt.net>
References: <20050204213813.4bd642ad.davem@davemloft.net>
	<20050205061110.GA18275@gondor.apana.org.au>
	<4204AA7C.9010509@tomt.net>
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

In article <4204AA7C.9010509@tomt.net> (at Sat, 05 Feb 2005 12:14:04 +0100), Andre Tomt <andre@tomt.net> says:

> This patch fixes my problems with hangs when dot1q VLAN interfaces gets 
> removed when loopback is down, as reported in the thread "2.6.10 
> ipv6/8021q lockup on vconfig on interface removal".

Please tell me, why your lo is down...

Anyway, if we really want to "fix" this,
we should do in other way.

I think "Make loopback idev stick around" patches
(for IPv4 and IPv6) could be start of that.

--yoshfuji
