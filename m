Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270987AbTGPRlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270969AbTGPRk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:40:27 -0400
Received: from mh57.com ([217.160.185.21]:50850 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S270965AbTGPRjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:39:06 -0400
Date: Wed, 16 Jul 2003 19:53:28 +0200
From: Martin Hermanowski <martin@mh57.de>
To: Peter Chubb <peter@chubb.wattle.id.au>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030716175328.GU8228@mh57.de>
References: <20030711155613.GC2210@gtf.org> <20030711203850.GB20970@win.tue.nl> <20030715000331.GB904@matchmail.com> <20030715170804.GA1089@win.tue.nl> <16148.53643.475710.301248@wombat.chubb.wattle.id.au> <20030716170720.GC2681@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20030716170720.GC2681@matchmail.com>
User-Agent: Mutt/1.5.4i
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2003 at 10:07:20AM -0700, Mike Fedyk wrote:
> On Wed, Jul 16, 2003 at 02:16:11PM +1000, Peter Chubb wrote:
> > >>>>> "Andries" =3D=3D Andries Brouwer <aebr@win.tue.nl> writes:
> >=20
> > Andries> On Mon, Jul 14, 2003 at 05:03:31PM -0700, Mike Fedyk wrote:
> > >> So, will the DOS partition make it up to 2TB?  If so, then we won't
> > >> have a problem until we have larger than 2TB drives
> >=20
> > Andries> Yes, DOS partition table works up to 2^32 sectors, and with
> > Andries> 2^9-byte sectors that is 2 TiB.
> >=20
> > Andries> People are encountering that limit already. We need something
> > Andries> better, either use some existing scheme, or invent something.
> >=20
> > We had this discussion before, back when I first submitted the large
> > block device patches.  The consensus then was to use EFI, or LDM.
> >=20
> > Unless the BIOS supports a partitioning scheme, you're not
> > going to be able to boot anyway, or at least not without doing
> > something clever.
>=20
> The bios shouldn't even know about partition tables.  It just loads the c=
ode
> in the MBR, and the boot loader deals with the rest from there.

There are some bios variants that refuse to boot if the hard disk has no
partition with the boot-flag set.

LLAP, Martin

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/FZEYmGb6Npij0ewRAkNfAKCBBo5/mdCZbWp4SOrzijG/N0q8gACgnQjp
fzZOIa07wUtiy9lJEZlmbRI=
=xg9w
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
