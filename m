Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266642AbTGKIss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269831AbTGKIss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:48:48 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:19723 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S266642AbTGKIsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:48:47 -0400
Date: Fri, 11 Jul 2003 18:04:49 +0900 (JST)
Message-Id: <20030711.180449.126456521.yoshfuji@linux-ipv6.org>
To: pekkas@netcore.fi
Cc: mika.liljeberg@welho.com, andre@tomt.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0307111143470.26262-100000@netcore.fi>
References: <20030711.143926.599349332.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.44.0307111143470.26262-100000@netcore.fi>
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

In article <Pine.LNX.4.44.0307111143470.26262-100000@netcore.fi> (at Fri, 11 Jul 2003 11:46:00 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:

> > I don't like this
> > while I would be ok to have configuration option
> > not to support anycast.
> 
> With "not to support anycast" you probably meant "not to support
> subnet-router anycast address [automatically, in the kernel, as now]" ?  
> These are entirely different things.

I meant disabling anycast entirely.

> (Note that if there's a user-level API for setting anycast addresses, one 
> could kick the subnet-router anycast address out of the kernel too.  
> Whether that's desirable is another thing.)

We have but we cannot; it is refcnt'ed.

--yoshfuji
