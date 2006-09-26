Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWIZJCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWIZJCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 05:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWIZJCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 05:02:22 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:60841 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750824AbWIZJCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 05:02:22 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ip2: use newer pci_get functions
Date: Tue, 26 Sep 2006 11:02:59 +0200
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <1159223852.11049.158.camel@localhost.localdomain>
In-Reply-To: <1159223852.11049.158.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1863345.mUQ5sVXBXg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609261102.59678.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1863345.mUQ5sVXBXg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Alan Cox wrote:

> @@ -566,6 +568,7 @@
>
>  	/* Initialise all the boards we can find (up to the maximum). */
>  	for ( i = 0; i < IP2_MAX_BOARDS; ++i ) {
> +
>  		switch ( ip2config.addr[i] ) {
>  		case 0:	/* skip this slot even if card is present */
>  			break;

?!?

--nextPart1863345.mUQ5sVXBXg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFGOzDXKSJPmm5/E4RAlNUAKCS+IX94YxwuX8p7J3uesT2pdDpqQCdGYKV
hQYnTJVpL83kzZJ4P+0FQZQ=
=2ubA
-----END PGP SIGNATURE-----

--nextPart1863345.mUQ5sVXBXg--
