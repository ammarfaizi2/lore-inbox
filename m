Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbTLLNFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264576AbTLLNFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:05:30 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:7178 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264575AbTLLNF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:05:27 -0500
Date: Fri, 12 Dec 2003 21:58:37 +0900 (JST)
Message-Id: <20031212.215837.31545329.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org
Subject: sysctl vs /proc/sys
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
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

Hello.

sysctl(2) seems to be deprecated, but
IMHO, /proc/sys cannot be the alternative
because it cannot return "previous" value atomicly.

I would say it is okay to leave sysctl(2)
because the interface is very common.
Or, I'd rather propose introducing sysctlbyname(2).

.. or do I miss something?

--yoshfuji
