Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268064AbTBRWZ4>; Tue, 18 Feb 2003 17:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbTBRWZz>; Tue, 18 Feb 2003 17:25:55 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:36079 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S268064AbTBRWZt>; Tue, 18 Feb 2003 17:25:49 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Jamie Lokier <jamie@shareable.org>, Nicolas Pitre <nico@cam.org>,
       Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Date: Tue, 18 Feb 2003 14:34:42 -0800 (PST)
Subject: Re: openbkweb-0.0
In-Reply-To: <Pine.LNX.4.50L.0302171120060.16271-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0302181427440.8963-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, it sounds like we have the following resources available for getting
the kernel source

1. FTP of hourly snapshots
2. e-mail of individual patches hourly (patch may be e-mailed before
bkbits.net is updated)
3. bitkeeper access to bkbits.net
4. read-only rsync (including access to the SCCS info) of the full
up-to-the-second tree
5. web access to look at individual patches (automated pulls not allowed)
6. kernel.org mirrors of releases

This isn't enough for people so will adding read-only CVS access to the
tree itself be enough? does the CVS access need to also include the SCCS
directories? what's the next thing that people will complain limits their
access to the kernel source?

it used to be that we only had #6 and the griping that people did was that
to many patches were dropped, now we have all the others and only #3 and
#5 are limited by the evil bitmover company at all ;-) all the others are
available to anyone withouta need to use any software they don't want to
use.

David Lang

On Mon, 17 Feb 2003, Rik van Riel wrote:

> Date: Mon, 17 Feb 2003 11:50:02 -0300 (BRT)
> From: Rik van Riel <riel@imladris.surriel.com>
> To: Jamie Lokier <jamie@shareable.org>
> Cc: Nicolas Pitre <nico@cam.org>, David Lang <david.lang@digitalinsight.com>,
>      Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
>      lkml <linux-kernel@vger.kernel.org>
> Subject: Re: openbkweb-0.0
>
> On Mon, 17 Feb 2003, Jamie Lokier wrote:
>
> > However, rsync from the repository is generally _much_ faster than CVS
> > if you are tracking changes, so I (an impatient modem user) prefer rsync.
>
> > So I vote for rsync read-only access to the actual SCCS-ish repository
> > files that BK manages.
>
> See ftp://nl.linux.org/pub/linux/bk2patch/
>
> You can get BK trees (uncompressed SCCS) via rsync, as well as
> patches from the latest tagged version to the head of the tree.
>
> cheers,
>
> Rik
> --
> Bravely reimplemented by the knights who say "NIH".
> http://www.surriel.com/		http://guru.conectiva.com/
> Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
>
