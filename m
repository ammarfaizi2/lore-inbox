Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272741AbTHEMyX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272743AbTHEMyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:54:23 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:32645 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S272741AbTHEMyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:54:07 -0400
Date: Tue, 5 Aug 2003 15:54:00 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Rafael Costa dos Santos <rafael@thinkfreak.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux syscall list
Message-ID: <20030805125400.GI32093@actcom.co.il>
References: <200308050933.16351.rafael@thinkfreak.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Content-Disposition: inline
In-Reply-To: <200308050933.16351.rafael@thinkfreak.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2003 at 09:33:16AM +0000, Rafael Costa dos Santos wrote:
> Hi all,
>=20
> Where can I find the last linux syscall list ?

There is no formal list that I know of. You can look at
arch/i386/kernel/entry.S for the names and numbers of syscalls, but
for the parameters you would have to grep around for the system call
definition.=20

For the syscalltrack project we have a close to complete of syscalls
and their parameters for 2.4, i386, at
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/*checkout*/syscalltrack/sysc=
alltrack/module/syscalls.dat?rev=3D1.18

Note that such a list is of limited useful utility unless it is tied
to a specific kernel version, since the kernel gains new syscalls
occasionally. Patches to update the list to 2.5 will be happily
accepted ;-)

Cheers,=20
Muli
--=20
Muli Ben-Yehuda
http://www.mulix.org
http://www.livejournal.com/~mulix/


--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/L6joKRs727/VN8sRAgk9AJ4vKBQ3Hl41m+7u6zWChx85hxWy3gCguTcY
0AgLVK6u+mXMMvXDF4e/N00=
=wvI0
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
