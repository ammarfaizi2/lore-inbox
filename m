Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSEYNJL>; Sat, 25 May 2002 09:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSEYNJK>; Sat, 25 May 2002 09:09:10 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:23485 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314548AbSEYNJJ>;
	Sat, 25 May 2002 09:09:09 -0400
Date: Sat, 25 May 2002 15:08:59 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Gert Vervoort <Gert.Vervoort@wxs.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 ide-scsi compile fix
Message-Id: <20020525150859.2335c10a.sebastian.droege@gmx.de>
In-Reply-To: <3CEF8815.C7C13D39@wxs.nl>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="dy7Bcg.OEJj=.R,l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--dy7Bcg.OEJj=.R,l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 May 2002 14:48:21 +0200
Gert Vervoort <Gert.Vervoort@wxs.nl> wrote:

> --- ide-scsi.c.1	Sat May 25 14:21:28 2002
> +++ ide-scsi.c	Sat May 25 14:21:37 2002
> @@ -804,7 +804,7 @@
>  };
>  
>  
> -static int __init idescsi_init(void)
> +int __init idescsi_init(void)
>  {
>  	int ret;
>  	ret = ata_driver_module(&idescsi_driver);

Well... this is a _compile_ fix... ;)
But when you boot a kernel with this patch... it hangs directly after
SCSI subsystem driver Revision: X.YZ

Bye
--dy7Bcg.OEJj=.R,l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE874zue9FFpVVDScsRAjDPAJsG/iw5COSr74cdRSBhq421f+z4egCgwK2d
iY3NTsw8zri/2HUUNkA74Vw=
=vkJN
-----END PGP SIGNATURE-----

--dy7Bcg.OEJj=.R,l--

