Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSKREYD>; Sun, 17 Nov 2002 23:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSKREYD>; Sun, 17 Nov 2002 23:24:03 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:6019 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261371AbSKREYC>; Sun, 17 Nov 2002 23:24:02 -0500
Message-ID: <3DD86D08.3030207@redhat.com>
Date: Sun, 17 Nov 2002 20:31:04 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

>  - please don't introduce a new pointer, just use the old one. There 
>    appears to be no cases where you want to have different pointers
>    anyway.

Although I could imagine a possible situation where this might be useful
 I haven't had the need.  And not adding a new pointer means that
clone() on x86 has a parameter register left which might be important in
future.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92G0I2ijCOnn/RHQRAqAeAKC6VJnPL77c6bsx5QuOgt9x4r5DEACfcKJu
XVteSqGucerkqMfbCpaxzEo=
=JD5n
-----END PGP SIGNATURE-----

