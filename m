Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTEaXIv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTEaXIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 19:08:51 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:50835 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264490AbTEaXIu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 19:08:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: must-fix, version 6
Date: Sun, 1 Jun 2003 00:49:17 +0200
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030530235008$3775@gated-at.bofh.it> <200305311558.h4VFwpKc024058@post.webmailer.de> <20030531203125.A4202@infradead.org>
In-Reply-To: <20030531203125.A4202@infradead.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306010049.21266.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 31 May 2003 21:31, Christoph Hellwig wrote:

> So instead of fixing the code you rely on vendors merging crap?
> what a wonderful idea, let's hope RH, SuSE & co reject it...

Exactly. Only speaking for myself: I don't have access to the hardware,
the code is outside of the official tree and the maintainers don't
care if it ever gets merged. To me, that's not much different from all
the other obscure stuff in the vendor kernels.

Note that all the /important/ s390 drivers are in 2.5 (except qeth and
the new 3270 -- both are being worked on) and in reasonably good
shape now, mostly due to the fact that Martin rewrote 80% of the code
during the last year.

For zfcp, the chances of getting it cleaned up during 2.7 are good and 
the code for 2.6 will already be much better than what we have now.
For claw and z90crypt we still need a volunteer who will either take 
over maintainership or teach the current maintainers.

	Arnd <><
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2TFw5t5GS2LDRf4RAgNDAJ9kK++TCYCn6kaRM1w1ZlyrT98swQCffO4t
4eGUYyCX8bYnuQCE+iHsUqg=
=oWCi
-----END PGP SIGNATURE-----

