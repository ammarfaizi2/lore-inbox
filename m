Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVKTD42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVKTD42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 22:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKTD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 22:56:28 -0500
Received: from dp.samba.org ([66.70.73.150]:52185 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S1751194AbVKTD42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 22:56:28 -0500
Subject: Re: support for mknod to windows now in cifs vfs
From: Andrew Bartlett <abartlet@samba.org>
To: Steve French <smfrench@austin.rr.com>
Cc: mkoeppe@gmx.de, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <437F8339.3060502@austin.rr.com>
References: <437EAA7F.5050907@austin.rr.com>
	 <1132404007.4397.3.camel@amy.flyaway.abartlet.net>
	 <437F8339.3060502@austin.rr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-w/QIDqAaDhFqksqcsEG+"
Date: Sun, 20 Nov 2005 14:56:44 +1100
Message-Id: <1132459005.17693.21.camel@amy.flyaway.abartlet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w/QIDqAaDhFqksqcsEG+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-11-19 at 13:55 -0600, Steve French wrote:
> Andrew Bartlett wrote:=20
> > On Fri, 2005-11-18 at 22:30 -0600, Steve French wrote:
> >  =20
> > > I added the code to cifs vfs to enable it do mknod of block and=20
> > > chardevice even if the server does not support the Unix extensions (s=
uch=20
> > > as Windows).  This requires the "sfu" mount option to be specified=20
> > >    =20
> >=20
> > Any reason why this isn't on by default?=20
> >=20
> > Andrew Bartlett
> >  =20
>=20
> I agree with most of Martin's points - even on Windows there are a few
> (possibly with Vista) three ways e.g. to do symlinks.  Although sfu is
> the most important way to do it it is a bit slower too.

Isn't there also the mac 'magic file size' thing too?  Did that change,
or should we also cope with servers holding those files?

Andrew Bartlett

--=20
Andrew Bartlett                                http://samba.org/~abartlet/
Samba Developer, SuSE Labs, Novell Inc.        http://suse.de
Authentication Developer, Samba Team           http://samba.org
Student Network Administrator, Hawker College  http://hawkerc.net

--=-w/QIDqAaDhFqksqcsEG+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDf/P8z4A8Wyi0NrsRAh00AJ427jft3Po76caa7IbSs5j/GxDGrACdHODa
87CEb5Z9CXdTSf3H5IvLfy8=
=1+/A
-----END PGP SIGNATURE-----

--=-w/QIDqAaDhFqksqcsEG+--

