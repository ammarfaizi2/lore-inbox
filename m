Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVDRTxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVDRTxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDRTvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:51:43 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:13020 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262189AbVDRTu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:50:58 -0400
Subject: Re: [PATCH] TCP ipv4 source port randomization
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050418122600.0664f26b.davem@davemloft.net>
References: <1113851051.17341.94.camel@localhost.localdomain>
	 <20050418122600.0664f26b.davem@davemloft.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xflHGERuDR2HfURN+O2h"
Date: Mon, 18 Apr 2005 21:42:21 +0200
Message-Id: <1113853341.17341.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xflHGERuDR2HfURN+O2h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 18-04-2005 a las 12:26 -0700, David S. Miller escribi=F3:
> Stephen Hemminger has already added TCP port randomization on
> connect() to the 2.6.x tree.  See
> net/ipv4/tcp_ipv4.c:tcp_v4_hash_connect(), where randomized port
> selection occurs.  And unlike your patch, Stephen did add ipv6
> support (via net/ipv6/tcp_ipv6.c:tcp_v6_hash_connect()) for
> port randomization as well.

I missed Hemminger's bits there.
I apologize for any inconvenience.

>=20
> 1) That you use netdev@oss.sgi.com for networking patches as that
>    is where the networking developers listen.

OK.

> 2) That you do some checking to see that the feature you're adding
>    is not already present in the tree.

I do, just missed that ;)
Among that I have the patch done since time ago, just didn't submitted
it to the list, so, during the transition I forgot all about any change
(nor I checked the CSETs).

Thanks for the advice,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-xflHGERuDR2HfURN+O2h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZA2dDcEopW8rLewRAlP1AJwPj74ylOT02yUgH3iH3qaFG0rRrgCgrhx/
MGisCNSF3aMzwd6/JAFN0E8=
=nj1g
-----END PGP SIGNATURE-----

--=-xflHGERuDR2HfURN+O2h--

