Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVAKDQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVAKDQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAKDOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:14:47 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:60614 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262520AbVAKDN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:13:27 -0500
Date: Tue, 11 Jan 2005 14:13:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: bernard@blackham.com.au, shawv@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-Id: <20050111141332.68e5e05b.sfr@canb.auug.org.au>
In-Reply-To: <20050111001426.GF1444@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com>
	<20050109224711.GF1353@elf.ucw.cz>
	<200501092328.54092.shawv@comcast.net>
	<20050110074422.GA17710@mussel>
	<20050110105759.GM1353@elf.ucw.cz>
	<20050110174804.GC4641@blackham.com.au>
	<20050111001426.GF1444@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__11_Jan_2005_14_13_32_+1100_5X/uKIWaWZ4cIp3x"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__11_Jan_2005_14_13_32_+1100_5X/uKIWaWZ4cIp3x
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 11 Jan 2005 01:14:26 +0100 Pavel Machek <pavel@ucw.cz> wrote:
>
> I think that hwclock --hctosys is not quite straightforward operation
> -- it needs to know if your CMOS clock are in local timezone or GMT,
> or something like that, IIRC.
> 
> But this might work: compute difference between system and cmos time
> before suspend, and use that info to restore time after suspend.

Which is, of course, what APM has done all along ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__11_Jan_2005_14_13_32_+1100_5X/uKIWaWZ4cIp3x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB40Rh4CJfqux9a+8RAhxGAJ0SF9H2NuqRF1q8Hc1TrpLQbqb+6QCgg9p7
jmr7suMhzo1qUb9Snr1+0Ec=
=AZOf
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Jan_2005_14_13_32_+1100_5X/uKIWaWZ4cIp3x--
