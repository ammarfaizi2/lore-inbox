Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTIDRMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTIDRMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:12:40 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:40968 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S265224AbTIDRMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:12:38 -0400
Date: Fri, 05 Sep 2003 02:13:07 +0900 (JST)
Message-Id: <20030905.021307.123497946.yoshfuji@linux-ipv6.org>
To: jfbeam@bluetronic.net
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       yoshfuji@linux-ipv6.org
Subject: Re: /proc/net/* read drops data
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.GSO.4.33.0309041223430.13584-100000@sweetums.bluetronic.net>
References: <20030904004638.1d4b001d.davem@redhat.com>
	<Pine.GSO.4.33.0309041223430.13584-100000@sweetums.bluetronic.net>
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

In article <Pine.GSO.4.33.0309041223430.13584-100000@sweetums.bluetronic.net> (at Thu, 4 Sep 2003 12:25:16 -0400 (EDT)), Ricky Beam <jfbeam@bluetronic.net> says:

> The list:
> (file)			(bs=1)	(bs=10000)
> /proc/net/igmp		122     191
> /proc/net/route		128     384
> /proc/net/rt_acct	0	4096
> /proc/net/rt_cache	384     512
> /proc/net/tcp		1800    1950
> /proc/net/udp		1024    1152

Okay, I'll seek the code.
--yoshfuji
