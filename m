Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRBBM0n>; Fri, 2 Feb 2001 07:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbRBBM0e>; Fri, 2 Feb 2001 07:26:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59141 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129143AbRBBM0Q>; Fri, 2 Feb 2001 07:26:16 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 2 Feb 2001 12:26:52 +0000 (GMT)
Cc: kas@informatics.muni.cz (Jan Kasprzak), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
In-Reply-To: <3A7A944D.A2AB9FE@namesys.com> from "Hans Reiser" at Feb 02, 2001 02:04:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OfIl-0006P1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is why our next patch will detect the use of gcc 2.96, and complain, in the
> reiserfs Makefile.

What makes you think its gcc 2.96 ?

If the person concerned can clarify what they built with (2.96-69 or
egcs-1.1.2 (kgcc)), that would be useful.

I've certainly done the Reiserfs testing I did with gcc 2.96-69 with no
problems at all. Reiserfsck was having _bad_ problems but I saw those with
egcs-1.1.2 too and I understand there is a new reiserfsck about to appear
or just out which is much better.

[I've been simulating the effect of bad blocks on file systems]

Worse behaviour so far is minixfs. If an inode rewrite fails leaving what
is now a directory as a file the minix fsck prunes the entire subtree. Very
nasty

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
