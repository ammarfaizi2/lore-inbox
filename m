Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbULFAjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbULFAjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbULFAjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:39:42 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:6345 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261437AbULFAjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:39:20 -0500
Message-ID: <41B3AA33.6020806@g-house.de>
Date: Mon, 06 Dec 2004 01:39:15 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: undefined reference to `pgd_offset_is_obsolete' (ppc32)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi list,

today i got an error while compiling 2.6.10-rc2-mm4:

arch/ppc/mm/built-in.o(.init.text+0x1d0): In function `paging_init':
: undefined reference to `pgd_offset_is_obsolete'
make: *** [.tmp_vmlinux1] Error 1

for the sake of readability, the full output is here:

http://nerdbynature.de/bits/hal/2.6.10-rc2-mm3/make.log
http://nerdbynature.de/bits/hal/2.6.10-rc2-mm3/config

vanilla 2.6-BK kernels compile fine, the .config was adopted from the
working kernel of 2.6.10-rc3 (yes '' | make oldconfig).

this is tried on a i386-for-ppc32(target-arch)-cross-compile environment,
gcc-3.4.2, binutils-2.15.

please let me know if you need further details.

Christian.
- --
BOFH excuse #239:

CPU needs bearings repacked
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBs6oz+A7rjkF8z0wRAsQiAJ9fgqypXQ9LMyidcx8deyMV5e2QtQCffs76
dhe8RXy+NGXgrnI+LGDxQHA=
=ZEQ6
-----END PGP SIGNATURE-----
