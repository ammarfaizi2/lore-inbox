Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266061AbUAUEmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUAUEjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:39:09 -0500
Received: from mcgroarty.net ([64.81.147.195]:56207 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S266061AbUAUEgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:36:22 -0500
Date: Tue, 20 Jan 2004 22:35:36 -0600
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT370 status [2.4/2.6]
Message-ID: <20040121043536.GA14390@mcgroarty.net>
References: <1g0ZG-2q6-15@gated-at.bofh.it> <400D72B5.40705@gmx.at> <yw1x4quqo1gx.fsf@ford.guide> <20040120204537.GA6820@mcgroarty.net> <yw1xoesymilb.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <yw1xoesymilb.fsf@ford.guide>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2004 at 10:10:56PM +0100, M?ns Rullg?rd wrote:
> Brian McGroarty <brian@mcgroarty.net> writes:
>=20
> > Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:
> >> Jan De Luyck wrote:
> >>> Hello List,
> >>> Before I start frying my disks and all, what's the usability status
> >>> of the Hightpoint HPT370 ide "raid" controller on linux 2.4 and 2.6?
> >>
> >> 2.4 is fine if you use the ataraid code. mirroring is not fault
> >> tolerant so you would not want to use that.
> >
> > No problems with 2.4 here.
> >
> > 2.6 recognizes my 374, which uses the hpt366 driver like the
> > 370. However, no devices are being made available from it [1].
> >
> > If others' experiences are any different, I'd love to hear.
>=20
> I've been successfully using an hpt374 based board for a year or so.
> Right now I'm running Linux 2.6.0 (no reboot after 2.6.1 release).

Can you say a bit about your configuration?

- What module(s) do you load? Any parameters?

- What devices do you access the hpt374 through?

- Are you running a RAID, or individual drives?

Any other info (dmesg, contents of ide procdir, etc) would be great
for us to compare.

Very much appreciated!

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADgGY2PBacobwYH4RAtUDAJ9HQ4DMezNt++2lCqVXppXwXCP1uwCfZdRq
DEM79+e9PxnRd/eXSfYc+wk=
=aGn/
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
