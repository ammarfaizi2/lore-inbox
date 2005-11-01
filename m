Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVKAREP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVKAREP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVKAREP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:04:15 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:47322 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S1750963AbVKAREO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:04:14 -0500
Date: Tue, 1 Nov 2005 09:04:13 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last third of inode tables
Message-ID: <20051101170413.GA11640@the-penguin.otak.com>
References: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]> <87oe54cza8.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <87oe54cza8.fsf@mid.deneb.enyo.de>
X-Operating-System: Linux 2.6.14-rc4-mm1 on an i686
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Weimer [fw@deneb.enyo.de] wrote:
> * Alex Bligh:
>=20
> > All seems to go well until I try and do mke2fs. This appears to work,
> > and tries to write the inode tables. However, at (about) 3400 inodes
> > (of 11176), it slows to a crawl, writing one table every 10 seconds.
> > strace shows it is still running, and no errors are being reported.
> > However, it seems very sick.
>=20
> In my experience, the 3ware SATA controllers which are not NCQ-capable
> have very, very lousy write performance with some drives, unless you
> enable the write cache (which is, of course, a bit dangerous without
> UPS or battery backup on the controller).
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Not to sound like the a 3ware chearleader, but this card does support NCQ.
--=20
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - -=20



--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDZ6ANsgPkFxgrWYkRAkl2AJsHGL7jhENEYdq1mZkWV7WADg9KaQCfXSN4
zVcNTjygjvj9LngXQuXZRho=
=RQ20
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
