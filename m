Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTFKPMs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFKPMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:12:48 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:47302 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262385AbTFKPMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:12:13 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [2.5.70-mm8] NETDEV WATCHDOG: eth0: transmit timed out
Date: Wed, 11 Jun 2003 17:25:43 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030611013325.355a6184.akpm@digeo.com> <200306111356.52950.schlicht@uni-mannheim.de> <200306111516.46648.schlicht@uni-mannheim.de>
In-Reply-To: <200306111516.46648.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_9n05+GWjhokhT2/";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306111725.49952.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_9n05+GWjhokhT2/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

OK, I've found it...!

After reverting the pci-init-ordering-fix everything works as expected=20
again...

Best regards
  Thomas Schlichter

--Boundary-02=_9n05+GWjhokhT2/
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+50n9YAiN+WRIZzQRAg7iAJ4syPiKM3Omz5CmGvL5aQbLDp6lCACdHQg4
utVGid6mCLl9a9JL61f7t5c=
=ThDB
-----END PGP SIGNATURE-----

--Boundary-02=_9n05+GWjhokhT2/--
