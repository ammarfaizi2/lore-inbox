Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUHORLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUHORLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUHORL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:11:29 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:55458 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S266096AbUHORLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:11:22 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck1
Date: Sun, 15 Aug 2004 10:11:18 -0700
User-Agent: KMail/1.7
References: <411F6679.5080008@kolivas.org>
In-Reply-To: <411F6679.5080008@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3542866.fxhCqoiHQY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408151011.20327.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3542866.fxhCqoiHQY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 15 August 2004 06:34, Con Kolivas wrote:
> +1g_lowmem_i386.diff
> Allows 1Gb of ram to be used without enabling highmem

Note that valgrind 2.x (a fairly powerful memory debugger/profiler) hates=20
this. It dies with:

executable is mapped outside of range 0x80d7000-0xaffff000
failed to load /usr/lib/valgrind/stage2: Cannot allocate memory

Haven't looked in to how easy this is to hack around, just a heads up.

=2DRyan

--nextPart3542866.fxhCqoiHQY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBH5k4W4yVCW5p+qYRAs/jAJ9nnp+Q06Aa4I8nNBplW2SrdM9jOgCfbcty
VfW56FitP60rdfe02BEUsaM=
=O0/u
-----END PGP SIGNATURE-----

--nextPart3542866.fxhCqoiHQY--
