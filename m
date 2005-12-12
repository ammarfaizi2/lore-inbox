Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVLLTjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVLLTjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVLLTjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:39:37 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:23446 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S932176AbVLLTjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:39:36 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: control placement of vDSO page
Date: Mon, 12 Dec 2005 20:39:25 +0100
User-Agent: KMail/1.7.2
Cc: John Reiser <jreiser@bitwagon.com>
References: <439D9767.2000208@BitWagon.com>
In-Reply-To: <439D9767.2000208@BitWagon.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3864222.c7NC5UuN8r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512122039.29799.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3864222.c7NC5UuN8r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 12 December 2005 16:29, John Reiser wrote:
> Possible solution: a new system call  move_vdso(old_addr, new_addr, flags=
).
> Check that current vDSO was at old_addr, else error.  Change vDSO page
> under control of flags like in mmap(): new_addr is hint (place to start
> search) or required address if MAP_FIXED.  Return value is new vDSO addre=
ss.
>=20

What about special casing the vDSO page in mremap() ?


Regards

Ingo Oeser


--nextPart3864222.c7NC5UuN8r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDndHxU56oYWuOrkARAq8tAJsGSc64uZBY8QFD4l18mLp/JShUSQCgoXrx
n1p+IGxsxofBne4/cLJ0CHY=
=639I
-----END PGP SIGNATURE-----

--nextPart3864222.c7NC5UuN8r--
