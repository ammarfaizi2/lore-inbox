Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130231AbQK1SBN>; Tue, 28 Nov 2000 13:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130340AbQK1SBF>; Tue, 28 Nov 2000 13:01:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51844 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S130231AbQK1SA4>;
        Tue, 28 Nov 2000 13:00:56 -0500
Date: Tue, 28 Nov 2000 09:15:21 -0800
Message-Id: <200011281715.JAA08686@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: lenstra@tiscalinet.it
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20001128182352.00b5fa80@pop.tiscalinet.it> (message
        from Lorenzo Allegrucci on Tue, 28 Nov 2000 18:23:52 +0100)
Subject: Re: lmbench on linux-2.4.0-test[4-11]
In-Reply-To: <3.0.6.32.20001128110817.00acae30@pop.tiscalinet.it>
 <3.0.6.32.20001128110817.00acae30@pop.tiscalinet.it> <3.0.6.32.20001128182352.00b5fa80@pop.tiscalinet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Tue, 28 Nov 2000 18:23:52 +0100
   From: Lorenzo Allegrucci <lenstra@tiscalinet.it>

   BTW, all local services (smtp, telnet etc) work well.  Any ideas?

No ideas, and since the indicated programs from lmbench work
perfectly fine here on my machines, you're going to have to do some
detective work so we can figure out whats wrong.

You need to do some strace'ing of the affected programs and try
to figure out exactly how they get stuck and for what reason.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
