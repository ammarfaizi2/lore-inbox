Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVEIOYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVEIOYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVEIOYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:24:24 -0400
Received: from zak.futurequest.net ([69.5.6.152]:32173 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S261387AbVEIOXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:23:43 -0400
Date: Mon, 9 May 2005 08:23:38 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: How to diagnose a kernel memory leak
Message-ID: <20050509142338.GB16663@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050509035823.GA13715@em.ca> <1115627361.936.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <1115627361.936.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2005 at 10:29:21AM +0200, Alexander Nyberg wrote:
> You should keep an eye on /proc/meminfo but if there is memory that is
> not accounted for then the patch below might help as it works on a
> lower level.  It accounts for bare pages in the system available from
> /proc/page_owner.
> Select Track page owner under kernel hacking.

I will try that the next time I have to reboot.  As this is a server, I
cannot arbitrarily take it down unfortunately.

> Also the meminfo you posted, how long had the box been alive when you
> took it?

Almost exactly 2 days.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCf3Jq6W+y3GmZgOgRAu5/AKCWssu6XvWzs22njvsEy7B7hs/BsQCePHK5
ogUYDOz5JFm/pnPVk+WYiwA=
=ksCy
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
