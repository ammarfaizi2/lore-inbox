Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbUKQWrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbUKQWrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUKQWpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:45:07 -0500
Received: from pauli.thundrix.ch ([213.239.201.101]:23983 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S262598AbUKQWnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:43:37 -0500
Date: Wed, 17 Nov 2004 23:43:15 +0100
From: Tonnerre <tonnerre@thundrix.ch>
To: "Steffen A. Mork" <linux-dev@morknet.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] dss1_divert ISDN module compile fix for kernel 2.6.8.1
Message-ID: <20041117224315.GA2198@pauli.thundrix.ch>
References: <419B662D.5020904@morknet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <419B662D.5020904@morknet.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Nov 17, 2004 at 03:54:37PM +0100, Steffen A. Mork wrote:
> http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert.diff

This patch is wrong. You're using a spinlock you declare on the stack=20
of a function, so it's completely pointless.

Please look at http://users.thundrix.ch/~tonnerre/kernel/2.6.1-tch1/=20
where I gathered lots of ISDN patches a while ago. It might be a start=20
for you.

			    Tonnerre


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBm9QDFrSZSaXqQusRAhKqAKCQc+O+Fgl921qTNwdCoeuAQbweOACfRJ1/
6LYKm+Tjr2M6vOXnXACc3Tw=
=+1nB
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
