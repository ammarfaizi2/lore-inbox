Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTFTKC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTFTKC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:02:27 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:53888
	"HELO ghanima.endorphin.org") by vger.kernel.org with SMTP
	id S262610AbTFTKC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:02:26 -0400
Date: Fri, 20 Jun 2003 12:14:52 +0200
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620101452.GA2233@ghanima.endorphin.org>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <p73u1al3xlw.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2003 at 11:30:03AM +0200, Andi Kleen wrote:
> Fruhwirth Clemens <clemens-dated-1056963973.bf26@endorphin.org> writes:
>=20
> > So go for it. Fix it before 2.6.x is out and we're stuck with this crap
> > again.=20
>=20
> This will break existing crypto loop installations, making
> the existing encrypted image unreadable. After all this is Linux
> here, not HackOS where you can break user file system formats at will.
> The only way to implement this is with a new flag that is set by losetup
> and keep the old behaviour by default.

There is no cryptoloop installation which is affected by this. Read my mail
properly. Every cryptoloop setup out there uses loop-AES or kerneli's
patch-int. And both fixed this issue a _long_ time ago. (Have a look at
the linux-crypto archives of 2001).

Adam Richter's version of loop.c which is in his ygg tree is quite nice,
but his changes are HUGE. Nobody is going to split them up in small patches.

Again: _no_ userbase is affected by this change. Every userbase which
could have ever been affected has done the fix for itself.

Clemens

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+8t6cW7sr9DEJLk4RAkp7AJ9iYGZv45zEK0sAhKscWfJ6lhcVaACfdyld
A7m36kELFARZWlKtrY/TlJE=
=xL03
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
