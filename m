Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTDTDbq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 23:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263520AbTDTDbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 23:31:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42400 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263519AbTDTDbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 23:31:45 -0400
Date: Sat, 19 Apr 2003 20:35:43 -0700 (PDT)
Message-Id: <20030419.203543.112604079.davem@redhat.com>
To: yoshfuji@wide.ad.jp
Cc: latten@austin.ibm.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: IPsecv6 integrity failures not dropped
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030419.115053.123574563.yoshfuji@wide.ad.jp>
References: <200304182017.h3IKH4ng019821@faith.austin.ibm.com>
	<20030419.115053.123574563.yoshfuji@wide.ad.jp>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@wide.ad.jp>
   Date: Sat, 19 Apr 2003 11:50:53 +0900 (JST)

   just change u8 nexthdr = 0 to int nexthdr = 0, in xfrm6_rcv() is fine, 
   isn't it?

That's exactly the most correct fix, applied to my tree.
Thanks.
