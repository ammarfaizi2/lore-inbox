Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTLKIgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTLKIgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:36:45 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:38066 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S264506AbTLKIgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:36:44 -0500
Date: Thu, 11 Dec 2003 10:36:36 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: RunNHide <res0g1ta@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initio SCSI Drivers
Message-ID: <20031211083636.GA7658@actcom.co.il>
References: <3FD82252.6050300@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <3FD82252.6050300@verizon.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2003 at 02:52:50AM -0500, RunNHide wrote:

> Can anyone help out? Tried building 2.6.0-test11 today and, lo and=20
> behold, noticed the support for my Initio SCSI card has been removed -=20
> is this a permanent thing or will it show back up soon? It's an Initio=20
> 9100U using the 2.4.x series initio.o module - or will I be stuck using=
=20
> the 2.4 series? Any feedback is appreciated.

CONFIG_INITIO depends on CNOFIG_BROKEN. You need to disable "Select
only drivers expected to compile cleanly" to get it to appear. It
doesn't currently compile, however.  Someone who has the inclination
and preferably the hardware needs to update it.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2CyUKRs727/VN8sRAt9TAKCSw7teGnQ6CiwpD9oR4/F11//ckwCfd7hb
ma9lo0tvTvdfhWroTwSRqvs=
=rmlJ
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
