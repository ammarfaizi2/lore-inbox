Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264161AbUD0PA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUD0PA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUD0PAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:00:25 -0400
Received: from lists.us.dell.com ([143.166.224.162]:53163 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264161AbUD0PAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:00:11 -0400
Date: Tue, 27 Apr 2004 09:58:12 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: always store MODULE_VERSION("") data?
Message-ID: <20040427145812.GA20421@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rusty,

I started going through the kernel, adding MODULE_VERSION("foo")
everywhere, but there are a lot of modules which are not separately
versioned, and a value of MODULE_VERSION("") would be appropriate.

How hard would it be to always include the space for the
MODULE_VERSION("") data rather than specifying it in each file that
doesn't care, and only modules with their own versioning could put
MODULE_VERSION("myversion") to override the default?

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAjnUEIavu95Lw/AkRAiJVAJ0c29Qq+Md2niyJxFj+QiYiWGD8MwCffutU
FDksCmAUgHsEpZwOHA3UV3k=
=+BtB
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
