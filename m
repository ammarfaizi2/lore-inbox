Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130069AbRABMJb>; Tue, 2 Jan 2001 07:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRABMJM>; Tue, 2 Jan 2001 07:09:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44677 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129859AbRABMJK>;
	Tue, 2 Jan 2001 07:09:10 -0500
Date: Tue, 2 Jan 2001 03:21:24 -0800
Message-Id: <200101021121.DAA14657@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: matthew@wil.cx
CC: grundler@cup.hp.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, parisc-linux@thepuffingroup.com
In-Reply-To: <20010102112242.A7040@parcelfarce.linux.theplanet.co.uk> (message
	from Matthew Wilcox on Tue, 2 Jan 2001 11:22:42 +0000)
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
In-Reply-To: <200101020811.AAA26525@milano.cup.hp.com> <200101020903.BAA14334@pizda.ninka.net> <20010102112242.A7040@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 2 Jan 2001 11:22:42 +0000
   From: Matthew Wilcox <matthew@wil.cx>

   We really can't.  We _only_ have load-and-zero.  And it has to be
   16-byte aligned.  xchg() is just not something the CPU implements.

Oh bugger... you do have real problems.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
