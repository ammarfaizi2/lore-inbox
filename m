Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270480AbTHLO6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270483AbTHLO6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:58:32 -0400
Received: from h80ad2614.async.vt.edu ([128.173.38.20]:61313 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270480AbTHLO6W (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:58:22 -0400
Message-Id: <200308121458.h7CEwIfZ008906@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Brandon Stewart <rbrandonstewart@yahoo.com>
Cc: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms 
In-Reply-To: Your message of "Tue, 12 Aug 2003 10:48:59 EDT."
             <3F38FE5B.1030102@yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <3F38FE5B.1030102@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1605706396P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Aug 2003 10:58:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1605706396P
Content-Type: text/plain; charset=us-ascii

On Tue, 12 Aug 2003 10:48:59 EDT, Brandon Stewart <rbrandonstewart@yahoo.com>  said:

> 3) Reapply the CMOV emulation patch to your downloaded kernel. Not 
> recommended since it turns one CPU cycle into 400.

True, as far as it goes.  However, you need to balance the huge hit you take
on CMOV and how often it's actually used in glibc, against how many places
you save 5 or 10 cycles due to more optimized code...

No, I don't have numbers for either side of the question...


--==_Exmh_-1605706396P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/OQCKcC3lWbTT17ARAinvAJ48xd4p0AT+nLwbIhDo7HgSbF/ETgCg1UeH
rjATY2v4mUM6HMm05oWA9B0=
=cQTA
-----END PGP SIGNATURE-----

--==_Exmh_-1605706396P--
