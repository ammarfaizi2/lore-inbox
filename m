Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbUA1TWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUA1TWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:22:45 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:20282 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S266143AbUA1TV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:21:59 -0500
Subject: Re: [PATCH] smbfs: Large File Support (3/3)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200401281202.i0SC2s6Y010350@hera.kernel.org>
References: <200401281202.i0SC2s6Y010350@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+3pHM+x8vbKCAUFKb4s7"
Organization: Red Hat, Inc.
Message-Id: <1075317712.4569.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Jan 2004 14:21:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+3pHM+x8vbKCAUFKb4s7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-01-28 at 06:05, Linux Kernel Mailing List wrote:

> diff -Nru a/include/linux/smb.h b/include/linux/smb.h
> --- a/include/linux/smb.h	Wed Jan 28 04:02:56 2004
> +++ b/include/linux/smb.h	Wed Jan 28 04:02:56 2004
> @@ -85,7 +85,7 @@
>  	uid_t		f_uid;
>  	gid_t		f_gid;
>  	kdev_t		f_rdev;
> -	off_t		f_size;
> +	loff_t		f_size;
>  	time_t		f_atime;
>  	time_t		f_mtime;
>  	time_t		f_ctime;

ehhmmmm doesn't this change the userspace ABI incompatibly ???

--=-+3pHM+x8vbKCAUFKb4s7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAGAvPxULwo51rQBIRAku7AJ4oR1KdAx2R6rP+3c4wciYSs3guewCfWvpo
DtIFNRdm1xMyrwm3ye885mo=
=7pHC
-----END PGP SIGNATURE-----

--=-+3pHM+x8vbKCAUFKb4s7--
