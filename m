Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264784AbSJaJDQ>; Thu, 31 Oct 2002 04:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSJaJDQ>; Thu, 31 Oct 2002 04:03:16 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:19727 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S264784AbSJaJDN>; Thu, 31 Oct 2002 04:03:13 -0500
Date: Thu, 31 Oct 2002 18:08:53 +0900 (JST)
Message-Id: <20021031.180853.380251036.yoshfuji@linux-ipv6.org>
To: pekkas@netcore.fi
Cc: takamiya@po.ntts.co.jp, ajtuomin@morphine.tml.hut.fi, davem@redhat.com,
       kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, jagana@us.ibm.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.44.0210311053570.19356-100000@netcore.fi>
References: <20021031.174442.846937513.takamiya@po.ntts.co.jp>
	<Pine.LNX.4.44.0210311053570.19356-100000@netcore.fi>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: ,!^C1nUj;HDn\o}#MDnZW<|oj*]iIB/>/Rj|xZ=D=hBIY#)lQ,$n#kJvDg7at|p;w0^8&4_
 OS17ezZP7m/LlFJYPF}FdcGx!,qBM:w{Ub2#M8_@n^nYT%?u+bwTsqni(z5
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0210311053570.19356-100000@netcore.fi> (at Thu, 31 Oct 2002 10:55:56 +0200 (EET)), Pekka Savola <pekkas@netcore.fi> says:

> > (7) Source Address Selection of MN
> > 	When host acts as MN, your implementation always select HoA as the
> > 	source address. The source address should be a CoA. 
> 
> No, draft-ietf-ipv6-default-addr-select-09.txt Rule 4 says home addresses 
> should be preferred, except via a possible API interaction.

Yes, we know.

What we meant was there are some cases that we need to use actual 
address on the device, not HoA.

---yoshfuji
