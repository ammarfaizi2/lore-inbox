Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSB1RER>; Thu, 28 Feb 2002 12:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293437AbSB1RB0>; Thu, 28 Feb 2002 12:01:26 -0500
Received: from think.faceprint.com ([166.90.149.11]:56990 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S293472AbSB1RAi>; Thu, 28 Feb 2002 12:00:38 -0500
Date: Thu, 28 Feb 2002 11:59:54 -0500
To: Dave Jones <davej@suse.de>, Benjamin Pharr <ben@benpharr.com>,
        linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020228165951.GA4014@faceprint.com>
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu> <20020222022149.N5583@suse.de> <20020222063721.GA8879@faceprint.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20020222063721.GA8879@faceprint.com>
User-Agent: Mutt/1.3.27i
From: faceprint@faceprint.com (Nathan Walp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2002 at 01:37:24AM -0500, Nathan Walp wrote:
> On Fri, Feb 22, 2002 at 02:21:49AM +0100, Dave Jones wrote:
> >  > It compiled fine. When I booted up everything looked normal with the
> >  > exception of a=20
> >  > eth1: going OOM=20
> >  > message that kept scrolling down the screen. My eth1 is a natsemi ca=
rd.
> >=20
> >  That's interesting. Probably moreso for Manfred. I'll double check
> >  I didn't goof merging the oom-handling patch tomorrow.
>=20
> Ditto here on my natsemi.  It hasn't really spit out the error since
> boot, about 12 hours ago.  Card has been mainly idle, only used to
> connect via crossover cable to my laptop, which hasn't been used much in
> that time.

dj2 is showing the same behavior, but I found out that the messages
continue to be printed 100 times/second until I ping-flooded the machine
on the other end of that card.  The minimal DHCP traffic prior to the
ping flood was not enough to make it stop.

Hope this helps narrow down the problem some.

Nathan


--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fmIHPkYs3Ekt234RAlVeAJ4i9giRTadcFgqAjzqE6gOgpyUdOgCfaGpC
QuwvQRhBbv+cf1e0wCq/9X4=
=WmWT
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
