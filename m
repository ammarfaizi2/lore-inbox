Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTDXHuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTDXHuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:50:12 -0400
Received: from freesurfmta05.sunrise.ch ([194.230.0.18]:56204 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id S261727AbTDXHuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:50:10 -0400
Date: Thu, 24 Apr 2003 10:00:23 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem with a cobalt RaQ550 system and DMA (Serverworks OSB4 in impossible state)
Message-ID: <20030424080023.GG21689@puck.ch>
Mail-Followup-To: Olivier Bornet <Olivier.Bornet@puck.ch>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423212713.GD21689@puck.ch> <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk> <20030423232909.GE21689@puck.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20030423232909.GE21689@puck.ch>
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I reply to myself, after having test this solution.

> At this time, I have compiled and installed a 2.4.20-ac2 + some cobalt
> patches. Is the bug also fixed in 2.4.20-ac2, or must I rebuild the
> 2.4.20 with the check commented out ?

The 2.4.20-ac2 patched kernel help a little : the system don't crash
anymore. But the disk is marked as defective, and is removed from the
raid1 metadevice.

One other problem with the -ac2 is the speed for the rebuild : it seems
to be 2 times slower than with the Ducan patch. (about 2 hours instead
of 1 hour).

So, my solution is to use the patch from Ducan. I hope it (or a
derivative form of it) will be included in the next kernel releases.

Good day, and thanks all for the help.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p5mXdj3R/MU9khgRAnJJAJ9Efv9gyi1jziBGZeY2DWiFVP6rCACdFDr5
4ERMMqg0215i/yOMvX+KC04=
=6S+9
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
