Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRBWHB5>; Fri, 23 Feb 2001 02:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131553AbRBWHBj>; Fri, 23 Feb 2001 02:01:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15744 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131426AbRBWHBa>;
	Fri, 23 Feb 2001 02:01:30 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14998.2628.144784.585248@pizda.ninka.net>
Date: Thu, 22 Feb 2001 22:59:16 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] zerocopy BETA 3
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Usual spot:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2-2.diff.gz

Changes since last installment:

1) More errors in TCP receive queue collapser are discovered and
   fixed.
2) Several URG handling details on receive side are made more
   consistent and sane.
3) Workaround for win2000/95 VJ header compression bugs is
   implemented.
4) Update to latest 3c59x driver from Andrew, this should cure some
   link type detection problems.
5) IP conntrack fix from Rusty.

Please test, to my knowledge the only issue remaining now are the
gbit performance issues, which are being discussed by Pekka and
Alexey.

Later,
David S. Miller
davem@redhat.com
