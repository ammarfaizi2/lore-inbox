Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWBJRet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWBJRet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWBJRet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:34:49 -0500
Received: from mout1.freenet.de ([194.97.50.132]:52664 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751275AbWBJRes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:34:48 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Fri, 10 Feb 2006 18:32:29 +0100
User-Agent: KMail/1.8.3
References: <200602031724.55729.luke@dashjr.org> <Pine.LNX.4.61.0602091832500.30108@yvahk01.tjqt.qr> <43EC72E3.nailISD4HI9WC@burner>
In-Reply-To: <43EC72E3.nailISD4HI9WC@burner>
Cc: eter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3189547.49poKJXB4P";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602101832.29992.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3189547.49poKJXB4P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 10 February 2006 12:02, you wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>=20
>=20
> > Right. The question was rather like this:
> > Say we have our non-stable /dev/sr0 mapping to /dev/sg0, and it has got=
 BTL=20
> > 1,1,0. Now, if the user starts `cdrecord -dev=3D1,1,0`,
> > `ls -l /proc/$(pidof -s cdrecord)/fd/` should show (and in fact did whe=
n I=20
> > used ide-scsi back then) /dev/sg0, right?
> >
> > If so, what's wrong with just opening /dev/sg0 directly (as per user=20
> > request, i.e. cdrecord -dev=3D/dev/sg0) and sending the scsi commands d=
own=20
> > the fd?
>=20
> As I did write _many_ times, this was done by the program "cdwrite" on Li=
nux
> in 1995 and as cdwrite did not check whether if actually got a CD writer,
> cdwrite did destroy many hard disk drives just _because_ the /dev/sg*=20
> is non-stable.
>=20
> People did not believe this and did write shell scripts with e.g. /dev/sg=
0=20
> inside and later suffered from the non-stable /dev/sg* <-> device relatio=
n.

I am sure they used udev, back in 1995...

=2D-=20
Greetings Michael.

--nextPart3189547.49poKJXB4P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD7M4tlb09HEdWDKgRAnhsAKC5BgviAv2XrN4DQg7J4gw1SK3wFACgqG9S
7kGNbLZ9cEvhI/mbBwAxwu4=
=ARtx
-----END PGP SIGNATURE-----

--nextPart3189547.49poKJXB4P--
