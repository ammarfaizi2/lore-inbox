Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTKZRVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTKZRVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:21:15 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:43780 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264260AbTKZRVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:21:11 -0500
Date: Thu, 27 Nov 2003 02:21:28 +0900 (JST)
Message-Id: <20031127.022128.79435641.yoshfuji@linux-ipv6.org>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: BUG (non-kernel), can hurt developers.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.53.0311261153050.10929@chaos>
References: <Pine.LNX.4.53.0311261153050.10929@chaos>
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

In article <Pine.LNX.4.53.0311261153050.10929@chaos> (at Wed, 26 Nov 2003 11:54:56 -0500 (EST)), "Richard B. Johnson" <root@chaos.analogic.com> says:

> Note  to hackers. Even though this is a lib-c bug, be
> aware that many versions of the 'C' runtime library
> have a rand() function that can (read will) segfault
> in threads or signals.

How about rand_r(); reentrant version of rand()?

--yoshfuji
