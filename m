Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUBFSYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUBFSYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:24:50 -0500
Received: from h80ad2445.async.vt.edu ([128.173.36.69]:19331 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265651AbUBFSXs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:23:48 -0500
Message-Id: <200402061822.i16IMdHJ013686@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: root@chaos.analogic.com
Cc: Roland Dreier <roland@topspin.com>, "Hefty, Sean" <sean.hefty@intel.com>,
       Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel 
In-Reply-To: Your message of "Fri, 06 Feb 2004 13:00:38 EST."
             <Pine.LNX.4.53.0402061258110.4045@chaos> 
From: Valdis.Kletnieks@vt.edu
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com> <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com>
            <Pine.LNX.4.53.0402061258110.4045@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2007120530P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Feb 2004 13:22:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2007120530P
Content-Type: text/plain; charset=us-ascii

On Fri, 06 Feb 2004 13:00:38 EST, "Richard B. Johnson" said:

> Yes you can. You just don't use an ';' if you are going
> to use 'else'.

You did realize we've changed things from macros to inline functions
(and vice versa) on occasion?

Yes, you *can* hack around the "problem".  Is there any actual
evidence that any real performance issues arise from the null
do/while?  Does said issue outweigh the increased fragility of
the code?

--==_Exmh_-2007120530P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAI9tucC3lWbTT17ARAntLAKDzFCB32VeS4I5S9h3TunBMok0tQQCfd38S
kcfDxK3Z9Ml+utSoKs/Mi18=
=bTMZ
-----END PGP SIGNATURE-----

--==_Exmh_-2007120530P--
