Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWCQJsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWCQJsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbWCQJsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:48:06 -0500
Received: from merlin.artenumerica.net ([80.68.90.14]:60939 "EHLO
	merlin.artenumerica.net") by vger.kernel.org with ESMTP
	id S1751268AbWCQJsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:48:04 -0500
Message-ID: <441A85CF.7030902@artenumerica.com>
Date: Fri, 17 Mar 2006 09:47:59 +0000
From: J M Cerqueira Esteves <jmce@artenumerica.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: support@artenumerica.com, ngalamba@fc.ul.pt, Jens Axboe <axboe@suse.de>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
References: <4405D383.5070201@artenumerica.com>	<20060302011735.55851ca2.akpm@osdl.org>	<440865A9.4000102@artenumerica.com>	<4409B8DC.9040404@artenumerica.com> <20060304161519.6e6fbe2c.akpm@osdl.org> <440BF718.60504@artenumerica.com>
In-Reply-To: <440BF718.60504@artenumerica.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C37E4FECB1D59084FA39626"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C37E4FECB1D59084FA39626
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

J M Cerqueira Esteves wrote:
> Andrew Morton wrote:
>>We have a candidate fix at
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
>> [...] The patch is against 2.6.16-rc5.
> 
> Testing that kernel now, with good news: the machine has been apparently
> stable, running Gaussian processes for the last 20 hours, with no
> oom-killer messages.

... and still using that 2.6.16-rc5 with the suggested patch,
during the last 11 days, always doing a lot of number-crunching with
Gaussian and other programs, we had no more oom-killings or other
noticeable instabilities.

I did take the opportunity to configure the kernel with CONFIG_EDAC,
CONFIG_EDAC_MM_EDAC and CONFIG_EDAC_E752X, and during this period (11
days) got about 20 messages like these:

Mar  7 15:25:08 localhost kernel: [182069.699544] Non-Fatal Error DRAM
Controler
Mar  7 15:25:08 localhost kernel: [182069.699559] EDAC MC0: CE page
0x9c334, offset 0x0, grain 4096, syndrome 0x2510, row 2, channel 1,
label "": e752x CE

always with the same values for page, offset, grain, syndrome, row, and
channel values.  A defective DIMM?

Best regards
                        J Esteves

-- 
+351 939838775   Skype:jmcerqueira   http://del.icio.us/jmce

--------------enig9C37E4FECB1D59084FA39626
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFEGoXPesWiVDEbnjYRAiyqAKCjmWPUB9YpeP9WGzMGulIf4Bm+MwCYkctO
gRLhBbnfiNX//MQs9sQfPA==
=seSb
-----END PGP SIGNATURE-----

--------------enig9C37E4FECB1D59084FA39626--
