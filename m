Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265252AbSKACaF>; Thu, 31 Oct 2002 21:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265481AbSKACaE>; Thu, 31 Oct 2002 21:30:04 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:3347 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265252AbSKACaE>; Thu, 31 Oct 2002 21:30:04 -0500
Date: Fri, 01 Nov 2002 11:36:12 +0900 (JST)
Message-Id: <20021101.113612.10745857.yoshfuji@wide.ad.jp>
To: davem@redhat.com
Cc: krkumar@us.ibm.com, kuznet@ms2.inr.ac.ru, ajtuomin@tml.hut.fi,
       lpetande@tml.hut.fi, jagana@us.ibm.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <20021031.181708.102783497.davem@redhat.com>
References: <200211010219.gA12JMn11699@eng2.beaverton.ibm.com>
	<20021031.181708.102783497.davem@redhat.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021031.181708.102783497.davem@redhat.com> (at Thu, 31 Oct 2002 18:17:08 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

> 
> Why isn't the home agent code being done in userspace?  That is
> where it belongs.  It's huge.

I think core part of HA belongs to kernel (forwarding etc.)
Registration process should live in user space.

--yoshfuji
