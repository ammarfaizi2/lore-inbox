Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVBQWDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVBQWDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVBQWDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:03:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42136 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261205AbVBQWDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:03:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: "Needlessly global functions static...."
Date: Thu, 17 Feb 2005 22:53:04 +0100
User-Agent: KMail/1.6.2
Cc: linux-os <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0502171607500.18275@chaos.analogic.com> <20050217212506.GA21662@shell0.pdx.osdl.net>
In-Reply-To: <20050217212506.GA21662@shell0.pdx.osdl.net>
MIME-Version: 1.0
Message-Id: <200502172253.04648.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_AJRFCMylirf3T3Q";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_AJRFCMylirf3T3Q
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dunnersdag 17 Februar 2005 22:25, Chris Wright wrote:

> static !=3D inline. =A0Locally scoped symbols, 't', =A0and global, 'T',=20
> are in kallsyms or System.map.

Well, actually they might get inlined automatically when building with
gcc -funit-at-a-time. That is of course a desired side effect of making
symbols local, although it can be confusing when you're looking at the
assembler output.

	Arnd <><



--Boundary-02=_AJRFCMylirf3T3Q
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCFRJA5t5GS2LDRf4RAr+TAJ45RxY4ltAXLNPi02JDGxZtEBbXWwCcDWcC
EUvOtmjxCL84zbMCmyoRPCc=
=i0x6
-----END PGP SIGNATURE-----

--Boundary-02=_AJRFCMylirf3T3Q--
