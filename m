Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWG2Dgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWG2Dgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 23:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWG2Dgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 23:36:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54432 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752006AbWG2Dgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 23:36:36 -0400
Message-ID: <44CAD81A.9060401@redhat.com>
Date: Fri, 28 Jul 2006 20:38:02 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Zach Brown <zach.brown@oracle.com>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru> <44CA586C.4010205@oracle.com> <20060728184445.GA10797@2ka.mipt.ru> <44CA613F.9080806@oracle.com>
In-Reply-To: <44CA613F.9080806@oracle.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1B2C08651A93A5532AC0B66A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B2C08651A93A5532AC0B66A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Zach Brown wrote:
> Ulrich, would you be satisfied if we didn't
> have the userspace mapped ring on the first pass and only had a
> collection syscall?

I'm not the one to make a call but why rush things?  Let's do it right
from the start.  Later changes can only lead to problems with users of
the earlier interface.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig1B2C08651A93A5532AC0B66A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEytga2ijCOnn/RHQRAvDpAJwJWFGyrC5rJZMjNF/h2l3NhV739QCfdt0E
6TYaA/HYfEsA7aV0f/bdBTw=
=frO5
-----END PGP SIGNATURE-----

--------------enig1B2C08651A93A5532AC0B66A--
