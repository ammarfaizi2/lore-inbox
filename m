Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131931AbQLIVwm>; Sat, 9 Dec 2000 16:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132119AbQLIVwd>; Sat, 9 Dec 2000 16:52:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11404 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131931AbQLIVwQ>;
	Sat, 9 Dec 2000 16:52:16 -0500
Date: Sat, 9 Dec 2000 13:05:44 -0800
Message-Id: <200012092105.NAA31335@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: matthew@hairy.beasts.org
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012092113440.32548-100000@sphinx.mythic-beasts.com>
	(message from Matthew Kirkwood on Sat, 9 Dec 2000 21:16:51 +0000
	(GMT))
Subject: Re: skbuff.c BUG() pedantry
In-Reply-To: <Pine.LNX.4.10.10012092113440.32548-100000@sphinx.mythic-beasts.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 9 Dec 2000 21:16:51 +0000 (GMT)
   From: Matthew Kirkwood <matthew@hairy.beasts.org>

   I guess it should probably be removed (or replace with a
   call to something which doesn't try to kill the attached
   process.

BUG is supposed to give a backtrace, nothing more.
If it happens to kill the machine too, so be it, state
is corrupted anyways...

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
