Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136240AbRBFBmH>; Mon, 5 Feb 2001 20:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136241AbRBFBl5>; Mon, 5 Feb 2001 20:41:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60033 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136240AbRBFBlq>;
	Mon, 5 Feb 2001 20:41:46 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14975.22030.765975.161693@pizda.ninka.net>
Date: Mon, 5 Feb 2001 17:40:30 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] New zerocopy against 2.4.2-pre1
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the usual spot:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2p1-1.diff.gz

Changes since last installment:

1) Merge in lots of AC patch fixes, from Alan.
2) Use more reasonable MTU for loopback under
   Zerocopy, basically it's 16K + sizeof TCP/IP headers now.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
