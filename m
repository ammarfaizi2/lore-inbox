Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143492AbRAHNfh>; Mon, 8 Jan 2001 08:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143692AbRAHNf2>; Mon, 8 Jan 2001 08:35:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35023 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S143492AbRAHNfP>;
	Mon, 8 Jan 2001 08:35:15 -0500
Date: Mon, 8 Jan 2001 08:35:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stefan Traby <stefan@hello-penguin.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010108141721.C13072@stefan.sime.com>
Message-ID: <Pine.GSO.4.21.0101080821450.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Stefan Traby wrote:

> On Mon, Jan 08, 2001 at 12:26:17PM +0000, Alan Cox wrote:
> 
> > I can put all that in the VFS so I did (right now the ext2 size calculator is
> > wrong but thats proof of concept detail). Just need to shift if over from
> > ext2/file.c
> 
> Try 'getconf LINK_MAX /ramfs'.
> While the result (127) is in some way SuS/POSIXLY_CORRECT,
> it's not the truth.
> 
> Why not start to fix this problem outside the funny switch/case in glibc ?
> The filesystem itself should able to handle this.

Sigh... And the API would be?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
