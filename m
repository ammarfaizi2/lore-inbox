Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVE3LfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVE3LfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVE3LfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:35:14 -0400
Received: from smtp1.rz.uni-karlsruhe.de ([129.13.185.217]:30338 "EHLO
	smtp1.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S261487AbVE3Lex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:34:53 -0400
Message-ID: <429AFA40.3010705@web.de>
Date: Mon, 30 May 2005 13:34:24 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050514)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fdomain SCSI driver broken in 2.6 series?
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA9FE931DFDE7540960F365C7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9FE931DFDE7540960F365C7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,
does anybody remember the state of the future domain driver in the 
current 2.6 kernel? I tried to find some pointers to the cause of an 
Oops I get every time during insmod with any 2.6 kernel, booting e.g. 
from two versions of the Gentoo installation CD and Knoppix, while the 
2.4 version of the driver detects the card and attached disk just fine. 
Even a self-made grub boot cd containing 2.6.11.10 and some userland as 
initramfs shows the same beahviour.

I am trying to get an ancient ISA adaptor to work, namely a Future 
Domain 1860 w/ 18C30 Chip, if I recall correctly. The card is detected 
properly at base 0x140, irq 11, and the scsi_eh_0 thread is launched as 
well. But even before the disk is detected, the problem occurs.

Unfortunately, I am currently away from the box in question, and did not 
manage to extract any further information so far. Any hints would be 
appreciated, and if I can provide some information that would actually 
be of any use, please let me know.

Thanks in advance,
Chris

--------------enigA9FE931DFDE7540960F365C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQpr6VF2m8MprmeOlAQIdig/7B0CSK32Uyq0UzHiVThsrLtc+bTwIazXa
OogEb73ydZf8UtnDf3gADXVS7F5abwAxhIiaU44D8vh7khL40Mp0slHx/5214NrT
93ax8MFVe6eYPaSDqgLd5qh6P5w8/tkhlMs+fzIvl94Gq2v4LauwFUsOiFoP0iEL
rvxprCutz0EI4iZ/NrIwLQgyUBagDjVtlXHbaujOjtvYworGcJs1AJdhWpaFZXxr
29oexkmdt5znUWVLq5CgtnR6iTOvy7x2b+E3ibJyVF4Rl03bYZ5v4sMi2QEpeqfE
76Sns59aIQ5DdJ5B1nszI+B9kbOw1ICFEBuvLcHkZr9qYBZ/IqIlrxAdh4ApWbHd
6GBt797EJWTOoe5wGM2nmJOVHrmYTmBDLt2JKxRqSrJ92kUCF5A4zIO4E2niR7U8
oaWOsIorJDTSLO0NArcj+QNXFk6RE/SX+a6PypmSrdPYjkn4wsjSSkJc29fTrdYZ
w8LWKQl/Jv8yOxruS9KlosFfxMDmLMF31u7mzY/zTgTlqoXC+FSQWYBY/8wrwH3O
8DHg73xE4HZhZ9F/y7ANEYASCOV8h+yYyTnR4dUH08q8aLEs5CB9K9bvrW6cBf5Z
0pnhJDJXuVnHwox4VX4Y/MPAh/nyXp4r3NIl1iwiM1OQRaS+pP3kVbGY/qcBTw+9
leziTRmpB0k=
=/cNs
-----END PGP SIGNATURE-----

--------------enigA9FE931DFDE7540960F365C7--
