Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUKCJDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUKCJDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUKCJDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:03:30 -0500
Received: from dev.tequila.jp ([128.121.50.153]:2315 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S261492AbUKCJDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:03:12 -0500
Message-ID: <41889EB5.3060304@tequila.co.jp>
Date: Wed, 03 Nov 2004 18:02:45 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
References: <41889857.5040506@tequila.co.jp> <20041103084330.GB10434@suse.de>
In-Reply-To: <20041103084330.GB10434@suse.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/2004 05:43 PM, Jens Axboe wrote:

> It should work, are the permissions on your device file correct?

that was the first thing I checked:

gullevek@pluto:~$ ls -l /dev/scd3
brw-rw----  1 root cdrom 11, 3 2004-04-30 09:28 /dev/scd3

then I thought I am not in the right group:

gullevek@pluto:~$ groups
users disk cdrom audio operator video staff games

but I am ...

I haven't tried to write a CD, but DVD is definilty not possible,
because the device is _not_ listed in k3b if started as user. The
internal CD writer is, so probably I can write here, because before,
this wasn't even listed ...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiJ60jBz/yQjBxz8RAql/AKCAjzCNPZCjHFPo8V1SCwEoAwYlHgCgxY0/
LuZBC4owtk8tYn2/M8jnFlw=
=z23f
-----END PGP SIGNATURE-----
