Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTD1QZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbTD1QZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:25:44 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1923 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261188AbTD1QZm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:25:42 -0400
Message-Id: <200304281637.h3SGbm5U002651@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Robert Williamson <robbiew@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on which headers to use when compiling 2.5 kernels 
In-Reply-To: Your message of "Mon, 28 Apr 2003 11:19:48 CDT."
             <OF60B60028.F8DD3823-ON85256D16.0058E5AD-86256D16.0059CC01@pok.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <OF60B60028.F8DD3823-ON85256D16.0058E5AD-86256D16.0059CC01@pok.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_112009459P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Apr 2003 12:37:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_112009459P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Apr 2003 11:19:48 CDT, Robert Williamson <robbiew@us.ibm.com>  said:
> I would REALLY appreciate it, if someone could clarify this issue for me.
> When testing the latest 2.5 kernels, I've frequently come across issues
> where the headers in /usr/include conflict with the headers packaged with
> the kernel.  I was under the assumption that when compiling user mode
> programs, such as the LTP test suite, we should use the headers in
> /usr/include.  However, I have had some kernel developers tell me that I
> should compile against the kernel includes.....could I get some
> clarification on this?

Things that run in user space use the /usr/include headers.

Things that run in kernel space use the kernel includes.

If you think you need to violate these rules, you're either incorrect or
shouldn't be needing to ask.

(Having said that, if you're encountering a *specific* case where the difference
between the two sets of headers is *actually causing a problem*, feel free to
re-post and explain in detail what the issue is....)

--==_Exmh_112009459P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+rVjbcC3lWbTT17ARAiEnAKCJYpgu16u0Ap4tNNfRMg4T/oZjPACgj35T
DKS/MjSyrBpy5RdDcFeSitA=
=5vog
-----END PGP SIGNATURE-----

--==_Exmh_112009459P--
