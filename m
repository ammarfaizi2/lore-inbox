Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289437AbSAJNXh>; Thu, 10 Jan 2002 08:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289438AbSAJNX1>; Thu, 10 Jan 2002 08:23:27 -0500
Received: from gate.mesa.nl ([194.151.5.70]:35602 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S289437AbSAJNXS>;
	Thu, 10 Jan 2002 08:23:18 -0500
Date: Thu, 10 Jan 2002 14:22:19 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Jim Crilly <noth@noth.is.eleet.ca>,
        Chris Ball <chris@void.printf.net>,
        Benjamin S Carrell <ben@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
Message-ID: <20020110142219.G22717@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <3C3D191E.7090804@noth.is.eleet.ca> <Pine.LNX.4.33L.0201101010090.2985-100000@imladris.surriel.com> <20020110131557.Y19814@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020110131557.Y19814@suse.de>; from axboe@suse.de on Thu, Jan 10, 2002 at 01:15:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 01:15:57PM +0100, Jens Axboe wrote:
> On Thu, Jan 10 2002, Rik van Riel wrote:
> > On Wed, 9 Jan 2002, Jim Crilly wrote:
> > 
> > > Actually it would seem this is just Andre's, not so subtle, way of
> > > trying to prove that his ATA133/48-bit addressing patches need
> > > included in 2.4.
> > 
> > I think you'll agree with him the moment you end up with
> > a cheap 160 GB drive in your machine and the old driver
> > (which is limited to 32(?)-bit LBA) won't let you use a
> > large portion of the disk ;)
> 
> It's 28-bit LBA, which means
> 
> 2^28 * 512 == 137GB (hard disk manufacturer gigs)
> 
> So waste is just 23GB :-)

At the current rate the 200GB or 32GB disk will appear in a couple of 
days:  320-137 = 183 GB :-)

> 
> Once the ide stuff has been proven, of course it will get integrated.
> 

At this time it is stale enough to keep my laptop from filesystem
corruption (write cash flush)...

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
