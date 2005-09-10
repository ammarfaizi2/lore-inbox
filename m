Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVIJSjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVIJSjB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVIJSjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:39:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:33728 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932199AbVIJSjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:39:00 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm2
Date: Sat, 10 Sep 2005 20:43:04 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1171117.vi6cop6HEp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509102043.25928.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1171117.vi6cop6HEp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 08 September 2005 14:30, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.=
13
>-mm2/

I have problems using NFS with 2.6.13-mm2, it failes to start, but works wi=
th=20
2.6.13-ck1 (so pure 2.6.13 should work too, as there are no nfs related=20
changes in -ck, I think).
=46ollowing messages appear in /var/log/messages:

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
rpc.statd[15041]: Version 1.0.7 Starting
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
portmap[15048]: connect from 127.0.0.1 to set(nfs): request from unprivileg=
ed=20
port
nfsd[15046]: nfssvc: Permission denied


with 2.6.13-ck1:

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
rpc.statd[16126]: Version 1.0.7 Starting
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period

hth,
dominik

--nextPart1171117.vi6cop6HEp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQyMpTQvcoSHvsHMnAQKsHAP/RpK/1Sjj6U9reJ6cvTIThqjNhS06NGiF
+70Lkun1qS8naIMrna3bEq+j9QiJQxNsxM/BCY9et9NMDp6qTxvuKf+o0b4Gr2P1
sVyfIFlrJdydRRks+hvtGuL+rTn9aoTNRJ7yNbsKLDjQsjB1FUxgoKzQxAQP7q4V
Gj0lT2PKMnQ=
=+HWE
-----END PGP SIGNATURE-----

--nextPart1171117.vi6cop6HEp--
