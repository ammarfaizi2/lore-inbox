Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUGRLMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUGRLMR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUGRLMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:12:17 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:47321
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S263775AbUGRLMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:12:12 -0400
Message-ID: <40FA5B05.9050905@portrix.net>
Date: Sun, 18 Jul 2004 13:12:05 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Sandor <aditsu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: disabling irq, nobody cared
References: <20040718110343.42481.qmail@web40309.mail.yahoo.com>
In-Reply-To: <20040718110343.42481.qmail@web40309.mail.yahoo.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB2207AEAE637BF2BBD897CD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB2207AEAE637BF2BBD897CD
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Sandor wrote:
> hdb: dma_timer_expiry: dma status == 0x64
> hdb: DMA interrupt recovery
> hdb: lost interrupt

> I have an Asus P4P800 Deluxe mobo, and a P4 2.8GHz
> with HT activated.

Had the same problem last week. After some googling the solution was to 
change the settings of the SATA port in BIOS to Enhanced Mode, SATA only.

(http://seclists.org/lists/linux-kernel/2004/Jan/2324.html)

Jan

--------------enigEB2207AEAE637BF2BBD897CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA+lsFLqMJRclVKIYRAllgAJ96RJj5SCjThp1l6tUJVlOny0AHoACeOzJK
mipcE7CLJOwMjcKX8n3vPXo=
=J4s0
-----END PGP SIGNATURE-----

--------------enigEB2207AEAE637BF2BBD897CD--
