Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRHaWQz>; Fri, 31 Aug 2001 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269489AbRHaWQq>; Fri, 31 Aug 2001 18:16:46 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:3846 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S269481AbRHaWQ1>; Fri, 31 Aug 2001 18:16:27 -0400
Date: Fri, 31 Aug 2001 15:16:36 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] usb fix
Message-ID: <20010831151636.B17480@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <200108312203.WAA15637@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108312203.WAA15637@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Aug 31, 2001 at 10:03:27PM +0000
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Odd.... must have been some sort of merging error on my part.  Sorry about
that.

Alan, Linus, this looks fine.

Matt

On Fri, Aug 31, 2001 at 10:03:27PM +0000, Andries.Brouwer@cwi.nl wrote:
> Wondering why my USB Compact Flash cardreader works with 2.4.7
> but not with 2.4.9, I noticed that my name was added and some
> constant changed. Changing it back revived my CF reader.
>=20
> Andries
>=20
> --- ../linux-2.4.9/linux/drivers/usb/storage/unusual_devs.h	Sat Aug 11 03=
:16:46 2001
> +++ ./linux/drivers/usb/storage/unusual_devs.h	Fri Aug 31 23:50:19 2001
> @@ -96,7 +96,7 @@
>  #endif
> =20
>  /* This entry is from Andries.Brouwer@cwi.nl */
> -UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0205,=20
> +UNUSUAL_DEV(  0x04e6, 0x0005, 0x0100, 0x0208,
>  		"SCM Microsystems",
>  		"eUSB SmartMedia / CompactFlash Adapter",
>  		US_SC_SCSI, US_PR_DPCM_USB, NULL,=20

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

DP: And judging from the scores, Stef has the sma... =20
T:  LET'S NOT GO THERE!
					-- Dust Puppy and Tanya
User Friendly, 12/11/1997

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7kAzEz64nssGU+ykRAsXWAJ43l0buh6V5Xq/Wtd3cbi6EUUB+pQCdHeAM
y600l6YtDePtP/TMub27qlg=
=91SG
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
