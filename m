Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272632AbRIGMxM>; Fri, 7 Sep 2001 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272633AbRIGMxD>; Fri, 7 Sep 2001 08:53:03 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:60420 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S272632AbRIGMwv>; Fri, 7 Sep 2001 08:52:51 -0400
X-Envelope-From: mmokrejs
Posted-Date: Fri, 7 Sep 2001 14:53:07 +0200 (MET DST)
Date: Fri, 7 Sep 2001 14:53:07 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed.
In-Reply-To: <20010904160546Z16284-32383+3441@humbolt.nl.linux.org>
Message-ID: <Pine.OSF.4.21.0109071451120.11540-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Daniel Phillips wrote:

Hi,

> On September 4, 2001 03:11 pm, Martin MOKREJ? wrote:
> > Hi,
> >   I'm getting the above error on 2.4.9 kernel with kernel HIGHMEM option
> > enabled to 2GB, 2x Intel PentiumIII. The machine has 1GB RAM
> > physically. Althougj I've found many report to linux-kernel list during
> > past months, not a real solution. Maybe only:
> > http://www.alsa-project.org/archive/alsa-devel/msg08629.html
> 
> Try 2.4.10-pre4.

Hmm, so after a day of run we got it again:
__alloc_pages: 0-order allocation failed (gfp=0x70/1).

> > so I think it's another problem in 2.4.9, right?
> 
> Yep.  Most probably bounce buffers, patch by Marcelo already in Linus's
> tree.

So it did not fix it? But the output now has extra "(gfp=0x70/1)" string
appended.

Any ideas?
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany

