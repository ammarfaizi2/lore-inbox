Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTFGGfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTFGGfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:35:53 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:23819 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262263AbTFGGfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:35:41 -0400
Date: Sat, 07 Jun 2003 15:49:58 +0900 (JST)
Message-Id: <20030607.154958.108408804.yoshfuji@wide.ad.jp>
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on
 CONFIG_EMBEDDED
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20030607063424.GA12616@averell>
References: <20030607063424.GA12616@averell>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030607063424.GA12616@averell> (at Sat, 7 Jun 2003 08:34:24 +0200), Andi Kleen <ak@muc.de> says:

> I finally got sick of seeing bug reports from people who did not enable
> CONFIG_VT or forgot to enable the obscure options for the keyboard
> driver. This is especially a big problem for people who do make oldconfig
> with a 2.4 configuration, but seems to happen in general often.
> I also included the PS/2 mouse driver. It is small enough and a useful
> fallback on any PC.

Why isn't it enough to change default to "y"?
Not showing the config is not good.
I want to disable it while using standard (not embeded) PC.

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
