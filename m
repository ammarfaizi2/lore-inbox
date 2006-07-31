Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWGaRQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWGaRQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWGaRQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:16:23 -0400
Received: from lug-owl.de ([195.71.106.12]:8402 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030265AbWGaRQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:16:22 -0400
Date: Mon, 31 Jul 2006 19:16:20 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dan Oglesby <doglesby@teleformix.com>
Cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731171620.GL31121@lug-owl.de>
Mail-Followup-To: Dan Oglesby <doglesby@teleformix.com>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <1154364421.7964.22.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zROEGoKAXsG5UqGB"
Content-Disposition: inline
In-Reply-To: <1154364421.7964.22.camel@localhost>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zROEGoKAXsG5UqGB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 11:47:00 -0500, Dan Oglesby <doglesby@teleformix.com> wr=
ote:
> On Mon, 2006-07-31 at 18:22 +0200, Jan-Benedict Glaw wrote:
> > On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich <reiser4@blinkenlights=
=2Ech> wrote:
> > > A colleague of mine happened to create a ~300gb filesystem and started
> > > to migrate Mailboxes (Maildir-style format =3D many small files (1-3k=
b))
> > > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> > So preparation work wasn't done.
>=20
> As someone who is currently planning to migrate ~100GB of stored mail to
> the Maildirs format, it was pretty clear early on that EXT3 would not
> cut it (from past and current experiences), and not just for the sake of
> calculating inodes.

Uh?  Where did you face a problem there?

With maildir, you shouldn't face any problems IMO. Even users with
zillions of mails should work properly with the dir_index stuff:

	tune2fs -O dir_index /dev/hdXX

or alternatively (to start that for already existing directories):

	e2fsck -fD /dev/hdXX


Of course, you'll always face a problem with lots of files in one
directory at getdents() time (eg. opendir()/readdir()/closedir()), but
this is a common limit for all filesystems.

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
Signature of:           Alles wird gut! ...und heute wirds schon ein bi=C3=
=9Fchen besser.
the second  :

--zROEGoKAXsG5UqGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzjrkHb1edYOZ4bsRAjZUAJ4jmxJQFGQSzz6CfPEbZeVAbPIUNQCeMIlB
1lhHhNKeQxAgf7hj7UsnYws=
=aNZk
-----END PGP SIGNATURE-----

--zROEGoKAXsG5UqGB--
