Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVBGWme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVBGWme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVBGWmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:42:33 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62215 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261310AbVBGWlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:41:46 -0500
Message-Id: <200502072241.j17MfTfP027969@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Chris Wright <chrisw@osdl.org>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8) 
In-Reply-To: Your message of "Mon, 07 Feb 2005 14:26:03 PST."
             <20050207142603.A469@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <20050207192108.GA776@halcrow.us> <20050207193129.GB834@halcrow.us>
            <20050207142603.A469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107816087_22594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 17:41:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107816087_22594P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Feb 2005 14:26:03 PST, Chris Wright said:

> Hard links still point to same inode, what's the issue that this
> addresses?

For those systems that have everything on one big partition, you can often
do stuff like:

ln /etc/passwd /tmp/<filename_generated_by_mktemp>

and wait for /etc/passwd to get clobbered by a cron job run by root...

--==_Exmh_1107816087_22594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCB+6XcC3lWbTT17ARAv8pAJ9BJ53CZDrP7jPY/xrd58Trf79w3wCfWPDr
D0agMzr+RXVJOzZegD6dzJQ=
=qj7B
-----END PGP SIGNATURE-----

--==_Exmh_1107816087_22594P--
