Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbVCEQyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbVCEQyp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVCEQuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:50:24 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:24483 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S263129AbVCEQpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:45:15 -0500
Date: Sat, 05 Mar 2005 11:45:13 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
Subject: Re: diff command line?
In-reply-to: <20050305161822.H3282@flint.arm.linux.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <4229E219.20100@cwazy.co.uk>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <200503051048.00682.gene.heskett@verizon.net>
 <20050305161822.H3282@flint.arm.linux.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Russell King wrote:
| On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
|
|>What are the options normally used to generate a diff for public
|>consumption on this list?
|
|
| diff -urpN orig new
|
| where "orig" and "new" both contain the top level "linux" directory,
| so the resulting patch can be applied with patch -p1.
|

You'd also want to add "-x dontdiff", using

http://developer.osdl.org/rddunlap/scripts/dontdiff-osdl

That way, you can do a diff, even if you have run a compile in one of the
directory trees.

- --
GPG Public key at pgp.mit.edu

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCKeIZevfmjTWdv3MRAjPYAJ9s3PrU/hjuILrGlIh3nuO/Scd4TACghQwQ
WD5p8VRpp6mfI+b+FOHZIn0=
=n8/k
-----END PGP SIGNATURE-----
