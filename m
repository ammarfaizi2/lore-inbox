Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVHJN1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVHJN1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVHJN1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:27:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3041 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965104AbVHJN1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:27:07 -0400
Date: Wed, 10 Aug 2005 08:26:26 -0500
From: AJ Lewis <alewis@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Lars Marowsky-Bree <lmb@suse.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [Linux-cluster] Re: [PATCH 00/14] GFS
Message-ID: <20050810132626.GC4954@null.msp.redhat.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	David Teigland <teigland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk> <20050810070309.GA2415@infradead.org> <20050810103041.GB4634@marowsky-bree.de> <20050810103256.GA6127@infradead.org> <20050810103424.GC4634@marowsky-bree.de> <20050810105450.GA6519@infradead.org> <20050810110259.GE4634@marowsky-bree.de> <20050810110511.GA6728@infradead.org> <20050810110917.GG4634@marowsky-bree.de> <20050810111110.GA6878@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTzoGrkn2AhIv4sC"
Content-Disposition: inline
In-Reply-To: <20050810111110.GA6878@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wTzoGrkn2AhIv4sC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2005 at 12:11:10PM +0100, Christoph Hellwig wrote:
> On Wed, Aug 10, 2005 at 01:09:17PM +0200, Lars Marowsky-Bree wrote:
> > So for every directoy hiearchy on a shared filesystem, each user needs
> > to have the complete list of bindmounts needed, and automatically resync
> > that across all nodes when a new one is added or removed? And then have
> > that executed by root, because a regular user can't?
>=20
> Do it in an initscripts and let users simply not do it, they shouldn't
> even know what kind of filesystem they are on.

I'm just thinking of a 100-node cluster that has different mounts on differ=
ent
nodes, and trying to update the bind mounts in a sane and efficient manner
without clobbering the various mount setups.  Ouch.

--=20
AJ Lewis                                   Voice:  612-638-0500
Red Hat                                    E-Mail: alewis@redhat.com
One Main Street SE, Suite 209
Minneapolis, MN 55414
  =20
Current GPG fingerprint =3D D9F8 EDCE 4242 855F A03D  9B63 F50C 54A8 578C 8=
715
Grab the key at: http://people.redhat.com/alewis/gpg.html or one of the
many keyservers out there...


--wTzoGrkn2AhIv4sC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+gCB9QxUqFeMhxURAioRAJ4qJ/z3BsFHI3lc26TMCFgdYp8d/QCeKqya
2CwkTlXcO5DVDiLwfE6u0Qk=
=Frx3
-----END PGP SIGNATURE-----

--wTzoGrkn2AhIv4sC--
