Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUHXOnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUHXOnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUHXOnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:43:02 -0400
Received: from p5089F06A.dip.t-dialin.net ([80.137.240.106]:772 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S267899AbUHXOmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:42:44 -0400
X-Mailbox-Line: From bbpetkov@yahoo.de Tue Aug 24 14:09:23 2004
Subject: 2.6.9-rc1: fs/smbfs/inode.c: warning: comparison is always false due to limited range of data type
From: Borislav Petkov <bbpetkov@yahoo.de>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 16:42:34 +0200
X-Evolution-Transport: smtp://bbpetkov;auth=PLAIN@smtp.mail.yahoo.de
X-Evolution-Account: yahoo
X-Evolution-Fcc: file:///home/boris/evolution/local/Sent
X-Evolution-Format: text/plain
Content-Disposition: inline
Message-Id: <200408241642.42399.bbpetkov@yahoo.de>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,
just gave 2.6.9-rc1 a try. gcc warning:
fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:563: warning: comparison is always false due to limited
range of data type
fs/smbfs/inode.c:564: warning: comparison is always false due to limited
range of data type

Paul Jackson has already submitted a patch (on the 8 of August) about
this warning but i guess it was forgotten. Just informing about it.

Boris.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBK1PfQ6NBq1iMuxERAtLZAJ9W9OhIxrQABBkHtyawtR3GC3NyogCfZA6s
zWAs7mgIO82EBHODDOQD2q0=
=DA2m
-----END PGP SIGNATURE-----
