Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTEPM2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 08:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbTEPM2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 08:28:15 -0400
Received: from galileo.bork.org ([66.11.174.148]:54034 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S264429AbTEPM2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 08:28:13 -0400
Date: Fri, 16 May 2003 08:41:03 -0400
From: Martin Hicks <mort@wildopensource.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: rename the ksoftirqd kernel thread.
Message-ID: <20030516124103.GB29266@bork.org>
References: <20030515211716.GV17021@bork.org> <20030515215121.GC2669@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20030515215121.GC2669@werewolf.able.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Thu, May 15, 2003 at 11:51:21PM +0200, J.A. Magallon wrote:
>=20
> Standard Linux 2.4 only supports 32 CPUS (include/linux/threads.h).
> Wouldn't be useful to format it as %0.2d ?
> Even in -aa, that supports 64 in 64-bits arches, it would be enough and
> you get rid of the jump from _CPU9 to _CPU10.

I agree that currently there is only support for sizeof(long) CPUS.
Including this small fix will make the diff to run > 64 CPUS smaller=20
and will increase consistency between 2.4 and 2.5.=20

There are machines out there that are running 128 processors on 2.4

mh

--=20
Wild Open Source Inc.                  mort@wildopensource.com

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+xNxf0ZUZrUx/K+4RAkjkAJ4rXiBDNsNRgh5gBPWv4fEN0n1iowCfdq5P
YWj8Smw7TS3b9iDKc4ckxW4=
=gdz4
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
