Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTDVUp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbTDVUpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:45:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28801 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263854AbTDVUpi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:45:38 -0400
Message-Id: <200304222057.h3MKvbLq005110@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig? 
In-Reply-To: Your message of "Tue, 22 Apr 2003 17:04:34 EDT."
             <3EA5AE62.1040706@techsource.com> 
From: Valdis.Kletnieks@vt.edu
References: <3EA5AABF.4090303@techsource.com> <200304222041.h3MKfILq027562@turing-police.cc.vt.edu>
            <3EA5AE62.1040706@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1526588216P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Apr 2003 16:57:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1526588216P
Content-Type: text/plain; charset=us-ascii

On Tue, 22 Apr 2003 17:04:34 EDT, Timothy Miller said:

> Great.  Why do I have a feeling that installing it will bork my 
> workstation?  Not to say that it can't be done but that I will probably 
> screw it up.  I'm sure that Red Hat (7.2) has some dependencies on there 
> being 2.96 installed.  Any suggestions on how I might deal with this 
> problem?

Well...

> I'm not actually going to run the kernel.

Then the use of 3.0.2 won't matter..

> I'm trying to do an allyesconfig kernel so that I can get all printk 
> format strings.

'make -k' should suffice there.  I assume you're grovelling them out of
the .o files?  Otherwise, just grepping the *.c should be OK.

Also, note that you probably want to *also* do an 'allmodconfig' just in
case there's printk inside a #ifdef MODULE....

--==_Exmh_1526588216P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pazAcC3lWbTT17ARAghQAJ0bSj0BkwNtQirO9Rn1V0K9oBS5DACbBwY0
JTTdoi1G0H1OrXFE7Vzhdug=
=2LUj
-----END PGP SIGNATURE-----

--==_Exmh_1526588216P--
