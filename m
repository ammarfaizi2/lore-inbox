Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314266AbSD0Pja>; Sat, 27 Apr 2002 11:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314268AbSD0Pj3>; Sat, 27 Apr 2002 11:39:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:48839 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314266AbSD0Pj2>;
	Sat, 27 Apr 2002 11:39:28 -0400
Date: Sat, 27 Apr 2002 17:39:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
        Martin Bene <martin.bene@icomedias.com>, linux-kernel@vger.kernel.org
Subject: Re: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Message-ID: <20020427173913.A7293@ucw.cz>
In-Reply-To: <D143FBF049570C4BB99D962DC25FC2D2159B3A@freedom.icomedias.com> <20020427125551.GG10849@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 03:55:51PM +0300, Ville Herva wrote:
> On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
> > 
> > IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> > 160GB.
> > 
> > (...) however, you can do something about the linux ATA driver: code
> > is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.
> 
> But which IDE controllers support 48-bit addressing? Not all of them?

ALL IDE controllers support 48-bit addressing. Actually, they don't need
to know about it.

> Does
> linux IDE driver support 48-bit for all of them?

Yes, since 2.4.19-pre3 as far as I know.

> Do they require BIOS
> upgrade in order to operate 48-bit?

Only if you need to boot from the drive and then you still can boot from
the first 140 megs or so.

> Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
> box I have and be done with it?

That's it, yes.

-- 
Vojtech Pavlik
SuSE Labs
