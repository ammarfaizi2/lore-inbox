Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265911AbUFDShq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUFDShq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUFDShq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:37:46 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54146 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265919AbUFDShn (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:37:43 -0400
Message-Id: <200406041837.i54IbfYE023527@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6 
In-Reply-To: Your message of "Fri, 04 Jun 2004 14:17:14 EDT."
             <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl> 
From: Valdis.Kletnieks@vt.edu
References: <200406041817.i54IHFgZ004530@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143825952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Jun 2004 14:37:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1143825952P
Content-Type: text/plain; charset=us-ascii

On Fri, 04 Jun 2004 14:17:14 EDT, Horst von Brand said:
> Pavel Machek <pavel@suse.cz> said:

> > You get pretty nasty managment problems. How do you do init=/bin/bash
> > if your keyboard is userspace?
> 
> You don't tell any kernel about that... it is the bootloader you are
> talking to. And that one may very well have integrated kbd support.

So GRUB knows about keyboards, lets you type in the "init=/bin/bash", it loads
the kernel, the kernel launches init, /bin/bash gets loaded - and /bin/bash
can't talk to the keyboard because the userspace handler hasn't happened.  At
that point you're stuck...


--==_Exmh_1143825952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAwMF0cC3lWbTT17ARAhZSAKCbF0JntfxgTsKyaGtWBiRVJZZXtgCgqldA
jiINno5aStStjOe8/MugplI=
=EemQ
-----END PGP SIGNATURE-----

--==_Exmh_1143825952P--
