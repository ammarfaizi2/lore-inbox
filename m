Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267946AbUHUWGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbUHUWGG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267949AbUHUWGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:06:06 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:4572 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S267946AbUHUWF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:05:59 -0400
Message-ID: <4127C733.90808@g-house.de>
Date: Sun, 22 Aug 2004 00:05:39 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, support@bitmover.com
Subject: new bk version does not pull?
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

a couple of days ago i updated to the latest bk version [1] when i
noticed today, that my repositories are not updated any more:

evil@sheep:/usr/src/linux-2.6-BK$ bk parent
Parent repository is http://linux.bkbits.net/linux-2.5
evil@sheep:/usr/src/linux-2.6-BK$ bk pull
Pull http://linux.bkbits.net/linux-2.5
  -> file://usr/src/linux-2.6-BK
Nothing to pull.
evil@sheep:/usr/src/linux-2.6-BK$ head -n1 ChangeSet
torvalds@athlon.transmeta.com|fs/nfs/file.c|20020205173938|09221|5d1b10fca0b197c
torvalds@ppc970.osdl.org|fs/nfs/file.c|20040814105619|14166
- -------------------------------------------^^^^
last update was on 08/14/2004.

(yes, i did "bk -r get")

i guess a "bk clone" will set things right, but i wonder what's up here...

Christian.

[1]
evil@sheep:/usr/src/linux-2.6-BK$ bk version
BitKeeper/Free version is bk-3.2.3 20040814023516 for x86-glibc23-linux
Built by: lm@redhat9.bitmover.com in /build/3.2.x-lm/src
Built on: Sat Aug 14 16:50:49 PDT 2004
Running on: Linux 2.6.8.1

- --
BOFH excuse #250:

Program load too heavy for processor to lift.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJ8cz+A7rjkF8z0wRAq22AJ9gGIvKt+5HLdCm6RNkMTI6neUqHwCgl9v9
1lET+93huUYHp1hxn6nSFzo=
=XA3B
-----END PGP SIGNATURE-----
