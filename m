Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTDZT70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 15:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbTDZT70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 15:59:26 -0400
Received: from p50887CA8.dip.t-dialin.net ([80.136.124.168]:36841 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id S262964AbTDZT7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 15:59:24 -0400
Date: Sat, 26 Apr 2003 22:17:07 +0200
From: Thunder Anklin <thunder@keepsake.ch>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: missing #includes?
Message-ID: <20030426201706.GE69349@hawkeye.luckynet.adm>
References: <20030425235119.6f337e70.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline
In-Reply-To: <20030425235119.6f337e70.randy.dunlap@verizon.net>
X-Location: Dorndorf-Steudnitz, Germany
X-GPG-KeyID: 0x30F8436E
X-GPG-Fingerprint: 22F7 F950 CCCF DC35 408C  4A4C 2CDE 7159 E070 C1EC
X-GPG-Key: http://lightweight.ods.org/~thunder/thunder.asc
X-Priority: I really don't care.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Fri, Apr 25, 2003 at 11:51:19PM -0700, Randy.Dunlap wrote:
> What's the preferred thing to do here?  I would like to see explicit
> #includes when symbols are used.  Is that what others expect also?

It's perlable. I might do this if you want.

> However, it makes for quite a large list of missing includes.

I  suppose this  is because  it's implicitly  included via  some other
include file. You will need to descend through

#include <blah>

in order to do the right checks.

			Thunder

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (FreeBSD)

iD8DBQE+quk/LN5xWeBwwewRAngLAJwNOYpiklPdsm+/sjJdRYgmGc61swCfWv+9
pRQmZDq4JUC50AOk5oS+zrQ=
=tzEB
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
