Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263882AbUDON5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbUDON5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:57:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263882AbUDON4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:56:55 -0400
Subject: Re: modules in 2.6 kernel - question for FAQ?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <407E9127.8070303@nortelnetworks.com>
References: <200404142142.41137.arekm@pld-linux.org>
	 <1081993968.17782.112.camel@bach> <20040415044452.GA2215@mars.ravnborg.org>
	 <1082004860.17780.143.camel@bach>  <407E9127.8070303@nortelnetworks.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Rl753dqvjUq593803MdA"
Organization: Red Hat UK
Message-Id: <1082037381.12255.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 15 Apr 2004 15:56:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rl753dqvjUq593803MdA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-04-15 at 15:41, Chris Friesen wrote:
> Rusty Russell wrote:
>=20
> > They can only do this if they're not using the kernel makefiles.  So I
> > don't really think it's a priority...
>=20
> Unfortunately some of us have no choice but to use binary-only drivers.
>=20
> This is starting to change, but they are currently still needed for some=20
> hardware.

I think you misunderstood; even binary only module build stuff needs to
use the kernel makefiles, via make -C /path/to/kernel etc, as documented
in Documentation/kbuild/modules.txt


--=-Rl753dqvjUq593803MdA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAfpSFxULwo51rQBIRAjVhAJ4+iqo5elvdd7Mt9S1RtgWrzMKENQCfSkaw
kSsm9OjEsHmipn33AW7q1Ls=
=XLKC
-----END PGP SIGNATURE-----

--=-Rl753dqvjUq593803MdA--

