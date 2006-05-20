Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWETDxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWETDxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 23:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWETDxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 23:53:12 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:10813 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932491AbWETDxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 23:53:12 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=ihn9C9RuyR4ZV6ARUHO0+VZF08qonoMMR/DmJ3URjhN2MVx/1qzUcjMCb0oIxOIj5Vu0DdNUwPf14e+g2fhFSARJ9R5PRa/C6YhMuIa5SZ28pOpsdYOk5WAu9f1Xzf//;
X-IronPort-AV: i="4.05,149,1146459600"; 
   d="scan'208"; a="18324928:sNHT38198619"
Date: Fri, 19 May 2006 22:53:11 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDD isn't EXPERIMENTAL anymore
Message-ID: <20060520035310.GA28977@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20060520025255.GB9486@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20060520025255.GB9486@taniwha.stupidest.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2006 at 07:52:55PM -0700, Chris Wedgwood wrote:
> Lots of people use this.  Apparently RH has for over 18 months so lets
> drop EXPERIMENTAL.
>=20
>=20
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
>=20
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 1e371a5..4ea7044 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -7,7 +7,6 @@ menu "Firmware Drivers"
> =20
>  config EDD
>  	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMEN=
TAL)"
> -	depends on EXPERIMENTAL
>  	depends on !IA64
>  	help
>  	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive

almost-ack.  The tristate line needs (EXPERIMENTAL) removed please.

Thanks,
Matt

--
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQFEbpKmIavu95Lw/AkRAjLXAJ41UUqn+g+GDtY28tMXGRc8wA+dKwCffA9I
XB6J+PCdHKtigzr/lOWpI7Y=
=+k8w
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
