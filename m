Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUCKWx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUCKWx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:53:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54212 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261815AbUCKWxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:53:09 -0500
Date: Thu, 11 Mar 2004 23:53:01 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Daniel Egger <degger@fhm.edu>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] MAINTAINERS: remove LAN media entry
Message-ID: <20040311225301.GG14833@fs.tum.de>
References: <20040307155008.GM22479@fs.tum.de> <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403080221520.2604-100000@dmt.cyclades>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 02:22:36AM -0300, Marcelo Tosatti wrote:
> 
> > It's a question whether removing drivers from a stable kernel series is 
> > a good idea, but the following is definitely correct:
> > 
> > 
> > --- linux-2.4.26-pre2-full/MAINTAINERS.old	2004-03-07 16:48:59.000000000 +0100
> > +++ linux-2.4.26-pre2-full/MAINTAINERS	2004-03-07 16:49:09.000000000 +0100
> > @@ -1077,12 +1077,6 @@
> >  W:	http://www.cse.unsw.edu.au/~neilb/oss/knfsd/
> >  S:	Maintained
> >  
> > -LANMEDIA WAN CARD DRIVER
> > -P:      Andrew Stanley-Jones
> > -M:      asj@lanmedia.com
> > -W:      http://www.lanmedia.com/
> > -S:      Supported
> > - 
> >  LAPB module
> >  P:	Henner Eisen
> >  M:	eis@baty.hanse.de
> > 
> 
> I think it might be better to change to
> 
> 
> LANMEDIA WAN CARD DRIVER
> S: UNMAINTAINED
> 
> Thoughts? 

I discussed this with Sam in the subthread regarding the 2.6 version of 
this patch:
It seems to be the more common practice that non-maintained drivers 
don't have an entry in MAINTAINERS.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

