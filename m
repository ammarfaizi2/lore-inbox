Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277783AbRJRQHj>; Thu, 18 Oct 2001 12:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277785AbRJRQH3>; Thu, 18 Oct 2001 12:07:29 -0400
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:40968 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S277783AbRJRQHK>;
	Thu, 18 Oct 2001 12:07:10 -0400
Date: Thu, 18 Oct 2001 11:08:26 -0500
From: Taral <taral@taral.net>
To: Patrick Mochel <mochelp@infinity.powertie.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011018110826.A22339@taral.net>
In-Reply-To: <Pine.LNX.4.21.0110171617460.15653-100000@marty.infinity.powertie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2001 at 04:52:29PM -0700, Patrick Mochel wrote:
> When a suspend transition is triggered, the device tree is walked first t=
o=20
> save the state of all the devices in the system. Once this is complete, t=
he=20
> saved state, now residing in memory, can be written to some non-volatile=
=20
> location, like a disk partition or network location.=20
>=20
> The device tree is then walked again to suspend all of the devices. This=
=20
> guarantees that the device controlling the location to write the state is=
=20
> still powered on while you have a snapshot of the system state.=20

Aha! A much nicer solution to the problem the ACPI people are having
with suspend/resume (ordering problems).

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjvO/noACgkQoQQF8xCPwJSKEQCfRDABojCC41Rcjj4WzYQOrdfX
fgYAn1Ze4GSOzW5iF57Y0lZ+yJ/Tb9/V
=o4Ck
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
