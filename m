Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317567AbSHEJuY>; Mon, 5 Aug 2002 05:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSHEJuY>; Mon, 5 Aug 2002 05:50:24 -0400
Received: from ppp-217-133-218-75.dialup.tiscali.it ([217.133.218.75]:11199
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317567AbSHEJuX>; Mon, 5 Aug 2002 05:50:23 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028545510.17780.28.camel@irongate.swansea.linux.org.uk>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk> 
	<1028493814.26332.9.camel@ldb> 
	<1028505732.15495.38.camel@irongate.swansea.linux.org.uk> 
	<1028535126.1572.48.camel@ldb> 
	<1028540954.16550.26.camel@irongate.swansea.linux.org.uk> 
	<1028539877.1572.108.camel@ldb> 
	<1028545510.17780.28.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-lOtG1ARrIyizMQkoA5XE"
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Aug 2002 11:53:13 +0200
Message-Id: <1028541193.1572.114.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lOtG1ARrIyizMQkoA5XE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> If OOSTORE is defined then we can't safely use any mmx operations, so
> this is all noise and its still the case no change is required
Yes, this is only for future processors (e.g. out-order AMD/Intels or
Winchips with extended MMX).

So are lfence and mfence OK?


--=-lOtG1ARrIyizMQkoA5XE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TksJdjkty3ft5+cRAn6mAKCcUS0Okq/n7Xrddnx6yAfMgyNG9QCg1LY/
ROvoIvYZYYPsRks19NOscZ8=
=r/U6
-----END PGP SIGNATURE-----

--=-lOtG1ARrIyizMQkoA5XE--
