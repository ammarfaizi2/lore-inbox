Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbUCKULd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbUCKULc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:11:32 -0500
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:775 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S261691AbUCKUL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:11:27 -0500
In-Reply-To: <Pine.GSO.4.44.0403111123190.29042-100000@math.ut.ee>
References: <Pine.GSO.4.44.0403111123190.29042-100000@math.ut.ee>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-36--203035589"
Message-Id: <4C348BFA-7398-11D8-AFFE-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Paul Wagland <paul@wagland.net>
Subject: Re: megaraid warnings on sparc64 (2.6.4)
Date: Thu, 11 Mar 2004 21:11:35 +0100
To: Meelis Roos <mroos@linux.ee>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-36--203035589
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Mar 11, 2004, at 10:24, Meelis Roos wrote:

> FYI:
>
>   CC [M]  drivers/scsi/megaraid.o
> drivers/scsi/megaraid.c: In function `megadev_ioctl':
> drivers/scsi/megaraid.c:3500: warning: cast to pointer from integer of 
> different size
> drivers/scsi/megaraid.c:3552: warning: cast to pointer from integer of 
> different size
> drivers/scsi/megaraid.c:3578: warning: cast to pointer from integer of 
> different size
> drivers/scsi/megaraid.c:3630: warning: cast to pointer from integer of 
> different size
> drivers/scsi/megaraid.c:3670: warning: cast to pointer from integer of 
> different size
> drivers/scsi/megaraid.c: In function `mega_n_to_m':
> drivers/scsi/megaraid.c:3857: warning: cast to pointer from integer of 
> different size
> drivers/scsi/megaraid.c:3873: warning: cast to pointer from integer of 
> different size

Good news and bad news. The good news is that LSI are working on a new 
driver that is meant to be able to support both 32 and 64 bit hosts, 
the bad news is that nothing appears to be being done to this driver 
until that new driver lands.

Cheers,
Paul

--Apple-Mail-36--203035589
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAUMf4tch0EvEFvxURAhwrAKCzS9LmIqzJOzVZzxYi0Ffv9MhPmACcCm2M
l5aqXyYI07nyvErVqG83PwU=
=woPI
-----END PGP SIGNATURE-----

--Apple-Mail-36--203035589--

