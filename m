Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUAGMQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 07:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbUAGMQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 07:16:30 -0500
Received: from pD9E342BD.dip.t-dialin.net ([217.227.66.189]:50320 "EHLO
	necessity.reactor.de") by vger.kernel.org with ESMTP
	id S265505AbUAGMQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 07:16:28 -0500
Date: Wed, 7 Jan 2004 13:16:25 +0100
From: Steffen Beyer <sbeyer@reactor.de>
To: linux-kernel@vger.kernel.org
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
In-Reply-To: <3FFACF9C.40001@gmx.de>
References: <20040106135634.A5825@beton.cybernet.src>
	<S264471AbUAFPAy/20040106150054Z+23529@vger.kernel.org>
	<3FFACF9C.40001@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__7_Jan_2004_13_16_25_+0100_3UGiJ2Jim7.4P6IO"
Message-Id: <E1AeCbp-0005dc-00@necessity.reactor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__7_Jan_2004_13_16_25_+0100_3UGiJ2Jim7.4P6IO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 06 Jan 2004 16:09:16 +0100
"Prakash K. Cheemplavam" <PrakashKC@gmx.de> wrote:

> I am not Jeff but, SATA is embedded SCSI infrastructure, thus you get 
> sda device.

Not with the libata VIA driver.

> Performace is so bad because of workaround for Seagate drives (max 
> 15kb/transfer or alike). HDParm won't help you.

I had to apply the mm patch for 2.6 to get the full performance out of my
3112 (also Seagate drives) using the IDE (non-libata) driver. Didn't test
libata for the 3112 after applying.

Regards,
-- 
Steffen Beyer <sbeyer@reactor.de>

GnuPG key fingerprint: 6C9B 2844 AF75 AC7A C38C  9FFD 06CB A788 398B D2D9
Public key available upon request or at http://wwwkeys.pgp.net

--Signature=_Wed__7_Jan_2004_13_16_25_+0100_3UGiJ2Jim7.4P6IO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+/iZBsuniDmL0tkRAj0wAJ9f7a2nMMLh3RSf3pXoADkQNpUjUgCdEUMg
20J+jS91Y2iYZR4exoskyMo=
=3TqI
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Jan_2004_13_16_25_+0100_3UGiJ2Jim7.4P6IO--
