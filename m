Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130372AbQLYOMv>; Mon, 25 Dec 2000 09:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbQLYOMm>; Mon, 25 Dec 2000 09:12:42 -0500
Received: from oracle.clara.net ([195.8.69.94]:4621 "EHLO oracle.clara.net")
	by vger.kernel.org with ESMTP id <S131000AbQLYOMd>;
	Mon, 25 Dec 2000 09:12:33 -0500
Date: Mon, 25 Dec 2000 13:38:46 +0000 (GMT)
From: Dave Gilbert <gilbertd@treblig.org>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: css hang; somewhere between test12 and test13pre4ac2
In-Reply-To: <20001225121037.B303@suse.de>
Message-ID: <Pine.LNX.4.10.10012251336230.666-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2000, Jens Axboe wrote:

> The most likely suspect (as someone else pointed out) is not at
> all css (I'm not even sure what you mean by css hang?) but UDF.

I mean a complete system hang when playing a CSS disc - doesn't even ping.
Doesn't recover.

> Given the fs changes. Since sysrq still works, it would help a
> lot if you could capture sysrq-p repeatedly and send it in.

I think at this point the only thing that works is sysrq-b - at least the
sysrq-u's and sysrq-s's that I've given don't seem to have cleanly
unmounted the file system.
 
> Do you have any non-css discs to beat on UDF?


Yep one disc (Scanners) - it is fine - hence my reason for beleiving it is
a CSSism (although I guess CSS makes other demands on the UDF code).

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on       |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
