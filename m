Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUEVKwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUEVKwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 06:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUEVKwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 06:52:11 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:47042 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264957AbUEVKwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 06:52:08 -0400
Message-ID: <40AF30D8.6050107@g-house.de>
Date: Sat, 22 May 2004 12:52:08 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/buffer.c:1270! [TAINTED]
References: <40AE4AAB.60008@g-house.de> <20040521191904.68544946.akpm@osdl.org>
In-Reply-To: <20040521191904.68544946.akpm@osdl.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton schrieb:
| This is isofs passing sinful block sizes to bread().  There's a patch in
| Linus's current tree which should allow the system to survive this.  It
| won't fix the root problem though, which is presumably related to
those I/O
| errors.

Thank you for the explanation and the patch! well, if it's in Linus'
tree anyway, i guess "bk pull" will hit it soon.
astonishing, how this oops-gibberish makes sense to someone and even
points out to be a known issue :-)

you guys rock,
Christian.
- --
BOFH excuse #251:

Processes running slowly due to weak power supply
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFArzDY+A7rjkF8z0wRAv8PAKDD/wbwvAntQNUlJsM3+Gp5OhV5QwCgotug
bxyLwhS1jY/GLdt6cw6zbH8=
=7++L
-----END PGP SIGNATURE-----
