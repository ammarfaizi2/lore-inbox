Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288814AbSAFWpL>; Sun, 6 Jan 2002 17:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288923AbSAFWpC>; Sun, 6 Jan 2002 17:45:02 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:33802 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288902AbSAFWot>;
	Sun, 6 Jan 2002 17:44:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [RFC] Unbork fs.h, 1 of 4
Date: Sun, 6 Jan 2002 23:48:37 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16NLbK-0001LE-00@starship.berlin> <3C38D1B3.51724D66@mandrakesoft.com>
In-Reply-To: <3C38D1B3.51724D66@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NM5n-0001Li-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 6, 2002 11:37 pm, Jeff Garzik wrote:
> I share the opinion of a couple others, to use generic_ip and
> generic_sbp.  That's what they are there for.

That approach is workable but inferior.

> May I suggest the course of action whereby you convert the code to use
> ext2_sb(sb) and ext2_i(inode) first, without changing fs.h at all.  That
> lays the groundwork for arguing out the final solution, and the code is
> much cleaner either way.
> 
> I have not seen anyone arguing -against- ext2_sb() and ext2_i()
> cleanups... they seem to make the code obviously more clean.
> 
> After those cleanups go in, your further "unbork fs.h" patches will be
> smaller and only show the core changes you are interested in.

Patches (2) and (3), which implement the 'ext2_i' and 'ext2_s' changes 
respectively, apply independently of the patch (1), the VFS changes.  Did you 
read my posting?

--
Daniel
