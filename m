Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752321AbWCFJTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbWCFJTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbWCFJTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:19:40 -0500
Received: from merlin.artenumerica.net ([80.68.90.14]:27914 "EHLO
	merlin.artenumerica.net") by vger.kernel.org with ESMTP
	id S1752321AbWCFJTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:19:39 -0500
Message-ID: <440BFEA8.2080103@artenumerica.com>
Date: Mon, 06 Mar 2006 09:19:36 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       Jens Axboe <axboe@suse.de>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
References: <4405D383.5070201@artenumerica.com>	<20060302011735.55851ca2.akpm@osdl.org>	<440865A9.4000102@artenumerica.com>	<4409B8DC.9040404@artenumerica.com> <20060304161519.6e6fbe2c.akpm@osdl.org>
In-Reply-To: <20060304161519.6e6fbe2c.akpm@osdl.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA195A286FF312313FFDF9FDB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA195A286FF312313FFDF9FDB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
>  Could you test that?  (and don't alter the Cc: list!).  The patch is
> against 2.6.16-rc5.

I forgot to mention that the DVD drive was not automatically recognized:

ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18F0 irq 14
ata1: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000 85:0218 86:0000 87:4000
88:041f
ata1: dev 0 ATAPI, max UDMA/66
ata1: dev 0 configured for UDMA/33
scsi0 : ata_piix
ata1(0): WARNING: ATAPI is disabled, device ignored.

Is this still as described in
http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux
under "DVD drive not recognized"?  Perhaps I'll be able to do some tests
on that later, too.

Best regards
                J Esteves
-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enigA195A286FF312313FFDF9FDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEC/6oesWiVDEbnjYRAlfrAKCpyetAEQqm1N0FFuwOQzQNIqr4iACfRGs/
XUVhdxbPpyR0ervB3x8Ws3k=
=Y3NG
-----END PGP SIGNATURE-----

--------------enigA195A286FF312313FFDF9FDB--
