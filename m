Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbQJ1TE1>; Sat, 28 Oct 2000 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131258AbQJ1TER>; Sat, 28 Oct 2000 15:04:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10377 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131231AbQJ1TEI>;
	Sat, 28 Oct 2000 15:04:08 -0400
Date: Sat, 28 Oct 2000 11:49:59 -0700
Message-Id: <200010281849.LAA07162@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: eger@cc.gatech.edu
CC: linux-kernel@vger.kernel.org, eger@cc.gatech.edu
In-Reply-To: <Pine.LNX.4.21.0010281432490.18772-100000@su13.eastnet.gatech.edu>
	(message from David Eger on Sat, 28 Oct 2000 14:44:03 -0400 (EDT))
Subject: Re: signal handlers not linked properly in do_fork()?
In-Reply-To: <Pine.LNX.4.21.0010281432490.18772-100000@su13.eastnet.gatech.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sat, 28 Oct 2000 14:44:03 -0400 (EDT)
   From: David Eger <eger@cc.gatech.edu>

   I see nowhere else in do_fork() where sig is set, either.  What
   gives?

fork.c, around line 560:
*p = *current

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
