Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135772AbREDTO0>; Fri, 4 May 2001 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135759AbREDTOQ>; Fri, 4 May 2001 15:14:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:61446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135618AbREDTOF>; Fri, 4 May 2001 15:14:05 -0400
Date: Fri, 4 May 2001 12:13:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <volodya@mindspring.com>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0105041418550.21896-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31.0105041213150.797-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Alexander Viro wrote:
>
> ObProcfs: I don't think that walking the page tables is a good way to
> compute RSS, especially since VM maintains the thing.

Well, the VM didn't always use to maintain the stuff it does now, so I bet
that most of the code is just old code that still works.

Feel free to rip it out.

		Linus

