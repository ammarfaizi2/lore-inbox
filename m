Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265233AbUGDRuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUGDRuI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUGDRuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:50:08 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:41956 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265233AbUGDRt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:49:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: move O_LARGEFILE forcing to filp_open()
Date: Sun, 4 Jul 2004 19:49:00 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com> <20040704172750.GJ21066@holomorphy.com> <20040704173805.GK21066@holomorphy.com>
In-Reply-To: <20040704173805.GK21066@holomorphy.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_NME6Ay8bxZkp/BX";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407041949.01126.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_NME6Ay8bxZkp/BX
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sonntag, 4. Juli 2004 19:38, William Lee Irwin III wrote:
> How does this look as an implementation of that suggestion, incremental
> to your compat_sys_open() consolidation patch?

At first sight, it looks like (filp->f_flags & O_LARGEFILE) will always
be true after calling filp_open, but I don't have time to look closer
today.

	Arnd <><

--Boundary-02=_NME6Ay8bxZkp/BX
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA6EMN5t5GS2LDRf4RAn/HAJ0W9fhCzSBBX1g3yUXpzkuaLaFYawCfR+1K
jj+TNsorhnFspfTmYrWOV+4=
=bFg1
-----END PGP SIGNATURE-----

--Boundary-02=_NME6Ay8bxZkp/BX--
