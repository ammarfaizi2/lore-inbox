Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbRGEXHB>; Thu, 5 Jul 2001 19:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbRGEXGo>; Thu, 5 Jul 2001 19:06:44 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:2323 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S265470AbRGEXGX>; Thu, 5 Jul 2001 19:06:23 -0400
Date: Thu, 5 Jul 2001 16:05:34 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Message-ID: <20010705160534.A17113@one-eyed-alien.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <9515.994372983@redhat.com> <E15II3b-0003T8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15II3b-0003T8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 05, 2001 at 11:57:11PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Better, but throwing __FILE__ in there would be good too...

Come to think of it, tho, we have multiple files named the same thing in
multiple places on the kernel tree... even __var##__LINE__##__FILE__ isn't
_guaranteed_ to be unique.

Matt

On Thu, Jul 05, 2001 at 11:57:11PM +0100, Alan Cox wrote:
> > Life's a bitch.
> > cf. get_user(__ret_gu, __val_gu); (on i386)
> >=20
> > Time to invent a gcc extension which gives us unique names? :)
>=20
> #define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)
>=20
> #define __magic_minfoo(A,B,C,D) \
> 	{ typeof(A) C =3D (A)  .... }
>=20
>=20
> Alan
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Ye gods! I have feet??!
					-- Dust Puppy
User Friendly, 12/4/1997

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7RPK9z64nssGU+ykRAmFbAJ4hFXPbEJ0BtEmIBgV7LOa9P3P16ACfXGfU
6KtUsSxdMUgsuZc5OQa/i7k=
=346M
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
