Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272922AbTHEWIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272923AbTHEWIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:08:20 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:21421 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S272922AbTHEWIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:08:13 -0400
Subject: RE: [2.6] Perl weirdness with ext3 and HTREE
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Christopher Li <chrisl@vmware.com>
Cc: KML <linux-kernel@vger.kernel.org>, akpm@digeo.com, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org
In-Reply-To: <68F326C497FDB743B5F844B776C9B1460976FD@pa-exch4.vmware.com>
References: <68F326C497FDB743B5F844B776C9B1460976FD@pa-exch4.vmware.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UpCXs5oQSZ5bJWVtEP7D"
Message-Id: <1060121303.8355.47.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 00:08:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UpCXs5oQSZ5bJWVtEP7D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 at 23:53, Christopher Li wrote:

> >=20
> > I cannot really see that it is a Gentoo specific problem, but=20
> > who knows.
> > I will try to get a CD of another distro somewhere, and get that on a
> > box to test - currently work/whatnot just keeps me pretty tied up :(
> > Another reason why I posted, is now that 2.6 is more widely=20
> > used/tested,
> > its not only me that gets this, but other users as well - thus I hoped
> > that somebody with more time wanted to have a crack at it.
>=20
> I am not claiming it is a gentoo issue. I just want to duplicate
> this bug with minimal damage to my box.
>=20

Yep, I know, I just 'clarified' it in case somebody was wondering.

> >=20
> > If it works fine (with a 2.6 kernel), I will go and bang my=20
> > head against
> > a wall, and shutup until I can make time to try and track=20
> > this - if not,
> > any ideas as to creating it outside the perl install (or=20
> > rather the man
> > page part of the install process) would be great.
> >=20
>=20
> You can do a strace on the perl install, then grep for all
> the file changes happen on that directory. There is a good
> chance follow the strace log can duplicate the bug also.

Yep, did that.  I had a simple c program once that tried to
simulate all file operations on that file, and the 'real'
man page that gets installed.  Did not have the same effect
however.  Might be that I was off by something.  Don't have
it however anymore, as it was some months before, just before
I mailed the first time.


Thanks,

--=20

Martin Schlemmer




--=-UpCXs5oQSZ5bJWVtEP7D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MCrVqburzKaJYLYRAg8YAJ4sLI6CQde/sN1KuIs5cJRWpSZUMACfZQGf
q6CKb6kXtbJQOaXoVkiGmUE=
=GdY3
-----END PGP SIGNATURE-----

--=-UpCXs5oQSZ5bJWVtEP7D--

