Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277710AbRJRNqJ>; Thu, 18 Oct 2001 09:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277712AbRJRNp7>; Thu, 18 Oct 2001 09:45:59 -0400
Received: from adsl-64-109-204-69.milwaukee.wi.ameritech.net ([64.109.204.69]:26362
	"HELO alphaflight.d6.dnsalias.org") by vger.kernel.org with SMTP
	id <S277710AbRJRNpm>; Thu, 18 Oct 2001 09:45:42 -0400
Date: Thu, 18 Oct 2001 08:45:59 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: pierre@lineo.com
Cc: arjanv@redhat.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
Message-ID: <20011018084559.H22296@0xd6.org>
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net> <3BCDE77F.D1B164A@lineo.com> <200110171934.f9HJY8w01260@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <3BCDF89C.32916516@lineo.com> <3BCDEAD9.DEC2415F@redhat.com> <3BCDFFE8.3DDB2591@lineo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <3BCDFFE8.3DDB2591@lineo.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* pierre@lineo.com <pierre@lineo.com> on Wed, Oct 17, 2001:

> >=20
> > It's not legal issues.
>=20
> Of course it is, this is code that deals with
> whether or not the kernel has loaded something
> that's not covered under the GPL license.
>=20

No, it isn't, the fact that a module is GPL'd or BSD'd means that the
source is available, which means that any available kernel hacker can debug
it.  Proprietary/binary-only modules won't have such a license, the source
isn't accessible, and can't be debugged by the general hacking community.

You've been reading waaaay too much into this.

>=20
> Then that's the wrong purpose : instead, oops
> posters should be made aware that they should
> post the list of loaded modules as well. If you
> really insist on having the kernel deal with this,
> make the kernel print the list of modules as well
> as the oops.
>=20

Obviously that's not enough if the tainted mechanism is needed to "dismiss"
those posts.  And how does printing the use of active modules help
determine which modules are supported and which aren't?  You'd still need
to label those modules as being proprietary and such, so you still end up
with the tainted mechanism.

>=20
> Yes it is : what about the code that allows me
> to cat /proc/sys/kernel/tainted and echo an integer
> into it ? and the code that's not loaded into kernel
> memory sure takes storage space, even if it's not
> much.
>=20

What the hell are you talking about?

> But that's not the point : the point is, the kernel
> should contain as much non-kernel junk as possible.
> Kernel code, even a small amount of it, that deals
> with licensing is junk code. It's silly enough to
> have "sponsored by" strings in the kernel as it is.
>=20

Two things.  Bitching about code that you don't agree with without
providing a suitable alternative won't really get you anywhere.  The
tainted inteface is needed to sway or halt the onslaught of bug reports for
unsupported modules.  You do realize that the kernel community can't
support modules without source?  Also, it's up to the copyright holder of a
piece of code what strings are in their code, as long as it's accepted by
whomever who cares if it contains "I'd like to give a shout out...".

M. R.

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7zt0XaK6pP/GNw0URAqNbAJ9cec/ZUwwn6KXVp3giSYMKeUr1OwCfZlK7
omqpBwyJ1t7mxpFbcsz3N7g=
=faTI
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
