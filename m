Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262419AbTCIFCA>; Sun, 9 Mar 2003 00:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbTCIFCA>; Sun, 9 Mar 2003 00:02:00 -0500
Received: from h80ad267b.async.vt.edu ([128.173.38.123]:63107 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S262419AbTCIFB7>; Sun, 9 Mar 2003 00:01:59 -0500
Message-Id: <200303090511.h295Bb7U007865@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev 
In-Reply-To: Your message of "Sun, 09 Mar 2003 00:32:56 -0400."
             <200303090433.h294Wuu6005571@eeyore.valparaiso.cl> 
From: Valdis.Kletnieks@vt.edu
References: <200303090433.h294Wuu6005571@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1867510200P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Mar 2003 00:11:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1867510200P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Mar 2003 00:32:56 -0400, Horst von Brand said:
> This kind of changes in the middle of feature freeze are exactly what gets
> you to 2.5 years.

On Sat, Mar 08, 2003 at 07:43:31PM +0000, Christoph Hellwig wrote:
> So people should have started working on it sooner.  If people really think
> they need a 32bit dev_t for their $BIGNUM of disks (and I still don't buy
> that argument) we should just introduce it and use it only for block devices
> (which already are fixed up for this) and stay with the old 8+8 split for
> character devices.  Note that Linux is about doing stuff right, not fast.

*shrug* In the end, it's Linus's call on how to balance the release date
against the features that make it in.

--==_Exmh_-1867510200P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+as0JcC3lWbTT17ARAn2DAJ0VFDpCDEI+3w0mrWSGS874Up1IlwCgo0bH
L4aeOhKvigWGKCCimc8EoJI=
=9/t0
-----END PGP SIGNATURE-----

--==_Exmh_-1867510200P--
