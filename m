Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUCBSua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUCBSua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:50:30 -0500
Received: from cryptobackpack.org ([68.164.243.10]:35486 "EHLO
	mail.cryptobackpack.org") by vger.kernel.org with ESMTP
	id S261658AbUCBSuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:50:17 -0500
Date: Tue, 2 Mar 2004 10:47:58 -0800
From: David Bryson <david@tsumego.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: circular pivot_root, is this possible ?
Message-ID: <20040302184758.GA10082@heliosphan.futuretel.com>
Reply-To: David Bryson <david@tsumego.com>
References: <1v7Zf-5EG-5@gated-at.bofh.it> <E1AyCUQ-00004T-N0@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <E1AyCUQ-00004T-N0@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2004 at 05:11:26PM +0100 or thereabouts, Pascal Schmidt wro=
te:
> On Tue, 02 Mar 2004 03:40:09 +0100, you wrote in linux.kernel:
>=20
> > Say the system needs an upgrade.... I want to
> >
> > 1) pivot_root _back out_ of the tmpfs, onto the initrd again
> > 2) obtain via network a new sys.img, write it to the flash
> > 3) wipe tmpfs, and recopy the contents of the new sys.img into memory
> > 4) pivot_root back into the tmpfs and start the higher level system
> > again
>=20
> How about using a second, small tmpfs for / under/over which the tmpfs
> for the full system can be mounted and umounted at will?
>=20

Are you suggesing something like:

* tmfs1 contains 'basic functionality'
* tmpfs2 is mounted somewhere on tmpfs1

I still fail to see how this will let one restart/position init based
on which filesystem/director is root.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARNbeLfsM4nS2FiARAmFFAKCtFP8/z7VJBFqZn6NRYmAs98fD2ACgq3CO
xB9btmySSD8EbO2ddlZey1w=
=lUAw
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
