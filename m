Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271743AbTHMLYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271755AbTHMLYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:24:21 -0400
Received: from mail.gondor.com ([212.117.64.182]:6665 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S271743AbTHMLYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:24:20 -0400
Date: Wed, 13 Aug 2003 13:20:05 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Message-ID: <20030813112005.GB8798@gondor.com>
References: <20030806150335.GA5430@gondor.com> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk> <20030813005057.A1863@pclin040.win.tue.nl> <200308130221.26305.bzolnier@elka.pw.edu.pl> <20030813080309.GB2006@gondor.com> <1060773360.8009.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <1060773360.8009.11.camel@localhost.localdomain>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2003 at 12:16:09PM +0100, Alan Cox wrote:
> That sounds about right for UDMA33, which is what you'd get without the
> fix I sent Marcelo a few days ago

But I've not yet patched the kernel, and while booting it says:

Aug 13 09:13:59 sirith kernel: hde: 312581808 sectors (160042 MB) w/8192KiB=
 Cache, CHS=3D19457/255/63, UDMA(100)

hdparm -i also says:
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5=20

So I think it should use UDMA(100), which should give more than 20MB/s
(Seagate says the drive does 32-58MB/s sustained transfer rate)


Jan


--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Oh7lnIUccvEtoGURAq6fAKCOa+2fqN+UX4gXrGd1uDoQLgaP1gCfQApD
OlzffZ1Ui+hJczcH30SJFNw=
=GppS
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
