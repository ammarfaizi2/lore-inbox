Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276628AbSIVGV6>; Sun, 22 Sep 2002 02:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276639AbSIVGV5>; Sun, 22 Sep 2002 02:21:57 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:31579 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S276628AbSIVGV5>;
	Sun, 22 Sep 2002 02:21:57 -0400
Date: Sun, 22 Sep 2002 01:27:02 -0500
To: William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <20020922062702.GA652@iucha.net>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <20020921161702.GA709@iucha.net> <597384533.1032600316@[10.10.2.3]> <20020921185939.GA1771@iucha.net> <20020921202353.GA15661@win.tue.nl> <20020922043050.GU3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20020922043050.GU3530@holomorphy.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2002 at 09:30:50PM -0700, William Lee Irwin III wrote:
> On Sat, Sep 21, 2002 at 01:59:39PM -0500, Florin Iucha wrote:
> >> X is not locked up, as it eats all the CPU. And 2.5.36 works just fine.
>=20
> On Sat, Sep 21, 2002 at 10:23:53PM +0200, Andries Brouwer wrote:
> > I noticed that the pgrp-related behaviour of some programs changed.
> > Some programs hang, some programs loop. The hang occurs when they
> > are stopped by SIGTTOU. The infinite loop occurs when they catch SIGTTOU
> > (and the same signal is sent immediately again when they leave the
> > signal routine).
> > Have not yet investigated details.
>=20
> Linus seems to have put out 2.5.38 with some X lockup fixes. Can you
> still reproduce this? If so, are there non-X-related testcases where
> you can trigger this? My T21 Thinkpad doesn't see this at all.
>=20
> I'm still prodding the SIGTTOU path trying to trigger it until then.

Weird. 2.5.38 works just fine but the head from few hours ago (which
supposedly had the fix) doesn't. Oh well, it works fine now on both the
desktop and the laptop.

florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9jWK1NLPgdTuQ3+QRAhw8AJ0eBBCktXn3lzXFB3Zpp3RRSSUVTwCfSeMS
AmkrSLTMEm3fY2oE5UkkJio=
=wpGE
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
