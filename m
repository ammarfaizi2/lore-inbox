Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUECVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUECVLn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUECVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:11:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264002AbUECVLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:11:30 -0400
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       bunk@fs.tum.de, eyal@eyal.emu.id.au, linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16534.45589.62353.878714@napali.hpl.hp.com>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	 <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
	 <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	 <20040501161035.67205a1f.akpm@osdl.org>
	 <Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	 <20040501175134.243b389c.akpm@osdl.org>
	 <16534.35355.671554.321611@napali.hpl.hp.com>
	 <Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
	 <16534.45589.62353.878714@napali.hpl.hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HyxdwrBE6CtFIeXtEinD"
Organization: Red Hat UK
Message-Id: <1083618424.3843.12.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 03 May 2004 23:07:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HyxdwrBE6CtFIeXtEinD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>  For example, the ATI
> driver wants to call mlock()/munlock().  While this happens to be a
> proprietary/binary-only driver, the same issue can arise with GPL'd
> modules.

that is too ugly to live imo. Exporting sys_mlock() for a kernel module
soooo sounds wrong to me, regardless of binary only vs gpl.

--=-HyxdwrBE6CtFIeXtEinD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAlrR4xULwo51rQBIRAj77AKCN6xqYqFPkkqAXcwHA0ZEktumz1ACfRS8V
eFChKpOYodYXgzJjG962/xQ=
=qkNP
-----END PGP SIGNATURE-----

--=-HyxdwrBE6CtFIeXtEinD--

