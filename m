Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWFHOhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWFHOhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWFHOhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:37:42 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:6417 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S964839AbWFHOhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:37:41 -0400
Date: Thu, 08 Jun 2006 23:38:16 +0900 (JST)
Message-Id: <20060608.233816.36365945.yoshfuji@linux-ipv6.org>
To: alan@lxorguk.ukuu.org.uk
Cc: gerrit@erg.abdn.ac.uk, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@namei.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6.17-rc6-mm1 ] net: RFC 3828-compliant UDP-Lite
 support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1149778072.22124.6.camel@localhost.localdomain>
References: <200606081150.34018@this-message-has-been-logged>
	<1149778072.22124.6.camel@localhost.localdomain>
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

In article <1149778072.22124.6.camel@localhost.localdomain> (at Thu, 08 Jun 2006 15:47:52 +0100), Alan Cox <alan@lxorguk.ukuu.org.uk> says:

> Ar Iau, 2006-06-08 am 11:50 +0100, ysgrifennodd Gerrit Renker:
> > +  UDP-Lite introduces a new socket type, the SOCK_LDGRAM (note the L) for
> > +  lightweight, connection-less services. These are the socket options:
:
> 	s = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDPLITE);
> 
> is probably the right way to do this, keeping 0 "default" as before
> meaning IPPROTO_UDP

I do think so, too.

--yoshfuji
