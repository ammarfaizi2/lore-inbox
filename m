Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUJQWog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUJQWog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269314AbUJQWoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 18:44:01 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:8400 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S269311AbUJQWn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 18:43:56 -0400
Date: Sun, 17 Oct 2004 23:44:10 +0100
From: Alexander Clouter <alex-kernel@digriz.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041017224410.GA30611@inskipp.digriz.org.uk>
References: <20041017222916.GA30841@inskipp.digriz.org.uk> <4172F3C5.8090604@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <4172F3C5.8090604@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 18, Con Kolivas wrote:
>=20
> I'd much prefer it shot up to 100% or else every time the cpu usage went=
=20
> up there'd be an obvious lag till the machine ran at it's capable speed.=
=20
>  I very much doubt the small amount of time it spent at 100% speed with=
=20
> the default design would decrease the battery life significantly as well.
>=20
The issue I found was that if you are running a process that is io bound, f=
or
example, then you may never need to run your cpu at 100%, it will speed up
bit by bit[1] till it gets to a speed that is fast enough to to deal with it
without max'ing the cpufreq.

This is after all exactly want most (if not all) the userspace daemons try =
to=20
do anyway.

Cheers

Alex

[1] also you might find that the task does not last long enough to warrant=
=20
	jumping and lurking at 100% speed anyway

--=20
 _________________________________________=20
/ It's always darkest just before it gets \
\ pitch black.                            /
 -----------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcvW6Nv5Ugh/sRBYRAmHRAJ4/MBihgzwxTRHYQ6m2iGToq2qWlgCgiFzz
v7vob5jvig48p3dbHFR9+Dk=
=42EQ
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
