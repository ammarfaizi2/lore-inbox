Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbQJaRcH>; Tue, 31 Oct 2000 12:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130292AbQJaRbr>; Tue, 31 Oct 2000 12:31:47 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36368 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130000AbQJaRbl>; Tue, 31 Oct 2000 12:31:41 -0500
Date: Tue, 31 Oct 2000 09:31:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Russell King <rmk@arm.linux.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: <16544.973000930@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10010310930110.6866-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2000, Keith Owens wrote:
>
> LINK_FIRST is processed in the order it is specified, so a.o will be
> linked before z.o when both are present.  See the patch.

So why don't you do the same thing for obj-y, then?

Why can't you do

	LINK_FIRST=$(obj-y)

and be done with it?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
