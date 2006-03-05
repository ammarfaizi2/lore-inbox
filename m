Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWCECyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWCECyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWCECyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:54:05 -0500
Received: from 213-205-70-242.net.novis.pt ([213.205.70.242]:2001 "EHLO
	gilgamesh.eufrates.artenumerica.net") by vger.kernel.org with ESMTP
	id S1751066AbWCECyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:54:04 -0500
Message-ID: <440A531D.9050009@artenumerica.com>
Date: Sun, 05 Mar 2006 02:55:25 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       Jens Axboe <axboe@suse.de>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
References: <4405D383.5070201@artenumerica.com>	<20060302011735.55851ca2.akpm@osdl.org>	<440865A9.4000102@artenumerica.com>	<4409B8DC.9040404@artenumerica.com> <20060304161519.6e6fbe2c.akpm@osdl.org>
In-Reply-To: <20060304161519.6e6fbe2c.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig33D6D672327FDDEF0A42127B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33D6D672327FDDEF0A42127B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> We have a candidate fix at
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
>  Could you test that?  (and don't alter the Cc: list!).  The patch is
> against 2.6.16-rc5.

Thanks! I'll test it in a few hours, after a short "barbaric" test
inspired (perhaps naively) by those call traces: running with a 2.6.15.4
without SCSI cd-rom support (with multiple Gaussian processes, no
oom-killings until now (3 hours)).

Best regards
                        J Esteves

--------------enig33D6D672327FDDEF0A42127B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEClMlesWiVDEbnjYRAhyFAJ9E36O7WyvBKje3e4+EVtsXDuDPCACaAs68
gIUFHGIik8hIGLgHFzIk0Sw=
=bfP7
-----END PGP SIGNATURE-----

--------------enig33D6D672327FDDEF0A42127B--
