Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUDWXWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUDWXWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUDWXWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:22:36 -0400
Received: from seraph3.grc.nasa.gov ([128.156.10.12]:22515 "EHLO
	seraph3.grc.nasa.gov") by vger.kernel.org with ESMTP
	id S261685AbUDWXWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:22:34 -0400
Date: Fri, 23 Apr 2004 19:19:14 -0400
From: Wesley Eddy <weddy@grc.nasa.gov>
To: David Stevens <dlstevens@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP rto estimation patch
Message-ID: <20040423231914.GB9057@grc.nasa.gov>
Reply-To: weddy@grc.nasa.gov
References: <20040423142445.GC501@grc.nasa.gov> <OFE28EC49F.335C9D5D-ON88256E7F.0073BC2E-88256E7F.0073F700@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <OFE28EC49F.335C9D5D-ON88256E7F.0073BC2E-88256E7F.0073F700@us.ibm.com>
X-People-Whose-Mailers-Cant-See-This-Header-Are-Lame: true
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2004 at 02:06:39PM -0700, David Stevens wrote:
> I believe "2" and "3" are the scale factors for the fixed-point=20
> representation
> of the data, not the "alpha" and "beta" I remember from the estimator=20
> paper.
>

The math is done with bit shifts instead of floating point multiplications.
It's the same thing though.  The 2 means beta of 1/4 and the 3 means alpha
of 1/8.

-Wes=20

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAiaRyzBuYqbnj3IwRAkQ4AJ9dXt7Odh3p18MhTydzRxoXrIiGsACdEZfs
7aHa74eaeQkk2fp2VeDNwfA=
=CQbL
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
