Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272770AbRILNGg>; Wed, 12 Sep 2001 09:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272774AbRILNG0>; Wed, 12 Sep 2001 09:06:26 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:54532 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S272770AbRILNGK>; Wed, 12 Sep 2001 09:06:10 -0400
X-Envelope-From: mmokrejs
Posted-Date: Wed, 12 Sep 2001 15:06:29 +0200 (MET DST)
Date: Wed, 12 Sep 2001 15:06:28 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed.
In-Reply-To: <20010907205321Z16323-26184+70@humbolt.nl.linux.org>
Message-ID: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001, Daniel Phillips wrote:

> > You can get the patch from Marcelo's post on lkml on Aug 22 under the
> > subject "Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on
> > 7899P)".  Note the correction posted in his next message in the thread.
> > It applies to 2.4.9.  Please try it and see if these failures go away.

Yes, it fixed my problem. I had to aplly also "patch" from someone from
this list, who replied to Daniel, because in original Daniels version of
patch were two typo mistakes.

> > This patch *should* be in the main tree soon.  Some testing by you would
> > help a lot.

I had a look on monday into the -pre7 but it did not look like it contains
this patch.

> Correction, it's in Linus's tree all write, with some changed names.  So...
> conclusion: Marcelo's approach is not airtight.  Or there was an error in
> translation.  Arjan has a patch going in soon to the -ac tree, so stay
> tuned.

I don't know what's Arjan's patch, but Marcelo's patch applied to plain
2.4.9 sources (manually applied) works for 2 days already here.

If you know how to push Marcelo's patch into the -preX version, please do
so. ;-)
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany

