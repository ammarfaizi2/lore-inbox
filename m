Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbRG0Mue>; Fri, 27 Jul 2001 08:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbRG0MuY>; Fri, 27 Jul 2001 08:50:24 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:41227 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S266578AbRG0MuR>; Fri, 27 Jul 2001 08:50:17 -0400
From: bvermeul@devel.blackstar.nl
Date: Fri, 27 Jul 2001 14:52:45 +0200 (CEST)
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Steve Kieu <haiquy@yahoo.com>,
        Sam Thompson <samuelt@cervantes.dabney.caltech.edu>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <20010718182201.J13239@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.33.0107271448510.9291-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 18 Jul 2001, Erik Mouw wrote:

> On Wed, Jul 18, 2001 at 03:18:59PM +1000, Steve Kieu wrote:
> > My advice:
> >
> > Dont use reiserfs,JFS
> > it is ok to use ext2
> >
> > Go journalling? use ext3 or XFS
> >
> > I have used  all of these fs and pick up this rule (up
> > to now, not sure it remains right in the far  future)
>
> FUD. I've been using reiserfs on quite some systems and never got any
> problem. If reiserfs wouldn't be stable, SuSE wouldn't have supported
> it as one of their stable filesystems for over a year.

Actually, I've been having some nasty corruption problems as well with
reiserfs. I develop my own drivers, and do occasionally make a mistake,
and when that hangs the kernel it will also screw up all files touched
just before it in a edit-make-install-try cycle. Which can be rather
annoying, because you can start all over again (this effect randomly
distributes the last touched sectors to the last touched files. Very nice
effect, but not something I expect from a journalled filesystem).

Regards,

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

