Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282062AbRKVHaP>; Thu, 22 Nov 2001 02:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282064AbRKVHaF>; Thu, 22 Nov 2001 02:30:05 -0500
Received: from gate.mesa.nl ([194.151.5.70]:43531 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S282062AbRKVH3v>;
	Thu, 22 Nov 2001 02:29:51 -0500
Date: Thu, 22 Nov 2001 08:29:30 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dominik Kubla <kubla@sciobyte.de>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: New ac patch???
Message-ID: <20011122082930.A18888@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <E166VIr-0004ik-00@the-village.bc.nu> <Pine.LNX.4.40.0111221100460.10224-100000@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0111221100460.10224-100000@boston.corp.fedex.com>; from jeffchua@silk.corp.fedex.com on Thu, Nov 22, 2001 at 11:03:27AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 11:03:27AM +0800, Jeff Chua wrote:
> On Wed, 21 Nov 2001, Alan Cox wrote:
> 
> > > > Not exaclty. It is a 48Gig drive in a dell inspiron 8000. I think it is
> > > > IBM but the logs do not show a brandname. I can try open up the case tonight
> > > > if you want to know for sure?
> > >
> > > It's an IBM IC25T048ATDA05-0 to be precise.
> >
> > Thanks. It seems IBM laptop drives are the ones that specifically need this
> > fix. That ties in with the windows 98 reports/microsoft fixes.
> 
> I'm using IBM 240Z with IBM-DJSA-220 (20GB, 9.5mm thickness) with
> 2.4.15-pre7 and it does not need any fixes. Disk clean after shutdown.

Does it have write caching enabled? check with hdparm ( I think you need one of
the latest hdparm versions...)

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
