Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUBKODM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbUBKODL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:03:11 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:8464 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264441AbUBKODK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:03:10 -0500
Date: Wed, 11 Feb 2004 23:04:04 +0900 (JST)
Message-Id: <20040211.230404.125428828.yoshfuji@linux-ipv6.org>
To: bart@etpmod.phys.tue.nl
Cc: maze@cela.pl, wdebruij@dds.nl, zstingx@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: printk and long long 
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040211135456.B33ED2BD4@etpmod.phys.tue.nl>
References: <20040211135456.B33ED2BD4@etpmod.phys.tue.nl>
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

In article <20040211135456.B33ED2BD4@etpmod.phys.tue.nl> (at Wed, 11 Feb 2004 14:54:56 +0100 (CET)), Bart Hartgers <bart@etpmod.phys.tue.nl> says:

> On 11 Feb, Maciej Zenczykowski wrote:
> >> how about simply using a shift to output two regular longs, i.e.
> >> 
> >> printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t << sizeof(long) * 8 >>
> >> sizeof(long) * 8);
> > 
> > I'd venture to guess you'd also have to cast the above to long.
:
> And use %lx%lx ?

%08lx%08lx

--yoshfuji
