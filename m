Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTJNIAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTJNIAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:00:50 -0400
Received: from ns.schottelius.org ([213.146.113.242]:34706 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S261946AbTJNIAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:00:47 -0400
Date: Tue, 14 Oct 2003 09:57:43 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Andre Tomt <andre@tomt.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, underley@underley.eu.org
Subject: Re: [BUG] 2.6.0test7 & test4: tun.o (devfs)
Message-ID: <20031014075743.GA30368@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Andre Tomt <andre@tomt.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, underley@underley.eu.org
References: <20031013214835.GA8006@schottelius.org> <1066118003.482.5.camel@slurv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <1066118003.482.5.camel@slurv>
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andre Tomt [Tue, Oct 14, 2003 at 09:53:24AM +0200]:
> On Mon, 2003-10-13 at 23:48, Nico Schottelius wrote:
> > Hello!
> >=20
> > When loading tun.o in test7 and test4 it does not create /dev/net/tun.
> > I am not familar with the devfs_create_device() call, so I cannot
> > currently see what's wrong where. But I think tun.o should create the d=
evice..
>=20
> It creates /dev/misc/net/tun, IIRC.

*shameonme*
hit me twice.

but why is it not found in /dev/net/tun?

Nico

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/i6x3zGnTqo0OJ6QRAh+9AKDOD5S1LVCqptOhg4K6S3eumUutRwCfbVr/
qIwK6qvNA/mAnGarlLp9eU0=
=GcfX
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
