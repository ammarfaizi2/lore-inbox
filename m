Return-Path: <linux-kernel-owner+w=401wt.eu-S1755124AbWL3Apn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbWL3Apn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755126AbWL3Apn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:45:43 -0500
Received: from kenobi.snowman.net ([70.84.9.186]:57574 "EHLO
	kenobi.snowman.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbWL3Apn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:45:43 -0500
Date: Fri, 29 Dec 2006 19:45:42 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Adam Megacz <megacz@cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OpenAFS gatekeepers request addition of AFS_SUPER_MAGIC to magic.h
Message-ID: <20061230004542.GJ24675@kenobi.snowman.net>
Mail-Followup-To: Adam Megacz <megacz@cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <x3fyay2r4z.fsf@nowhere.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aExbj4quxJ/WWgx4"
Content-Disposition: inline
In-Reply-To: <x3fyay2r4z.fsf@nowhere.com>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.6.16-2-vserver-686 (i686)
X-Uptime: 19:45:13 up 103 days, 54 min, 18 users,  load average: 0.35, 0.50, 0.40
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aExbj4quxJ/WWgx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Adam Megacz (megacz@cs.berkeley.edu) wrote:
> --- include/linux/magic.h       2006-12-29 15:48:50.000000000 -0800
> +++ include/linux/magic.h       2006-11-29 13:57:37.000000000 -0800
> @@ -3,7 +3,6 @@
> =20
>  #define ADFS_SUPER_MAGIC       0xadf5
>  #define AFFS_SUPER_MAGIC       0xadff
> -#define AFS_SUPER_MAGIC                0x5346414F
>  #define AUTOFS_SUPER_MAGIC     0x0187
>  #define CODA_SUPER_MAGIC       0x73757245
>  #define EFS_SUPER_MAGIC                0x414A53

Wouldn't you want a patch which *adds* it, rather than one which
*removes* it...?

	Thanks,

		Stephen

--aExbj4quxJ/WWgx4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFlba2rzgMPqB3kigRAn+mAJ9cFsoAGEGUDpQphddmgkarj2M9YACfQnc2
HpmJPlvfNKUcI40sb2rPbr4=
=bxs/
-----END PGP SIGNATURE-----

--aExbj4quxJ/WWgx4--
