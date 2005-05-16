Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVEPM4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVEPM4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEPM4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:56:08 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:28328 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261591AbVEPMz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:55:56 -0400
Message-ID: <42889858.1040009@g-house.de>
Date: Mon, 16 May 2005 14:55:52 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maneesh@in.ibm.com
CC: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no,
       Andrew Morton <akpm@osdl.org>
Subject: Re: probably NFS related Oops during shutdown with 2.6.12-rc3-mm3
References: <428691E3.9040800@g-house.de> <1116116799.14297.29.camel@lade.trondhjem.org> <17923.195.126.66.126.1116177426.squirrel@housecafe.dyndns.org> <20050516063136.GB13091@in.ibm.com>
In-Reply-To: <20050516063136.GB13091@in.ibm.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Maneesh Soni wrote:
> Could you try configuring kdump and get a crashdump when the system 
> crashes(oops). Please refer to Documentation/kdump.txt in -mm kernel tree.
> You might also want to set /proc/sys/kernel/panic_on_oops to 1, so as to
> initiate kernel panic during oops.

i've done so, but..hmm...no panic was triggered, because the Oops is gone.
but it *was* there, i swear ;-)

http://nerdbynature.de/bits/prinz/2.6.12-rc3-mm3/prinz-nc_2.6.12-rc4-mm1.log
(but this time with a tainted kernel)

now i can boot 2.6.12-rc4-mm1 (tainted/not tainted), but the oops does not
show up anymore.

but thanks for the hint, i'll keep that in mind next time [1]

Christian.

[1] when will it be? even the -mm kernel is pretty rock-solid for me.
    great job!
- --
BOFH excuse #415:

Maintenance window broken
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCiJhY+A7rjkF8z0wRAqJbAJ9zIhAoIGfzLqrNgewmgqR7FafdSQCeOQMM
U6VPMiAOlofUVPl64lf7HdM=
=T0dN
-----END PGP SIGNATURE-----
