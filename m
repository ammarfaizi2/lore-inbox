Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTBSV6I>; Wed, 19 Feb 2003 16:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTBSV6I>; Wed, 19 Feb 2003 16:58:08 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:48390 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261934AbTBSV6H>; Wed, 19 Feb 2003 16:58:07 -0500
Date: Thu, 20 Feb 2003 07:07:48 +0900 (JST)
Message-Id: <20030220.070748.127370664.yoshfuji@wide.ad.jp>
To: davem@redhat.com, toml@us.ibm.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPSec protocol application order
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20030219.133906.127189630.davem@redhat.com>
References: <OF8FC87DCF.42F7A5C1-ON86256CD2.007686FA-86256CD2.0077C5EA@pok.ibm.com>
	<20030219.133906.127189630.davem@redhat.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030219.133906.127189630.davem@redhat.com> (at Wed, 19 Feb 2003 13:39:06 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

> setkey is for manual keying and debugging.  Therefore, disallowing
> experimenting with non-rfc-compliant orderings seems to lack purpose
> to me.

I'm for davem.  Setkey is very flexible manual-keying tool and
we should not limit this flexibility.

--yoshfuji
