Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUFBTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUFBTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUFBTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:31:29 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28128 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263865AbUFBTb1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:31:27 -0400
Message-Id: <200406021931.i52JVMw2032442@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: ndiamond@despammed.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module? 
In-Reply-To: Your message of "Wed, 02 Jun 2004 00:52:57 CDT."
             <200406020552.i525qvk08725@mailout.despammed.com> 
From: Valdis.Kletnieks@vt.edu
References: <200406020552.i525qvk08725@mailout.despammed.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1402193516P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 15:31:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1402193516P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Jun 2004 00:52:57 CDT, ndiamond@despammed.com  said:

> I'm not quite sure what that means.  It was pretty easy to code a log2()
> function using the built-in opcode, but it took me nearly a day to code
> an exp2() function.  The built-in f2xm1 opcode helps a lot but there's
> no help for the other half exp2()'s lot.

I think what he meant was that if you get basic stuff like floating point
add and subtract, all the other opcodes like f2xm1 work as well.  If there
isn't an opcode you're still have to build the code from the appropriate
primitives, of course....

--==_Exmh_1402193516P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvisKcC3lWbTT17ARAhBIAKCz4mIl9aPm5PbmfzBpPj8GRkUv6QCdHzTU
eukeJeu7zs67zMxObq2rmYA=
=oLlI
-----END PGP SIGNATURE-----

--==_Exmh_1402193516P--
