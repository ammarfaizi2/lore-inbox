Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbULENax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbULENax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 08:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULENax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 08:30:53 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:52949 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S261300AbULENaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 08:30:46 -0500
Message-ID: <41B30D6B.3060506@jonmasters.org>
Date: Sun, 05 Dec 2004 13:30:19 +0000
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [PATCH] UML - SYSEMU fixes
References: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org>  <35fb2e5904120403281a63eccd@mail.gmail.com> <200412050819.iB58Jlhj006511@ccure.user-mode-linux.org>
In-Reply-To: <200412050819.iB58Jlhj006511@ccure.user-mode-linux.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Dike wrote:

| jonmasters@gmail.com said:
|
|>That's great, but do any of these patches address various undefines in
|>arch/um/kernel/process.c:check_sysemu when built without skas?
|
|
| Apparently they did.  I just checked with skas turned off and got a
successful
| build.

Good. I've got a working build on an Intel box but it's being more
stubburn building for ppc in 2.6.9 - I'll post an update when I've
actually looked at it.

|>Also, on 2.6.9, I get dud CFLAGS defined when CONFIG_PROF is set *and*
|>CONFIG_FRAME_POINTER is also set - gcc complains about use of "-gp"
|>and "-fomit-frame-pointer" but surely it should be building with frame
|>pointers anyway if I've asked it to do so?
|
|
| I just checked with that config, and it builds fine.

Oh good. Then it works now.

Cheers,

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBsw1reTyyexZHHxERAs34AJ9yXOHe84a73sy81zC3hfSApH67NwCfZPlq
xWiHY1jlmBPftJeIfgtbur4=
=NxJe
-----END PGP SIGNATURE-----
