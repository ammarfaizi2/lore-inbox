Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUAJF6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 00:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUAJF5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 00:57:45 -0500
Received: from h80ad25a9.async.vt.edu ([128.173.37.169]:62080 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264887AbUAJF5m (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 00:57:42 -0500
Message-Id: <200401100555.i0A5tXmx003024@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.6.1-mm1 - OOPs and hangs during modprobe 
In-Reply-To: Your message of "Sat, 10 Jan 2004 14:11:17 +1100."
             <20040110031521.309282C050@lists.samba.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040110031521.309282C050@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1513812110P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 10 Jan 2004 00:55:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1513812110P
Content-Type: text/plain; charset=us-ascii

On Sat, 10 Jan 2004 14:11:17 +1100, Rusty Russell said:

> Vladis, relative patch, actually sets error code.  What happens now?

I still get this in the dmesg (2 modules won't load - most of rest are fine)

Module len 6897 truncated
Module len 19014 truncated

However, at least now modprobe manages not to hose up the entire modules stuff, but
simply exits with this error:

FATAL: Error inserting aes (/lib/modules/2.6.1-mm1/kernel/crypto/aes.ko): Invali
d module format

and lsmod and 'cat /proc/modules' don't get borked up afterwards.

> Please send module which fails if it still fails...

Sent under separate cover, the list probably doesn't want the 2 .ko files.. ;)

--==_Exmh_-1513812110P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE//5POcC3lWbTT17ARAtTyAJ4j5zW8e9vwpt2059uBf/ZChgQaVgCeNjUO
f36nzI5g3lTUKrMLDik5U8s=
=OxQv
-----END PGP SIGNATURE-----

--==_Exmh_-1513812110P--
