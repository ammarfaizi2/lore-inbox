Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUAYWgD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUAYWgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:36:03 -0500
Received: from mail.g-housing.de ([62.75.136.201]:42667 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S265290AbUAYWf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:35:59 -0500
Message-ID: <401444C6.3090602@g-house.de>
Date: Sun, 25 Jan 2004 23:35:50 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031203 Thunderbird/0.4RC2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Rebsamen <mrebsamen@swissonline.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
References: <200401242137.34881.mrebsamen@swissonline.ch> <20040125124557.GA2036@mars.ravnborg.org> <200401251427.02975.mrebsamen@swissonline.ch>
In-Reply-To: <200401251427.02975.mrebsamen@swissonline.ch>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marco Rebsamen wrote:
| bineo:/usr/src/linux-2.6.1 # LANG=C LC_ALL=C objcopy -O binary -R .note
| -R .comment -S vmlinux arch/i386/boot/compressed/vmlinux.bin
| Ungültiger Maschinenbefehl

try with "export LANG=C && objcopy ...." to get english messages.

also: what binutils (objcopy -V), gcc, make, etc.. do you use? have you
bugged SuSE yet?

Christian.

- --
BOFH excuse #154:

You can tune a file system, but you can't tune a fish (from most tunefs
man pages)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAFETE+A7rjkF8z0wRAnbOAJ9oxQi0xuZNzE2S0t3R67NkWxzwjQCgxfDP
j36b+cPwz0vgJ8WiINsu+Wk=
=8Ba0
-----END PGP SIGNATURE-----

