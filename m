Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157352-27302>; Sat, 30 Jan 1999 19:14:01 -0500
Received: by vger.rutgers.edu id <157359-27302>; Sat, 30 Jan 1999 19:13:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20542 "EHLO penguin.e-mind.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157404-27302>; Sat, 30 Jan 1999 19:11:06 -0500
Date: Sun, 31 Jan 1999 01:23:34 +0100 (CET)
From: Andrea Arcangeli <andrea@e-mind.com>
To: Tim Waugh <tim@cyberelk.demon.co.uk>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: [patch] down_norecurse(), down_interruptible_norecurse(), up_norecurse()
In-Reply-To: <Pine.LNX.4.05.9901301916240.263-100000@cyberelk.elk.co.uk>
Message-ID: <Pine.LNX.3.96.990131012137.303A-100000@laser.bogus>
X-PgP-Public-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, 30 Jan 1999, Tim Waugh wrote:

> MUTEX_NORECURSE probably isn't for a mutex -- it's semaphores that don't
> want recursion.  It would be nicer to have something like
> SEMAPHORE(initval).  If I thought long enough about it, I'm fairly sure I
> could come up with a situation where you'd want to initialise a semaphore
> to >1.

Ok. I think the MUTEX word was to tell that you wanted a semaphore
initialized to 1 (as a mutex unlocked), but agreed, SEMAPHORE(x) looks a
better name for the norecursive semaphore initializer. 

Andrea Arcangeli


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
