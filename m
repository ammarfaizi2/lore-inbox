Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUGRLmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUGRLmt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUGRLmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:42:49 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:22491
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S263802AbUGRLmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:42:47 -0400
Message-ID: <40FA6230.7030506@portrix.net>
Date: Sun, 18 Jul 2004 13:42:40 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Sandor <aditsu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: disabling irq, nobody cared
References: <20040718112926.3474.qmail@web40303.mail.yahoo.com>
In-Reply-To: <20040718112926.3474.qmail@web40303.mail.yahoo.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig56305CF3DD1CAB0D888D2299"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig56305CF3DD1CAB0D888D2299
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Sandor wrote:
> --- Jan Dittmer wrote:
> 
>>Adrian Sandor wrote:
>>
>>>hdb: dma_timer_expiry: dma status == 0x64
>>>hdb: DMA interrupt recovery
>>>hdb: lost interrupt
>>
>>Had the same problem last week. After some googling
>>the solution was to 
>>change the settings of the SATA port in BIOS to
>>Enhanced Mode, SATA only.
> 
> 
> Thanks, but I don't have any SATA disk; my BIOS IDE
> settings are: Enhanced Mode, P-ATA only.
> And my main problem seems to be the "disabling irq"
> thing.

I don't have any SATA disk either. Though it did make a difference!
Have you actually tried to change it?

Jan

--------------enig56305CF3DD1CAB0D888D2299
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA+mIwLqMJRclVKIYRAimZAJ9sKstRNhXihTbzAfA0uDvOH8nyCACgik4O
9SVDKhEOqUQGRTebI9bfWP4=
=/tYj
-----END PGP SIGNATURE-----

--------------enig56305CF3DD1CAB0D888D2299--
