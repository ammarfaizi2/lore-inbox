Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVGVTgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVGVTgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 15:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVGVTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 15:36:17 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:16529 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S262133AbVGVTgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 15:36:09 -0400
Message-ID: <42E12105.3090900@trn.iki.fi>
Date: Fri, 22 Jul 2005 19:38:29 +0300
From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen_/_Tronic?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050712)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ioGL64NX <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Supermount
References: <42E00DD3.9060407@trn.iki.fi> <2de37a440507211450501a8378@mail.gmail.com>
In-Reply-To: <2de37a440507211450501a8378@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD961465B2BCE25AD230AE76"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD961465B2BCE25AD230AE76
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> Supermount is obsolete there are other tools in userspace that do the
> job perfectly.
> e.g ivman which uses hal and dbus.

They cannot mount on demand, thus cannot do the same job. The boot
partition, for example, is something that should only be mounted when
required. The same obviously also goes for network filesystems in many
cases (i.e. avoid having zillion idling connections to the server).

> Also there are other fs like supermount e.g submount etc...

I woudldn't care about the implementation (original supermount,
supermountng, submount or something else). Getting the job done is what
counts.

- Tronic -

--------------enigCD961465B2BCE25AD230AE76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC4SEIOBbAI1NE8/ERAuu4AJ9++rnjahcNzJHtQN+FVL5Kagw8GQCggg33
dlUeh314t6N0G2WiKfgmunA=
=U5dr
-----END PGP SIGNATURE-----

--------------enigCD961465B2BCE25AD230AE76--
