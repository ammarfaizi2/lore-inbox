Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSENHhH>; Tue, 14 May 2002 03:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315258AbSENHhG>; Tue, 14 May 2002 03:37:06 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:60633 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S315257AbSENHhE>;
	Tue, 14 May 2002 03:37:04 -0400
Date: Tue, 14 May 2002 09:37:08 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: graeme fisher <graeme@2d3d.co.za>, linux-kernel@vger.kernel.org
Subject: Re: Agpgart for 845G
Message-ID: <20020514093708.A27785@crystal.2d3d.co.za>
Mail-Followup-To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>,
	graeme fisher <graeme@2d3d.co.za>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.cfjurcv.v30q20@ifi.uio.no> <3CDFDB26.5070509@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 9:28am  up 12 days, 16:17, 15 users,  load average: 0.00, 0.00, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas!

> > +    { PCI_DEVICE_ID_INTEL_845_G_0,
> > +		 PCI_VENDOR_ID_INTEL,
> > +		 INTEL_I845_G,
> > +		 "Intel",
> > +		 "i845G",
> > +		 intel_830mp_setup },
>=20
> Are you sure that 830mp and 845g have exactly the same addresses to=20
> write/read to ? BTW, I can't find any datasheet for 845g on Intel's=20
> website ... do you have any at hand ?

The 845g chipset is the little brother of 830mp - it's memory allocation
didn't change a bit, so above setup is actually correct.

> > +			if (i810_dev =3D=3D NULL) {
> > +                                /*=20
> > +                                 * We probably have a I830MP chipset
> > +                                 * with an external graphics
> > +                                 * card. It will be initialized later=
=20
> > +                                 */
> > +				agp_bridge.type =3D INTEL_I845_G;
> > +				break;
> > +			}
>=20
> Are you sure about the comment :-)) ?

Smells like cut & paste to me (;

--=20

Regards
 Abraham

"Intelligence without character is a dangerous thing."
-- G. Steinem

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE84L6kzNXhP0RCUqMRAmAkAJ9RLSLM4O1Xjuv6NcZai4cCJhNHZgCeODVT
uIMo7wQPQO+d06v5Lxpf+DA=
=5tqw
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
