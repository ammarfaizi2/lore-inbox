Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVAHD2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVAHD2q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 22:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVAHDPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 22:15:55 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:51468 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261789AbVAHC7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 21:59:38 -0500
Date: Sat, 08 Jan 2005 11:59:59 +0900 (JST)
Message-Id: <20050108.115959.123256742.yoshfuji@linux-ipv6.org>
To: coody@netease.com
Cc: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: Wrong value in the cp936 (gb2312) codepage.
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1105150357.1833.4.camel@mattwu>
References: <1105150357.1833.4.camel@mattwu>
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

In article <1105150357.1833.4.camel@mattwu> (at 08 Jan 2005 10:14:30 +0800), matt <coody@netease.com> says:

> in /linux/fs/nls/nls_cp936.c:
> 
> static wchar_t c2u_B1[256] = {
> ...
> 0x5351,0xF963,0x8F88,0x80CC,0x8D1D,0x94A1,0x500D,0x72C8,/* 0xB0-0xB7 */
> ...
> };
> 
> For 0xb1, 0xb1, the correct value should be 0x5317. You can get it at
> www.microsoft.com/globaldev/reference/dbcs/936/936_B1.htm.
> 
> I didn't check all of them. But it should have possibility of containing
> more wrong values. Maybe these tables need to be re-generated.

It seems there're over 100 differences.

--yoshfuji
