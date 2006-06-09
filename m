Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbWFIN2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbWFIN2i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbWFIN2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:28:38 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:41746 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965257AbWFIN2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:28:37 -0400
Date: Fri, 09 Jun 2006 22:29:15 +0900 (JST)
Message-Id: <20060609.222915.60108698.yoshfuji@linux-ipv6.org>
To: gerrit@erg.abdn.ac.uk
Cc: davem@davemloft.net, jmorris@namei.org, alan@lxorguk.ukuu.org.uk,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, kaber@coreworks.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6.17-rc6-mm1 ] net: RFC 3828-compliant UDP-Lite
 support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200606091036.42075.gerrit@erg.abdn.ac.uk>
References: <200606082109.34338.gerrit@erg.abdn.ac.uk>
	<20060608.151347.55505744.davem@davemloft.net>
	<200606091036.42075.gerrit@erg.abdn.ac.uk>
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

In article <200606091036.42075.gerrit@erg.abdn.ac.uk> (at Fri, 9 Jun 2006 10:36:41 +0100), Gerrit Renker <gerrit@erg.abdn.ac.uk> says:

> Thank you for your replies and comments, I will be back when the v6 side is ready.

Please fix the following as well.

1. Put your code in net/ipv4, probably as udplite.c, and remove net/udp-lite/.
   Similarly, plasse put implementation as net/ipv6/udplite.c.
2. Eliminate any cosmetic changes (space, new-line, coding style etc.);
   minimize diffs between udp.c udplite.c

BTW, I cannot find descriptions about fragmentation of 
UDP-Lite in the spec.  Is it yours?

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
