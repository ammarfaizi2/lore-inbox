Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266832AbUHTMu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUHTMu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUHTMu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:50:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:31205 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266832AbUHTMuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:50:25 -0400
Date: Fri, 20 Aug 2004 14:46:48 +0200
From: Kurt Garloff <garloff@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Chris Mason <mason@suse.com>, Jens Axboe <axboe@suse.de>,
       Greg Afinogenov <antisthenes@inbox.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bio_uncopy_user mem leak
Message-ID: <20040820124648.GA12396@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Con Kolivas <kernel@kolivas.org>, Chris Mason <mason@suse.com>,
	Jens Axboe <axboe@suse.de>, Greg Afinogenov <antisthenes@inbox.ru>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1092909598.8364.5.camel@localhost> <412489E5.7000806@kolivas.org> <1092923494.12138.1667.camel@watt.suse.com> <20040819195521.GC12363@tpkurt.garloff.de> <41256DC9.7070500@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <41256DC9.7070500@kolivas.org>
X-Operating-System: Linux 2.6.8-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 20, 2004 at 01:19:37PM +1000, Con Kolivas wrote:
> Kurt Garloff wrote:
> >Not yet tested either :-(
>=20
> Ok looks like your cold medicine is working well for you ;-). This patch=
=20
> on top of the other patch has the memory freeing _and_ burns good cds.=20
> Well done. I only tested with a video cd. Can someone confirm audio cd=20
> (although it seems obvious it would help both).

Tested here as well now. Could reproduce the noise CD before and have
nice music again, after applying Chris' fix as well.=20
Found a CD-RW to test ;-)

Thx,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBJfK4xmLh6hyYd04RAg3RAJ0TrcmQOZw4td9E3vgq7OQZtUUl7gCgwRPa
wOA1mZGH7WextL+HQ6/nl5E=
=z8EQ
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
