Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWFHLDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWFHLDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWFHLDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:03:14 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:34064 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S964823AbWFHLDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:03:11 -0400
Date: Thu, 08 Jun 2006 20:03:49 +0900 (JST)
Message-Id: <20060608.200349.81316352.yoshfuji@linux-ipv6.org>
To: gerrit@erg.abdn.ac.uk
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, kaber@coreworks.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH 2.6.17-rc6-mm1 ] net: RFC 3828-compliant UDP-Lite
 support
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200606081150.34018@this-message-has-been-logged>
References: <200606081150.34018@this-message-has-been-logged>
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

In article <200606081150.34018@this-message-has-been-logged> (at Thu, 8 Jun 2006 11:50:33 +0100), Gerrit Renker <gerrit@erg.abdn.ac.uk> says:

> Attached is an extension which adds RFC3828 - compliant UDP-Lite functionality 
> to the IPv4 networking stack. 
:
>  net/core/sock.c                       |    7
>  net/ipv4/af_inet.c                    |   64 +
>  net/ipv4/proc.c                       |   32
>  net/udp_lite/Kbuild                   |    1
>  net/udp_lite/Kconfig                  |   20
>  net/udp_lite/udplitev4.c              | 1730 ++++++++++++++++++++++++++++++++++
>  19 files changed, 2296 insertions(+), 22 deletions(-)

Plase do the ipv6 side.  Thank you.

BTW, is it possible to do merge or share codes among the following things?
 - udp / udp-lite (=> net/ipv4, net/ipv6)
and/or
 - udp-lite/ipv6 / udp-lite/ipv4 (=> net/udplite)

Regards,

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
