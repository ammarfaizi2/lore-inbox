Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUKIBdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUKIBdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbUKIBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:32:40 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:6873 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261334AbUKIBbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:31:32 -0500
Message-ID: <41901DF0.8040302@g-house.de>
Date: Tue, 09 Nov 2004 02:31:28 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de> <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org> <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>
In-Reply-To: <419005F2.8080800@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ok, i've done some other things here and built kernels from
2.6.10-rc1-bk13 and all were giving the oops:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1-bk13
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops-2.6.10-rc1-bk13.txt

the config is the same config i am usually using, never gave me a
headache, new options (due to new kernel version) were left to default in
most cases. anyway - i've pulled again a recent tree, did
"bk undo -a1.2463" again but this time i stripped down my .config (via
menuconfig) to the absolute necessary things:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1_a1.2463_take2

...and  it did *NOT* oops:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-no-oops-2.6.10-rc1_a1.2463.txt

i'll investigate further, building former -bk snapshots, using other
configs before i'll fiddle around with bk again (to get the smaller
changes). but this is a tomorrow thing, real life calls in :(

Thank you all so far,
Christian.
- --
BOFH excuse #92:

Stale file handle (next time use Tupperware(tm)!)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkB3v+A7rjkF8z0wRAjU/AKCGPnfuJiBzamcRwU9hIiH+GXZNSwCgi2YK
kwN9O4z/1MzWEakWX0p6IGo=
=d8GA
-----END PGP SIGNATURE-----
