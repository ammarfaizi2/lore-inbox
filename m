Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310993AbSCMSzW>; Wed, 13 Mar 2002 13:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310990AbSCMSzI>; Wed, 13 Mar 2002 13:55:08 -0500
Received: from runyon.sfbay.redhat.com ([205.180.230.5]:46509 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S310989AbSCMSzC>;
	Wed, 13 Mar 2002 13:55:02 -0500
Subject: Re: futex and timeouts
From: Ulrich Drepper <drepper@redhat.com>
To: frankeh@watson.ibm.com
Cc: rusty@rustcorp.com.au, matthew@hairy.beasts.org,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <20020313182552.945523FE06@smtp.linux.ibm.com>
In-Reply-To: <20020313182552.945523FE06@smtp.linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-roAMe2pYcSRF2o04XVIv"
X-Mailer: Evolution/1.0.2 (1.0.2-0.7x) 
Date: 13 Mar 2002 10:54:54 -0800
Message-Id: <1016045694.16743.1046.camel@myware.mynet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-roAMe2pYcSRF2o04XVIv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-03-13 at 10:26, Hubertus Franke wrote:

> Ulrich, it seems to me that absolute timeouts are the easiest to do.

Does it work with settimeofday()?


> Question is whether the granularity of jiffies (10ms) is sufficiently sma=
ll=20
> for timeouts.....

Hopefully there will be support for high-resolution clocks and timers
sometime soon.  I don't know how to prepare new interfaces for this.  I
guess there will be a whole bunch of interface changes/additions so you=20
could ignore the problem for now.

--=20
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

--=-roAMe2pYcSRF2o04XVIv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8j6B+2ijCOnn/RHQRAnZiAJ435BSJKpwrIXD0GFtGpHAKQM09EACeMcIN
NDJQc5PsiwCUtDIwew33J1A=
=92Hf
-----END PGP SIGNATURE-----

--=-roAMe2pYcSRF2o04XVIv--

