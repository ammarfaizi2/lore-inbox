Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWHJHQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWHJHQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 03:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWHJHQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 03:16:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:33107 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751239AbWHJHQL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 03:16:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,108,1154934000"; 
   d="asc'?scan'208"; a="106094581:sNHT45459197"
Subject: Re: Announcing free software graphics drivers for Intel i965
	chipset
From: Keith Packard <keith.packard@intel.com>
Reply-To: keith.packard@intel.com
To: Jeff Garzik <jeff@garzik.org>
Cc: keith.packard@intel.com, Linux-kernel@vger.kernel.org,
       Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
In-Reply-To: <44DACD51.7080607@garzik.org>
References: <1155151903.11104.112.camel@neko.keithp.com>
	 <44DACD51.7080607@garzik.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VLcu9ZgvN+F7K+tXdNAm"
Organization: Intel Corp
Date: Thu, 10 Aug 2006 00:15:57 -0700
Message-Id: <1155194157.6386.14.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VLcu9ZgvN+F7K+tXdNAm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-08-10 at 02:08 -0400, Jeff Garzik wrote:

> * is the 3D stuff available from git somewhere?  The download filename=20
> includes "-git-", but the checkout instructions reference cvs.

Yes, the 3D stuff is in the Mesa CVS repository, but you'll need the
X.org 2D driver and the DRM kernel bits to use it.

> * is anyone working on a more dynamic GLSL compilation system?  i.e. a=20
> "JIT", in compiler technology terms.

Yes, that's all included at the same price. Mesa includes the pieces to
get to a reasonable IR which can then be converted to the necessary
target-specific instruction set by the driver. Much of the 3D driver for
the 965 actually uses GLSL to execute things previously handled by the
traditional fixed function pipeline.

--=20
keith.packard@intel.com

--=-VLcu9ZgvN+F7K+tXdNAm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2t0tQp8BWwlsTdMRAgIFAJ0bEazGZ6pzLM8RZ5saVyvODY1oGgCeIUhk
m47a4b9rX2CjKAABsLb6Jo8=
=/TSb
-----END PGP SIGNATURE-----

--=-VLcu9ZgvN+F7K+tXdNAm--
