Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUEPRNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUEPRNu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUEPRNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:13:50 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:38844 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263687AbUEPRNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:13:48 -0400
Message-ID: <40A7A145.5020201@g-house.de>
Date: Sun, 16 May 2004 19:13:41 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] "bk pull" does not update my sources...?
References: <40A51CFB.7000305@g-house.de> <c85lk9$96j$1@sea.gmane.org>
In-Reply-To: <c85lk9$96j$1@sea.gmane.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

walt schrieb:
|> evil@sheep:/usr/src/linux-2.6-BK$ head -n5 Makefile
|> VERSION = 2
|> PATCHLEVEL = 6
|> SUBLEVEL = 6
|> EXTRAVERSION =
|
| This is correct.  Linus does not include the 'bk' in the 'extraversion'
| field.

so, the Makefile from the -bk snapshots (e.g. patch-2.6.6-bk1.bz2) was
edited and will show an EXTRAVERSION of "-bk1", while the original
Makefile does not? this is insane!

Thanks,
Christian.
- --
BOFH excuse #163:

no "any" key on keyboard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAp6FE+A7rjkF8z0wRAmpiAJ90352ybw4mL1qkjw1Kfk5Z/uOw+wCg0AtI
SJ0x6ASWWWwSAkIRJJkLglg=
=86dB
-----END PGP SIGNATURE-----
