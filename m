Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUIIRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUIIRSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUIIRSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:18:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23223 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266333AbUIIRRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:17:55 -0400
Subject: Re: What File System supports Application XIP
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Tim Bird <tim.bird@am.sony.com>
Cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <41408B41.4030306@am.sony.com>
References: <1094723597.2801.8.camel@laptop.fenrus.com>
	 <41408B41.4030306@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IY5gqrzOx5i17ks72hF5"
Organization: Red Hat UK
Message-Id: <1094750264.2801.16.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 19:17:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IY5gqrzOx5i17ks72hF5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Most other filesystems populate the pagecache with I/O, presumably.
> In the case of a ramfs, is the page mapped directly from the fs
> into the pagecache without a copy?

actually ramfs exclusively lives in the pagecache.


--=-IY5gqrzOx5i17ks72hF5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQJA3xULwo51rQBIRAi9eAJ0X6Cwz6pB3TnUxw2gjgQKyYX1e/wCdF/cF
JkloI7AhYgmgfMCON+OY/As=
=wpRX
-----END PGP SIGNATURE-----

--=-IY5gqrzOx5i17ks72hF5--

