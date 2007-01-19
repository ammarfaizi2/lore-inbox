Return-Path: <linux-kernel-owner+w=401wt.eu-S965101AbXASMiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbXASMiR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 07:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbXASMiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 07:38:17 -0500
Received: from ns1.suse.de ([195.135.220.2]:47803 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965101AbXASMiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 07:38:16 -0500
Date: Fri, 19 Jan 2007 13:38:14 +0100
From: Bernhard Walle <bwalle@suse.de>
To: Tomas Carnecky <tom@dbservice.com>, linux-kernel@vger.kernel.org,
       Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
Message-ID: <20070119123814.GA9825@strauss.suse.de>
Mail-Followup-To: Tomas Carnecky <tom@dbservice.com>,
	linux-kernel@vger.kernel.org, Alon Bar-Lev <alon.barlev@gmail.com>
References: <20070118125849.441998000@strauss.suse.de> <20070118130028.719472000@strauss.suse.de> <20070118141359.GB31418@flint.arm.linux.org.uk> <45AF92E7.50901@dbservice.com> <20070118152326.GC31418@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20070118152326.GC31418@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell King <rmk+lkml@arm.linux.org.uk> [2007-01-18 16:23]:
>=20
> However, there is a bigger question here: that is the tradeoff between
> making this variable part of the on-disk kernel image, but throw away
> the memory at runtime, or to leave it in the BSS where it will not be
> part of the on-disk kernel image, but will not be thrown away at
> runtime.

Are 1024 bytes of a bigger kernel image really a problem? And even,
normally kernel images are compressed, and compressing 1024 zeros
can be compressed very well.

I think saving memory is more important than saving disk space. I know
that most ARM device use flash disk, but also most ARM devices have
limited RAM.


Regards,
  Bernhard

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFsLu2iGU2lt2vZFQRAnwtAJ9tcLSOA2c6xVSSfN8WM/U9IXR3jwCfULSm
5bJWwUmTQOafhEGX9LJLD6A=
=7m3D
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
