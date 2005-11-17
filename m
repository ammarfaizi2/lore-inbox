Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbVKQC7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbVKQC7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 21:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbVKQC7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 21:59:12 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:49419 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1161091AbVKQC7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 21:59:12 -0500
Date: Thu, 17 Nov 2005 11:59:48 +0900 (JST)
Message-Id: <20051117.115948.117652717.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org
Subject: Compilation Error in arch/i386/apm.c
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
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

Failed to compile current git tree.

% make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  CHK     usr/initramfs_list
  CC [M]  arch/i386/kernel/apm.o
arch/i386/kernel/apm.c: In function `apm_init':
arch/i386/kernel/apm.c:2304: error: `pm_active' undeclared (first use in this function)
arch/i386/kernel/apm.c:2304: error: (Each undeclared identifier is reported only once
arch/i386/kernel/apm.c:2304: error: for each function it appears in.)
arch/i386/kernel/apm.c: In function `apm_exit':
arch/i386/kernel/apm.c:2410: error: `pm_active' undeclared (first use in this function)
make[1]: *** [arch/i386/kernel/apm.o] Error 1
make: *** [arch/i386/kernel] Error 2

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
