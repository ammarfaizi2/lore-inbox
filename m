Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUBRUUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267996AbUBRUUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:20:10 -0500
Received: from ns2.len.rkcom.net ([80.148.32.9]:64963 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S268053AbUBRUTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:19:49 -0500
From: Florian Schanda <ma1flfs@bath.ac.uk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel Panic: Fatal Exception in interrupt (reproducible)
Date: Wed, 18 Feb 2004 20:21:08 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402182021.14579.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I get a kernel panic when doing this:

$ cdrecord dev=ATAPI -scanbus

I have uploded a screenshot here: http://www.bath.ac.uk/~ma1flfs/kpanic1.jpg
(BTW, is there any way to "scroll up" once a panic happens? I would love to 
see the beginning of this message.)

The above command works fine with 2.6.2; upgrading to 2.6.3 make this happen.

Note that I had this problem before - I got rid of it be compiling everything 
(a new Linux From Scratch) based on 2.6.2 and this project: 
http://ep09.pld-linux.org/~mmazur/glibc-kernel-headers/

It's obviously not a practical solution to make a new LFS system every time I 
want to upgrade my kernel.

Any ideas? Any addiitional info I should post?

Thanks in advance,

	Florian Schanda
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAM8k3fCf8muQVS4cRAqarAJ0XlnKLHL8HVkyNySksJc0hl73wVwCeKvpn
munjwOcZgmPU7hNeW+IXNnk=
=s6OM
-----END PGP SIGNATURE-----
