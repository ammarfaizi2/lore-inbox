Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUHaHiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUHaHiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 03:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHaHiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 03:38:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41439 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267311AbUHaHiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 03:38:10 -0400
Subject: Re: MAX_NESTED_LINKS
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1093920028.2445.2.camel@smfhome.smfdom>
References: <1093920028.2445.2.camel@smfhome.smfdom>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NuJybdExvIvu6hK2VuOH"
Organization: Red Hat UK
Message-Id: <1093937883.2797.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 09:38:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NuJybdExvIvu6hK2VuOH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-31 at 04:40, Steve French wrote:
> MAX_NESTED_LINKS seems to have been set to 5, but the comment in
> fs/namei.c indicates a larger number.  Is that intentional?

yes for now; 8 overflowed stacks on several architectures.
Al Viro has a patch series is finalizing getting that merged that makes
it safe to use 8 again.


--=-NuJybdExvIvu6hK2VuOH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBNCrbxULwo51rQBIRAk3fAKCPWvA6khtjyPbLTRPdx/OJK3pzTQCeNZCZ
O6VE/P/IOFPrNV6Act91lrY=
=MJba
-----END PGP SIGNATURE-----

--=-NuJybdExvIvu6hK2VuOH--

