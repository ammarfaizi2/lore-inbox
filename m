Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269466AbTGZUU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 16:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269528AbTGZUU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 16:20:26 -0400
Received: from mx02.qsc.de ([213.148.130.14]:40090 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S269466AbTGZUUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 16:20:24 -0400
Date: Sat, 26 Jul 2003 22:35:35 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Message-ID: <20030726203535.GD789@gmx.de>
References: <20030725185325.GA3944@localhost.localdomain> <20030726104506.GA663@gmx.de> <20030726175214.GA2535@localhost.localdomain> <20030726183750.GB789@gmx.de> <20030726201919.GA5166@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
In-Reply-To: <20030726104506.GA663@gmx.de>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm2-O9 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2003 at 01:49:19AM +0530, Balram Adlakha wrote:
> On Sat, Jul 26, 2003 at 08:37:50PM +0200, Wiktor Wodecki wrote:
> > On Sat, Jul 26, 2003 at 11:22:14PM +0530, Balram Adlakha wrote:
> > > The old naming scheme is (quite) depricated. Firstly, devfs shows onl=
y those devices which are probed (have a driver), secondly the devices are =
sorted in an easy to understand directory heirarchy to reduce clutter.
> > > Theres a devfs daemon called devfsd which is actually (almost) a part=
 of a working devfs system. Using devfsd, you can autoload modules even whi=
le using devfs, and it also creates symlinks to older device name if that i=
s specified in the /etc/devfsd.conf file.
> > > It is your choice if you want to use devfs or not, linux is all about=
 choice. If you don't like the new naming scheme, you can edit a few lines =
in the devfs source and change the scheme. Or you can have devfs mounted in=
 another place (like /dev2) and create a script which creates symlinks from=
 /dev2 to /dev with your own preferred names, and you can edit /etc/rc.d/rc=
=2Esysinit to run the script on bootup.
> > > Or you can continue using the old device inodes...Some people still p=
refer them.
> >=20
> > I understand that and I greatly appreciate the new naming scheme.
> > However it would have been nice if I could have bootet just up and look
> > at it without changing my core system files (I regard /etc/fstab as
> > core). Nevermind, I might give it another shot on a testing system.
> >=20
> You won't need to update /etc/fstab if you use devfsd and its configured =
to create old device names in /dev...

ah! This should be placed somewhere in a FAQ or so. As I've read through
the docs this isn't mentioned anywhere. This of course solves all my
concerns about devfs. Will try it again soon.
Thanks for enlightment :-)

--=20
Regards,

Wiktor Wodecki

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IuYX6SNaNRgsl4MRApjtAJsFR7+pzHRLb0z1LM9UQTSBq+oopQCeIYvt
zz2AwxOudwqSXN2UL0U/Jx8=
=L93e
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
