Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTJSSQo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 14:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTJSSQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 14:16:44 -0400
Received: from mout2.freenet.de ([194.97.50.155]:56510 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S262011AbTJSSQl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 14:16:41 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Harold Martin <cocoadev@earthlink.net>
Subject: Re: Mounting /dev/md0 as root in 2.6.0-test7
Date: Sun, 19 Oct 2003 20:16:30 +0200
User-Agent: KMail/1.5.4
References: <1066582732.1108.5.camel@localhost>
In-Reply-To: <1066582732.1108.5.camel@localhost>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310192016.38818.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 19 October 2003 18:58, Harold Martin wrote:
> First, is it possible to mount an md device as root (superblock is
> present)?

Yes, it is. I've had such a configuration on this
machine some weeks ago.

> If so, I can't get it to work :(
> I pass root=/dev/md0 to the kernl, but I get the "Kernel panic: VFS:
> Unable to mount root fs on md0" error.

Did you correctly set up the md? Did you make
proper use of the raidtools? How does your raidtab, that you
used to create the array, look like?

Are you able to mount the md from a running system (not as / root)?

> Thanks for your help,
> Harold

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ktUGoxoigfggmSgRAsymAJ9g4bPy+8S+Mq5zkOC+N2BLSQJmUACfcr5l
hSHv/lWFF5UEA2NrSbFX5OA=
=V//M
-----END PGP SIGNATURE-----

