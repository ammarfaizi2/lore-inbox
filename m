Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314619AbSD0VjP>; Sat, 27 Apr 2002 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314620AbSD0VjO>; Sat, 27 Apr 2002 17:39:14 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58128
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314619AbSD0VjO>; Sat, 27 Apr 2002 17:39:14 -0400
Date: Sat, 27 Apr 2002 14:36:07 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Ville Herva <vherva@twilight.cs.hut.fi>,
        Martin Bene <martin.bene@icomedias.com>, linux-kernel@vger.kernel.org
Subject: Re: 48-bit IDE [Re: 160gb disk showing up as 137gb]
In-Reply-To: <20020427173913.A7293@ucw.cz>
Message-ID: <Pine.LNX.4.10.10204271434490.15403-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Vojtech Pavlik wrote:

> On Sat, Apr 27, 2002 at 03:55:51PM +0300, Ville Herva wrote:
> > On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
> > > 
> > > IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> > > 160GB.
> > > 
> > > (...) however, you can do something about the linux ATA driver: code
> > > is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.
> > 
> > But which IDE controllers support 48-bit addressing? Not all of them?
> 
> ALL IDE controllers support 48-bit addressing. Actually, they don't need
> to know about it.

Sorry this is not correct, I have a list that fail.
However I need to compose a test to revoke their 48-bit operations
regardless if the device supports.

> > Does
> > linux IDE driver support 48-bit for all of them?
> 
> Yes, since 2.4.19-pre3 as far as I know.
> 
> > Do they require BIOS
> > upgrade in order to operate 48-bit?
> 
> Only if you need to boot from the drive and then you still can boot from
> the first 140 megs or so.
> 
> > Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
> > box I have and be done with it?
> 
> That's it, yes.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

