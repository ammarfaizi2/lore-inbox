Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269377AbUIIJTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269377AbUIIJTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269378AbUIIJTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:19:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35498 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269377AbUIIJS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:18:59 -0400
Subject: Re: What File System supports Application XIP
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Vt6Ia1PNA/RD0mn1KAyc"
Organization: Red Hat UK
Message-Id: <1094721529.2801.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 11:18:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Vt6Ia1PNA/RD0mn1KAyc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-09 at 10:55, colin wrote:
> Hi there,
> We are developing embedded Linux system. Performance is our consideration=
.
> We hope some applications can run as fast as possible,

well ramfs by definition is XIP :)

but I guess the filesystem comes from flash somewhere at which point
jffs2 with compression might be a better choice; if you have enough ram
then the apps run from the pagecache anyway and compression keeps you
from transfering too much data from the slower flash. It's not XIP but I
don't think you really want XIP...

--=-Vt6Ia1PNA/RD0mn1KAyc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQB/5xULwo51rQBIRAjzjAJ9B1SMN3ZkLf9AJMMXKaKNxz8Yq4wCfQ72Y
xnW203QocX70oqKAZfujq2k=
=/ITc
-----END PGP SIGNATURE-----

--=-Vt6Ia1PNA/RD0mn1KAyc--

