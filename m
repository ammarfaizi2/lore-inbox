Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269382AbUIIJx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269382AbUIIJx0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbUIIJx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:53:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269382AbUIIJxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:53:24 -0400
Subject: Re: Re: What File System supports Application XIP
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00bb01c49651$b7525480$8b1a13ac@realtek.com.tw>
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
	 <1094721529.2801.6.camel@laptop.fenrus.com>
	 <00bb01c49651$b7525480$8b1a13ac@realtek.com.tw>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A3umllTocn73fhOIs9ce"
Organization: Red Hat UK
Message-Id: <1094723597.2801.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 11:53:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A3umllTocn73fhOIs9ce
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-09 at 11:45, colin wrote:
> Hi,
> How does ramfs offer application XIP ability?
> I mean, when the ramfs image is mounted and the application in it is
> executed,
> "exec", which is called by sh, should first copy every section of the
> application to RAM and then jump to the text section.
> How do I avoid the stage copying text section to RAM?

this is not how linux works. programs execute directly from the
pagecache without copy.


--=-A3umllTocn73fhOIs9ce
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQCgNxULwo51rQBIRApICAKCOXv4lHIWe9uQuGwdsxSFBHzgS5ACeLDYi
C4KLjyU0X4oABXOHL4KrDKk=
=cNI1
-----END PGP SIGNATURE-----

--=-A3umllTocn73fhOIs9ce--

