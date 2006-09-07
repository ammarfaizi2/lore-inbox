Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWIGOls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWIGOls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 10:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWIGOls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 10:41:48 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:25797 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751769AbWIGOlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 10:41:47 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: ioread64()?
Date: Thu, 7 Sep 2006 16:41:42 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1844968.iQVMoVHDUQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609071641.48513.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1844968.iQVMoVHDUQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm looking for a way to access 64 or 128 bit of device space in a single=20
access. For smaller accesses I use ioread32() and friends. But which way=20
should I do it for the next bigger accesses? Casting the iospace to somethi=
ng=20
like u64* looks very suspicious to me. Any better ideas?

Greetings,

Eike

--nextPart1844968.iQVMoVHDUQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFAC+sXKSJPmm5/E4RAkOwAKCVXa/oXpL+/TgYPM2BJ9qEsZEjeQCeOt2S
TU8SiEx5S+VMjnpY6pOEXOk=
=wLNm
-----END PGP SIGNATURE-----

--nextPart1844968.iQVMoVHDUQ--
