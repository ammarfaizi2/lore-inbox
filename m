Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWHLHcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWHLHcA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 03:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWHLHcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 03:32:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:32392 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751376AbWHLHb7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 03:31:59 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,116,1154934000"; 
   d="asc'?scan'208"; a="115407061:sNHT379349229"
Subject: Re: Announcing free software graphics drivers for Intel i965
	chipset
From: Keith Packard <keith.packard@intel.com>
Reply-To: keith.packard@intel.com
To: Nicholas Miell <nmiell@comcast.net>
Cc: keith.packard@intel.com, Jeff Garzik <jeff@garzik.org>,
       Linux-kernel@vger.kernel.org, Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
In-Reply-To: <1155190917.2349.4.camel@entropy>
References: <1155151903.11104.112.camel@neko.keithp.com>
	 <44DACD51.7080607@garzik.org>  <1155190917.2349.4.camel@entropy>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-26u3OP6LieYcxtqe3sE9"
Organization: Intel Corp
Date: Sat, 12 Aug 2006 00:31:33 -0700
Message-Id: <1155367893.6386.179.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-26u3OP6LieYcxtqe3sE9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-09 at 23:21 -0700, Nicholas Miell wrote:

> More importantly, where's the source to intel_hal.so?

This module contains stuff which Intel can't publish in source form,
like Macrovision register stuff and other trade secrets. It's optional,
so if you don't want to use a binary module, you don't get to use code
written by Intel agents for these features. And, we also haven't figured
out how and when to release this binary blob, so there's no way you can
use it today. The driver remains completely functional in the absense of
the binary piece, and in fact has no reduction in functionality from
previous driver releases.

One important note -- the interface for the binary module exists only in
user-mode code which is licensed under the MIT license, not the GPL.

--=20
keith.packard@intel.com

--=-26u3OP6LieYcxtqe3sE9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE3YPVQp8BWwlsTdMRAlvfAKDXndAdbQoTHhiDX80r+d79RFJ59ACgwm37
bakkBa9PJKTnwPetADNtZbY=
=FEuc
-----END PGP SIGNATURE-----

--=-26u3OP6LieYcxtqe3sE9--
