Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSKCMHZ>; Sun, 3 Nov 2002 07:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSKCMHZ>; Sun, 3 Nov 2002 07:07:25 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47322 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261799AbSKCMHT>;
	Sun, 3 Nov 2002 07:07:19 -0500
Date: Sun, 03 Nov 2002 04:03:38 -0800 (PST)
Message-Id: <20021103.040338.98864962.davem@redhat.com>
To: kisza@securityaudit.hu
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, kuznet@ms2.inr.ac.ru,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Functions Clean-up
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1036328414.1048.3.camel@arwen>
References: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
	<1036328414.1048.3.camel@arwen>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andras Kis-Szabo <kisza@securityaudit.hu>
   Date: Sun, 03 Nov 2002 14:00:14 +0100

   (And we should not to trust in the kernel.)

If you can't trust the exthdr parser in the kernel, you probably can't
trust the kernel to even give you the packets correctly in the first
place.  So you better just rm -rf netfilter/ while you have the chance
:-)
