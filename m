Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315145AbSDWKpZ>; Tue, 23 Apr 2002 06:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315146AbSDWKpY>; Tue, 23 Apr 2002 06:45:24 -0400
Received: from dsl-213-023-038-128.arcor-ip.net ([213.23.38.128]:28834 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315145AbSDWKpX>;
	Tue, 23 Apr 2002 06:45:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Mon, 22 Apr 2002 12:44:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Rasmus Andersen <rasmus@jaquet.dk>,
        CaT <cat@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16z06w-0000mM-00@starship> <20020423070417.A19987@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zbJ6-0001Rq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 April 2002 08:04, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > In fact, the basic premise is that people mail to the patchbot, not the
> > maintainer.  The patchbot knows who the maintainer is and forwards the patch
> > to the maintainer, using the maintainer's format of choice, or as now
> > proposed, just drops it into the BK repository and forwards a notification,
> > both to the maintainer and the linux-patches list.
> 
> Oh, now that _is_ a good idea.  So individuals like me can register and
> say "notify me if anyone posts something for net/packet/* or
> include/linux/if_packet.h".  Whether I'm a maintainer or not?

Yes, see the NOTIFYONCHANGE remark earlier.  Some form of metadata in the file
could could be used to effect that, or the patchbot's database could record it.

Want to help throw code at this?  I see the scope of this expanding.

> That would be pretty useful.
> 
> An uber-feature would be "notify me if the VFS interface or locking
> rules change", for version 2 perhaps ;-)

Challenging, but doable.  It's a database + command interface problem, and of
course, coding resource problem.  Did you have a framework in mind?

-- 
Daniel
