Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSELUeu>; Sun, 12 May 2002 16:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSELUet>; Sun, 12 May 2002 16:34:49 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:60221 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315416AbSELUes>; Sun, 12 May 2002 16:34:48 -0400
Message-Id: <5.1.0.14.2.20020512211838.02024c10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 12 May 2002 21:35:31 +0100
To: torvalds@transmeta.com (Linus Torvalds)
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: Changelogs on kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <abmi0f$ugh$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:06 12/05/02, Linus Torvalds wrote:
>In article <20020512010709.7a973fac.spyro@armlinux.org>,
>Ian Molton  <spyro@armlinux.org> wrote:
> >
> >I dont know who to write to about this, but the changelogs for
> >2.4.19-pre on kernel.org are COMPLETELY illegible.
>
>Hmm..
>
>You're definitely right about the BK version numbers, since those are
>meaningless anyway (they are only meaningful within one BK tree, and
>they change over time when you merge different trees together.
>
>The 2.4.x changelogs seem to be done with my "release" scripts, but
>additionally they don't have the same kind of detailed information that
>the 2.5.x kernels have, and yes, the result is fairly ugly.
>
>What are peoples opinion about the "full" changelog format that v2.5.x
>kernels have? Should we sort that too by author?

I like the current 2.5.x format. It gives a quick overview so I can choose 
which changesets interest me and I usually go into bk revtool afterwards 
and have a look at the actual code in the changesets of interest...

And I agree that the cut down 2.4.x changelog is not very useful... I 
always have to do a bk changes on the 2.4.x tree to get the full details.

Best regards,

Anton


>Perl is the obvious choice for doing transformations like these.  Is
>anybody willing to write a perl script that does the "sort by author"
>thing?
>
>I'll remove the date/BK ID thing, so that my unsorted changelogs would
>look like the appended thing.  But yes, sorting (and merging) by author
>would probably be a good thing. (My BK changelog scripts can also add
>markers around the actual log message, to make parsing easier).
>
>                 Linus
>
>-----
>
>Summary of changes from v2.5.13 to v2.5.14
>============================================
>
><jsimmons@heisenberg.transvirtual.com>
>         A bunch of fixes.
>
><jsimmons@heisenberg.transvirtual.com>
>         Pmac updates
>
><jsimmons@heisenberg.transvirtual.com>
>         Some more small fixes.
>
><rmk@arm.linux.org.uk>
>         [PATCH] 2.5.13: vmalloc link failure
>
>         The following patch fixes this, and also fixes the similar problem in
>         scsi_debug.c:
>
><trond.myklebust@fys.uio.no>
>         [PATCH] in_ntoa link failure
>
>         Nothing serious. Whoever it was that did that global replacemissed a
>         spot is all...
>
><viro@math.psu.edu>
>         [PATCH] change_floppy() fix
>
>         Needed both in 2.4 and 2.5
>...
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

