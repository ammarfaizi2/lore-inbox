Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268177AbTBXGst>; Mon, 24 Feb 2003 01:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268179AbTBXGst>; Mon, 24 Feb 2003 01:48:49 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:32779 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S268177AbTBXGss>; Mon, 24 Feb 2003 01:48:48 -0500
Date: Mon, 24 Feb 2003 15:58:52 +0900 (JST)
Message-Id: <20030224.155852.611429637.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Privacy Extensions for Stateless Address
 Autoconfiguration in IPv6
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20030223.223114.65976206.davem@redhat.com>
References: <Pine.LNX.4.44.0210311021560.19356-100000@netcore.fi>
	<20021101.174832.44646503.yoshfuji@linux-ipv6.org>
	<20030223.223114.65976206.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030223.223114.65976206.davem@redhat.com> (at Sun, 23 Feb 2003 22:31:14 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

> Hmmm, some thinking is needed in order to backport this to
> 2.4.x due to lack of crypto library.  I guess USAGI 2.4.x
> version of this patch uses crypto library from USAGI 2.4.x ipsec?

MD5 code in linux-2.4.x patch what I sent you was taken from 
Colin Plumb's public domain implementation.  
(USAGI itself uses KAME implementation.)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
