Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270823AbRHSWbC>; Sun, 19 Aug 2001 18:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270825AbRHSWaW>; Sun, 19 Aug 2001 18:30:22 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:11781
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S270823AbRHSWaF>; Sun, 19 Aug 2001 18:30:05 -0400
Date: Sun, 19 Aug 2001 15:30:17 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Mike Castle <dalgoda@ix.netcom.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        mayfield+usb@sackheads.org
Subject: Re: [PATCH] config options for USB
Message-ID: <20010819153017.A24976@one-eyed-alien.net>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	mayfield+usb@sackheads.org
In-Reply-To: <20010819124459.F30309@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010819124459.F30309@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Sun, Aug 19, 2001 at 12:44:59PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These two should probably be put under "experimental".

Matt

On Sun, Aug 19, 2001 at 12:44:59PM -0700, Mike Castle wrote:
>=20
> I noticed that 2.4.8 introduced Jimme Mayfield's Datafab and Jumpshot USB
> drivers.  However, there are no entries in Config.in.  There were also
> other new features added (ISD200) that are also missing entries, though
> since I don't know anything about them, I didn't create entries for them.
>=20
>=20
> diff -ru linux-2.4.9.orig/drivers/usb/Config.in linux-2.4.9/drivers/usb/C=
onfig.in
> --- linux-2.4.9.orig/drivers/usb/Config.in	Wed Jun 27 13:59:32 2001
> +++ linux-2.4.9/drivers/usb/Config.in	Sun Aug 19 12:29:03 2001
> @@ -33,6 +33,8 @@
>        bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
>        bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FRE=
ECOM
>        bool '    Microtech CompactFlash/SmartMedia reader' CONFIG_USB_STO=
RAGE_DPCM
> +      bool '    Datafab MDCFE-B Compact Flash Reader' CONFIG_USB_STORAGE=
_DATAFAB
> +      bool '    Lexar Jumpshot Compact Flash Reader' CONFIG_USB_STORAGE_=
JUMPSHOT
>     fi
>     dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_U=
SB
>     dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
>=20
> --=20
>      Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
>     We are all of us living in the shadow of Manhattan.  -- Watchmen
> fatal ("You are in a maze of twisty compiler features, all different"); -=
- gcc

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'll scuff my feet on the carpet and zap your nose hairs unless you=20
TALK mister!! Who put you up to this?
					-- Pitr
User Friendly, 3/30/1998

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7gD35z64nssGU+ykRAlN9AJ9lGNSF2CtO2M22Rtig+mcmdKosjgCgwi63
yv6Is6RWM+b7sWaVo8JdyKY=
=Jm/x
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
