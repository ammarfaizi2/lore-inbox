Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVBCPRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVBCPRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVBCPRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:17:15 -0500
Received: from svana.org ([203.20.62.76]:4876 "EHLO svana.org")
	by vger.kernel.org with ESMTP id S263213AbVBCPLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:11:02 -0500
Date: Thu, 3 Feb 2005 16:10:54 +0100
From: Martijn van Oosterhout <kleptog@svana.org>
To: Pankaj Agarwal <pankaj@toughguy.net>
Cc: linux-kernel@vger.kernel.org, Linux Net <linux-net@vger.kernel.org>
Subject: Re: Query - Regarding strange behaviour.
Message-ID: <20050203151049.GA16100@svana.org>
Reply-To: Martijn van Oosterhout <kleptog@svana.org>
References: <001501c509ff$d4be02e0$8d00150a@dreammac>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <001501c509ff$d4be02e0$8d00150a@dreammac>
User-Agent: Mutt/1.3.28i
X-PGP-Key-ID: Length=1024; ID=0x0DC67BE6
X-PGP-Key-Fingerprint: 295F A899 A81A 156D B522  48A7 6394 F08A 0DC6 7BE6
X-PGP-Key-URL: <http://svana.org/kleptog/0DC67BE6.pgp.asc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Try:

lsattr /usr/bin

Hope this helps,

On Thu, Feb 03, 2005 at 08:15:39PM +0530, Pankaj Agarwal wrote:
> Hi,
>=20
> In my system there's a strange behaviour.... its not allowing me to creat=
e=20
> any file in /usr/bin even as root. Its chmod is set to 755. Its even not=
=20
> allowing me to change the chmod value of /usr/bin. The strangest part whi=
ch=20
> i felt is ...its shows the owner and group as root when i issue command=
=20
> "ls -ld /usr/bin" and not allowing root to create any file or directory=
=20
> under /usr/bin and not even allowing to change the chmod value. The error=
=20
> is access permission denied... I can change the chmod value of /usr and=
=20
> other directories under /usr/...but not of bin....
>=20
> I need your help/support. kindly let me know what all can i try to resolv=
e=20
> this problem.
>=20
> Thanks and Regards,
>=20
> Pankaj Agarwal=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Martijn van Oosterhout   <kleptog@svana.org>   http://svana.org/kleptog/
> Patent. n. Genius is 5% inspiration and 95% perspiration. A patent is a
> tool for doing 5% of the work and then sitting around waiting for someone
> else to do the other 95% so you can sue them.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFCAj75Y5Twig3Ge+YRAmvmAKCNFQrA8kaGth91mOEe2kkZCEoINQCgnBOb
ABu7no4iIXNQSrsw7p9SJzI=
=pzG6
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
