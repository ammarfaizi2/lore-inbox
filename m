Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSHZQfZ>; Mon, 26 Aug 2002 12:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318128AbSHZQfY>; Mon, 26 Aug 2002 12:35:24 -0400
Received: from ppp-217-133-221-128.dialup.tiscali.it ([217.133.221.128]:20697
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318123AbSHZQfY>; Mon, 26 Aug 2002 12:35:24 -0400
Subject: Re: Broken inlines all over the source tree
From: Luca Barbieri <ldb@ldb.ods.org>
To: Greg KH <greg@kroah.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
In-Reply-To: <20020826162204.GB17819@kroah.com>
References: <1030232838.1451.99.camel@ldb> 
	<20020826162204.GB17819@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Tf/t6WnEgnjN44Kjb6lD"
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 Aug 2002 18:39:35 +0200
Message-Id: <1030379975.1886.39.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tf/t6WnEgnjN44Kjb6lD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > ./drivers/usb/serial/whiteheat.c
> 
> False positive, those functions are never even called :)
Remove them :)
 
> > ./drivers/usb/host/hc_simple.h
> 
> Hm, these also need to be fixed, but there doesn't seem to be a
> maintainer for the code.  I'll just take the inline marking off of them,
> if no one minds.
Or you could fix them by removing the declarations and moving the
definitions where the declarations were (if they use something declared
between the declaration and the definition more changes are required).


--=-Tf/t6WnEgnjN44Kjb6lD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9alnHdjkty3ft5+cRAlSIAKCwnqzXKPHOu3r+E4PY++S0OXNYhwCdFV9x
5DRdK8BAn0Wj5qK1ONpb6m4=
=khNU
-----END PGP SIGNATURE-----

--=-Tf/t6WnEgnjN44Kjb6lD--
