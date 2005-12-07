Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVLGRC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVLGRC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVLGRC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:02:27 -0500
Received: from galileo.bork.org ([134.117.69.57]:50897 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S1751264AbVLGRC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:02:26 -0500
Date: Wed, 7 Dec 2005 12:02:26 -0500
From: Martin Hicks <mort@bork.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mm: fold sc.may_writepage and sc.may_swap into sc.flags
Message-ID: <20051207170226.GB3085@bork.org>
References: <20051207104755.177435000@localhost.localdomain> <20051207105154.142779000@localhost.localdomain> <20051207111501.GA8133@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QVzQgM+zdZ3YWXqn"
Content-Disposition: inline
In-Reply-To: <20051207111501.GA8133@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QVzQgM+zdZ3YWXqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed, Dec 07, 2005 at 07:15:01PM +0800, Wu Fengguang wrote:
> Fold bool values into flags to make struct scan_control more compact.
>=20

I suspect that the may_swap flag is still a left over from my failed
attempt at zone_reclaim.  It should be removed.

mh

--=20
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

--QVzQgM+zdZ3YWXqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDlxWi0ZUZrUx/K+4RAlQAAKCH6h4pXFZi9ovGET2NiuzJ8GZ6CgCgsnwj
VUw5p5i2/2ynXrOFiRkjVxo=
=4Yjs
-----END PGP SIGNATURE-----

--QVzQgM+zdZ3YWXqn--
