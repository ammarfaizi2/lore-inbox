Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUILMSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUILMSN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbUILMSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:18:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268690AbUILMSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:18:11 -0400
Subject: Re: /proc/sys/kernel/pid_max issues
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk, wli@holomorphy.com
In-Reply-To: <20040912085609.GK32755@krispykreme>
References: <20040912085609.GK32755@krispykreme>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i0A6oVaUNP9T5pXrBREW"
Organization: Red Hat UK
Message-Id: <1094991480.2626.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 14:18:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i0A6oVaUNP9T5pXrBREW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-09-12 at 10:56, Anton Blanchard wrote:
> Hi,
>=20
> I tried creating 100,000 threads just for the hell of it. I was
> surprised that it appears to have worked even with pid_max set at 32k.

there are a lot of other reasons why you can't go over 64k threads ;)
(esp on a 32 bit machine)

such as all the 16 bit counters in rwsems etc etc...=20
Just Say No(tm) :)


--=-i0A6oVaUNP9T5pXrBREW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBRD54xULwo51rQBIRAqnoAJ9jBM+4C3s9YcDYwJLSz7SyM3LP4gCgg4aB
kRkf5kdIituEPwTZqewCqpE=
=9rVz
-----END PGP SIGNATURE-----

--=-i0A6oVaUNP9T5pXrBREW--

