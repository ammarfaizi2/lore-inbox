Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314632AbSD0Wco>; Sat, 27 Apr 2002 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314633AbSD0Wcn>; Sat, 27 Apr 2002 18:32:43 -0400
Received: from ch-12-44-141-235.lcisp.com ([12.44.141.235]:13185 "EHLO
	dual.lcisp.com") by vger.kernel.org with ESMTP id <S314632AbSD0Wcn>;
	Sat, 27 Apr 2002 18:32:43 -0400
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Date: Sat, 27 Apr 2002 17:32:35 -0500
Message-ID: <NDBBLFLJADKDMBPPNBALIEIMIEAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <D143FBF049570C4BB99D962DC25FC2D2159B40@freedom.icomedias.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, I was recalling some article I read last year that said you
needed upgraded firmware (such as upgraded motherboard or new PCI card) to
get > 137GB support.  I should have verified that my information was still
correct.

And here I made sure the motherboard I bought this month had 133 support so
I could use future large hard drives on it :)  At least I finally have
support for my ATA100 drives at something faster than ATA33.

-----Original Message-----
From: Martin Bene [mailto:martin.bene@icomedias.com]
Sent: Saturday, April 27, 2002 10:34 AM
To: Kevin Krieser; linux-kernel@vger.kernel.org
Subject: AW: 48-bit IDE [Re: 160gb disk showing up as 137gb]


Hi Kevin,

> You need an IDE controller that supports ATA133.  For most existing
> computers, that is going to require a new card.

That actually turns out not to be the case.

While you do need a new controller if you want to use ATA133, the LBA48
addressing scheme in no way depends on ATA133. Running a 160GB disk on your
old ATA100 (or ATA66 or ATA33) controller works just fine.

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



