Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRA3Jep>; Tue, 30 Jan 2001 04:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbRA3Jel>; Tue, 30 Jan 2001 04:34:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36993 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129789AbRA3Je0>;
	Tue, 30 Jan 2001 04:34:26 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14966.35438.429963.405587@pizda.ninka.net>
Date: Tue, 30 Jan 2001 01:33:34 -0800 (PST)
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com
Subject: [UPDATE] Fresh zerocopy patch on kernel.org
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At the usual place:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1-1.diff.gz

(As usual, please allow some minutes for the mirrors to get it)

Changes since last installment:

1) Merge to 2.4.1 final. (me)
2) Accept TCP flags (ACK, URG, RST, etc.) for out of window packets
   if truncating the data to the window would make that packet valid.
   (Alexey)
3) Add SO_ACCEPTCONN, Unix standard wants it. (me)

Have fun testing...

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
