Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUGBHhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUGBHhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUGBHhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:37:52 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:15057 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S266492AbUGBHhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:37:48 -0400
Date: Fri, 2 Jul 2004 03:36:36 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Voodoo3 2000 is eating my chars!
Message-ID: <20040702073636.GA25592@babylon.d2dc.net>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040701185527.GB122@DervishD>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20040701185527.GB122@DervishD>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 01, 2004 at 08:55:27PM +0200, DervishD wrote:
>     Hi all :)
>=20
>     I recently put a Voodoo3 2000 (AGP) card to my home linux box,
> and now I have a problem in the console. When switching from X to the
> console, some chars dissappear, or appear cut, etc. I've googled for
> this, but with no success. Is this a known bug? Maybe an X bug?

This is actually an X bug, which I thought I had fixed a long time ago
when I was still doing 3Dfx stuff.

On console switch not all the state is being restored properly,
specificly the font is getting screwed up, simply reloading the font
should work fine though.

I no longer have either an X tree to easily play in, nor a 3Dfx card in
a box to test with, so I'm afraid that you're going to have to bug the X
people.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Has anyone got a reference cynic? I think I need to recalibrate myself.
  -- James Riden in the SDM.

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5RCDRFMAi+ZaeAERAtLIAKCjquwLJogjj9c9cS97+XpiR+NRjwCfTfZg
94h6s3NM+N/voYYrmT4kjt8=
=mZUE
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
