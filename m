Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTDSOkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 10:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTDSOkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 10:40:42 -0400
Received: from iucha.net ([209.98.146.184]:32342 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263394AbTDSOkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 10:40:40 -0400
Date: Sat, 19 Apr 2003 09:52:39 -0500
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Private namespaces
Message-ID: <20030419145239.GL29143@iucha.net>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1052141040.355.12.camel@labunix> <20030416132324.GA18700@win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFUYW7mPOLJ+Jd2A"
Content-Disposition: inline
In-Reply-To: <20030416132324.GA18700@win.tue.nl>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bFUYW7mPOLJ+Jd2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2003 at 03:23:24PM +0200, Andries Brouwer wrote:
> On Mon, May 05, 2003 at 10:23:56AM -0300, Adrian Etchevarne wrote:
>=20
> > 	I've been looking for instructions to use private namespaces in Linux,
> > without results. Can anyone tell where is the documentation about it?
> > (I'm not refering to chroot(), but to /proc/<pid>/mounts). Or the proper
> > files in the kernel sources?
>=20
> A tiny demo program is given in
>   http://www.win.tue.nl/~aeb/linux/lk/lk-6.html#ss6.3.3
>=20
> In the kernel source, grep for CLONE_NEWNS.

I have compiled the sample program on 2.5.67-pre6 and it fails with
   clone: Cannot allocate memory
when run as a regular user. Is there a workaround?

Thank you,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--bFUYW7mPOLJ+Jd2A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+oWK3NLPgdTuQ3+QRAlgpAJsG7LEJFh4mTiYrAN44shJEVHLyRgCgnBqw
H32Z62eF4AnR+cyykcJo1Mw=
=lJA1
-----END PGP SIGNATURE-----

--bFUYW7mPOLJ+Jd2A--
