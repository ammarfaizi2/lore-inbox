Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277775AbRJRPsr>; Thu, 18 Oct 2001 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277766AbRJRPsh>; Thu, 18 Oct 2001 11:48:37 -0400
Received: from adsl-64-109-204-69.milwaukee.wi.ameritech.net ([64.109.204.69]:32501
	"HELO alphaflight.d6.dnsalias.org") by vger.kernel.org with SMTP
	id <S277756AbRJRPsS>; Thu, 18 Oct 2001 11:48:18 -0400
Date: Thu, 18 Oct 2001 10:48:35 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Martin Donnelly <md@uklinux.net>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Non-GPL modules
Message-ID: <20011018104835.J22296@0xd6.org>
In-Reply-To: <Pine.LNX.3.95.1011018091343.32746A-100000@chaos.analogic.com> <20011018090412.I22296@0xd6.org> <1003415874.4004.45.camel@inchgower>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
In-Reply-To: <1003415874.4004.45.camel@inchgower>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Martin Donnelly <md@uklinux.net> on Thu, Oct 18, 2001:

>=20
> It is a completely naive idea. You export some symbols as
> EXPORT_MODULE_GPL(). I write a wrapper which is GPL'd but i don't export
> my symbols as EXPORT_MODULE_GPL(), i now can interface to your code from
> a proprietry module without breach of license through my wrapper with
> very little work on my part.

Prorprietary modules do that anyways, your workaround isn't anything new
(NVIDIA's module comes to mind).  If you don't want to use
EXPORT_MODULE_GPL(), don't use it, and if you're willing to make the effort
to write a wrapper and accept the blight that comes with it, by all means
go ahead.  Thanks for pointing out the obvious.

> Your probably the same people who run about using ROT13 as encryption.

I fail to see how this statement has anything to do with the above
paragraph.  But anyway, I use PGP-based and other forms of encryption (did
you notice that this e-mail is signed?).

> =20
> That is you decision and you are free to have it, but don't try and
> force it on other people by saying if you don't have a system running
> 100% GPL'd (or compatibly) licensed kernel - we reserve the right to
> ignore any bugs you try and inform us about, regardless of whether or
> not is is to do with the binary only module. It isn't exactly
> encouraging.
>=20

It's not force, it's a choice.  That taint mechanism is by no means force,
it doesn't force modules to be GPL-compatible, it just taints when a module
isn't.  Tainting and EXPORT_MODULE_GPL() are two entirely different things,
intended to accomplish entirely seperate goals.  Are you able to make that
distinction?  It seems from the posts so far that most people can't.  The
only thing in common with tainting and EXPORT_MODULE_GPL() is the
MODULE_LICENSE() macro.  Any other comparisons are apples and oranges.

> Perhaps a less blunt tool could be used to encourage people to release
> GPL compatibly licensed code for their previously binary modules? I
> think you risk manufacturers withdrawing the support they have given by
> saying if they don't release their code we won't support anything to do
> with it. Carrots work better than sticks.
>=20

The GPL was the tool, but since binary-only modules were allowed
EXPORT_MODULE_GPL() takes on that role.  And again, you confuse tainting
with GPL-only symbols, the support issue comes from tainted kernels - so
no, we won't support anything to do with unreleased code.

M. R.

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7zvnTaK6pP/GNw0URAnlFAJ9d57W2aqFpj396XIAYkEM5QhkB4ACggObm
DI5cfhpesrzHp+8NUaihVdA=
=xBTw
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
