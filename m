Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129764AbQK1Utu>; Tue, 28 Nov 2000 15:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130157AbQK1Utj>; Tue, 28 Nov 2000 15:49:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24448 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S130162AbQK1Ut0>;
        Tue, 28 Nov 2000 15:49:26 -0500
Date: Tue, 28 Nov 2000 12:04:01 -0800
Message-Id: <200011282004.MAA01496@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: VANDROVE@vc.cvut.cz
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org, tytso@valinux.com
In-Reply-To: <E2BA5DE1AE9@vcnet.vc.cvut.cz> (VANDROVE@vc.cvut.cz)
Subject: Re: 2.4.0-test11 ext2 fs corruption
In-Reply-To: <E2BA5DE1AE9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
   Date:          Tue, 28 Nov 2000 21:10:36 MET-1

   Yes, it is identical copy. But I do not think that hdd can write same
   data into two places with one command...

Petr, did the af_inet.c assertions get triggered on this
same machine?

If yes, you seem to have some crazy kernel data corruptions
going on, and whatever it is would seem to be the cause of
both these problems you are reporting.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
