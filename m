Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132027AbRAIVh0>; Tue, 9 Jan 2001 16:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRAIVhQ>; Tue, 9 Jan 2001 16:37:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46470 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132027AbRAIVhH>;
	Tue, 9 Jan 2001 16:37:07 -0500
Date: Tue, 9 Jan 2001 13:19:28 -0800
Message-Id: <200101092119.NAA05633@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <14939.11765.649805.239618@charged.uio.no> (message from Trond
	Myklebust on Tue, 9 Jan 2001 16:27:49 +0100 (CET))
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net>
	<shs4rz8vnmf.fsf@charged.uio.no>
	<200101091342.FAA02414@pizda.ninka.net> <14939.11765.649805.239618@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 9 Jan 2001 16:27:49 +0100 (CET)
   From: Trond Myklebust <trond.myklebust@fys.uio.no>

   OK, but can you eventually generalize it to non-stream protocols
   (i.e. UDP)?

Sure, this is what MSG_MORE is meant to accomodate.  UDP could support
it just fine.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
