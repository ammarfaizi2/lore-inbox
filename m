Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSELUHX>; Sun, 12 May 2002 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSELUHW>; Sun, 12 May 2002 16:07:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7176 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315412AbSELUHW>; Sun, 12 May 2002 16:07:22 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Changelogs on kernel.org
Date: Sun, 12 May 2002 20:06:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <abmi0f$ugh$1@penguin.transmeta.com>
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org>
X-Trace: palladium.transmeta.com 1021234016 30416 127.0.0.1 (12 May 2002 20:06:56 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 May 2002 20:06:56 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020512010709.7a973fac.spyro@armlinux.org>,
Ian Molton  <spyro@armlinux.org> wrote:
>
>I dont know who to write to about this, but the changelogs for
>2.4.19-pre on kernel.org are COMPLETELY illegible.

Hmm..

You're definitely right about the BK version numbers, since those are
meaningless anyway (they are only meaningful within one BK tree, and
they change over time when you merge different trees together.

The 2.4.x changelogs seem to be done with my "release" scripts, but
additionally they don't have the same kind of detailed information that
the 2.5.x kernels have, and yes, the result is fairly ugly.

What are peoples opinion about the "full" changelog format that v2.5.x
kernels have? Should we sort that too by author?

Perl is the obvious choice for doing transformations like these.  Is
anybody willing to write a perl script that does the "sort by author"
thing?

I'll remove the date/BK ID thing, so that my unsorted changelogs would
look like the appended thing.  But yes, sorting (and merging) by author
would probably be a good thing. (My BK changelog scripts can also add
markers around the actual log message, to make parsing easier).

		Linus

-----

Summary of changes from v2.5.13 to v2.5.14
============================================

<jsimmons@heisenberg.transvirtual.com>
        A bunch of fixes.

<jsimmons@heisenberg.transvirtual.com>
        Pmac updates

<jsimmons@heisenberg.transvirtual.com>
        Some more small fixes.

<rmk@arm.linux.org.uk>
        [PATCH] 2.5.13: vmalloc link failure
        
        The following patch fixes this, and also fixes the similar problem in
        scsi_debug.c:

<trond.myklebust@fys.uio.no>
        [PATCH] in_ntoa link failure
        
        Nothing serious. Whoever it was that did that global replacemissed a
        spot is all...

<viro@math.psu.edu>
        [PATCH] change_floppy() fix
        
        Needed both in 2.4 and 2.5
...
