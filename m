Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbTJUUXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTJUUWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:22:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54402 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263327AbTJUUVu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:21:50 -0400
Message-Id: <200310212021.h9LKLQK3009397@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in 
In-Reply-To: Your message of "Tue, 21 Oct 2003 16:05:15 EDT."
             <Pine.LNX.4.53.0310211558500.19942@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <175701c397e6$b36e5310$24ee4ca5@DIAMONDLX60> <20031021193128.GA18618@helium.inexs.com>
            <Pine.LNX.4.53.0310211558500.19942@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-690795902P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Oct 2003 16:21:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-690795902P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Oct 2003 16:05:15 EDT, "Richard B. Johnson" said:

> If the respondent wants them isolated into a "BADBLOCKS" file,
> he can make a utility to do that. It's really quite easy because
> you can raw-read disks under Linux, plus there is already
> the `badblocks` program that will locate them.

Yes, it's trivially easy to figure out that block 193453 on /dev/hdb is bad.
It's even not too bad to map that to an offset on /dev/hdb4.  Even if you're
using LVM or DM to map stuff, it's still attackable.  But how do you guarantee
that block 193453 gets allocated to your badblocks file and not to some other
file that just tried to extend itself by 32K?


--==_Exmh_-690795902P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/lZVGcC3lWbTT17ARAhrvAKCa/KEnOtWQJ8xnj57hnqVm8zNJNACgj72k
rfyEpErBuEAG/+5ckVKs+uI=
=0MYH
-----END PGP SIGNATURE-----

--==_Exmh_-690795902P--
