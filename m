Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbUCOAXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 19:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUCOAXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 19:23:12 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:384 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262083AbUCOAXJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 19:23:09 -0500
Message-Id: <200403130515.i2D5F7DG009253@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Adam Jones <adam@yggdrasl.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA and 2.6.4? 
In-Reply-To: Your message of "Fri, 12 Mar 2004 18:24:01 GMT."
             <adam.20040312182401$5015%samael.haus@yggdrasl.demon.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <405082A2.5040304@blueyonder.co.uk> <200403111326.08055.maxvalde@fis.unam.mx> <405112DD.2020009@blueyonder.co.uk>
            <adam.20040312182401$5015%samael.haus@yggdrasl.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_811765798P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 13 Mar 2004 00:15:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_811765798P
Content-Type: text/plain; charset=us-ascii

On Fri, 12 Mar 2004 18:24:01 GMT, Adam Jones <adam@yggdrasl.demon.co.uk>  said:
> In a futile gesture against entropy, Sid Boyce wrote:
> > Max Valdez wrote:
> 
> > >Been using nvidia modules for quite a few 2.6.x kernels, most of them mmX.
 
> > >without problems
> 
> I'm using it here with 2.6.4, no problems as yet.
> 
> > Something strange happened, I shall try 2.6.4-mm1 shortly to see if it 
> > is still the same. I reckon though that I've suffered a filesystem 
> > corruption.
> 
> A quick thought - have you got CONFIG_REGPARM enabled in the kernel
> config?  If so, disable it and try again.  (It's almost certain to
> cause crashes with binary modules.)

Also, the NVidia driver uses a bit of kernel stack, so it's incompatible
with the CONFIG_4KSTACKS option in recent -mm kernels...

--==_Exmh_811765798P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAUpjacC3lWbTT17ARAkl1AJ9+3XIG/F33yJAOj8qGfOwzxyoC3QCg+FA4
iXkWC2lW+qGkpIdRvZ/TqAo=
=ZNhI
-----END PGP SIGNATURE-----

--==_Exmh_811765798P--
