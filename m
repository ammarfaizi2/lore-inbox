Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTLTEto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 23:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTLTEto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 23:49:44 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:61196 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263810AbTLTEtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 23:49:43 -0500
Date: Sat, 20 Dec 2003 13:42:40 +0900 (JST)
Message-Id: <20031220.134240.30421622.yoshfuji@linux-ipv6.org>
To: rogerhc@pacbell.net, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: install_modules (or) modules_install? (main README in 2.6.0
 stable source)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200312191838.55569.rogerhc@pacbell.net>
References: <200312191838.55569.rogerhc@pacbell.net>
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

In article <200312191838.55569.rogerhc@pacbell.net> (at Fri, 19 Dec 2003 18:38:55 -0800), Roger Chrisman <rogerhc@pacbell.net> says:

> Am I correct that
>                                 install_modules
> should be
>                                 module_install
> ?

Of course not; it should be modules_install :-)
                                  ~

===== README 1.12 vs edited =====
--- 1.12/README	Sun Oct  5 15:50:49 2003
+++ edited/README	Sat Dec 20 13:38:43 2003
@@ -119,7 +119,7 @@
    cd /usr/src/linux-2.6.N
    make O=/home/name/build/kernel menuconfig
    make O=/home/name/build/kernel
-   sudo make O=/home/name/build/kernel install_modules install
+   sudo make O=/home/name/build/kernel modules_install install
 
    Please note: If the 'O=output/dir' option is used then it must be
    used for all invocations of make.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
