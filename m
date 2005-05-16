Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVEPPfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVEPPfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVEPPfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:35:04 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:42509 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261713AbVEPPeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:34:11 -0400
Date: Tue, 17 May 2005 00:37:01 +0900 (JST)
Message-Id: <20050517.003701.96868957.yoshfuji@linux-ipv6.org>
To: william@erg.abdn.ac.uk
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: UDP-Lite Patch for linux kernel 2.6.11.x
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200505161505.j4GF5tAY026358@erg.abdn.ac.uk>
References: <200505161505.j4GF5tAY026358@erg.abdn.ac.uk>
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

In article <200505161505.j4GF5tAY026358@erg.abdn.ac.uk> (at Mon, 16 May 2005 16:05:47 +0100), "William StanisLaus" <william@erg.abdn.ac.uk> says:

> Please take a look at UDP-Lite document @
> http://www.erg.abdn.ac.uk/users/william/udp-lite/Linux%20Kernel%20Update%20f
> or%20UDPLite%20protocol.doc

Grr, why doc...

UDP-Lite is SOCK_DGRAM, not SOCK_LDGRAM.
And, It is almost duplicate of UDP code.
I think it is much better to share code.
Please avoid cosmetic changes.

BTW, what's happened with checksum offloading?

--yoshfuji
