Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbRBBJeu>; Fri, 2 Feb 2001 04:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBBJek>; Fri, 2 Feb 2001 04:34:40 -0500
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:13272 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129042AbRBBJe0>; Fri, 2 Feb 2001 04:34:26 -0500
Message-ID: <002101c08cfb$a3e026b0$8d19b018@c779218a>
From: "Nicholas Knight" <tegeran@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: VT82C686A corruption with 2.4.x
Date: Fri, 2 Feb 2001 01:36:37 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops, I forgot to send this to linux-kernel as well...

----- Original Message -----
From: "Nicholas Knight" <tegeran@home.com>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Sent: Thursday, February 01, 2001 5:24 AM
Subject: Re: VT82C686A corruption with 2.4.x


> ----- Original Message -----
> From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
> To: "David Riley" <oscar@the-rileys.net>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Thursday, February 01, 2001 4:51 AM
> Subject: Re: VT82C686A corruption with 2.4.x
>
>
> > Yeah, I'm seriously beginning to think it's a board specific issue. If I
> > drop the RAM count down to 768MB I get far less drops in app deaths
>
> <....>
>
> >Right now I've got the full 1GB in there. What I'm seeing now is
> >application deaths, occational X11 lockups, but SUPRIZE! SUPRIZE! no more
> >drive corruptions since I removed the DMA flag from the drives, disabled
> >DMA use in the BIOS and replaced the ATA66 cable with an ATA33.
>
> (the following is a lot of conjecture and doesn't wholly fit the
information
> avalible to me on this problem, but maybe it'll help bring about other
ideas
> that will lead to a fix for this)
>
> OK, I haven't had a chance to get 2.4 up and running yet, but yesterday I
> was troubleshooting some lockup issues in Win2k and there was a slim
chance
> that it might have had to do with overheating of the chipset that controls
> the RAM on the machine; but it turned out to be something of a driver
issue.
> However this got me thinking more about heat... this *really* is sounding
> more and more like a heat problem to me... esspecialy if it might be board
> specific, since there might be something in the specific designs that
causes
> higher levels of heat.
> I *KNOW* that it seems unlikely since no other OS is exhibiting these
> problems to my knowledge (including linux 2.2.*) but what if? Could there
be
> something in 2.4 making it more sensitive to errors related to heat? Could
> 2.4 somehow be making the HDD controllers run hotter?
> Prehaps we should start collecting average system tempatures of systems
that
> display this problem, esspecialy while running 2.4.x both with and without
> DMA enabled.
>
> <end conjecture spoken by someone without enough information avalible to
> him>
>
> -NK
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
