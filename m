Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbTESNeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 09:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbTESNeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 09:34:36 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:27891 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262121AbTESNee
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 09:34:34 -0400
Subject: Re: recursive spinlocks. Shoot.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: ptb@it.uc3m.es
Cc: David Woodhouse <dwmw2@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200305191337.h4JDbf311387@oboe.it.uc3m.es>
References: <200305191337.h4JDbf311387@oboe.it.uc3m.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c4iAK19RtMobrxd7hp2C"
Organization: Red Hat, Inc.
Message-Id: <1053352040.1430.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 19 May 2003 15:47:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c4iAK19RtMobrxd7hp2C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-19 at 15:37, Peter T. Breuer wrote:
> "David Woodhouse wrote:"
> > To be honest, if any programmer is capable of committing this error and
> > not finding and fixing it for themselves, then they're also capable, an=
d
> > arguably _likely_, to introduce subtle lock ordering discrepancies whic=
h
> > will cause deadlock once in a blue moon.
> >=20
> > I don't _want_ you to make life easier for this hypothetical programmer=
.
> >=20
> > I want them to either learn to comprehend locking _properly_, or take u=
p
> > gardening instead.
>=20
> Let's quote the example from rubini & corbet of the sbull block device
> driver. The request function ends like so:

defective locking in a driver is no excuse to pamper over it with
recusrive shite.

--=-c4iAK19RtMobrxd7hp2C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+yOBoxULwo51rQBIRAuOiAJ4sJi6j+Ytodm1IOaVI+aP7Pz65GwCfZjlN
eQ/BY56PuB59NqU3iSe988c=
=GvPm
-----END PGP SIGNATURE-----

--=-c4iAK19RtMobrxd7hp2C--
