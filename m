Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWDRL6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWDRL6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWDRL6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:58:48 -0400
Received: from zit-mailfront1.uni-paderborn.de ([131.234.200.2]:21162 "EHLO
	zitmail.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S932217AbWDRL6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:58:47 -0400
Message-ID: <4444D46F.7010902@uni-paderborn.de>
Date: Tue, 18 Apr 2006 13:58:39 +0200
From: Bjoern Schmidt <bj-schmidt@uni-paderborn.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem with completion object
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=53D27ADB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

i wrote a kernel (2.6.16) module that creates 10 kernelthreads 0-9. That
works great but if i kill and recreate i.e. thread #4, unloading of the
module hangs at wait_for_completion() for thread #4. If i don't kill and
recreate a thread, unloading works fine. What did i wrong?

Please cc!

- --
Greets
Björn Schmidt


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFERNRvLR9iDVPSetsRAjYjAJ9pIwAdBPMwFV6xFkvgNmT2YIsw7gCdGXmh
4LZGYuhMWspmMeRcqzPhhJ4=
=8tSR
-----END PGP SIGNATURE-----
