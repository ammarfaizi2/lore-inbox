Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTDWXSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTDWXSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:18:50 -0400
Received: from freesurfmta04.sunrise.ch ([194.230.0.33]:55782 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id S263587AbTDWXSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:18:49 -0400
Date: Thu, 24 Apr 2003 01:29:09 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem with a cobalt RaQ550 system and DMA (Serverworks OSB4 in impossible state)
Message-ID: <20030423232909.GE21689@puck.ch>
Mail-Followup-To: Olivier Bornet <Olivier.Bornet@puck.ch>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423212713.GD21689@puck.ch> <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk>
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Wed, Apr 23, 2003 at 11:21:10PM +0100, Alan Cox wrote:
> On Mer, 2003-04-23 at 22:27, Olivier Bornet wrote:
> > I'm trying to install Debian on 4 RaQ550 with each 2 80GB disks. All
> > seems OK with 3 of RaQ, but with one, it crash when I put the two disks
> > in a RAID1 meta device. In fact, it as crash at about 6% before the 70GB
> > partition is fully synchronized.
>=20
>=20
> Bad block I think. Its a bug fixed in 2.4.21pre.  It trips a sanity
> check for an OSB4 bug inadvertantly. 2.4.21pre handles CSB5 with full
> UDMA and OSB4 in MWDMA2 without tripping wrongly.
>=20
> If your chipset is CSB5 you can also just comment out the check and
> rebuild

At this time, I have compiled and installed a 2.4.20-ac2 + some cobalt
patches. Is the bug also fixed in 2.4.20-ac2, or must I rebuild the
2.4.20 with the check commented out ?

(currently, the sync of the partition is in the way with the ac2
kernel... just started... need about 100 minutes to finish...).

I will comment out the check tomorrow if this is needed.

Thanks for your help, and keep up the good work.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+pyHFdj3R/MU9khgRAgbSAJ9Ve/MUxutxJP5EkvF58stdz+iUVACfYab2
4BprTRQA5KOX5YR2myJOX3g=
=P6FH
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
