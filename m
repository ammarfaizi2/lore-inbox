Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUJKNfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUJKNfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268947AbUJKNfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:35:11 -0400
Received: from smtp.ono.com ([62.42.230.12]:38037 "EHLO mta02.onolab.com")
	by vger.kernel.org with ESMTP id S268950AbUJKNez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:34:55 -0400
Message-ID: <416A8BF2.2020902@hispalinux.es>
Date: Mon, 11 Oct 2004 15:34:42 +0200
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Cambrant <cambrant@acc.umu.se>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unable to handle kernel paging request at virtual address 0000ed9c
 [was Re: 2.6.9-rc4-mm1]
References: <20041011032502.299dc88d.akpm@osdl.org> <416A8019.4050901@hispalinux.es> <20041011131926.GA13258@shaka.acc.umu.se>
In-Reply-To: <20041011131926.GA13258@shaka.acc.umu.se>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Cambrant wrote:

| This problem is left since -mm3, and is (for now) fixed by reversing
| optimize-profile-path-slightly.patch. Do it like this:
|
| cd /usr/src/linux
| wget
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
| patch -R -p1 < optimize-profile-path-slightly.patch

Ok, thanks, this works :). I skip the rc3-mm3 release
- --
Ramón Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBaovxw4Wp058o43cRAqcdAJ9CCautaLmY8DKli15SyntG4qAdgwCgzoFh
VVHnYHk8MwYptdymtaoBq28=
=hEqv
-----END PGP SIGNATURE-----
