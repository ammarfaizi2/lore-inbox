Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVCERSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVCERSG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVCERSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:18:06 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:8600 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261665AbVCERGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:06:31 -0500
Date: Sat, 05 Mar 2005 12:06:30 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: diff command line?
In-reply-to: <4229E219.20100@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503051206.30313.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200503051048.00682.gene.heskett@verizon.net>
 <20050305161822.H3282@flint.arm.linux.org.uk> <4229E219.20100@cwazy.co.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 11:45, Jim Nelson wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Russell King wrote:
>| On Sat, Mar 05, 2005 at 10:48:00AM -0500, Gene Heskett wrote:
>|>What are the options normally used to generate a diff for public
>|>consumption on this list?
>|
>| diff -urpN orig new
>|
>| where "orig" and "new" both contain the top level "linux"
>| directory, so the resulting patch can be applied with patch -p1.
>
>You'd also want to add "-x dontdiff", using
>
>http://developer.osdl.org/rddunlap/scripts/dontdiff-osdl
>
>That way, you can do a diff, even if you have run a compile in one
> of the directory trees.

And this is a list of files to ignore. In the previous case, only one 
file, but I can see thats a very good way to weed out the noise.  
Thanks.

>- --
>GPG Public key at pgp.mit.edu
>
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.4 (GNU/Linux)
>Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
>iD8DBQFCKeIZevfmjTWdv3MRAjPYAJ9s3PrU/hjuILrGlIh3nuO/Scd4TACghQwQ
>WD5p8VRpp6mfI+b+FOHZIn0=
>=n8/k
>-----END PGP SIGNATURE-----

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
