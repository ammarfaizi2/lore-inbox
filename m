Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbSI1FNE>; Sat, 28 Sep 2002 01:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbSI1FNE>; Sat, 28 Sep 2002 01:13:04 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:64269 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S262715AbSI1FND>; Sat, 28 Sep 2002 01:13:03 -0400
Date: Sat, 28 Sep 2002 14:14:07 +0900 (JST)
Message-Id: <20020928.141407.110833680.yoshfuji@linux-ipv6.org>
To: usagi@linux-ipv6.org, kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <200209280444.IAA02959@sex.inr.ac.ru>
References: <20020928.133019.38287529.yoshfuji@linux-ipv6.org>
	<200209280444.IAA02959@sex.inr.ac.ru>
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

In article <200209280444.IAA02959@sex.inr.ac.ru> (at Sat, 28 Sep 2002 08:44:29 +0400 (MSD)), kuznet@ms2.inr.ac.ru says:

> I am not sure that it is really interesting though. Just now I cannot
> imagine what user can invent which is not covered by system-wide rules,
> bind() and IP{V6}_PKTINFO. Well, if you think more hairy scheme is interesting,
> feel free to implement this.

we need per application (per socket) interface
for privacy extension (public address vs temporary address) and 
mobile ip (home address vs care-of address).

--
yoshfuji
