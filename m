Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTEGPgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTEGPgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:36:11 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:45554 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263653AbTEGPgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:36:09 -0400
Subject: Re: The disappearing sys_call_table export.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: petter wahlman <petter@bluezone.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1052321673.3727.737.camel@badeip>
References: <1052321673.3727.737.camel@badeip>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DIHKYFVer4MvqFuuuiGK"
Organization: Red Hat, Inc.
Message-Id: <1052322520.1404.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 07 May 2003 17:48:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DIHKYFVer4MvqFuuuiGK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-05-07 at 17:34, petter wahlman wrote:
>  It seems like nobody belives that there are any technically valid
> reasons for hooking system calls, but how should e.g anti virus
> on-access scanners intercept syscalls?
> Preloading libraries, ptracing init, patching g/libc, etc. are
> obviously not the way to go.

those obviously need to be implemented via the security subsystem (eg
LSM). Hooks are obviously the wrong level to do things and I could even
tell you that you cannot implement this right from a module actually.


--=-DIHKYFVer4MvqFuuuiGK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+uSrYxULwo51rQBIRAgllAJ4hMqz7dEnYVGGuAeKqn2Al4RX+1ACgnnom
kpCZPte2DWDzNUzKNeNSSp0=
=/jiQ
-----END PGP SIGNATURE-----

--=-DIHKYFVer4MvqFuuuiGK--
