Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262699AbSI1EZK>; Sat, 28 Sep 2002 00:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262700AbSI1EZK>; Sat, 28 Sep 2002 00:25:10 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:51213 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262699AbSI1EZJ>; Sat, 28 Sep 2002 00:25:09 -0400
Date: Sat, 28 Sep 2002 13:30:19 +0900 (JST)
Message-Id: <20020928.133019.38287529.yoshfuji@linux-ipv6.org>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200209280419.IAA02894@sex.inr.ac.ru>
References: <20020927.203606.32735488.davem@redhat.com>
	<200209280419.IAA02894@sex.inr.ac.ru>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200209280419.IAA02894@sex.inr.ac.ru> (at Sat, 28 Sep 2002 08:19:29 +0400 (MSD)), kuznet@ms2.inr.ac.ru says:

> This is just extending ipv6 routing entry with a field to hold
> source address and, generally, making the same work as IPv4 does,
> with all the advantages, particularily capability to select preferred
> source address via routes set up by admin (RTA_PREFSRC attribute,
> "src" in "ip route add").

we need per socket preference.
can we do that with this?

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
