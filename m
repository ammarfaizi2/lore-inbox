Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbUL0L7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUL0L7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 06:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUL0L7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 06:59:51 -0500
Received: from h80ad24f8.async.vt.edu ([128.173.36.248]:57497 "EHLO
	h80ad24f8.async.vt.edu") by vger.kernel.org with ESMTP
	id S261876AbUL0L7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 06:59:49 -0500
Message-Id: <200412271159.iBRBxbZD021538@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Alexander Prokoshev <ap@insysnet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 and time drift 
In-Reply-To: Your message of "Mon, 27 Dec 2004 14:28:25 +0300."
             <41CFF1D9.6030104@insysnet.ru> 
From: Valdis.Kletnieks@vt.edu
References: <41CFF1D9.6030104@insysnet.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1019532240P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Dec 2004 06:59:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1019532240P
Content-Type: text/plain; charset=us-ascii

On Mon, 27 Dec 2004 14:28:25 +0300, Alexander Prokoshev said:

>   after installation of 2.6.10 kernel I've noticed time drift, which
> (according to ntpdc's dmpeer command) is about 10-15 seconds per hour.
> Downgrade to 2.6.9 solves this problem. I can send any additional
> information which may be helpful.

For starters, the output of 'uname -a', the architecture/hardware you're
running on, and if your dmesg has any hints about which time source it's
using. On my Dell laptop, I see:

Dec 26 19:11:22 turing-police kernel: PID hash table entries: 1024 (order: 10, 16384 bytes)
Dec 26 19:11:22 turing-police kernel: Detected 1595.344 MHz processor.
Dec 26 19:11:22 turing-police kernel: Using pmtmr for high-res timesource
Dec 26 19:11:22 turing-police kernel: Console: colour dummy device 80x25
Dec 26 19:11:22 turing-police kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 26 19:11:22 turing-police kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)

Most x86 systems should have a similar note of the timesource right
around that point of the dmesg.

--==_Exmh_1019532240P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBz/kocC3lWbTT17ARAqvgAKCXEEUCDcFsPd8iDYuZ8Nwpt1lSZACghIRl
n/i87aaFopjGyr/jHWleyG0=
=SShO
-----END PGP SIGNATURE-----

--==_Exmh_1019532240P--
