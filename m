Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272432AbTGZHBc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 03:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272433AbTGZHBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 03:01:32 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:64438 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S272432AbTGZHBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 03:01:31 -0400
Date: Sat, 26 Jul 2003 03:15:53 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [RFC] TCP and UDP implementations
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200307260316.02149.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,
	I noticed that there are two implementations of TCP and UDP in the kernel - 
one for IPv4 and the other for IPv6. Correct me if I am wrong, but wouldn't 
it be better to just have one implementation for both versions of IP? I know 
this for sure:

1) it would decrease the size of the kernel (this wouldn't be too dramatic, 
but still)

2) it would make maintaining of the code half the work

AFAIK there are small differences in TCP and UDP between IPv4 and IPv6, but 
they could be resolved using simple "work arounds."

Thanks,
Jeff.

- -- 
The obvious mathematical breakthrough would be development of an easy
way to factor large prime numbers.
		- Bill Gates, The Road Ahead, pg. 265
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IiqtwFP0+seVj/4RAn5TAKCbdCGvUtPAJun994GfcsDkfMLqXwCgsKwG
dl/5CjR0hCRbpv+SNH7L3ds=
=z5jS
-----END PGP SIGNATURE-----

