Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUKBOf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUKBOf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUKBOLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:11:38 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:7955 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261244AbUKBNwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:52:51 -0500
Date: Tue, 02 Nov 2004 22:53:43 +0900 (JST)
Message-Id: <20041102.225343.06193184.yoshfuji@linux-ipv6.org>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, akpm@osdl.org,
       davem@davemloft.net, yoshfuji@linux-ipv6.org
Subject: Re: IPv6 dead in -bk11
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <418781EF.7020100@pobox.com>
References: <418781EF.7020100@pobox.com>
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

In article <418781EF.7020100@pobox.com> (at Tue, 02 Nov 2004 07:47:43 -0500), Jeff Garzik <jgarzik@pobox.com> says:

> 
> IPv6 works 100% for my workstations in 2.6.10-rc2-bk2, but fails in 
> 2.6.10-rc2-bk11:
> 
> 	[jgarzik@sata g]$ ping6 www.kame.net
> 	connect: Network is unreachable

Please send me:
 % ifconfig -a
 % netstat -nr --inet6
 % ip -6 addr
 % ip -6 route
 % ip -6 neigh

Thanks.

--yoshfuji @ still trying to debug refcnt etc....
