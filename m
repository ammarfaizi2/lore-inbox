Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314618AbSD0Vf7>; Sat, 27 Apr 2002 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314619AbSD0Vf6>; Sat, 27 Apr 2002 17:35:58 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56592
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314618AbSD0Vf6>; Sat, 27 Apr 2002 17:35:58 -0400
Date: Sat, 27 Apr 2002 14:33:08 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Kevin Krieser <kkrieser_list@footballmail.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: 48-bit IDE [Re: 160gb disk showing up as 137gb]
In-Reply-To: <NDBBLFLJADKDMBPPNBALAEHKIEAA.kkrieser_list@footballmail.com>
Message-ID: <Pine.LNX.4.10.10204271431230.15403-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No, you need a host that is capable of 48-bit command set operations.
Only a few hosts fail to support the double pump of the taskfile
registers, and it requires a control register for high ordered bit
operations.

cheers,


Andre Hedrick
LAD Storage Consulting Group

On Sat, 27 Apr 2002, Kevin Krieser wrote:

> You need an IDE controller that supports ATA133.  For most existing
> computers, that is going to require a new card.-----Original Message-----
> 
> 
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ville Herva
> Sent: Saturday, April 27, 2002 7:56 AM
> To: Martin Bene; linux-kernel@vger.kernel.org
> Subject: 48-bit IDE [Re: 160gb disk showing up as 137gb]
> 
> 
> On Sat, Apr 27, 2002 at 12:16:06PM +0200, you [Martin Bene] wrote:
> >
> > IDE: The kernel IDE driver needs to support 48-bit addresseing to support
> > 160GB.
> >
> > (...) however, you can do something about the linux ATA driver: code
> > is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.
> 
> But which IDE controllers support 48-bit addressing? Not all of them? Does
> linux IDE driver support 48-bit for all of them? Do they require BIOS
> upgrade in order to operate 48-bit?
> 
> Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
> box I have and be done with it?
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

