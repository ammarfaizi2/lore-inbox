Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVBYA3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVBYA3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVBYA1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:27:05 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:9606 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262632AbVBYAYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:24:44 -0500
Message-ID: <421E7033.1030600@g-house.de>
Date: Fri, 25 Feb 2005 01:24:19 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
CC: Meelis Roos <mroos@linux.ee>, Tom Rini <trini@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos> <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos>
In-Reply-To: <20050224160657.GB11197@pegasos>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sven Luther wrote:
> 
> Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
> meanwhile, you can try : 
> 
>   http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd

oh, what fun - it's booting! de4x5 is loading (although i build my kernels
with a (compiled in) tulip driver). sym53c8xx gets loaded and initializing
the scsi bus is *not* blocking all other activities as usual.

here are the logs:

http://nerdbynature.de/bits/hal/d-i-2005.02.23/  (working 2.6.8 from Sven)
http://nerdbynature.de/bits/hal/2.6.11-rc3/      (scsi errors)

(note: i still have no disks attached)

thank you,
Christian.
- --
BOFH excuse #286:

Telecommunications is downgrading.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCHnAz+A7rjkF8z0wRAsxtAJ9DPKaUg9nCWGZKGxqd6sCOtVqu1QCfRyjp
934bVyFtXvuTFYLCgQcAhrI=
=hSxn
-----END PGP SIGNATURE-----
