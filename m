Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUAYMcG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 07:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbUAYMcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 07:32:06 -0500
Received: from [193.170.124.123] ([193.170.124.123]:49355 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S264129AbUAYMcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 07:32:02 -0500
Date: Sun, 25 Jan 2004 13:31:46 +0100
From: JG <jg@cms.ac>
To: Lincoln Dale <ltd@cisco.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TG3: very high CPU usage
In-Reply-To: <5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
References: <20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<20040119033527.GA11493@linux.comp>
	<20040119033527.GA11493@linux.comp>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
	<20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__25_Jan_2004_13_31_47_+0100_kx/7nrtLsSupLgKs"
Message-Id: <20040125123154.A8CA4202CAA@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__25_Jan_2004_13_31_47_+0100_kx/7nrtLsSupLgKs
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

> urgh, those are terrible numbers!

yes ;)

> even an old Pentium3 @ 500MHz here is capable of pushing GbE wire-rate (i 
> just tested this using a Tigon2).

my machines are athlon xp 1700+ and 2400+ so they should be fast enough...
 
> Fast Ethernet only uses 1 pair of wires each for Tx/Rx (4 wires), whereas 
> copper GbE uses 2 pairs each for Tx/Rx (8 wires).

oh, yes, i didn't think of that (my bad...) because i thought "it worked with 2.4 kernels".

> if this is indeed simply an x-over cable, then i'd replace it and try again.

yes, they are located in different rooms and connected via an 20m x-over cable through the wall (easier than affording a gbit switch ;))

> Broadcom have a tool on their web site called "BACS" which [...] check the quality of the cable and report any 
> problems it sees; it can run a signal/noise test on each pair.

thank you for the info! i searched their site, but i only found a reference to BACS on their faq page and that this software should be on their driver cdrom (well, it is not on my netgear cdrom).
but i'll test my cable with a fluke networks cable tester tomorrorw or on tuesday. i'll post the results if they are relevant.

i also tested with a knoppix cdrom on box2, which i can reboot, with 2.4.21 kernel and v1.5 tg3 driver, but the problem was also there so it really seems to be the cable...

thx,
JG

--Signature=_Sun__25_Jan_2004_13_31_47_+0100_kx/7nrtLsSupLgKs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAE7c5U788cpz6t2kRAr/2AKCL44GTjTCCeeqvqCPtZTLapfnpPACfXE6J
r8ODiKig1Z9CeCD2IB6BFbE=
=yYU8
-----END PGP SIGNATURE-----

--Signature=_Sun__25_Jan_2004_13_31_47_+0100_kx/7nrtLsSupLgKs--
