Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVBELyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVBELyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVBELyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:54:16 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:10766 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261631AbVBELyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 06:54:11 -0500
Date: Sat, 05 Feb 2005 20:55:07 +0900 (JST)
Message-Id: <20050205.205507.75127320.yoshfuji@linux-ipv6.org>
To: andre@tomt.net
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
       mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, shemminger@osdl.org, yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <4204B27F.5040202@tomt.net>
References: <4204AA7C.9010509@tomt.net>
	<20050205.203900.66065862.yoshfuji@linux-ipv6.org>
	<4204B27F.5040202@tomt.net>
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

In article <4204B27F.5040202@tomt.net> (at Sat, 05 Feb 2005 12:48:15 +0100), Andre Tomt <andre@tomt.net> says:

> > Please tell me, why your lo is down...
:
> "ifdown -a" gets run on shutdown and reboot here, and ifdown -a in 
> Debian brings down loopback before any other interfaces.

Okay, thanks. (I now remember someone told me this before.) hmm...

--yoshfuji
