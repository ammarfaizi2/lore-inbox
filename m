Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbQLPOXf>; Sat, 16 Dec 2000 09:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131935AbQLPOX0>; Sat, 16 Dec 2000 09:23:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:50490 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131665AbQLPOXL>; Sat, 16 Dec 2000 09:23:11 -0500
Date: Sat, 16 Dec 2000 14:52:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Ulrich Drepper <drepper@cygnus.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
Message-ID: <20001216145242.C25150@inspiron.random>
In-Reply-To: <20001215205721.I17781@inspiron.random> <Pine.LNX.4.21.0012161337220.1433-100000@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0012161337220.1433-100000@bee.lk>; from anuradha@gnu.org on Sat, Dec 16, 2000 at 01:53:50PM +0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 01:53:50PM +0600, Anuradha Ratnaweera wrote:
> GCC will complain the absence of a statement after `out1:out2:`, but not
> two complains for `out1' and `out2', because they form a single entity.

I understand the formal specs (the email from Michael is very clear). What I'm
saying is that as the `dummy' statement is redoundant information but you're
requiring us to put it to build a labeled-statement, you could been even more
lazy and not define the labeled-statement as a statement so requiring us to put
a dummy statement after every label. That would been the same kind of issue
we're facing right now (but of course defining a labeled-statement as a
statement and allowing recursion makes the formal specs even simpler so that
probably wouldn't happen that easily).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
