Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVAKSzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVAKSzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVAKSzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:55:55 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13323 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261743AbVAKSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 13:55:47 -0500
Message-Id: <200501111855.j0BItcil027392@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Anton Blanchard <anton@samba.org>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp 
In-Reply-To: Your message of "Tue, 11 Jan 2005 11:01:10 +0100."
             <20050111100109.GA347@unthought.net> 
From: Valdis.Kletnieks@vt.edu
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com> <20050111035810.GG14239@krispykreme.ozlabs.ibm.com> <Pine.LNX.4.61.0501102321490.25796@twin.uoregon.edu> <200501110920.j0B9JwAL006980@turing-police.cc.vt.edu>
            <20050111100109.GA347@unthought.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1105469738_18072P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jan 2005 13:55:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1105469738_18072P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 Jan 2005 11:01:10 +0100, Jakob Oestergaard said:

> > If you threw that much hardware at a Linux system, 
> 
> ... theory ... or have you actually tried?

Merely indicating a method to approach the problem space...

> Current problems with 2.6:
> 1 ext3 causes kjournald oops on load
> 2 xfs has bad NFS/SMP/dcache interactions (you end up with undeletable
>   directories)
> 3 knfsd will give you stale handles (can be worked around by stat'ing
>   all your directories constantly on the server side)

A mere matter of debugging. ;)

--==_Exmh_1105469738_18072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB5CEqcC3lWbTT17ARAsNeAKCCWY9kESdQ2HXDwnn78MrYLHQa0gCdHt2Y
6MQW2Z9MfXostdyQpZRQ9VU=
=Tmv5
-----END PGP SIGNATURE-----

--==_Exmh_1105469738_18072P--
