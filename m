Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269570AbUIZQT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269570AbUIZQT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 12:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269571AbUIZQT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 12:19:58 -0400
Received: from sero.dbtech.de ([195.4.70.70]:8964 "HELO mx0.dbtech.de")
	by vger.kernel.org with SMTP id S269570AbUIZQT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 12:19:56 -0400
From: Christian Fischer <Christian.Fischer@fischundfischer.com>
Organization: Fisch+Fischer Veranstaltungstechnik
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS TUNING: #define NFS3_MAXGROUPS
Date: Sun, 26 Sep 2004 18:25:08 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409261638.36011.Christian.Fischer@fischundfischer.com> <1096215018.6828.26.camel@lade.trondhjem.org>
In-Reply-To: <1096215018.6828.26.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2306320.2r8QqmPWJH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409261825.08628.Christian.Fischer@fischundfischer.com>
X-Spam-HITS: 0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2306320.2r8QqmPWJH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 26 September 2004 18:10, Trond Myklebust wrote:

> No, it is NOT tunable. The SunRPC protocol (rfc1831) states clearly that
> the AUTH_SYS (a.k.a. AUTH_UNIX) structure is defined as
>
>       struct authsys_parms {
>          unsigned int stamp;
>          string machinename<255>;
>          unsigned int uid;
>          unsigned int gid;
>          unsigned int gids<16>;
>       };
>
> If the BSDs are playing around with that, then they are not adhering to
> the protocol, and will be incompatible with all other SunRPC
> implementations.

That's a pity.=20
Christian
=2D-=20

--nextPart2306320.2r8QqmPWJH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBBVu1kszmQKstIgt4RApvAAJ4jL7HsD0aY8I0c9qPFC1d/UFPxSgCgqBVT
gEtkUxGdELv5KKb/lEc2GDk=
=7woX
-----END PGP SIGNATURE-----

--nextPart2306320.2r8QqmPWJH--

