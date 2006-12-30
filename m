Return-Path: <linux-kernel-owner+w=401wt.eu-S1030211AbWL3BwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWL3BwV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWL3BwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:52:20 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:41377 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030211AbWL3BwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:52:20 -0500
X-Greylist: delayed 1740 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 20:52:20 EST
Date: Sat, 30 Dec 2006 10:23:58 +0900 (JST)
Message-Id: <20061230.102358.106876516.yoshfuji@linux-ipv6.org>
To: komurojun-mbn@nifty.com
Cc: bunk@stusta.de, jgarzik@pobox.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, yoshfuji@linux-ipv6.org
Subject: Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops during
 file-transfer
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20061230185043.d31d2104.komurojun-mbn@nifty.com>
References: <20061217232311.f181302f.komurojun-mbn@nifty.com>
	<20061218030113.GT10316@stusta.de>
	<20061230185043.d31d2104.komurojun-mbn@nifty.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20061230185043.d31d2104.komurojun-mbn@nifty.com> (at Sat, 30 Dec 2006 18:50:43 +0900), Komuro <komurojun-mbn@nifty.com> says:

> I investigated the ftp-file-transfer-stop problem by git-bisect method,
> and found this problem was introduced by
> "[TCP]: MD5 Signature Option (RFC2385) support" patch.
> 
> Mr.YOSHIFUJI san, please fix this problem.

Hmm, have you try disabling CONFIG_TCP_MD5SIG?
(Is it already disabled?)

Are there any specific size of transfer to reproduce this?
Do you see similar issue with other simple application?

--yoshfuji
