Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269755AbTGKBr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbTGKBr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:47:58 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:21000 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S269755AbTGKBrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:47:55 -0400
Date: Fri, 11 Jul 2003 11:03:58 +0900 (JST)
Message-Id: <20030711.110358.32018240.yoshfuji@linux-ipv6.org>
To: andre@tomt.net
Cc: linux-kernel@vger.kernel.org, mika.liljeberg@welho.com, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling broken
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1057888154.26854.324.camel@localhost>
References: <20030710233931.GG1722@zip.com.au>
	<1057881869.3588.10.camel@hades>
	<1057888154.26854.324.camel@localhost>
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

In article <1057888154.26854.324.camel@localhost> (at 11 Jul 2003 03:49:14 +0200), Andre Tomt <andre@tomt.net> says:

> Thanks for the explanation, I've been struggling to understand what
> Yoshfuji tried to explain to me earlier on this topic (see "IPv6 bugs
> introduced in 2.4.21" - ie. my bogus bugreport), now it all makes
> perfect sense :-)

Sorry for my poor explanation...


> If you don't have anything but one /64 for example.. I guess /126's
> would be ok as you could rule out the the anycast address? It will
> probably work with Linux - but is it wrong in any sense, other than
> "breaking" with EUI-64/autoconfiguration?

I don't think so, but I won't recoomend doing this.
(I even don't assign global addresses to p-t-p interface at all.)

--yoshfuji
