Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUAIDgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUAIDgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:36:35 -0500
Received: from h80ad25d9.async.vt.edu ([128.173.37.217]:41856 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261506AbUAIDgc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:36:32 -0500
Message-Id: <200401090336.i093aBxB004312@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       ericy@cais.com
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity checking 
In-Reply-To: Your message of "Thu, 08 Jan 2004 19:20:21 PST."
             <20040108192021.6c2aea60.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
            <20040108192021.6c2aea60.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2079825436P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Jan 2004 22:36:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2079825436P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Jan 2004 19:20:21 PST, Andrew Morton said:
> I've always had little confidence in the elf loader.  The problem is
> complex, the code quality is not high and the consequences of an error are
> severe.

You might want to read this very interesting dissection of the ELF format
for fun and non-profit.
 
http://www.muppetlabs.com/~breadbox/software/tiny/teensy.html

All I can say is - although it's insanely creative, this is *NOT* how I
want my ELF loader to work. ;)

--==_Exmh_2079825436P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE//iGqcC3lWbTT17ARAvSjAKDexldgKsWc8yXMST7uU/GroyyHgwCg2C8f
/CIh13FL8ZrMhW8XY/GGNHM=
=h/OJ
-----END PGP SIGNATURE-----

--==_Exmh_2079825436P--
