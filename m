Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSELU1d>; Sun, 12 May 2002 16:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSELU1b>; Sun, 12 May 2002 16:27:31 -0400
Received: from cambot.suite224.net ([209.176.64.2]:29189 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S315414AbSELU1a>;
	Sun, 12 May 2002 16:27:30 -0400
Message-ID: <000901c1f9f3$f399da00$87f583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@transmeta.com>
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com>
Subject: Re: Changelogs on kernel.org
Date: Sun, 12 May 2002 16:31:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

It would help if the some of the people that used BK would bother to be more
descriptive about the stuff they send.

I will have some patches for 2.5.x from my personal stash as soon as i get
the bugs worked out of them...

Matthew D. Pitts.

----- Original Message -----
From: "Linus Torvalds" <torvalds@transmeta.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 12, 2002 4:06 PM
Subject: Re: Changelogs on kernel.org


> In article <20020512010709.7a973fac.spyro@armlinux.org>,
> Ian Molton  <spyro@armlinux.org> wrote:
> >
> >I dont know who to write to about this, but the changelogs for
> >2.4.19-pre on kernel.org are COMPLETELY illegible.
>
> Hmm..
>
> You're definitely right about the BK version numbers, since those are
> meaningless anyway (they are only meaningful within one BK tree, and
> they change over time when you merge different trees together.
>
> The 2.4.x changelogs seem to be done with my "release" scripts, but
> additionally they don't have the same kind of detailed information that
> the 2.5.x kernels have, and yes, the result is fairly ugly.
>
> What are peoples opinion about the "full" changelog format that v2.5.x
> kernels have? Should we sort that too by author?
>
> Perl is the obvious choice for doing transformations like these.  Is
> anybody willing to write a perl script that does the "sort by author"
> thing?
>
> I'll remove the date/BK ID thing, so that my unsorted changelogs would
> look like the appended thing.  But yes, sorting (and merging) by author
> would probably be a good thing. (My BK changelog scripts can also add
> markers around the actual log message, to make parsing easier).
>
> Linus
>
> -----
>
> Summary of changes from v2.5.13 to v2.5.14
> ============================================
>
> <jsimmons@heisenberg.transvirtual.com>
>         A bunch of fixes.
>
> <jsimmons@heisenberg.transvirtual.com>
>         Pmac updates
>
> <jsimmons@heisenberg.transvirtual.com>
>         Some more small fixes.
>
> <rmk@arm.linux.org.uk>
>         [PATCH] 2.5.13: vmalloc link failure
>
>         The following patch fixes this, and also fixes the similar problem
in
>         scsi_debug.c:
>
> <trond.myklebust@fys.uio.no>
>         [PATCH] in_ntoa link failure
>
>         Nothing serious. Whoever it was that did that global replacemissed
a
>         spot is all...
>
> <viro@math.psu.edu>
>         [PATCH] change_floppy() fix
>
>         Needed both in 2.4 and 2.5
> ...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

