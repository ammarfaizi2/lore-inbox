Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131732AbRCQRbd>; Sat, 17 Mar 2001 12:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131734AbRCQRbX>; Sat, 17 Mar 2001 12:31:23 -0500
Received: from dial117.za.nextra.sk ([195.168.64.117]:2052 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S131732AbRCQRbK>;
	Sat, 17 Mar 2001 12:31:10 -0500
Date: Sat, 17 Mar 2001 18:59:15 +0100
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: Is swap == 2 * RAM a permanent thing?
Message-ID: <20010317185915.A5154@Boris>
In-Reply-To: <Pine.LNX.4.21.0103151421380.22425-100000@benatar.snurgle.org> <Pine.LNX.4.33.0103152344260.1320-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103152344260.1320-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Mar 15, 2001 at 11:44:52PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2001 at 11:44:52PM -0300, Rik van Riel wrote:
> On Thu, 15 Mar 2001, William T Wilson wrote:
>=20
> > it seems to me that in 2.2.x it looks like this:
> >
> > total usage =3D=3D swap + RAM
> > under 2.4.x it looks like:
> > total usage =3D=3D swap
>=20
>   total usage =3D=3D maximum(swap, ram)

Hi,=20

Do you in fact talk about=20
  1) curren usage =3D=3D maximum(swap, ram)
     or
  2) virtual ram capacity =3D=3D maximum(swap, ram)
?

I'm a bit confused.

My next question is: some time ago i've read, that code segments of process,
which comes from executable and should stay unmodified during process
duration, are not swapped into swap space, cause they can be restored
back from the executable. This should be ok, because in protect mode
no one can write into code seg. This does seem to be true for win, because
i cannot delete executable file when it's just run, but under linux
i can delete /bin/bash without any problem.=20

Why this is so ?

Because of security ? Say my disk gets corrupted right at blocks executable
image si contained and swapping in page(s) from this errorneous area
should lock/corrupt system ?

Code content can be changed indirectly in case data or some read-write segm=
ent overlaps=20
code segment. Does linux count with such a situation ? (may data segment
overlap code seg ?)



Thanks                                                                Boro


email: boris@acheron.sk=20

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjqzpeQACgkQ3+NbSeu0rHBolACeImefk0P7XjZryxCqtT2evIO8
b70An2t/eHYEEdkeRr3SWMEhTHV4gmtd
=gkOA
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
