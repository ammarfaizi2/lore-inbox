Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752291AbWCFIrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbWCFIrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbWCFIrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:47:35 -0500
Received: from merlin.artenumerica.net ([80.68.90.14]:24586 "EHLO
	merlin.artenumerica.net") by vger.kernel.org with ESMTP
	id S1752290AbWCFIre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:47:34 -0500
Message-ID: <440BF718.60504@artenumerica.com>
Date: Mon, 06 Mar 2006 08:47:20 +0000
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
 boundary="------------enigC1445DD293022CFD4BE6C565"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1445DD293022CFD4BE6C565
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> We have a candidate fix at
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
>  Could you test that?  (and don't alter the Cc: list!).  The patch is
> against 2.6.16-rc5.

Testing that kernel now, with good news: the machine has been apparently
stable, running Gaussian processes for the last 20 hours, with no
oom-killer messages.

A new "feature": 36 of these kernel message pairs as boot time:
  device-mapper: dm-linear: Device lookup failed
  device-mapper: error adding target to table

Many thanks and best regards
                              J Esteves

-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enigC1445DD293022CFD4BE6C565
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEC/chesWiVDEbnjYRAiIJAJ9IJ3p/fqgvL66sMxRa1lppNo6/+QCgkucp
KZ0A+AbBf8vZqKCqSDwyaRw=
=bbex
-----END PGP SIGNATURE-----

--------------enigC1445DD293022CFD4BE6C565--
