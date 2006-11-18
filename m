Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756243AbWKRNYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243AbWKRNYu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756315AbWKRNYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:24:50 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:24004 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1756243AbWKRNYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:24:50 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Christian <christiand59@web.de>
Subject: Re: Sluggish system responsiveness on I/O
Date: Sat, 18 Nov 2006 14:25:16 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611181412.29144.christiand59@web.de>
In-Reply-To: <200611181412.29144.christiand59@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2226829.qq0b3SGbsv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611181425.17024.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2226829.qq0b3SGbsv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag 18 November 2006 14:12 schrieb Christian:
> So I tried to nice the make and see what happens:
>
> nice 5 make -j4: Seems to make no difference. Heavy stuttering in glxgears
> and et
> nice 10 make -j4: Somewhat better but still unusable with et
>
> everything above nice 15 is usable. nice 19 has full interactivity, that
> means you can't make out a difference between no load and kernel compile
> while playing enemy-territory.
>
> I suspect that it has something to do with the priority boost for I/O hog=
s.
> But if this is a "general" scheduler problem, then why aren't more people
> complaining about this?

I complained about this a year ago, but not much has changed. :-( It gets e=
sp=20
bad if you copy GB size files (the writes are the problemmakers, less the=20
reads) - no matter which io scheduler I use, though using deadline seems to=
=20
lessen the impact a little bit. And I don't find it acceptable to have to=20
play around with nice to get a responsible desktop, esp when one is using a=
=20
GUI.

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2226829.qq0b3SGbsv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFXwm9xU2n/+9+t5gRAo45AJ0U6Zd6DCJO5dlzByOVgVTqg6kmwQCgw2Hh
oKOcWLTbckCqeDy6B8xJPH8=
=ND+A
-----END PGP SIGNATURE-----

--nextPart2226829.qq0b3SGbsv--
