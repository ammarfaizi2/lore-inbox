Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264183AbRFDK1y>; Mon, 4 Jun 2001 06:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbRFDKHL>; Mon, 4 Jun 2001 06:07:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46354 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263859AbRFDKG4>; Mon, 4 Jun 2001 06:06:56 -0400
Date: Mon, 4 Jun 2001 03:09:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Akash Jain <aki.jain@stanford.edu>,
        <linux-kernel@vger.kernel.org>, <su.class.cs99q@nntp.stanford.edu>
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <E156o6c-0005AB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0106040308240.5368-100000@p4.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Jun 2001, Alan Cox wrote:
>
> >  - the kernel stack is 4kB, and _nobody_ has the right to eat up a
> >    noticeable portion of it. It doesn't matter if you "know" your caller
>
> Umm Linus on what platform - its 8K or more on all that I can think of

Ehh.. It's _noticeably_ less than 8kB at least on i386.

> We have a very large number of violators of 1K of stack, and very few of 2K
> right now.

"Two wrongs do not make a right".

		Linus

