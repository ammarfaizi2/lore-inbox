Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbTLBTHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTLBTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:07:10 -0500
Received: from h80ad2445.async.vt.edu ([128.173.36.69]:52622 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264313AbTLBTHH (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:07:07 -0500
Message-Id: <200312021906.hB2J6qLB015931@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future 
In-Reply-To: Your message of "Tue, 02 Dec 2003 10:53:33 PST."
             <20031202185333.GV1566@mis-mike-wstn.matchmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <Pine.LNX.4.58.0312021402360.17892@moje.vabo.cz> <20031202131512.GU13388@conectiva.com.br> <Pine.LNX.4.58.0312021433360.8417@moje.vabo.cz> <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>
            <20031202185333.GV1566@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-634452376P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 02 Dec 2003 14:06:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-634452376P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 Dec 2003 10:53:33 PST, Mike Fedyk said:

> You have all of that for ext3 in 2.6.  The locking has been improved, there
> is acl support, and quota has been there for a long time (even in 2.4).  I'm
> not sure about the dump, but if dump gets all allocated blocks, then you
> should have ACLs dumped too.

At least the 'dump' that comes with Fedora Core 1:

dump 0.4b34 (using libext2fs 1.34 of 25-Jul-2003)

complains:  "ACLs in inode #%ld won't be dumped" (for some value of %ld)
when dumping files that have been tagged by SELinux.

http://dump.sourceforge.net/ disavows the existence of newer than 0.4b34.

It hasn't been a big issue for me, as I can re-run /usr/sbin/setfiles if I
restore. But (a) it's very noisy and liable to hide real errors and (b) any
other not-easily-recreated use of ACLs is a problem...


--==_Exmh_-634452376P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/zOLMcC3lWbTT17ARApnQAJ9WCQRLJ1mBQaB7E1pYNcOkAkB7WgCg7HVb
5fkS5fDXWuTQIgAXgP7PEzQ=
=1oz7
-----END PGP SIGNATURE-----

--==_Exmh_-634452376P--
