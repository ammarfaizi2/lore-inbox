Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWBJEtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWBJEtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWBJEtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:49:41 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:16361 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S1751082AbWBJEtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:49:40 -0500
Date: Fri, 10 Feb 2006 15:49:13 +1100
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jim@why.dont.jablowme.net, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210044913.GG26235@samad.com.au>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jim@why.dont.jablowme.net, peter.read@gmail.com,
	matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline
In-Reply-To: <43EB0DEB.nail52A1LVGUO@burner>
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2006 at 10:39:55AM +0100, Joerg Schilling wrote:
> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
>=20
> > > You just verify that you don't listen...
> > =20
> > Yes, I have been listening and I haven't seen you list one reason why
> > cdrecord absolutely has to use SCSI IDs when fsck can get away with usi=
ng
> > /dev/blah just fine.
>=20
> Are you _really_ missing basic know how to understand that fsck is using =
the
> block layer of a virtual "block device" emulated by UNIX while libscg is
> offering _direct_ acces to _any_ type of device allowing you to send _com=
mands_
> understood by the device?
>=20
> fsck is just sending abstract instructions to a virtual device and does=
=20
> not care about=20
>=20
> Please explain me:
>=20
> -	how to use /dev/hd* in order to scan an image from a scanner
>=20
> -	how to use /dev/hd* in order to talk to a CPU device
>=20
> -	how to use /dev/hd* in order to talk to a tape device
>=20
> -	how to use /dev/hd* in order to talk to a printer
>=20
> -	how to use /dev/hd* in order to talk to a jukebox
>=20
> -	how to use /dev/hd* in order to talk to a graphical device

Hi=20

I have been following this thread for quite a while, would just like to
point out that you are quick pedantic about accuracy. =20

so even though it might be a bit of a pain to create a file called
/dev/hd*, I believe with mknod you could assign this name to any device
you wanted to or even symlink it to any device so you could use you
/dev/hd* the same way as you used /dev/sda etc

>=20
> J?rg
>=20
> --=20
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) J?rg Schilling D-13353 Be=
rlin
>        js@cs.tu-berlin.de                (uni) =20
>        schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogs=
pot.com/
>  URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/s=
chily
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--QWpDgw58+k1mSFBj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7BtJkZz88chpJ2MRAtxQAKDKI4CTlQOd4P7otnebx2cL9p33bACeMw2H
ii1D0v6MyKKn7+JPcHiohv0=
=fKOM
-----END PGP SIGNATURE-----

--QWpDgw58+k1mSFBj--
