Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUAZFVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 00:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUAZFVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 00:21:39 -0500
Received: from h80ad25ed.async.vt.edu ([128.173.37.237]:49344 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265500AbUAZFVi (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 00:21:38 -0500
Message-Id: <200401260521.i0Q5LRha021370@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Steve Youngs <sryoungs@bigpond.net.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core 
In-Reply-To: Your message of "Mon, 26 Jan 2004 15:06:48 +1000."
             <microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org> <20040125222242.A24443@mail.kroptech.com>
            <microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1064116018P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jan 2004 00:21:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1064116018P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Jan 2004 15:06:48 +1000, Steve Youngs <sryoungs@bigpond.net.au>  said:

>   > A boolean is just a one-bit reference count. If the maximum number of
>   > simultaneous 'users' for a given module is one, then a boolean will work.
>   > If there is potential for more than one simultaneous user then you need
>   > more bits.
> 
> Why?  A module is either being used or it isn't, the number of uses
> shouldn't even come into it.

OK. There's 2 users of the module.  The first one exits.  How does it (or
anything else) know that it's NOT safe to just clear the in-use bit and clean
it up?

And how does the second one know it IS safe to clean up?

--==_Exmh_-1064116018P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAFKPWcC3lWbTT17ARAtbuAJ4sz8WeohB5WIJD5n1mqpfLrxdZWQCcD5Tt
8Tm8uXNhArvr9uuhMVoqXUg=
=M2CR
-----END PGP SIGNATURE-----

--==_Exmh_-1064116018P--
