Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUCZVyo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUCZVyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:54:44 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:59365 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261313AbUCZVyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:54:41 -0500
Message-ID: <4064A69C.7050906@g-house.de>
Date: Fri, 26 Mar 2004 22:54:36 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
References: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0403262029010.2460-100000@math.ut.ee>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Meelis Roos wrote:
| Recent 2.6.5-pre* and -rc1 and -BK don't boot on my Motorola Powerstack
| (PReP with no RTAS but with OF).
|
| I use netboot to test new kernels.  Normally, the screen is changed to
| VGA text mode and the bootloader speaks some lines of info and asks for
| the kernel command line. Now, the image is loaded via tftp (as shown by
| tcpdump, the last datagram is smaller) and nothing more happens. The
| cursor stays where it is - at the beginning of the Booting ... line in
| graphics mode OF environment and that's all.
|

are you sure this is not the issue "Blank screen after decompressing
kernel" described here:

http://www.codemonkey.org.uk/post-halloween-2.5.txt

| Make sure your .config has
|   CONFIG_INPUT=y
|   CONFIG_VT=y
|   CONFIG_VGA_CONSOLE=y
|   CONFIG_VT_CONSOLE=y

i really like to hear what your PowerStack is doing after booting. i
still have severe issues with 2.5/2.6 on my PReP...

Christian.
- --
BOFH excuse #227:

Fatal error right in front of screen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAZKac+A7rjkF8z0wRAp+xAJ9oDHmbPcTaL9SuEGdQNVWZI/1S/QCfbiO2
UdcbbEZnXyFClAmm4t/WGgY=
=WIXh
-----END PGP SIGNATURE-----
