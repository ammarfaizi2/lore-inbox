Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265524AbSKADXq>; Thu, 31 Oct 2002 22:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265526AbSKADXq>; Thu, 31 Oct 2002 22:23:46 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:23059 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265524AbSKADXp>; Thu, 31 Oct 2002 22:23:45 -0500
Date: Fri, 01 Nov 2002 12:27:58 +0900 (JST)
Message-Id: <20021101.122758.809131116.yoshfuji@linux-ipv6.org>
To: ajtuomin@morphine.tml.hut.fi
Cc: takamiya@po.ntts.co.jp, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, pekkas@netcore.fi,
       torvalds@transmeta.com, jagana@us.ibm.com, yoshfuji@linux-ipv6.org
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021031104146.GA18786@morphine.tml.hut.fi>
References: <20021017162624.GC16370@morphine.tml.hut.fi>
	<20021031.174442.846937513.takamiya@po.ntts.co.jp>
	<20021031104146.GA18786@morphine.tml.hut.fi>
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

In article <20021031104146.GA18786@morphine.tml.hut.fi> (at Thu, 31 Oct 2002 12:41:46 +0200), Antti Tuominen <ajtuomin@morphine.tml.hut.fi> says:

> > (4) Processing Mobility Header
> > 	How about using ip6_txoptions and hdrproc_lst?
> > 	Because Mobility header is an extension header, we think it is
> > 	reasonable way to handle it in ipv6_parse_exthdrs().
> 
> No.  We did this back in Draft 15, when all the mobility stuff was
> destination options.  Mobility Header is not an extension header, but
> rather a final protocol.  Only Home Address Option is an extension
> header and is handled in ipv6/exthdrs.c.  What is the problem with
> this?

This is not so strong request here at this moment.

--yoshfuji
