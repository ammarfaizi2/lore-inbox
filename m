Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTIMKYy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 06:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbTIMKYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 06:24:53 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:59666 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262111AbTIMKYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 06:24:53 -0400
Date: Sat, 13 Sep 2003 19:25:35 +0900 (JST)
Message-Id: <20030913.192535.114458752.yoshfuji@linux-ipv6.org>
To: james.harper@bigpond.com
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: oops in inet_bind/tcp_v4_get_port
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <3F62EA61.1000804@bigpond.com>
References: <3F62EA61.1000804@bigpond.com>
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

In article <3F62EA61.1000804@bigpond.com> (at Sat, 13 Sep 2003 19:58:57 +1000), James Harper <james.harper@bigpond.com> says:

> I get a null pointer exception in the same routine when restarting slapd 
> in 2.6.0-test5, and it hangs my system hard. I'm investigating now. If 
> anyone has a patch already please send me a copy too!

Have you tried to disable kernek preemption?

--yoshfuji
