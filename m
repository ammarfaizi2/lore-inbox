Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132143AbRAERuU>; Fri, 5 Jan 2001 12:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131384AbRAERuA>; Fri, 5 Jan 2001 12:50:00 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:9461 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129859AbRAERtz>; Fri, 5 Jan 2001 12:49:55 -0500
Date: Fri, 5 Jan 2001 15:48:57 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Admin Mailing Lists <mlist@intergrafix.net>
cc: Chris Evans <chris@scary.beasts.org>, Chris Mason <mason@suse.com>,
        reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs patch for 2.4.0-final
In-Reply-To: <Pine.LNX.4.10.10101051243200.323-100000@athena.intergrafix.net>
Message-ID: <Pine.LNX.4.21.0101051547160.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Admin Mailing Lists wrote:

> Is ext2 upgradable to reiserfs or ext3?

> If so, is it transparent..or like a umount, convert, mount..or
> do you like have to import to a whole new partition?

ext2 is upgradable to ext3; after you have created a journal
on the filesystem (either by hand or using tune2fs) you can
remount the filesystem as ext3.   If it turns out you don't
like ext3, you can even go back to ext2 by unmounting the ext3
fs and remounting it ext2.

Going to reiserfs will require a reformat of your partition,
because the format is completely different.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
