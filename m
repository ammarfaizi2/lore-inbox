Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTIXHL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 03:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbTIXHL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 03:11:29 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:29903 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S261384AbTIXHL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 03:11:27 -0400
Date: Wed, 24 Sep 2003 10:11:21 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Bruno Castro da Silva <sysware@portoweb.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: syscall hook
Message-ID: <20030924071120.GC24375@actcom.co.il>
References: <3f70d6f9.cec.16345@portoweb.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <3f70d6f9.cec.16345@portoweb.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2003 at 08:27:53PM -0300, Bruno Castro da Silva wrote:
> Hi all,
>=20
> I need to put a hook on a syscall so I can monitor the usage
> of sockets. I'm trying to do so without having to recompile
> the kernel (eg by using modules). Can anyone give me a hint
> on how to achieve this?

What exactly are you trying to do? do you need it to be done on a
system wide level (socket in general) or per application (a specific
socket)?

If it's per socket, just use strace. No kernel hacking
required(TM). If it's system wide, apart from the other options
mentioned in this thread, you can also use syscalltrack
(http://syscalltrack.sf.net). Depending on what you want to do, it may
or may not be the best tool for the job. Note that it doesn't support
2.5 yet, but we're working on it.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/cUOYKRs727/VN8sRAvLVAJ9ICO6fMdQ4vZ4EbdmDiINqVWoIewCfZsw/
vtyuoukSB08q5B7HJr9K7s0=
=8jDN
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
