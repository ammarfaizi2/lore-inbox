Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130250AbQLYSQw>; Mon, 25 Dec 2000 13:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130694AbQLYSQl>; Mon, 25 Dec 2000 13:16:41 -0500
Received: from www.wen-online.de ([212.223.88.39]:5385 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130250AbQLYSQb>;
	Mon, 25 Dec 2000 13:16:31 -0500
Date: Mon, 25 Dec 2000 18:45:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andreas Franck <afranck@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
In-Reply-To: <00122513292000.00531@dg1kfa.ampr.org>
Message-ID: <Pine.Linu.4.10.10012251818510.545-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2000, Andreas Franck wrote:

> Hello Mike, hello linux-kernel hackers,
> 
> Mike Galbraith wrote:
> > I wouldn't (not going to here;) spend a lot of time on it.  The compiler
> > has problems.  It won't build glibc-2.2, and chokes horribly on ipchains.
> 
> Maybe, but after having spent several hours debugging now, I think it was 
> worth it: I am almost sure this is not a gcc bug, but a nasty race condition 
> involving the semaphore handling bdflush_init. 
> 
> I figured out by spilling some printk's around in bdflush_init, which made 
> the bug magically disappear, what wasn't what I intended - but which gave me 
> a clearer impression of what's going on.

Oh?  Can you show me (offline) what you did exactly that made it go away?
(that's kinda scary.. _much_ prefer 'compiler has rough edges' option;)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
