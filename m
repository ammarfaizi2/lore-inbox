Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131772AbQL2SpN>; Fri, 29 Dec 2000 13:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131839AbQL2SpD>; Fri, 29 Dec 2000 13:45:03 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26898 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131772AbQL2Soy>; Fri, 29 Dec 2000 13:44:54 -0500
Date: Fri, 29 Dec 2000 14:21:20 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <267620000.978105801@tiny>
Message-ID: <Pine.LNX.4.21.0012291418570.13063-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Chris Mason wrote:

> BTW, the last anon space mapping patch I sent also works on test13-pre5.
> The block_truncate_page fix does help my patch, since I have bdflush
> locking pages ( thanks Marcelo )

Good to know. I thought that fix would not change performance noticeable.

Now the ext2 changes will for sure make a difference since right now the
superblock lock is suffering from contention. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
