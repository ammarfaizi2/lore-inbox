Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265009AbUFMGUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbUFMGUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 02:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUFMGUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 02:20:49 -0400
Received: from dev.tequila.jp ([128.121.50.153]:58898 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S265009AbUFMGUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 02:20:47 -0400
Message-ID: <40CBF29D.3080400@eunet.at>
Date: Sun, 13 Jun 2004 15:22:21 +0900
From: Clemens Schwaighofer <schwaigl@eunet.at>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: gullevek@gullevek.org, linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
References: <40C9AF48.2040807@gullevek.org>	<20040611062829.574db94f.pj@sgi.com>	<40CA6835.2070405@eunet.at>	<20040612034430.72a8207e.pj@sgi.com>	<40CBC809.3000102@eunet.at>	<20040612204207.0136b76f.pj@sgi.com>	<40CBD251.4000601@eunet.at> <20040612212024.0bbec683.pj@sgi.com>
In-Reply-To: <20040612212024.0bbec683.pj@sgi.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Jackson wrote:

okay, I am sorry :) I am not a C coder, just other lesser (perl, php,
java, etc)

| The preprocessor output from this line in the x86.i file will look
| something like this, hopefully:
|
|    Good:
|
| 	old_mask = ((cpumask_t){ { [0 ... (((8)+32 -1)/32)-1] = 0UL } });
|
| Not like this:
|
|    Bad:
|
| 	old_mask = { { [0 ... (((8)+32 -1)/32)-1] = 0UL } };

okay, I have the "Bad" one. Whatever that means, it seems bad :)

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAy/KdJwwYX0IeBp8RAjCRAJ96AtWAVml+rZ1ErGdh0b5PQR8/3QCgqzz4
ptOblxs2ln8V504PZpzc29Q=
=nXov
-----END PGP SIGNATURE-----
