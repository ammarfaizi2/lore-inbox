Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265258AbUEYXxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbUEYXxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 19:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbUEYXxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 19:53:13 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:19588 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S265258AbUEYXxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 19:53:08 -0400
Message-ID: <40B3CFB6.1080405@g-house.de>
Date: Wed, 26 May 2004 00:59:02 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Younggyun Koh <young@cc.gatech.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Installing 2.6.6 on hp zx6000
References: <Pine.GSO.4.58.0405251451300.28567@tokyo.cc.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0405251451300.28567@tokyo.cc.gatech.edu>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Younggyun Koh schrieb:
| 1. has anyone succeeded with the same condition?

no, as i don't own such a machine.

| 2. nfs-utils currently installed is version 0.3.3. the minimum requirement
| for 2.6.6 is 1.0.5, but i was told from the system management guy that
| installing 1.0.5 might cause serious problems... is it true?

just ask the "system management guy" exactly *what* seems to be the
problem with nfs-utils 1.0.5. i have 1.0.6 running with no problems.

| 3. i got the link error when i build the kernel
|
| bash-2.05$ make CROSS_COMPILE=/opt/gcc-3.3.3/usr/local/bin/
| warning: your linker cannot handle cross-segment segment-relative
| relocations.
|          please upgrade to a newer version (it is safe to use this linker,
| but
|          the kernel will be bigger than strictly necessary).

well, that's a pretty good error message, don't you think? a quick grep
with this error on your local kernel-sources will show that the message
is from: arch/ia64/scripts/toolchain-flags.
upgrading binutils (and other tools too) to the recommended versions as
shown in Documentation/Changes would be a first step. maybe system
management guy can help with that ;-)

Christian.
- --
BOFH excuse #23:

improperly oriented keyboard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAs8+2+A7rjkF8z0wRArPFAJ4lDlVs6ny7AhZbATYI88N14x0leQCg2Dio
WO9pWDOtK0qNVhPpj05cnyo=
=RcVy
-----END PGP SIGNATURE-----
