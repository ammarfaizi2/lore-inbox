Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVDEHjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDEHjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDEHik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:38:40 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:64915 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261596AbVDEHha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:37:30 -0400
Date: Tue, 5 Apr 2005 17:37:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Fix get_compat_sigevent()
Message-Id: <20050405173724.120631d7.sfr@canb.auug.org.au>
In-Reply-To: <20050404224409.1a34e732.davem@davemloft.net>
References: <20050404224409.1a34e732.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__5_Apr_2005_17_37_24_+1000_Pq7lT6lz4gV+nCOz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__5_Apr_2005_17_37_24_+1000_Pq7lT6lz4gV+nCOz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Apr 2005 22:44:09 -0700 "David S. Miller" <davem@davemloft.net> w=
rote:
>
> I have no idea how a bug like this lasted so long.

Probably because very few programs pass sigevents into the kernel ...

> -	memset(&event, 0, sizeof(*event));
> +	memset(event, 0, sizeof(*event));

Blush :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Apr_2005_17_37_24_+1000_Pq7lT6lz4gV+nCOz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUkA04CJfqux9a+8RAosBAJ4o2B3iT20n9o10yIBNnhHCcFfDNQCeI19F
/ugJIPqj9WbdyS/pJXtvBFs=
=KJ8a
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Apr_2005_17_37_24_+1000_Pq7lT6lz4gV+nCOz--
