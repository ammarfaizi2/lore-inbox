Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUGWV24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUGWV24 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUGWV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:28:56 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5276 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268076AbUGWV2y (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:28:54 -0400
Message-Id: <200407232128.i6NLSsLp001867@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4+dev
To: Steve G <linux_4ever@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 problems in dual booting machine with SE Linux 
In-Reply-To: Your message of "Fri, 23 Jul 2004 14:21:31 PDT."
             <20040723212131.86635.qmail@web50609.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040723212131.86635.qmail@web50609.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2077760884P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jul 2004 17:28:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2077760884P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Jul 2004 14:21:31 PDT, Steve G said:

> The problem is not that I trash my root filesystem under 2.4, my problem is I
> cannot unmount /mnt/target after I have been in SE Linux and ran fixfiles. My
> method of recovery is to remove files from /mnt/target until I get corruption
> detected at boot which finally lets me run mke2fs to get it back.

Sorry, I thought you were doing the rm -r under 2.6 and trashing it out from under you.

Couldn't you have just added:

/dev/sda3 /mnt/target ext3 noauto

to your 2.4 fstab, so it doesn't mount automagically, and then mke2fs it?

--==_Exmh_2077760884P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBAYMWcC3lWbTT17ARAgSFAJ9ER2ErWRCAzQsf7YJfai6L2uw4FACfTiPz
yN796kuzGCkHJoo7lxL/il0=
=K8Ga
-----END PGP SIGNATURE-----

--==_Exmh_2077760884P--
