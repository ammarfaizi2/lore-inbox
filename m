Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTEESnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbTEESnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:43:49 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21122 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261227AbTEESns (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:43:48 -0400
Message-Id: <200305051856.h45IuFJC004011@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: will be able to load new kernel without restarting? 
In-Reply-To: Your message of "Mon, 05 May 2003 14:49:15 EDT."
             <3EB6B22B.7090009@techsource.com> 
From: Valdis.Kletnieks@vt.edu
References: <freemail.20030403212422.18231@fm9.freemail.hu> <20030503205656.GA19352@middle.of.nowhere> <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
            <3EB6B22B.7090009@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1868142314P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 May 2003 14:56:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1868142314P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 May 2003 14:49:15 EDT, Timothy Miller said:

> The only major issue is that the data structures used to manage 
> processes would be different from one scheduler to the next.  One 
> possible answer would be to have an unloading driver translate all of 
> its process information into the default scheduler's format.  A newly 
> loaded one would translate it to its own format.  Things that would be 
> lost in the translation include interactivity information, etc.

We just had a similar battle regarding LSM extended attributes on files,
the biggest problem being what a module should do if it doesn't understand
the formats and semantics of the previous module...

It's certainly *doable* - the telcos have been doing this since whichever
of the SSn systems was first programmable rather than hardwire logic.  The
big question is whether it will still look like Linux if you implement it.


--==_Exmh_-1868142314P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+trPOcC3lWbTT17ARAlSGAJ9Da+YXyc0/6nGXwFV9TU53p4zEUQCg0Egb
zWE/lR35Br9mdu2xVJ0Ykus=
=ByWL
-----END PGP SIGNATURE-----

--==_Exmh_-1868142314P--
