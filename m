Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUDVIDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUDVIDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbUDVIDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:03:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58277 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263847AbUDVIDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:03:09 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040421144948.GJ2951@mschwid3.boeblingen.de.ibm.com>
References: <20040421144948.GJ2951@mschwid3.boeblingen.de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XgnHsI/LsbJjf1UFQI0r"
Organization: Red Hat UK
Message-Id: <1082620965.4690.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Apr 2004 10:02:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XgnHsI/LsbJjf1UFQI0r
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-21 at 16:49, Martin Schwidefsky wrote:
> [PATCH] s390: no timer interrupts in idle.
>=20
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>=20
> This patch add a system control that allows to switch off the jiffies
> timer interrupts while a cpu sleeps in idle. This is useful for a system
> running with virtual cpus under z/VM.


is this generally useful, eg can all architectures use the
infrastructure you propose ? I seriously hope so; s390 isn't the only
one who would benefit, I'd love to see a generic thing for this.

--=-XgnHsI/LsbJjf1UFQI0r
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAh3wlxULwo51rQBIRAkBlAKCbSp2S3i0DsNiNy/+pteG61P5sMACeN0bd
tToT3bOaMCRhKb3EJkdIM2Q=
=3LhM
-----END PGP SIGNATURE-----

--=-XgnHsI/LsbJjf1UFQI0r--

