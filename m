Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUHESDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUHESDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHESDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:03:06 -0400
Received: from [203.178.140.15] ([203.178.140.15]:5130 "EHLO yue.st-paulia.net")
	by vger.kernel.org with ESMTP id S267857AbUHESAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:00:47 -0400
Date: Thu, 05 Aug 2004 11:01:14 -0700 (PDT)
Message-Id: <20040805.110114.42141890.yoshfuji@linux-ipv6.org>
To: arpi@thot.banki.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to read /proc/net/arp properly?
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040805175204.EFE2E38BAB@mail.mplayerhq.hu>
References: <20040805175204.EFE2E38BAB@mail.mplayerhq.hu>
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

In article <20040805175204.EFE2E38BAB@mail.mplayerhq.hu> (at Thu,  5 Aug 2004 19:52:04 +0200 (CEST)), Arpi <arpi@thot.banki.hu> says:

> The problem, i'm writting here about, is that /proc/net/arp is
> dynamicaly generated, and according to kernelsrc/net/ipv4/arp.c's
> arp_get_info(), it's done by byte offset.

:
> Possible solutions:
:

use rtnetlink.

--yoshfuji
