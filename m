Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263116AbTCLJY3>; Wed, 12 Mar 2003 04:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263117AbTCLJY3>; Wed, 12 Mar 2003 04:24:29 -0500
Received: from imap.gmx.net ([213.165.64.20]:4039 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263116AbTCLJY2> convert rfc822-to-8bit;
	Wed, 12 Mar 2003 04:24:28 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.19] How to get the path name of a struct dentry
Date: Wed, 12 Mar 2003 10:33:05 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303121033.08560.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Assuming I have got a particular (struct dentry*)dp, how can I get it's full 
path name.

I understand that dp->d_name.name contain the relative path name. Then I can 
cycle through dp->d_parent while( !IS_ROOT(dp) ).

But that cycle finishes when the mount point of the current file system is 
hit.

How can I get the mount point's struct dentry of the parent file system basing 
on the root dentry of mounted file system?

Thanks
Torsten
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+bv7UwicyCTir8T4RAjCRAKCJaTNRnOQ4oXYPZIXIYeaH8X15xwCeNyMI
ftq5TknzeKMMPJIj4as3PaI=
=nm/0
-----END PGP SIGNATURE-----
