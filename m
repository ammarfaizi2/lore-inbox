Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVIVUdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVIVUdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVIVUdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:33:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19599 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750824AbVIVUdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:33:32 -0400
Message-Id: <200509222032.j8MKWo44011569@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Zan Lynx <zlynx@acm.org>
Cc: breno@kalangolinux.org, linux-kernel@vger.kernel.org
Subject: Re: security patch 
In-Reply-To: Your message of "Thu, 22 Sep 2005 14:24:48 MDT."
             <1127420688.10462.9.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <20050922194433.13200.qmail@webmail2.locasite.com.br> <200509222003.j8MK3i8E010365@turing-police.cc.vt.edu>
            <1127420688.10462.9.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127421170_2709P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 16:32:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127421170_2709P
Content-Type: text/plain; charset=us-ascii

On Thu, 22 Sep 2005 14:24:48 MDT, Zan Lynx said:

> An interesting thing that I don't think has been done before is to
> create a map linking stack call chains to syscalls.  If the call stack
> doesn't match then it isn't a valid call.

I suspect longjmp() and friends would play havoc on this, and vice versa,
as well as those syscalls that are legal from inside signal handlers, and
a few other cases.

What validity check were you planning to make on the stack call chain?

--==_Exmh_1127421170_2709P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDMxTycC3lWbTT17ARAkACAKCPOKCZ1wnV1AhOPYwIg32nCbd2DwCgixNf
SBpO8xCkCBE4aLrls5EoiAE=
=krNZ
-----END PGP SIGNATURE-----

--==_Exmh_1127421170_2709P--
