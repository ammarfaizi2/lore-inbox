Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUEFRQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUEFRQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUEFRQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:16:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1670 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261474AbUEFRQl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:16:41 -0400
Message-Id: <200405061716.i46HGZAP020550@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] code for raceless /sys/fs/foofs/* 
In-Reply-To: Your message of "Thu, 06 May 2004 20:35:37 +0400."
             <16538.26969.343294.164709@laputa.namesys.com> 
From: Valdis.Kletnieks@vt.edu
References: <16536.61900.721224.492325@laputa.namesys.com> <20040505162802.GN17014@parcelfarce.linux.theplanet.co.uk> <20040505163650.GO17014@parcelfarce.linux.theplanet.co.uk>
            <16538.26969.343294.164709@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1072157501P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 May 2004 13:16:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1072157501P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 May 2004 20:35:37 +0400, Nikita Danilov said:

> But isn't this a problem with sysfs in general? Restricted process still
> observes all devices, busses, etc. through /sys. If such information is
> sensitive, shouldn't there be some way to selectively mount only
> portions of kobject trees?

Alternatively, there's a nice security module infrastructure - use that to
restrict who can view given subtrees of /sys.  Currently, SELinux is able
to slice-n-dice the /proc filesystem for different accesses, but code
would need to be written to do it for /sys.

--==_Exmh_1072157501P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAmnLzcC3lWbTT17ARAgscAJ4tqFG2AVNQVs01e4cyD9fLsO5dlwCcCpwM
DsiC4Y9bWlMF5pfBKyburpw=
=ndFQ
-----END PGP SIGNATURE-----

--==_Exmh_1072157501P--
