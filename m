Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLDCeD>; Sun, 3 Dec 2000 21:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLDCdy>; Sun, 3 Dec 2000 21:33:54 -0500
Received: from oe40.law11.hotmail.com ([64.4.16.97]:28429 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129324AbQLDCdZ>;
	Sun, 3 Dec 2000 21:33:25 -0500
X-Originating-IP: [24.164.154.68]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "Steven N. Hirsch" <shirsch@adelphia.net>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0012031739360.3253-100000@pii.fast.net>
Subject: Re: Phantom PS/2 mouse persists..
Date: Sun, 3 Dec 2000 20:47:00 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE40Njy1jCzc3UspbP200006074@hotmail.com>
X-OriginalArrivalTime: 04 Dec 2000 02:02:58.0441 (UTC) FILETIME=[52F17F90:01C05D96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; <linux-kernel@vger.kernel.org>
Sent: Sunday, December 03, 2000 5:42 PM
Subject: Re: Phantom PS/2 mouse persists..


> On Sun, 3 Dec 2000, Jeff V. Merkey wrote:
>
> > > On Sun, Dec 03, 2000 at 06:27:52PM +0000, Alan Cox wrote:
> > > >
> > > > I've fixed the major case. I can see no definitive answer to the
other ghost
> > > > PS/2 stuff (except maybe USB interactions). I take it like the
others 2.4test
> > > > also misreports a PS/2 mouse being present.
> > > >
> > > > Anyway I think its no longer a showstopper for 2.2.18. Someone with
an affected
> > > > board can piece together the picture
>
> > I just tested 2.2.18-24 as a boot kernel with anaconda -- works great --
> > mouse problem on PS/2 system is nailed.
>
> <sigh>  I always seem to own the wierd hardware.  I agree the mouse
> mis-detection isn't a showstopper - just damn annoying.
>
> FWIW, USB isn't compiled into the kernel in question.
>

    Definately could be your hardware.  I once saw a 486 board (PcChips M571
I think) which would report a PS/2 mouse even though the port didn't even
exist on the motherboard.  This problem showed up on all versions of Win9x.
>From what I could tell it appeared as if the BIOS had support for the PS/2
mouse port but the port pins themself had not been saudered onto the board
and for some reason the board alway thaught it had a PS/2 mouse and reported
as so to Windows.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
