Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTKGCXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 21:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTKGCXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 21:23:37 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:55312 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S261321AbTKGCXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 21:23:37 -0500
Date: Fri, 07 Nov 2003 11:23:45 +0900 (JST)
Message-Id: <20031107.112345.72209310.yoshfuji@linux-ipv6.org>
To: jeff.zheng@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why size of sockaddr smaller than size of sockaddr_in6?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E07EC27@pdsmsx403.ccr.corp.intel.com>
References: <37FBBA5F3A361C41AB7CE44558C3448E07EC27@pdsmsx403.ccr.corp.intel.com>
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

In article <37FBBA5F3A361C41AB7CE44558C3448E07EC27@pdsmsx403.ccr.corp.intel.com> (at Fri, 7 Nov 2003 10:04:05 +0800), "Zheng, Jeff" <jeff.zheng@intel.com> says:

> I thought that sockaddr should hold sockaddr_in sockaddr_in6 and any other socket address (or at least sockaddr_in6). 

No, we do not change sockaddr{}.
use sockaddr_storage{} for that purpose.
Please read RFC 3493.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
