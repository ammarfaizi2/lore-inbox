Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbQKGBPY>; Mon, 6 Nov 2000 20:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbQKGBPO>; Mon, 6 Nov 2000 20:15:14 -0500
Received: from gateway.sequent.com ([192.148.1.10]:63597 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129111AbQKGBO7>; Mon, 6 Nov 2000 20:14:59 -0500
Message-Id: <200011070114.RAA06983@eng4.sequent.com>
To: linux-kernel@vger.kernel.org
Subject: Comprehensive list of locks available?
Date: Mon, 06 Nov 2000 17:14:48 -0800
From: Rick Lindsley <nevdull@sequent.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've taken to heart the "one lock does not fit all" and we
made the kernel increasingly fine-grained with regards to locking,
there are many more locks appearing in the code. While Linux does not
currently support hierarchical locks, it is still true that the order
in which you acquire multiple locks (when needed) can be your first
defense against inadvertent deadlock. Knowing how to properly utilize a
lock is becoming increasingly important.

Has anybody documented, in total or in part, how the various locks are
to be used? A quick scan of the 2.4 source indicates there may be more
than 400 non-static spinlocks right now. I've checked the Documentation
directory and although there's a little "how-to" from Linus there on
how to properly use spinlocks, there does not (yet) appear to be any
document on the proper use of specific spinlocks.

I suspect once I start digging that there will undoubtedly be nuggets
of information in the comments in the source code. But before I dig too
deep, let me make sure I'm not doing unnecessarily redundant work :)
Has anybody started on such a document? (Would anybody be willing to
contribute to one if I produce and coordinate it?)

Rick
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
