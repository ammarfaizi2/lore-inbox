Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSIOQbY>; Sun, 15 Sep 2002 12:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSIOQbY>; Sun, 15 Sep 2002 12:31:24 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:33078 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S318086AbSIOQbX>;
	Sun, 15 Sep 2002 12:31:23 -0400
Date: Sun, 15 Sep 2002 11:36:14 -0500
To: Oleg Drokin <green@namesys.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu, andre@linux-ide.org
Subject: Re: 2.5.34 BUG at kernel/sched.c:944 (partitions code related?)
Message-ID: <20020915163614.GA20293@iucha.net>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	viro@math.psu.edu, andre@linux-ide.org
References: <20020910175639.A830@namesys.com> <20020910140622.GX8719@suse.de> <20020910181153.B1095@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20020910181153.B1095@namesys.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2002 at 06:11:53PM +0400, Oleg Drokin wrote:
> Hello!
>=20
> On Tue, Sep 10, 2002 at 04:06:22PM +0200, Jens Axboe wrote:
>=20
> > >    Now it does it in reverse like this:
> > > hdb: host protected area =3D> 1
> > > hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=3D119150/16/63
> > > hdb: hdb1
> > > hda: host protected area =3D> 1
> > > hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=3D119150/16/63
> > > hda: hda1 hda2 hda3 hda4 < hda5PANIC
> > Kernel compiled with preempt support or not?
>=20
> No.

I am seeing the same message "kernel BUG at sched.c:944" on 2.5.34-curr
on my Toshiba laptop. It only appears when preempt is set. Without
preempt the problem does not occur. I do not have CONFIG_TOSHIBA set.

It appears before probing for IDE devices: I had to turn off the vga
framebuffer in order to see the traceback.

I cannot capture it on serial port since my laptop has none.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9hLb+NLPgdTuQ3+QRAs+vAJ0VvSDdhsQpwP9M3E6sZtX9gQ1yzgCfZ2xB
FOKmCpebMS8tNneLf4tseQ8=
=3ozE
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
