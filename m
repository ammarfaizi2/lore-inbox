Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUJCK41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUJCK41 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 06:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUJCK41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 06:56:27 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:7689 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S267779AbUJCK4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 06:56:25 -0400
Date: Sun, 03 Oct 2004 19:56:45 +0900 (JST)
Message-Id: <20041003.195645.08061913.yoshfuji@linux-ipv6.org>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: jmorris@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] add rotate left/right ops to bitops.h
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200410031344.54182.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410031344.54182.vda@port.imtp.ilyichevsk.odessa.ua>
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

In article <200410031344.54182.vda@port.imtp.ilyichevsk.odessa.ua> (at Sun, 3 Oct 2004 13:44:54 +0300), Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> says:

> extern inline u32 rol32(u32 x, int num)
:
Please do not use use extern inline; use static inline instead.

Thanks.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
