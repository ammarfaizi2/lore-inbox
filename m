Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSKFNvK>; Wed, 6 Nov 2002 08:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265082AbSKFNvK>; Wed, 6 Nov 2002 08:51:10 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:41454 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265077AbSKFNvJ>; Wed, 6 Nov 2002 08:51:09 -0500
Subject: Re: [Evms-announce] EVMS announcement
From: Arjan van de Ven <arjanv@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Kevin Corry <corryk@us.ibm.com>,
       evms-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1036590957.9803.24.camel@irongate.swansea.linux.org.uk>
References: <02110516191004.07074@boiler> 
	<20021106001607.GJ27832@marowsky-bree.de> 
	<1036590957.9803.24.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-CpuhvlqGy4DJtHMKXggB"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 14:59:08 +0100
Message-Id: <1036591157.2509.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CpuhvlqGy4DJtHMKXggB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-11-06 at 14:55, Alan Cox wrote:
> On Wed, 2002-11-06 at 00:16, Lars Marowsky-Bree wrote:
> > Now, an interesting question is whether the md modules etc will simply =
be
> > continued to be used or whether they'll make use of the DM engine too? =
Can
> > they be made "plugins" to DM or the EVMS framework? Or even, could EVMS=
 (in
> > theory) parse the meta-data from a legacy md device and just setup a DM
> > mapping for it? That would appeal to me quite a bit. I really need to s=
tart
> > reading up on it...
>=20
> I'm certainly hoping to kill off ataraid/pdcraid/hptraid by using device
> mapper and md

absolutely. The biggest issue with this is that DM needs to be able to
handle chunks where 1 page is split across 2 strides on disk... if/once
DM (and BIO) can deal with that the rest isn't hard...


--=-CpuhvlqGy4DJtHMKXggB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ySAsxULwo51rQBIRAo7ZAJ9oydM/747VO2DHItJLt6jACnPSigCeMPW4
phbXXuDIRitoLnkrZMN/XWY=
=ojhN
-----END PGP SIGNATURE-----

--=-CpuhvlqGy4DJtHMKXggB--

