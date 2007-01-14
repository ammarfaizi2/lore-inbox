Return-Path: <linux-kernel-owner+w=401wt.eu-S1750913AbXANBzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbXANBzy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXANBzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:55:54 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47294 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXANBzy (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:55:54 -0500
Message-Id: <200701140155.l0E1tpkB009184@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Bill Davidsen <davidsen@tmr.com>
Cc: Sunil Naidu <akula2.shark@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Choosing a HyperThreading/SMP/MultiCore kernel ?
In-Reply-To: Your message of "Sat, 13 Jan 2007 15:18:31 EST."
             <45A93E97.30007@tmr.com>
From: Valdis.Kletnieks@vt.edu
References: <8355959a0701120525m5d1a7904i56b8a8f7316883d6@mail.gmail.com> <20070112150349.GI17269@csclub.uwaterloo.ca> <200701130338.l0D3chOs026407@turing-police.cc.vt.edu>
            <45A93E97.30007@tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168739751_8374P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 13 Jan 2007 20:55:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168739751_8374P
Content-Type: text/plain; charset=us-ascii

On Sat, 13 Jan 2007 15:18:31 EST, Bill Davidsen said:
> Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 12 Jan 2007 10:03:49 EST, Lennart Sorensen said:
> >> I would expect any distribution should work on these (as long as the
> >> kernel they use isn't too old.).  Of course if it is a Mac, you need a
> >> distribution that supports their firmware (which is of course not a PC
> >> bios).  As long as you can boot it, any i386 or amd64 kernel with smp
> >> enabled should use all the processors present (well amd64 on the
> >> core2duo and on the p4 if it is em64t enabled).
> > 
> > amd64 will only work on a core2duo if it's a T7200 or higher - the
> > lower numbers are 32-bit-only chipsets.  I admit not knowing what
> > exact variant the Mac has.
> 
> I don't believe that's correct, the Intel features page indicates all 
> core2 have both 64bit and virtualization. Perhaps some of the core (no 
> 2) models didn't? Even the old 930 had those features by my notes.

My screwup - the chart I looked at managed to get the Core and Core2 series
mixed up. Here's a hopefully more canonical one:

http://www.intel.com/products/processor_number/proc_info_table.pdf

Does however list some Core2 that don't do virtualization (page 3, the
T5600 and T5500), which is what I think confused the author of the table
that I misread. ;)

--==_Exmh_1168739751_8374P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFqY2ncC3lWbTT17ARAmDlAJkBqjI3l5SOc6Wl7q2n3sDO3Si95ACdFRH0
4aHfolA0Gt9dz76hFlZweLk=
=7bDE
-----END PGP SIGNATURE-----

--==_Exmh_1168739751_8374P--
