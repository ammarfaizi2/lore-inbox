Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVDGI1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVDGI1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVDGI0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:26:22 -0400
Received: from dea.vocord.ru ([217.67.177.50]:52164 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262271AbVDGIYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:24:40 -0400
Subject: Re: connector is missing in 2.6.12-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050407081718.GA4402@kroah.com>
References: <1112855509.18360.27.camel@frecb000711.frec.bull.fr>
	 <20050406234257.460edb9a.akpm@osdl.org>  <20050407081718.GA4402@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d99Jno2X8cu7z07yXpj3"
Organization: MIPT
Date: Thu, 07 Apr 2005 12:30:49 +0400
Message-Id: <1112862649.28858.108.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 12:23:58 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d99Jno2X8cu7z07yXpj3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 01:17 -0700, Greg KH wrote:
> On Wed, Apr 06, 2005 at 11:42:57PM -0700, Andrew Morton wrote:
> > Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > >
> > > Hello,
> > >=20
> > >  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. So i=
t
> > > seems that you removed the connector?
> >=20
> > Greg dropped it for some reason.  I think that's best because it needed=
 a
> > significant amount of rework.  I'd like to see it resubitted in totalit=
y so
> > we can take another look at it.
>=20
> Greg dropped it because he's radically changing the way he handles
> patches.  I still have them around here somewhere...

He probably was quite dissapointed/overflowed by it's quality and
quantity, but please thank him for his comments and tell him it=20
was very pleasant to work with.

> Yeah, here they are.  Hm, I'd really like to stop carrying them around,
> as my workload doesn't lend itself to handling these.
>=20
> If you don't mind, can you create up a new connector, super-io, and
> kobject-connector patch and send them to andrew for him to add to -mm?
> That way I'll not have to worry about them anymore, as they keep
> floating in-and-out of the -mm releases depending on the state of my
> trees.  I can still handle your w1 patches, and have 2 of them pending.
>=20
> Is that ok with you?

Ok, I will prepare new series of that patches and will push them
upstream.

Thank you.

> thanks,
>=20
> greg k-h
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-d99Jno2X8cu7z07yXpj3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVO+5IKTPhE+8wY0RAvgLAJ9eirtQC+a3d7UgQRMahR161nXqRgCgi4m0
K9Ek8zxiCYQSIZtFHdN4qso=
=vCsZ
-----END PGP SIGNATURE-----

--=-d99Jno2X8cu7z07yXpj3--

