Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269605AbUJSSVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269605AbUJSSVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUJSSUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:20:45 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:26121 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S269886AbUJSRZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:25:44 -0400
Date: Wed, 20 Oct 2004 02:26:22 +0900 (JST)
Message-Id: <20041020.022622.27982693.yoshfuji@linux-ipv6.org>
To: lukasz@trabinski.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: unregister_netdevice 2.6.9
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.58LT.0410191738420.2725@lt.wsisiz.edu.pl>
References: <Pine.LNX.4.58LT.0410191738420.2725@lt.wsisiz.edu.pl>
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

In article <Pine.LNX.4.58LT.0410191738420.2725@lt.wsisiz.edu.pl> (at Tue, 19 Oct 2004 17:58:58 +0200 (CEST)), Lukasz Trabinski <lukasz@trabinski.net> says:

> After shutdown/reboot :
> 
> unregister_netdevice: waiting for xxxx to become free. Usage count = 1
:
> whreis xxxx is name of sit device, created via script

Is your box acting as router, or host?
% sysctl -a |grep ipv6|grep forwarding

What is happend if you let the interface down and delete it before
becore rebooting?

Thanks.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
