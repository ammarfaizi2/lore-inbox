Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314264AbSD0Pd4>; Sat, 27 Apr 2002 11:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314265AbSD0Pdz>; Sat, 27 Apr 2002 11:33:55 -0400
Received: from freedom.icomedias.com ([193.154.7.22]:55119 "EHLO
	freedom.icomedias.com") by vger.kernel.org with ESMTP
	id <S314264AbSD0Pdy> convert rfc822-to-8bit; Sat, 27 Apr 2002 11:33:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: AW: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Date: Sat, 27 Apr 2002 17:33:46 +0200
Message-ID: <D143FBF049570C4BB99D962DC25FC2D2159B40@freedom.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Thread-Index: AcHt81vdINzRZwnfSWK24vOMxefKowADUAlg
From: "Martin Bene" <martin.bene@icomedias.com>
To: "Kevin Krieser" <kkrieser_list@footballmail.com>,
        <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

> You need an IDE controller that supports ATA133.  For most existing
> computers, that is going to require a new card.

That actually turns out not to be the case.

While you do need a new controller if you want to use ATA133, the LBA48 addressing scheme in no way depends on ATA133. Running a 160GB disk on your old ATA100 (or ATA66 or ATA33) controller works just fine.

Bye, Martin

-----Original  Message-----
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
> > IDE: The kernel IDE driver needs to support 48-bit 
> addresseing to support
> > 160GB.
> >
> > (...) however, you can do something about the linux ATA driver: code
> > is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.
> 
> But which IDE controllers support 48-bit addressing? Not all 
> of them? Does
> linux IDE driver support 48-bit for all of them? Do they require BIOS
> upgrade in order to operate 48-bit?
> 
> Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them 
> into whatever
> box I have and be done with it?
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
