Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269895AbTGKKrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269896AbTGKKrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:47:55 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:47115 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S269895AbTGKKrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:47:51 -0400
Date: Fri, 11 Jul 2003 20:03:57 +0900 (JST)
Message-Id: <20030711.200357.33143193.yoshfuji@linux-ipv6.org>
To: pekkas@netcore.fi
Cc: mika.liljeberg@welho.com, andre@tomt.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0307111358440.27351-100000@netcore.fi>
References: <20030711.195917.89662318.yoshfuji@linux-ipv6.org>
	<Pine.LNX.4.44.0307111358440.27351-100000@netcore.fi>
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

In article <Pine.LNX.4.44.0307111358440.27351-100000@netcore.fi> (at Fri, 11 Jul 2003 13:59:14 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:

> > So, you cannot remove subnet router anycast address from
> > kernel via this interface; kernel keeps one reference.
> 
> .. which is why kernel shouldn't keep *any* reference *at all*!

No, it is because REQUIRED and UNREMOVABLE anycast address.
I don't think it is good to change this.

--yoshfuji
