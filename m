Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTEFSUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTEFSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:20:18 -0400
Received: from cox.ee.ed.ac.uk ([129.215.80.253]:42414 "EHLO
	postbox.ee.ed.ac.uk") by vger.kernel.org with ESMTP id S264009AbTEFSUR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:20:17 -0400
From: Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>
Organization: The University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: Re: Bootsector corruption
Date: Tue, 6 May 2003 19:31:33 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200305061931.43283.Unai.Garro@ee.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>Hi,
>I experience the following problem which occurs randomly.

>After a reboot, the Bootsector is often corrupted. The errors reported 
>by lilo differ.
>Today I had 99 (invalid second stage index sector).

I had this error right today for the first time, but I can't be sure if it's 
the same error/reason. The error happenned with 2.5.68-mm4. The steps were:

1) I booted with 2.5.69, changed the lilo.conf to add an option, and "lilo 
- -c". Rebooted, but the LILO remained the same
2) I booted again into 2.5.69, "lilo -c", and the same as in 1)
3) I booted in 2.5.68-mm4, lilo -c... and I got the error message saying L 99 
99 99..

This has never happenned before with kernels up to 2.5.67 nor 2.4.x


- -- 
Each new user of a new system uncovers a new class of bugs.
		-- Kernighan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+t/+MhxDfDIoZlaURAr0sAKCR4zTzbZe8NcV3Lisy79kGhaSyMACdGGak
bO1HuEiGVBldFQhXiVT+1zo=
=i4s6
-----END PGP SIGNATURE-----
