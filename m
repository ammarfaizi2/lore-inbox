Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSBANYx>; Fri, 1 Feb 2002 08:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291754AbSBANYo>; Fri, 1 Feb 2002 08:24:44 -0500
Received: from p3EE02CD7.dip.t-dialin.net ([62.224.44.215]:50695 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S291753AbSBANY3>;
	Fri, 1 Feb 2002 08:24:29 -0500
Date: Fri, 1 Feb 2002 14:19:43 +0100
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: David Dyck <dcd@tc.fluke.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 missing <linux/malloc.h>
Message-ID: <20020201141943.A16445@sistina.com>
Reply-To: mauelshagen@sistina.com
In-Reply-To: <Pine.LNX.4.33.0201301239370.19671-100000@dd.tc.fluke.com> <Pine.LNX.4.33.0201301446080.7748-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0201301446080.7748-100000@barbarella.hawaga.org.uk>; from benc@hawaga.org.uk on Wed, Jan 30, 2002 at 02:52:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:52:16PM -0800, Ben Clifford wrote:
> On Wed, 30 Jan 2002, David Dyck wrote:
> 
> >     drivers/base/core.c
> >     drivers/base/fs.c
> > try to include linux/malloc.h

./drivers/video/neofb.c

and

./arch/arm/mach-clps711x/dma.c

include it also.

> 
> > and I've noticed that many source files have
> >   #include <linux/slab.h>     /* kmalloc(), kfree() */
> > instead of trying to include linux/malloc.h
> 
> I have been changing the two malloc.h references to slab.h since at least
> 2.5.3-pre6 and I think possibly also in 2.5.2.
> 
> It seems to work ok.
> 
> -- 
> Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
> Job Required in Los Angeles - Will do most things unix or IP for money.
> http://www.hawaga.org.uk/resume/resume001.pdf
> Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
