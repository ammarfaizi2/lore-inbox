Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269673AbRHaWrW>; Fri, 31 Aug 2001 18:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269693AbRHaWrN>; Fri, 31 Aug 2001 18:47:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20494 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269673AbRHaWq7>; Fri, 31 Aug 2001 18:46:59 -0400
Subject: Re: [PATCH] usb fix
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Fri, 31 Aug 2001 23:50:16 +0100 (BST)
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010831151636.B17480@one-eyed-alien.net> from "Matthew Dharm" at Aug 31, 2001 03:16:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cx7A-00049p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> --LyciRD1jyfeSSjG0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Odd.... must have been some sort of merging error on my part.  Sorry about
> that.
> 
> Alan, Linus, this looks fine.
> 
> Matt
> 
> On Fri, Aug 31, 2001 at 10:03:27PM +0000, Andries.Brouwer@cwi.nl wrote:
> > Wondering why my USB Compact Flash cardreader works with 2.4.7
> > but not with 2.4.9, I noticed that my name was added and some
> > constant changed. Changing it back revived my CF reader.
> >=20
> > Andries
> >=20
> > --- ../linux-2.4.9/linux/drivers/usb/storage/unusual_devs.h	Sat Aug 11 03=
> :16:46 2001
> > +++ ./linux/drivers/usb/storage/unusual_devs.h	Fri Aug 31 23:50:19 2001
> > @@ -96,7 +96,7 @@
> >  #endif
> > =20
> >  /* This entry is from Andries.Brouwer@cwi.nl */
> > -UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0205,=20
> > +UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0208,
> >  		"SCM Microsystems",
> >  		"eUSB SmartMedia / CompactFlash Adapter",
> >  		US_SC_SCSI, US_PR_DPCM_USB, NULL,=20
> 
> --=20
> Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
> net=20
> Maintainer, Linux USB Mass Storage Driver
> 
> DP: And judging from the scores, Stef has the sma... =20
> T:  LET'S NOT GO THERE!
> 					-- Dust Puppy and Tanya
> User Friendly, 12/11/1997
> 
> --LyciRD1jyfeSSjG0
> Content-Type: application/pgp-signature
> Content-Disposition: inline
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.6 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
> 
> iD8DBQE7kAzEz64nssGU+ykRAsXWAJ43l0buh6V5Xq/Wtd3cbi6EUUB+pQCdHeAM
> y600l6YtDePtP/TMub27qlg=
> =91SG
> -----END PGP SIGNATURE-----
> 
> --LyciRD1jyfeSSjG0--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

