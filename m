Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWANWqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWANWqD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWANWqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:46:02 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:65498 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751335AbWANWqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:46:00 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Subject: Re: [PATCH] 2.6.15: access permission filesystem 0.17
Date: Sat, 14 Jan 2006 23:45:37 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <87ek3a8qpy.fsf@goat.bogus.local>
In-Reply-To: <87ek3a8qpy.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart29178540.bdWEDVAG6U";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601142345.47473.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart29178540.bdWEDVAG6U
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Olaf,

On Saturday 14 January 2006 22:06, Olaf Dietsche wrote:
[PATCH]

accessfs_readdir_aux() in fs/accessfs/inode.c=20

should set DT_REG, since accessfs supports just directories
and regular files. The directory is already handled before
in the sole caller of accessfs_readdir_aux().

This saves the superflous stat(2) call after readdir(2).

All in all I like the concept! It makes the life of admins
much easier.


Regards

Ingo Oeser



--nextPart29178540.bdWEDVAG6U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyX8bU56oYWuOrkARAjgNAJ9P7Qs+iKxU94r8k1HzQFjQipEszACfTd2/
xqb4X9SImi7k35zGJa8mWrg=
=Me5g
-----END PGP SIGNATURE-----

--nextPart29178540.bdWEDVAG6U--
