Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUIXMkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUIXMkK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUIXMkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:40:10 -0400
Received: from 60.Red-213-97-200.pooles.rima-tde.net ([213.97.200.60]:35988
	"EHLO marlow.intranet.hisitech.com") by vger.kernel.org with ESMTP
	id S268703AbUIXMkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:40:01 -0400
Message-ID: <415413B7.2070707@apache.org>
Date: Fri, 24 Sep 2004 14:31:51 +0200
From: Santiago Gala <sgala@apache.org>
Organization: Apache Software Foundation
User-Agent: Mozilla Thunderbird 0.8 (X11/20040917)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Typo in -mm2 patch for 2.6.9-rc2
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig823C24F3616645E6D41B9211"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig823C24F3616645E6D41B9211
Content-Type: multipart/mixed;
 boundary="------------080906070706020007030608"

This is a multi-part message in MIME format.
--------------080906070706020007030608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ditto: s/exec_dma/exec_cmd/

The patch is take for the root of the file system, I don't know the 
rules here, but it is trivial enough.

Regards
Santiago

--------------080906070706020007030608
Content-Type: text/x-patch;
 name="mm-sources-2.6.9-rc2-mm2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-sources-2.6.9-rc2-mm2.patch"

--- /usr/src/linux-2.6.9-rc2-mm2/drivers/ide/ppc/pmac.c~	2004-09-24 11:56:16.000000000 +0200
+++ /usr/src/linux-2.6.9-rc2-mm2/drivers/ide/ppc/pmac.c	2004-09-24 12:40:07.468128912 +0200
@@ -2093,7 +2093,7 @@
 	hwif->ide_dma_on = &__ide_dma_on;
 	hwif->ide_dma_check = &pmac_ide_dma_check;
 	hwif->dma_setup = &pmac_ide_dma_setup;
-	hwif->dma_exec_dma = &pmac_ide_dma_exec_cmd;
+	hwif->dma_exec_cmd = &pmac_ide_dma_exec_cmd;
 	hwif->dma_start = &pmac_ide_dma_start;
 	hwif->ide_dma_end = &pmac_ide_dma_end;
 	hwif->ide_dma_test_irq = &pmac_ide_dma_test_irq;

--------------080906070706020007030608--

--------------enig823C24F3616645E6D41B9211
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBVBO6ZAeG2a2/nhoRAv5cAJ4gVJzHo/3J8xyE7YAW4cF3SVav+ACg52sC
rxlcGp5a/1T04+7oVYDXwGM=
=vQIg
-----END PGP SIGNATURE-----

--------------enig823C24F3616645E6D41B9211--
