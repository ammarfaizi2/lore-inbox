Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130546AbQK1Dv2>; Mon, 27 Nov 2000 22:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130560AbQK1DvT>; Mon, 27 Nov 2000 22:51:19 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:35098 "EHLO
        smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
        id <S130546AbQK1DvE>; Mon, 27 Nov 2000 22:51:04 -0500
Message-ID: <3A22EC94.2A434703@mindspring.com>
Date: Mon, 27 Nov 2000 18:21:56 -0500
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: out of swap
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKKEJAMCAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What would I like it to do?  Warn me maybe before my swap goes to zero.  Kill the
program that is doing this possibly.  Allow me to set a per process memory / swap
limit so that no one process can suck up my system resources.

I'd rather not increase swap if possible, as it was only this one page that hosed
my system, and other than that, my system doesn't swap that much if at all.

> > Last night I was browsing the web and I came across a page with
> > LOTS of images.  There were so many that it drove my swap space
> > to ZERO.  I still had 3 Meg of memory, but the system became
> > virtually unusable and SLOW. (there were over 150 x 30k+ images
> > on one page).
> >
> > Is this something that the OOM would fix or is this another
> > issue altogether?
> >
> > The machine has
> > 64Meg of swap space, 128 Meg of RAM, Dual 233MMX, Itis running
> > 2.2.17 and Rh 6.2.
> >
> > Any ideas?  thanks Joe
>
>         Add more swap. What would you like the system to do if it's out of both
> memory and swap? It can either kill processes or become slow.
>
>         DS

--
Joe Acosta ........
home: joeja@mindspring.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
