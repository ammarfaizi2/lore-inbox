Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130575AbQK1EGL>; Mon, 27 Nov 2000 23:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130604AbQK1EFw>; Mon, 27 Nov 2000 23:05:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48332 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S130575AbQK1EFr>;
        Mon, 27 Nov 2000 23:05:47 -0500
Date: Mon, 27 Nov 2000 22:35:45 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001128042850.A29908@athlon.random>
Message-ID: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Andrea Arcangeli wrote:

> On Tue, Nov 28, 2000 at 12:10:33PM +0900, kumon@flab.fujitsu.co.jp wrote:
> > If you have two files:
> > test1.c:
> > int a,b,c;
> > 
> > test2.c:
> > int a,c;
> > 
> > Which is _stronger_?
> 
> Those won't link together as they aren't declared static.

Try it. They _will_ link together.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
