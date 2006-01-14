Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWANW6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWANW6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWANW6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:58:36 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:55749 "EHLO
	smtprelay06.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751471AbWANW6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:58:35 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.15: Filesystem capabilities 0.16
Date: Sat, 14 Jan 2006 23:58:24 +0100
User-Agent: KMail/1.7.2
Cc: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
References: <8764om8pzl.fsf@goat.bogus.local>
In-Reply-To: <8764om8pzl.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart19293470.3LX5P88XNo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601142358.31628.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart19293470.3LX5P88XNo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 14 January 2006 22:21, Olaf Dietsche wrote:
> This patch implements filesystem capabilities. It allows to run
> privileged executables without the need for suid root.

Why not implement this via xattr framework and the "system."=20
namespace there? I would suggest "system.posix_capabilties" for this.

That way you can reduce your infrastructure, take advantage
of caching features, have user space tools for viewing and changing=20
this and resize2fs works for it now or soon.

What do you think?


Regards

Ingo Oeser


--nextPart19293470.3LX5P88XNo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyYIXU56oYWuOrkARAhfdAJ4sUXYYybffLG7qXDraKk1vFUBNMACgz9Rh
Ro6tBAeFGCvEArKn8Xfb1Xg=
=/ZEZ
-----END PGP SIGNATURE-----

--nextPart19293470.3LX5P88XNo--
