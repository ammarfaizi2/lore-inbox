Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUCZDAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUCZDAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:00:53 -0500
Received: from 66-194-152-191.gen.twtelecom.net ([66.194.152.191]:35457 "EHLO
	pico.surpasshosting.com") by vger.kernel.org with ESMTP
	id S262974AbUCZDAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:00:47 -0500
Date: Thu, 25 Mar 2004 20:59:09 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: David Schwartz <davids@webmaster.com>
Cc: Matthew Wilcox <willy@debian.org>, Jeff Garzik <jgarzik@pobox.com>,
       Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Message-ID: <20040326025909.GY9248@cheney.cx>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	Matthew Wilcox <willy@debian.org>, Jeff Garzik <jgarzik@pobox.com>,
	Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
	debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <81ptb0wh45.wl@omega.webmasters.gr.jp> <MDEHLPKNGKAHNMBLJOLKAEFILEAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t3Rhqlz/9+3FgEet"
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEFILEAA.davids@webmaster.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cheney.cx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--t3Rhqlz/9+3FgEet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2004 at 06:06:37PM -0800, David Schwartz wrote:
>=20
>=20
> > At Fri, 26 Mar 2004 00:33:39 +0000,
>=20
> > Matthew Wilcox wrote:
>=20
> > > I realise there's a grey area between "magic data you write to a devi=
ce"
> > > and "a program that is executed on a different processor".  For examp=
le,
> > > palette data for a frame buffer.  But nobody's arguing for that grey
> > > area here -- it's clearly a program without source code that Debian
> > > can't distribute.
>=20
> > Well, I also think this is grey area.
>=20
> 	On what basis? How is this file different from an executable?
>=20
> 	The gray area cases are where the code, as orginally written, is obscure.
> Perhaps because it uses 'magic numbers' from data sheets rather than
> symbolic constants. However, the GPL doesn't require you to add comments =
or
> to write clear code. It simply prohibits deliberate obfuscation by one
> particular means, namely having two forms of the code, one that you
> distribute and one that you use to make modifications. (Other forms of
> obfuscation are the gray areas.)
>=20
> 	But this case is squarely where the GPL says "no". In this case, there is
> one form of the firmware for the purposes of making modifications to it a=
nd
> there is another form that's distributed, ostensibly under the GPL.

So is a reverse engineered driver where there is a binary blob the
preferred form of source? Otherwise the case isn't that binary blobs are
against the GPL, just that if the author knows what generates the binary
blob and doesn't disclose it then it is against the GPL. Of course
reverse engineered drivers with binary blobs in them are probably
copyright infringements anyway...

Chris

--t3Rhqlz/9+3FgEet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAY5x90QZas444SvIRApTCAKCyBAii8vZhlos6YuHD6iJtHaNDwgCgsLCv
Gd61Bzvk82tnxi4RKtteyG4=
=ZmHM
-----END PGP SIGNATURE-----

--t3Rhqlz/9+3FgEet--
