Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130568AbQLaTPI>; Sun, 31 Dec 2000 14:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130352AbQLaTO5>; Sun, 31 Dec 2000 14:14:57 -0500
Received: from ziggy.one-eyed-alien.net ([216.120.107.189]:43529 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S129370AbQLaTOo>; Sun, 31 Dec 2000 14:14:44 -0500
Date: Sun, 31 Dec 2000 10:43:58 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: jerdfelt@valinux.com, linux-kernel <linux-kernel@vger.kernel.org>,
        Linux USB Storage List <usb-storage@one-eyed-alien.net>
Subject: Re: [patchlet] enable HP 8200e USB CDRW
Message-ID: <20001231104358.B6652@one-eyed-alien.net>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>, jerdfelt@valinux.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux USB Storage List <usb-storage@one-eyed-alien.net>
In-Reply-To: <Pine.LNX.4.30.0012311148340.20511-100000@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0012311148340.20511-100000@waste.org>; from oxymoron@waste.org on Sun, Dec 31, 2000 at 11:50:14AM -0600
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Um, I'm not sure that this driver is even ready for the EXPERIMENTAL label.
What does the driver's author say?

Matt

On Sun, Dec 31, 2000 at 11:50:14AM -0600, Oliver Xymoron wrote:
> This patchlet lets me use my HP CDRW.
>=20
> --- linux/drivers/usb/Config.in~	Mon Nov 27 20:10:35 2000
> +++ linux/drivers/usb/Config.in	Tue Dec 19 12:21:56 2000
> @@ -32,6 +32,9 @@
>     if [ "$CONFIG_USB_STORAGE" !=3D "n" ]; then
>        bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
>        bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FRE=
ECOM
> +      if [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
> +          bool '    HP8200e support (EXPERIMENTAL)' CONFIG_USB_STORAGE_H=
P8200e
> +      fi
>     fi
>     dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_U=
SB
>     dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
>=20
> --=20
>  "Love the dolphins," she advised him. "Write by W.A.S.T.E.."
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:  Let me guess, you started on the 'net with AOL, right?
C:  WOW! d00d! U r leet!
					-- Greg and Customer=20
User Friendly, 2/12/1999

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6T35uz64nssGU+ykRAhiaAKCYt1eU4ZiThKETl0qzuWNwl7twuQCdHwzm
sKoAmE4A4xg6KiVLmvfs4aE=
=KNRT
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
