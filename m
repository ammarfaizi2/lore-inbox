Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVI1H56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVI1H56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVI1H56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 03:57:58 -0400
Received: from h80ad25b8.async.vt.edu ([128.173.37.184]:64974 "EHLO
	h80ad25b8.async.vt.edu") by vger.kernel.org with ESMTP
	id S1030211AbVI1H55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 03:57:57 -0400
Message-Id: <200509280757.j8S7vmjB023730@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: iodophlymiaelo@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: raw aio write guarantee 
In-Reply-To: Your message of "Wed, 28 Sep 2005 00:12:33 PDT."
             <98b62faa050928001275d28771@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <98b62faa050928001275d28771@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127894267_31960P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Sep 2005 03:57:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127894267_31960P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Sep 2005 00:12:33 PDT, iodophlymiaelo@gmail.com said:

> Just a quick question: How can a user-mode application ensure that an
> AIO write on a raw block device (i.e. open()ed with O_DIRECT) has
> really -really- been written to the disk and not residing in an on-disk
> write cache where it could be lost in case of a power failure?

Step 1: Make sure you buy disk drives that don't lie through their teeth
regarding details such as "is the write cache enabled?" or "did the flush
cache work?".  Such hardware can generate vast amounts of bad karma....

Step 2: Buy a UPS.  A good one.  You can't lose the cache during a power failure
that doesn't actually hit.

Step 3: http://catb.org/~esr/jargon/html/M/molly-guard.html - You want these.
Lots of them. 


--==_Exmh_1127894267_31960P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDOkz7cC3lWbTT17ARAsIrAKCFjVEouw1nnDfUNpTp1KTHm9yfGQCeLtiA
v3aokm7d99PnrWqc+zrjJK0=
=aTF+
-----END PGP SIGNATURE-----

--==_Exmh_1127894267_31960P--
