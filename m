Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVANIFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVANIFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 03:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVANIFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 03:05:34 -0500
Received: from rdrz.de ([217.160.107.209]:47300 "HELO rdrz.de")
	by vger.kernel.org with SMTP id S261725AbVANIFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 03:05:24 -0500
Date: Fri, 14 Jan 2005 09:05:22 +0100
From: Raphael Zimmerer <killekulla@rdrz.de>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-as1
Message-ID: <20050114080522.GA26525@rdrz.de>
Mail-Followup-To: Andres Salomon <dilinger@voxel.net>,
	linux-kernel@vger.kernel.org
References: <1105605448.7316.13.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1105605448.7316.13.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 13, 2005 at 03:37:28AM -0500, Andres Salomon wrote:
> The goal of this tree is to form a stable base for vendors/distributors
> to use for their kernels. In order to do this, I intend to include only
> security fixes and obvious bugfixes, from various sources.

Thank you very much for your effort. I'am looking forward to see your
tree as 2.6.x.y :)

By the way, I don't hink this is intentional:

killekulla@flori:~/src/kernel/test$ find linux-2.6.10 -name '*.orig'
killekulla@flori:~/src/kernel/test$ cp -rl linux-2.6.10 linux-2.6.10-as1
killekulla@flori:~/src/kernel/test$ zcat patch-2.6.10-as1.gz | patch -sp1 -d linux-2.6.10-as1
killekulla@flori:~/src/kernel/test$ find linux-2.6.10-as1/ -name '*.orig'
linux-2.6.10-as1/fs/nfs/dir.c.orig
linux-2.6.10-as1/fs/binfmt_elf.c.orig
linux-2.6.10-as1/mm/mmap.c.orig
linux-2.6.10-as1/net/sunrpc/sched.c.orig
linux-2.6.10-as1/net/sunrpc/xdr.c.orig
linux-2.6.10-as1/arch/x86_64/ia32/ia32_aout.c.orig
linux-2.6.10-as1/drivers/acpi/video.c.orig
linux-2.6.10-as1/security/dummy.c.orig
linux-2.6.10-as1/include/linux/ipv6.h.orig
linux-2.6.10-as1/include/asm-sparc64/pgtable.h.orig

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB531CUcUgUprPgz4RAjIuAJ4lehVfr40pcBDwF5dhKrVSNLrvSACdHRjX
PEmZM88KW5DvToRxm4XEDW8=
=zbk7
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
