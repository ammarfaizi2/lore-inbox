Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVEMR6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVEMR6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVEMR6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:58:45 -0400
Received: from zlynx.org ([199.45.143.209]:47884 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262484AbVEMR6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:58:23 -0400
Subject: Re: Sync option destroys flash!
From: Zan Lynx <zlynx@acm.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: mhw@wittsend.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050513171758.GB23621@csclub.uwaterloo.ca>
References: <1116001207.5239.38.camel@localhost.localdomain>
	 <20050513171758.GB23621@csclub.uwaterloo.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dcDghFnMEhDmLtEhM6zQ"
Date: Fri, 13 May 2005 11:58:19 -0600
Message-Id: <1116007099.29258.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dcDghFnMEhDmLtEhM6zQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-05-13 at 13:17 -0400, Lennart Sorensen wrote:
> On Fri, May 13, 2005 at 12:20:06PM -0400, Michael H. Warfield wrote:
> >	I'm also going to file a couple of bug reports in bugzilla at RedHat
> > but this seems to be a more fundamental problem than a RedHat specific
> > problem.  But, IMHO, they should never be setting that damn sync flag
> > arbitrarily.
>=20
> No they certainly should not, but it may have something to do with
> making life easier for kde/gnome desktops and automatic mount/umount of
> media.  Dumb idea still, but that happens sometimes.

Err, no, the sync flag is a wonderful idea.  I use sync on jump drives
(although I won't now that I've read about this problem) because I can
copy a file to it and as soon as the green light stops flashing I can
yank it out without bothering to click or type anything to "eject" it.
Requiring "eject" on removable media is a dumb idea.

Perhaps FAT updates could be cached and delayed until some # of ms after
the last write.

Turning the sync flag off and adjusting the values
in /proc/sys/vm/dirty_* would have the same effect, but would change it
on all devices, not just removables.

Maybe we need a way to set dirty_* per block device?
--=20
Zan Lynx <zlynx@acm.org>

--=-dcDghFnMEhDmLtEhM6zQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBChOq7G8fHaOLTWwgRAu8zAJ9+GahZKpgD5kppQU5BSzJ9I/jcHACglZHf
WAAYxNKCQW7VcDKR9zMDhKw=
=c/ak
-----END PGP SIGNATURE-----

--=-dcDghFnMEhDmLtEhM6zQ--

