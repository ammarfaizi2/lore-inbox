Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWADNkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWADNkx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 08:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWADNkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 08:40:52 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:30949 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751253AbWADNkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 08:40:52 -0500
Date: Wed, 4 Jan 2006 14:40:47 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Resubmit: [PATCH] natsemi: NAPI support
Message-ID: <20060104134047.GR4898@sunbeam.de.gnumonks.org>
References: <20051204231209.GA28949@electric-eye.fr.zoreil.com> <20051205232301.GA4551@sirena.org.uk> <20051206001934.GA18329@electric-eye.fr.zoreil.com> <20051206211729.GB3709@sirena.org.uk> <20051206215619.GB3425@electric-eye.fr.zoreil.com> <20051209104832.GA3677@sirena.org.uk> <20051212235531.GB3714@sirena.org.uk> <439E14F0.4040001@pobox.com> <20051221234850.GC5274@sirena.org.uk> <20060104073249.GA8024@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Content-Disposition: inline
In-Reply-To: <20060104073249.GA8024@sirena.org.uk>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2006 at 07:32:49AM +0000, Mark Brown wrote:
> This patch against 2.6.14 converts the natsemi driver to use NAPI.  It
> was originally based on one written by Harald Welte, though it has since
> been modified quite a bit, most extensively in order to remove the
> ability to disable NAPI since none of the other drivers seem to provide
> that functionality any more.

Mark, sorry for not responding earlier to your emails with regard to
your natsemi patch.

Thanks for pushing this persistently.  From reviewing your patch, I
personally thin it's fine to be merged.

I will test it on my natsemi based boxes later today.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDu9BfXaXGVTD0i/8RAi7dAJsFJF5e4ObWF3U4VVShjOdHDMhrggCfd4fH
yROpTNIBf4APf0Rof17b0ss=
=M2n2
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--
