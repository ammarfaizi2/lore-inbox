Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbRDCR3d>; Tue, 3 Apr 2001 13:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132385AbRDCR3X>; Tue, 3 Apr 2001 13:29:23 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:63465 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132373AbRDCR3M>; Tue, 3 Apr 2001 13:29:12 -0400
Date: Tue, 3 Apr 2001 18:16:19 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Stefan Linnemann <mazur@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sandisk flashcard reader on 2.4.2.  It works.  Sort of.
Message-ID: <20010403181619.J9355@redhat.com>
In-Reply-To: <01040302081301.00789@mazur.xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01040302081301.00789@mazur.xs4all.nl>; from mazur@xs4all.nl on Tue, Apr 03, 2001 at 02:08:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2001 at 02:08:13AM +0200, Stefan Linnemann wrote:

> the necessary features.  I copied .config from the 2.2.17, superficially=
=20
> checked the config, and remade and rebooted.
>=20
> This was where I noted, that the parport, paride, epat and pd modules did=
n't=20
> get installed as modules at all.  I havnet dug into the why of that, let=
=20
> those familiar with the processes and Makefiles do that.=20

It'll be because of the block device directory reorganisation I
expect, or something similar.  Double-check your config.

> So I reconfigured to get those into the kernel, and remade and
> rebooted.  No dice, so I succesfully again applied the same patch,
> configured it into the kernel and remade and rebooted.  No
> SanDisk. For some reason or another I rebooted again, and lo and
> behold, we have a SanDisk.

So the kernel you run which can see the SanDisk is with, or without,
the C7/8 patch?

> I mount it ok, cd=20
> /sandisk/dir/, mv * elsewhere, my system hangs.  Reset.=20

Enable magic-sysrq and see if Alt-SysRq-B reboots the machine or not.
Or, even better, jot down what Alt-SysRq-T says.

> So the message is: Yes, it could work, but with the patch from=20
> http://www.electricgod.net/~moomonk/epat/ it's slightly better working th=
an=20
> without it.

This patch is in the queue, but behind the bug-fixes.

You might want to try fiddling with the BIOS options for the parallel
port and see if that makes any difference.

Tim.
*/

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6ygVdONXnILZ4yVIRApHAAJ91grPlyutRUswJMZaSK3JzmBtv8gCfWwVW
2om7K27wHBFccGMDjYotD+U=
=zugX
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
